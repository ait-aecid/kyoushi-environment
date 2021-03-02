from typing import Dict, List, Sequence, Union

from ansible.errors import AnsibleFilterError
from ansible.module_utils.common._collections_compat import Iterable, Mapping
from ansible.plugins.filter.core import flatten, get_encrypted_password
from ansible.utils.display import Display


class FilterModule(object):
    def filters(self):
        return {
            "normalize_distribution": FilterModule.normalize_propabilities,
            "normalize_distributions": FilterModule.normalize_probabilities_map,
        }

    @staticmethod
    def _normalize_propabilities(
        propabilities: Sequence[float],
        check_positive: bool = True,
    ) -> List[float]:
        """Normalizes a propability distribution to sum up to 1.

        Has a floating point error tolerance of up to 1e-8 (same as numpy.choice).
        If the resulting difference is greater than 1e-8 it is added to the first
        non zero propability.

        Args:
            propabilities: The distribution to normalize
            check_positive: Switch to disable the positive number test.
                            This makes the function slightly faster

        Raises:
            ValueError: If the distribution sums to 0 or
                        If one of the propability values is negative

        Returns:
            The normalized probability distribution.
        """
        # only check when requested
        if check_positive and any(p < 0 for p in propabilities):
            raise AnsibleFilterError(
                f"Propabilities must be positive numbers, but got {propabilities}"
            )

        total = sum(propabilities)

        if abs(1.0 - total) < 1e-8:
            # if we already have a normalized
            # distribution then we can just return it
            return propabilities
        elif total > 0:
            multiplier = 1.0 / total
            propabilities = [p * multiplier for p in propabilities]
            diff = 1.0 - sum(propabilities)
            # when rounding errors become to extrem
            # then we fix them by adding the diff to 1 a propability
            if abs(diff) > 1e-8:
                # first non 0 propability index will be increased
                adjust_index = next(
                    (i for i, x in enumerate(propabilities) if x != 0.0)
                )
                propabilities[adjust_index] += diff
            return propabilities

        raise AnsibleFilterError(f"Propabilities sum to 0, but got {propabilities}")

    @staticmethod
    def normalize_propabilities(propabilities, ignore=["extra"]):
        """Accepts probability distribution dicts and lists and normalizes them.

        Args:
            propabilities (Union[Dict, List]): A probability distribution as dict or list
            ignore (List[str], optional): Additional dict keys to ignore during normalization.

        Raises:
            AnsibleFilterError: If the given distribution has an invalid container type, sums to 0
                                or contains negative numbers.

        Returns:
            The normalized distribution.
        """
        if isinstance(propabilities, Mapping):
            keys = []
            values = []

            # only consider non ignored fields as part of the distribution
            for k, p in propabilities.items():
                if k not in ignore:
                    keys.append(k)
                    values.append(p)

            # normalize the probabilities
            values = FilterModule._normalize_propabilities(values)

            # the order is preserved so we can simply zip them
            # back together
            norm = dict(zip(keys, values))

            # add the ignored fields back
            for e in ignore:
                if e in propabilities:
                    norm[e] = propabilities[e]

            return norm

        elif isinstance(propabilities, Iterable):
            # ensure we work on a copy (we don't want to modify the original)
            propabilities = list(propabilities)
            return FilterModule._normalize_propabilities(propabilities)

        raise AnsibleFilterError(
            f"Normalize target must be a dictionary or list, but got '{propabilities}'"
        )

    @staticmethod
    def normalize_probabilities_map(container, ignore=["extra"], skip=[]):
        """Normalizes a dictionary of distributions.

        Args:
            container (Dict[Union[Dict, List]]): Dictionary containing multiple distributions
            ignore (List[str], optional): Distribution dictionary keys to ignore during normalization
            skip (List[str], optional): Dictionary keys to ignore (i.e., incase the given dict contains keys
                                        which are not distributions.)

        Raises:
            AnsibleFilterError: If the given distributions have an invalid container type, sum to 0
                                or contain negative numbers.

        Returns:
            The dictionary with all its distributions normalized.
        """
        if isinstance(container, Mapping):
            container = dict(container)
            # normalize each distribution
            for k, v in container.items():
                # but do nothing with those in the skip list
                if k not in skip:
                    container[k] = FilterModule.normalize_propabilities(
                        v, ignore=ignore
                    )
            return container
        raise AnsibleFilterError(
            f"Normalize map target must be a dictionary, but got '{container}'"
        )

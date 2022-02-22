# Kyoushi Testbed Environment
This tool allows to generate labeled log datasets in simulation testbeds for security evaluations, e.g., IDSs, alert aggregation, or federated learning. 

The testbed simulates an enterprise IT network, involving mail servers, file share, firewall, intranet, DMZ, DNS, VPN, etc. Log data is collected from many sources, including network traffic, apache access logs, DNS logs, syslog, authentication logs, audit logs, suricata logs, exim/mail logs, monitoring logs, etc. The Kyoushi testbed was used to generate the following publicly available log datasets:

 * [AIT-LDSv1](https://zenodo.org/record/4264796)
 * [AIT-LDSv2](https://zenodo.org/record/5789064)
 * [Kyoushi LDS](https://zenodo.org/record/5779411)
 
 ## Getting Started

This is the main repository for the Kyoushi Testbed Environment that contains all models of the testbed infrastructure; it relies on several other repositories that are responsible for generating testbeds from the models, running user and attacker simulations, labeling log data, etc. The following instructions cover the whole procedure to create a testbed and collect log data from scratch. *Please note*: The Kyoushi Testbed Environment is designed for deployment on cloud infrastructure and will require at least 70 GB of RAM. This getting-started relies on OpenStack, Ansible, and Terragrunt, and assumes that the user is experienced with infrastructure/software provisioning. For the following instructions, we assume that the following packages are installed:

```
Poetry 1.1.7
```

### Generating a Testbed from the Models

First, switch into a directory named kyoushi and check out the kyoushi-environment:

```bash
user@ubuntu:~$ mkdir kyoushi
user@ubuntu:~$ cd kyoushi
user@ubuntu:~/kyoushi$ git clone https://github.com/ait-aecid/kyoushi-environment.git
Cloning into 'kyoushi-environment'...
```

The kyoushi-environment contains all models of the testbed infrastructure. These models allow to generate many different testbeds that vary in size and configuration. Testbed parameters that are subject to change include IP addresses of hosts, the number of simulated users, as well as their names and behavior profiles. The kyoushi-generator transforms the infrastructure models from the kyoushi-environment into setup scripts that are ready for deployment. Clone the kyoushi-generator as follows and install it using poetry:

```bash
user@ubuntu:~/kyoushi$ git clone https://github.com/ait-aecid/kyoushi-generator.git
Cloning into 'kyoushi-generator'...
user@ubuntu:~/kyoushi$ cd kyoushi-generator/
user@ubuntu:~/kyoushi/kyoushi-generator$ poetry install
Creating virtualenv cr-kyoushi-generator-PMpTKTKv-py3.8 in /home/user/.cache/pypoetry/virtualenvs
```



### Testbed Deployment

### Starting the Simulation

### Log Data Collection

### Log data Labeling

## Publications

If you use the Kyoushi Testbed Environment or any of the generated datasets, please cite the following publications: 

* Landauer M., Skopik F., Wurzenberger M., Hotwagner W., Rauber A. (2021): [Have It Your Way: Generating Customized Log Data Sets with a Model-driven Simulation Testbed.](https://ieeexplore.ieee.org/document/9262078) IEEE Transactions on Reliability, Vol.70, Issue 1, pp. 402-415. IEEE. [PDF](https://www.skopik.at/ait/2020_trel.pdf)
* Landauer M., Skopik F., Frank M., Hotwagner W., Wurzenberger M., Rauber A. (2022): Maintainable Log Datasets for Evaluation of Intrusion Detection Systems. Under Review.
* Landauer M., Frank M., Skopik F., Hotwagner W., Wurzenberger M., Rauber A. (2022): A Framework for Automatic Labeling of Log Datasets from Model-driven Testbeds for HIDS Evaluation. Under Review.

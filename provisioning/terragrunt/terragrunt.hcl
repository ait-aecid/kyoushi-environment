remote_state {
  backend = "http"
  config = {
    address        = "https://git-service.ait.ac.at/api/v4/projects/2197/terraform/state/${get_env("OS_PROJECT_NAME")}_${get_env("OS_USER_DOMAIN_NAME")}_${path_relative_to_include()}_${basename(get_repo_root())}"
    lock_address   = "https://git-service.ait.ac.at/api/v4/projects/2197/terraform/state/${get_env("OS_PROJECT_NAME")}_${get_env("OS_USER_DOMAIN_NAME")}_${path_relative_to_include()}_${basename(get_repo_root())}/lock"
    unlock_address = "https://git-service.ait.ac.at/api/v4/projects/2197/terraform/state/${get_env("OS_PROJECT_NAME")}_${get_env("OS_USER_DOMAIN_NAME")}_${path_relative_to_include()}_${basename(get_repo_root())}/lock"
    username       = "${get_env("GITLAB_USERNAME")}"
    password       = "${get_env("CR_GITLAB_ACCESS_TOKEN")}"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = "5"
  }
}

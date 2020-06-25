remote_state {
  backend = "consul" 
  config = {
    address = "consul.castle.local:8501"
    scheme  = "https"
    path    = "${get_env("OS_USER_DOMAIN_NAME","aecid")}/projects/${get_env("OS_PROJECT_NAME","aecid-testbed")}/environment/${path_relative_to_include()}/terraform.tfstate"
    lock = true
    access_token = "806f8499-2948-eec2-7477-d6d6c407e3f0"
  }
}

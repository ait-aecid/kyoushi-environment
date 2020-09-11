remote_state {
  backend = "consul" 
  config = {
    address = "consul.castle.local:8501"
    scheme  = "https"
    path    = "${get_env("OS_USER_DOMAIN_NAME","aecid")}/projects/${get_env("OS_PROJECT_NAME","aecid-testbed")}/environment/${path_relative_to_include()}/terraform.tfstate"
    lock = true
    access_token = "ddf7b2c7-3011-1cf8-fde4-5b3e47266381"
  }
}

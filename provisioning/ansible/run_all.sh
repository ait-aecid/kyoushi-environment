run_playbook () {
  ansible-playbook $1
  if [[ $? -ne 0 ]]; then
    exit
  fi
}
run_playbook ./playbooks/deploy/dns/main.yml
run_playbook ./playbooks/deploy/firewall/main.yml
run_playbook ./playbooks/deploy/certs/main.yml
run_playbook ./playbooks/deploy/ssh_keys/main.yml
run_playbook ./playbooks/deploy/employees/main.yml
run_playbook ./playbooks/deploy/ext_user/main.yml
run_playbook ./playbooks/deploy/mailservers/main.yml
run_playbook ./playbooks/deploy/webserver/main.yml
run_playbook ./playbooks/deploy/wordpress/main.yml
run_playbook ./playbooks/deploy/samba_shares/main.yml
run_playbook ./playbooks/deploy/owncloud/main.yml
run_playbook ./playbooks/deploy/gather/main.yml
run_playbook ./playbooks/deploy/attack_server_takeover/main.yml
run_playbook ./playbooks/deploy/openvpn/main.yml
run_playbook ./playbooks/deploy/attack_exfiltration/main.yml
run_playbook ./playbooks/deploy/kyoushi_simulation/main.yml
run_playbook ./playbooks/deploy/monitoring/main.yml
run_playbook ./playbooks/deploy/monitoring/beats.yml
run_playbook ./playbooks/deploy/audit/main.yml

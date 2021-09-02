ansible-playbook ./playbooks/deploy/dns/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/firewall/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/certs/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/ssh_keys/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/employees/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/ext_user/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/mailservers/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/webserver/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/wordpress/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/samba_shares/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/owncloud/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/gather/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/attack_server_takeover/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/openvpn/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/attack_exfiltration/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/kyoushi_simulation/main.yml
if [[ $? -ne 0 ]]; then
    exit
fi
ansible-playbook ./playbooks/deploy/audit/main.yml

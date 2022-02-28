# Kyoushi Testbed Environment
This tool allows to generate labeled log datasets in simulation testbeds for security evaluations, e.g., IDSs, alert aggregation, or federated learning. 

The testbed simulates an enterprise IT network, involving mail servers, file share, firewall, intranet, DMZ, DNS, VPN, etc. Log data is collected from many sources, including network traffic, apache access logs, DNS logs, syslog, authentication logs, audit logs, suricata logs, exim/mail logs, monitoring logs, etc. The Kyoushi testbed was used to generate the following publicly available log datasets:

 * [AIT-LDSv1](https://zenodo.org/record/4264796)
 * [AIT-LDSv2](https://zenodo.org/record/5789064)
 * [Kyoushi LDS](https://zenodo.org/record/5779411)
 
# Overview
 
The Kyoushi Testbed generates a network with three zones: Intranet, DMZ, and Intranet. Ubuntu VMs that simulate employees are located in all zones, where remote employees access the Intranet through a VPN connection. Employees utilize the Horde Mail platform, access the WordPress platform, share files, browse the web, and access the servers via SSH, while external users only send and respond to mails. The following figure shows an overview of the network.
 
![Network overview](https://i.ibb.co/KVwc6hk/network.png)
 
Several attacks are launched against the network from an attacker host. Thereby, the attacker gets access to the infrastructure through stolen VPN credentials. The following attacks are implemented:

 * Scans (nmap, WPScan, dirb)
 * Webshell upload (CVE-2020-24186)
 * Password cracking (John the Ripper)
 * Privilege escalation
 * Remote command execution
 * Data exfiltration (DNSteal)
 
## Getting Started

This is the main repository for the Kyoushi Testbed Environment that contains all models of the testbed infrastructure; it relies on several other repositories that are responsible for generating testbeds from the models, running user and attacker simulations, labeling log data, etc. The following instructions cover the whole procedure to create a testbed and collect log data from scratch. *Please note*: The Kyoushi Testbed Environment is designed for deployment on cloud infrastructure and will require at least 60 GB of RAM. This getting-started relies on OpenStack, Ansible, and Terragrunt, and assumes that the user is experienced with infrastructure/software provisioning. For the following instructions, we assume that the following packages are installed:

```
Python 3.8.5
Poetry 1.1.7
terragrunt version v0.31.3
ansible [core 2.11.5]
```

### Generating a Testbed from the Models

First, switch into a directory named kyoushi and check out the kyoushi-environment:

```bash
user@ubuntu:~$ mkdir kyoushi
user@ubuntu:~$ cd kyoushi
user@ubuntu:~/kyoushi$ git clone https://github.com/ait-aecid/kyoushi-environment.git
Cloning into 'kyoushi-environment'...
```

The kyoushi-environment contains all models of the testbed infrastructure. These models allow to generate many different testbeds that vary in size and configuration. Testbed parameters that are subject to change include IP addresses of hosts, the number of simulated users, as well as their names and behavior profiles. Most of these parameters are set in the `context.yml.j2` file. Here you can specify the number of users hosts (default: 2 internal, 2 remote, and 2 external users), the number of external mail servers (default: 1), and the times when attacks are carried out. For now, set the `kyoushi_attacker_start` and `dnsteal_endtime` variables to some point in time in the near future, e.g., the following day.

```bash
user@ubuntu:~/kyoushi$ cat /home/user/kyoushi/kyoushi-environment/model/context.yml.j2
{% set employees_internal_count = random.randint(2, 2) %}
{% set employees_remote_count = random.randint(2, 2) %}
{% set ext_mail_users_count = random.randint(2, 2) %}
{% set mail_servers_external_count = random.randint(1, 1) %}
kyoushi_attacker_start: 2021-10-04T{{ (random.randint(9, 14) | string()).zfill(2) }}:{{ (random.randint(0, 59) | string()).zfill(2) }}
kyoushi_attacker_escalate_start: +P00DT{{ (random.randint(3, 4) | string()).zfill(2) }}H{{ (random.randint(0, 59) | string()).zfill(2) }}M
dnsteal_endtime: 2021-10-02T{{ (random.randint(9, 18) | string()).zfill(2) }}:{{ (random.randint(0, 59) | string()).zfill(2) }}
```

The kyoushi-generator transforms the infrastructure models from the kyoushi-environment into setup scripts that are ready for deployment. Clone the kyoushi-generator as follows and install it using poetry:

```bash
user@ubuntu:~/kyoushi$ git clone https://github.com/ait-aecid/kyoushi-generator.git
Cloning into 'kyoushi-generator'...
user@ubuntu:~/kyoushi$ cd kyoushi-generator/
user@ubuntu:~/kyoushi/kyoushi-generator$ poetry install
Creating virtualenv cr-kyoushi-generator-PMpTKTKv-py3.8 in /home/user/.cache/pypoetry/virtualenvs
```

Now you are ready to run the kyoushi-generator. For this, you need to specify the source directory containing the models as well as the destination directory where you want to save the instantiated testbed. Use the following command to save the testbed in the directory called env:

```bash
user@ubuntu:~/kyoushi/kyoushi-generator$ poetry run cr-kyoushi-generator apply /home/user/kyoushi/kyoushi-environment/ /home/user/kyoushi/env
Created TSM in /home/user/kyoushi/env
You can now change to the directory and push TSM to a new GIT repository.
```

But what exactly happened there? Let's have a look at an example to understand the transformation from the testbed-independent models (TIM) to the testbed-specific models (TSM). Have a look at the DNS configuration of our testbed. The configuration file `dns.yml.j2` in the kyoushi-environment is a jinja2 template that does not specify several properties, such as the name of the domain or the number of mail servers. On the other hand, the dns.yml in the newly generated `env` directory contains specific values for all these variables. For example, in the following, the network is named mccoy. Note that these variables are randomly selected and therefore change every time you run the kyoushi-generator.

```bash
user@ubuntu:~/kyoushi/kyoushi-generator$ cat /home/user/kyoushi/kyoushi-environment/provisioning/ansible/group_vars/all/dns.yml.j2
domains:
  \var{context.network_name}:
    id: \var{context.network_name}
    server: inet-dns
    domain: \var{context.network_domain}
    ...
user@ubuntu:~/kyoushi/kyoushi-generator$ cat /home/user/kyoushi/env/provisioning/ansible/group_vars/all/dns.yml
domains:
  mccoy:
    id: mccoy
    server: inet-dns
    domain: mccoy.com
    ...
```

### Testbed Deployment

You are now ready to deploy the testbed. First, go to the keys directory and adjust the settings in the `terragrunt.hcl` file to fit your infrastructure. Then apply the changes:

```bash
user@ubuntu:~/kyoushi$ cd /home/user/kyoushi/env/provisioning/terragrunt/keys/
user@ubuntu:~/kyoushi/env/provisioning/terragrunt/keys$ cat terragrunt.hcl
user@ubuntu:~/kyoushi/env/provisioning/terragrunt/keys$ terragrunt apply
Initializing modules...
```

Next, go to the bootstrap directory and configure the setting to fit your virtualization provider. In particular, you need to change the name of the ubuntu bionic image (default: `kyoushi-ubuntu-bionic`), SSH key (default: `testbed-key`), router (default: `kyoushi-router`), etc. Then use terragrunt to deploy the infrastructure as follows.

```bash
user@ubuntu:~/kyoushi/env/provisioning/terragrunt/keys$ cd ../bootstrap/
user@ubuntu:~/kyoushi/env/provisioning/terragrunt/bootstrap$ cat terragrunt.hcl
user@ubuntu:~/kyoushi/env/provisioning/terragrunt/bootstrap$ terragrunt apply
Initializing modules...
```

Similarly, update the `terragrunt.hcl` file of the hosts directory and again apply the changes:

```bash
user@ubuntu:~/kyoushi/env/provisioning/terragrunt/keys$ cd ../hosts/
user@ubuntu:~/kyoushi/env/provisioning/terragrunt/hosts$ cat terragrunt.hcl
user@ubuntu:~/kyoushi/env/provisioning/terragrunt/hosts$ terragrunt apply
Initializing modules...
```

Once all virtual machines are up and running, you are ready to setup all services. For this, you need to install all requirements in the requirements.txt and requirements.yml file.

```bash
user@ubuntu:~/kyoushi/env/provisioning/terragrunt$ cd ../ansible/
user@ubuntu:~/kyoushi/env/provisioning/ansible$ source activate
user@ubuntu:~/kyoushi/env/provisioning/ansible$ pip3 install -r requirements.txt
user@ubuntu:~/kyoushi/env/provisioning/ansible$ ansible-galaxy install -r requirements.yml
Starting galaxy role install process
...
```

After installing all requirements, you can run all playbooks that are required for the testbed. The script run_all.sh installs all playbooks one after another, so you can just run the script. In case that one of the playbooks fails, the script will be interrupted. After fixing the error, you may also comment out all playbooks that have successfully been installed to save time. In total, running all playbooks may take several hours.

```bash
user@ubuntu:~/kyoushi/env/provisioning/ansible$ chmod +x run_all.sh
user@ubuntu:~/kyoushi/env/provisioning/ansible$ ./run_all.sh
PLAY [Fact gathering pre dns server configuration] 
TASK [Gathering Facts] 
ok: [ext_user_1]
...
```

### Starting the Simulation

After all virtual machines are successfully deployed and configured, the simulation is ready to be started. First, start the employee simulations that carry out normal (benign) activities such as sending mails or sharing files. Run the following playbook to start simulations for internal employees (Intranet zone), remote employees (connect through VPN), and external users (Internet zone). 

```bash
user@ubuntu:~/kyoushi/env/provisioning/ansible$ ansible-playbook playbooks/run/simulation/main.yml
PLAY [Start employee simulations] **************************************************************************************

TASK [Clean SM log] ****************************************************************************************************
skipping: [internal_employee_1]
...
```

To verify that the simulations successfully launched, it is recommended to log into one of the user machines and check the status of the simulation. To access any machine in the testbed, it is necessary to use the management host (mgmthost) as a proxy, e.g., `ssh -J ait@<mgmthost_ip> ait@<employee_ip>`. Note that the user `ait` is available on all machines. The user simulation runs as a service; its current status can be retrived with the command `service ait.beta_user status`. However, it may be more interesting to actually see what the user is currently doing. For this, check out the `sm.log` as shown in the following; the simulation log file generates new lines when new states are reached or actions are executed.

```bash
ait@internal-employee-1:~$ sudo -i
root@internal-employee-1:~# tail /var/log/kyoushi/ait.beta_user/sm.log
{"current_state": "selecting_activity", "level": "info", "message": "Opened horde", "run": "e38ce588-4a7f-409d-b419-e30ede64bf79", "target": "horde_login_check", "timestamp": 1646304147.4995081, "transition": "horde_go_to_horde", "transition_id": "38b772e5-24d6-44e1-83ee-8d052deee5ef"}
{"current_state": "selecting_activity", "level": "info", "message": "Moved to new state", "new_state": "horde_login_check", "run": "e38ce588-4a7f-409d-b419-e30ede64bf79", "target": "horde_login_check", "timestamp": 1646304147.5001175, "transition": "horde_go_to_horde", "transition_id": "38b772e5-24d6-44e1-83ee-8d052deee5ef"}
{"current_state": "horde_login_check", "level": "info", "message": "Executing transition horde_login_check -> name='horde_logged_in_no' -> target=horde_login_page", "run": "e38ce588-4a7f-409d-b419-e30ede64bf79", "target": "horde_login_page", "timestamp": 1646304147.5199068, "transition": "horde_logged_in_no", "transition_id": "fbdf9abb-d56b-4b7c-8e5a-5700dc1110ed"}
{"current_state": "horde_login_check", "level": "info", "message": "Moved to new state", "new_state": "horde_login_page", "run": "e38ce588-4a7f-409d-b419-e30ede64bf79", "target": "horde_login_page", "timestamp": 1646304147.5202732, "transition": "horde_logged_in_no", "transition_id": "fbdf9abb-d56b-4b7c-8e5a-5700dc1110ed"}
{"current_state": "horde_login_page", "level": "info", "message": "Executing transition horde_login_page -> name='horde_login' -> target=horde_selecting_menu", "run": "e38ce588-4a7f-409d-b419-e30ede64bf79", "target": "horde_selecting_menu", "timestamp": 1646304147.5212908, "transition": "horde_login", "transition_id": "9ff90793-ff61-4597-a517-aa33578eb0ee"}
{"current_state": "horde_login_page", "level": "info", "message": "Trying valid login", "password": "X0xVbHXfwZta", "run": "e38ce588-4a7f-409d-b419-e30ede64bf79", "target": "horde_selecting_menu", "timestamp": 1646304153.3251817, "transition": "horde_login", "transition_id": "9ff90793-ff61-4597-a517-aa33578eb0ee", "username": "renee.barnes"}
{"current_state": "horde_login_page", "level": "info", "message": "Logged in", "password": "X0xVbHXfwZta", "run": "e38ce588-4a7f-409d-b419-e30ede64bf79", "target": "horde_selecting_menu", "timestamp": 1646304154.4820826, "transition": "horde_login", "transition_id": "9ff90793-ff61-4597-a517-aa33578eb0ee", "username": "renee.barnes"}
{"current_state": "horde_login_page", "level": "info", "message": "Moved to new state", "new_state": "horde_selecting_menu", "run": "e38ce588-4a7f-409d-b419-e30ede64bf79", "target": "horde_selecting_menu", "timestamp": 1646304177.647844, "transition": "horde_login", "transition_id": "9ff90793-ff61-4597-a517-aa33578eb0ee"}
{"current_state": "horde_selecting_menu", "level": "info", "message": "Executing transition horde_selecting_menu -> name='horde_nav_preferences' -> target=horde_preferences_page", "run": "e38ce588-4a7f-409d-b419-e30ede64bf79", "target": "horde_preferences_page", "timestamp": 1646304177.651773, "transition": "horde_nav_preferences", "transition_id": "7b73236c-f4c4-4e1a-bb0b-1c7b311d6d33"}
{"current_state": "horde_selecting_menu", "level": "info", "message": "Navigating to Global Preferences", "run": "e38ce588-4a7f-409d-b419-e30ede64bf79", "target": "horde_preferences_page", "timestamp": 1646304177.685902, "transition": "horde_nav_preferences", "transition_id": "7b73236c-f4c4-4e1a-bb0b-1c7b311d6d33"}
```

Next, it is necessary to start the attacker simulation. Note that the attacker carries out a sequence of attacks, including scans, remote command execution, password cracking, etc. For more information on the attacks, please refer to the publications stated at the bottom of this page. Run the playbook that starts the simulation as follows.

```bash
user@ubuntu:~/kyoushi/env/provisioning/ansible$ ansible-playbook playbooks/run/attacker_takeover/main.yml
PLAY [Start employee simulations] **************************************************************************************

TASK [Clean SM log] ****************************************************************************************************
skipping: [attacker_0]

TASK [Start attacker SM] ***********************************************************************************************
changed: [attacker_0]

PLAY RECAP *************************************************************************************************************
attacker_0                 : ok=1    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
```

As for the normal user simulations, the attacker simulation runs as a service. To retrieve its status, use the command `service ait.aecid.attacker.wpdiscuz status`. Again, it is worth checking out the statemachine logs. As seen in the following sample, the attacker state machine will be created but wait until the datetime `kyoushi_attacker_start` that was configured earlier is reached. Only then the attack chain is launched.

```bash
root@attacker-0:~# tail /var/log/kyoushi/ait.aecid.attacker.wpdiscuz/sm.log
{"level": "info", "message": "Created state machine", "run": "e5a66416-8fbf-4773-b4f4-3173b1b6b4ff", "seed": 672088864, "timestamp": 1646296446.5048175}
```

The `run_all.sh` script that configured all servers also launched the data exfiltration attack, which is assumed to be already ongoing from the beginning of the simulation and stops at some point in time. Check out the logs of this attack case to ensure that the exfiltration script is actually transferring the data. The logs should appear similar to the following sample:

```bash
root@attacker-0:~# tail /var/log/dnsteal.log
{"data_length": 180, "event": "Received data", "file": "b'2010_invoices.xlsx'", "level": "info", "timestamp": 1646298257.592706}
{"data": "b'3x6-.2-.s0sYjwCEihbeKKNdbIOdYlZo6A7EeRg3GTklJq5XPo9bAlWYdiD9Dh8tkuMAj-.1vpJnNwUmtnTNZXSPAF7sPBeqN0nvmS9D4Z79cVp7mO3H*ZSxEQYAIPDASkBw-.2010_invoices.xlsx.lt-22.kelly-livingston.com.'", "event": "Received data text on server", "ip": "192.168.87.64", "level": "debug", "port": 53, "timestamp": 1646298257.5934248}
...
```

### Log Data Collection

Once the simulation is completed (i.e., the attack

### Log data Labeling

## Publications

If you use the Kyoushi Testbed Environment or any of the generated datasets, please cite the following publications: 

* Landauer M., Skopik F., Wurzenberger M., Hotwagner W., Rauber A. (2021): [Have It Your Way: Generating Customized Log Data Sets with a Model-driven Simulation Testbed.](https://ieeexplore.ieee.org/document/9262078) IEEE Transactions on Reliability, Vol.70, Issue 1, pp. 402-415. IEEE. [PDF](https://www.skopik.at/ait/2020_trel.pdf)
* Landauer M., Skopik F., Frank M., Hotwagner W., Wurzenberger M., Rauber A. (2022): Maintainable Log Datasets for Evaluation of Intrusion Detection Systems. Under Review.
* Landauer M., Frank M., Skopik F., Hotwagner W., Wurzenberger M., Rauber A. (2022): A Framework for Automatic Labeling of Log Datasets from Model-driven Testbeds for HIDS Evaluation. Proceedings of the Workshop on Secure and Trustworthy Cyber-Physical Systems, forthcoming. ACM.

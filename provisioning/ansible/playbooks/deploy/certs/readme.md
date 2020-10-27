# Certs

> Category: Deploy



The certs-playbook generates local private keys and certificates. In the first phase, it creates a certificate authority (CA) certificate, which is then in the later phases used to sign further certificates.  In the second phase host-based certificates based on specific sites are created, whereas in the third and last phase SMIME email certificates are generated. All of them are stored locally following the following structure:

```bash
data
├── certs
│   ├── mails
│   │   ├── *domains*
│   │   │   ├── *email_users*
│   └── sites
│       ├── *hosts*
```





## 1. Manage CA authority

**Hosts:** localhost
**Roles:** -

The purpose of the playbook is to generate the CA certificate. The path, names and credentials for the certificate are defined in group_vars/all/ca.yml. Thereby, the path where the certificate is generated is relative to the local ansible base folder, which is looked up in the following line:   

```yml
ca_base_path: "{{ lookup('env','LOCAL_PACKAGE_ANSIBLE_PATH') }}/data/certs"
```

**Steps of playbook:**

1. Respective directories are created.
2. Generate CA private Key [ansible openssl-module]
3. Generate CA signing request (CSR) for self-signing [ansible openssl-module] 
4. In case a certificate is present in the directory, its validity is checked
5. Generate CA certificate, signed by the previously generated private key



## 2. Manage host certificates

**Hosts:** localhost
**Roles:** -

This playbook locally generates certificates for all required sites. These certificates are then stored in /ansible/data/certs/sites.

A custom filter, defined in plugins/filter/fqdn_filters.py, called get_host_certificates is used to collect certificates information, which are then passed to the "Manage host certificates" tasks. 

**Steps of playbook:**

1. Create local certificate directories for each host, defined by the passed in domain_info from main.yml 
2. Generate a private key per host [ansible openssl-module]
3. Generate signing requests (CSR) [ansible openssl-module] 
4. Check for existing certificates and verify its validity
5. Sign host-certificate by previously generated CA certificate



## 3. Manage email certificates

**Hosts:** localhost
**Roles:** -

This playbook generates SMIME certificates for signed email communication when required. These certificates are then stored in /ansible/data/certs/mails/**domain/email_username**.

The used variables are set by utilizing jinja's json_query:

```yml
mail_servers: |
      {{ 
        groups['mailservers'] | map('extract', hostvars) | list 
        | json_query('[].{hostname: inventory_hostname, 
        domain: postfix_myhostname, email_users:email_users}')
      }}
```

A list of hostnames is created by searching for the *mailservers* group from the hosts-file and extracting the corresponding hostvars. It then applies a json_query to select only the required information:

- **hostname,** which corresponse to the designation from the hosts-file
- **domain,** which is defined in the respective host_vars files (e.g. /host_vars/control_mailserver/mail.yml)
- **email_users,** defined in /group_vars/mailservers/mail.yml, which is a list comprising all email_users_host, defined in the respective host_vars (e.g. /host_vars/control_mailserver/mail.yml), all email_users_group, defined in the /group_vars/mailservers/mail.yml and the email_users_all, also defined in the /group_vars/mailservers/mail.yml consisting of extra email users which are appended to the list. From the collected information, the email user, the part followed by the *@*-symbol and the hashed password is extracted.

**Steps of playbook:**

1. Create local certificate directories for each email_user 
2. Generate a private key per email_user [ansible openssl-module]
3. Generate signing requests (CSR) [ansible openssl-module] 
4. Check for existing certificates and verify its validity
5. Sign SMIME-certificate by previously generated CA certificate
6. Create PKCS version of the certificate for thunderbird and firefox
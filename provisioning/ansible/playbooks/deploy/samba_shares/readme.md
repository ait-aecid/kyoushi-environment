# Samba Shares

> Category: Deploy


## 1. Setup and configure samba shares

**Hosts:** share
**Roles:** 

- **grog.group**
  This role uses a provided group list which are then created on the host. In the case of the samba-shares, these lists are defined in the respective configuration files `/host_vars/<samba share>/samba.yml`. The `samba_groups` dictionary is converted into a flat list of unix groups.

- **grog.user**
  The grog.user-role uses the `user_list_host` to create the required user accounts, which is defined in `/group_vars/share/samba.yml`.

  The user information is gathered in the corresponding host_vars, `/host_vars/<share name>/samba.yml`, from the `samba_users`.
  All passwords are hashed as it is required by the role.

- **samba**

  General samba configuration is defined using the variables in `/group_vars/shares/samba.yml`. Within this role, samba is installed and configured and the access for samba users is managed. The `samba_users` are parsed from the `game_users` dictionary based on the `samba_groups` attribute.
  All necessary user groups defined for the samba groups are added to the user dictionaries.

**Additional tasks of the playbook:**

1. Creates folder structure for files to be copied to the shares
2. Copies defined files to shares 



These files are e.g. defined as follows:

```yml
smb_extra_files_base: files/accounting

smb_extra_files:
  Billing:
    - src: Billing
      directory: true
      recursive: yes
      owner: m03
  Customers:
    - src: Customers
      owner: m03
      directory: true
      recursive: yes
```

Where smb_extra_files_base depicts the source folder on the ansible orchestration machine. The first layer of smb_extra_files represents the target share name of the remote server. By using recursive mode, the directory and all files within are copied to the server with the default settings and ownership, provided in this dict. It can also be specified using an owner attribute. Per default, recursive is set to false, resulting in copying only the corresponding file.


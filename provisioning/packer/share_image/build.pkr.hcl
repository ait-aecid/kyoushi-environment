build {
  sources = ["source.openstack.builder"]

  provisioner "shell" {
    inline = [
        "echo 'Waiting for cloud-init to finish...'", 
        "/usr/bin/cloud-init status --wait"
    ]
  }

  provisioner "shell" {
    script = "scripts/prep-ansible.sh"
  }

  provisioner "ansible" {
    groups        = "${var.ansible_groups}"
    playbook_file = "playbook/main.yaml"
    user          = "${var.build_user}"
    use_proxy     = false
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; sudo {{ .Vars }} {{ .Path }}"
    script          = "scripts/cleanup.sh"
  }
}
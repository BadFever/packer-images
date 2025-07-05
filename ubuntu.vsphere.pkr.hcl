packer {
  required_plugins {
    vsphere = {
      version = "~> 1"
      source  = "github.com/hashicorp/vsphere"
    }
    ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
  }
}

source "vsphere-iso" "ubuntu.vsphere" {

  vm_name = "packer_${local.build_os}_${local.build_time}"

  # vm settings
  guest_os_type = "${var.guest_os_type}"
  firmware = "${var.firmware}"
  vm_version = "${var.vm_version}"
  CPUs = "${var.cpus}"
  cpu_cores = "${var.cpu_cores}"
  CPU_reservation = "${var.cpu_reservation}"
  CPU_limit = 0
  CPU_hot_plug = "${var.hot_plug}"
  RAM = "${var.memory}"
  RAM_reservation = "${var.memory_reservation}"
  RAM_reserve_all = false
  RAM_hot_plug = "${var.hot_plug}"
  network_adapters { 
    network = "${var.vsphere_network}"
    network_card = "vmxnet3"
  }
  disk_controller_type = ["pvscsi"]
  storage { 
    disk_size = "${var.disk_size}"
    disk_thin_provisioned = ${var.thin_provisioned}
    disk_controller_index = 0 
  }
  configuration_parameters = { 
    "disk.EnableUUID" = "TRUE" 
  }


  boot_wait = "${var.boot_wait}"
  boot_command = "${var.boot_command}"
  shutdown_command = "echo 'VMware1!' | sudo -S shutdown -P now"
  iso_url = "${var.iso_url}"
  iso_checksum = "${var.iso_checksum}"
  ssh_username = "mystic"
  ssh_password = "VMware1!"
  ssh_pty = true
  ssh_timeout = "20m"
  ssh_handshake_attempts = 50
  cd_files = [
    "./autoinstall/meta-data",
    "./autoinstall/user-data"]
  cd_label = "cidata"

  # VSPHERE SETTINGS

  vcenter_server = "${var.vsphere_vcenter_server}"
  username = "${var.vsphere_username}"
  password = "${var.vsphere_password}"
  insecure_connection = "${var.vsphere_insecure_connection}"
  datacenter = "${var.vsphere_datacenter}"
  host = "${var.vsphere_host}"
  datastore = "${var.vsphere_datastore}"
  folder = "${var.vsphere_folder}"

}

build {
  sources = ["sources.vsphere-iso.ubuntu.vsphere"]

  provisioner "shell" {
    execute_command = "echo 'VMware1!' | {{.Vars}} sudo -E -S bash '{{.Path}}'"
    expect_disconnect = true
    scripts = [
      "./provisioner/bootstrap.sh"
    ]
    pause_before = "15s"
  }

  provisioner "ansible-local" {
    playbook_file = "./provisioner/${var.install_base}/playbook.yml"
    galaxy_file = "./provisioner/${var.install_base}/requirements.yml"
    galaxy_roles_path = "/usr/share/ansible/roles"
    extra_arguments = [
      "--extra-vars",
      "\"bootstrap_ansible_user_ssh_public_key='${var.mystic_user_ssh_public_key}'\""
    ]
  }

  post-processors {
    post-processor "vsphere-template"{
      host                = "${var.vsphere_vcenter_server}"
      insecure            = "${var.vsphere_insecure_connection}"
      username            = "${var.vsphere_username}"
      password            = "${var.vsphere_password}"
      datacenter          = "${var.vsphere_datacenter}"   
      folder              = "/${var.vsphere_folder}"
    }
  }

}
packer {
  required_version = ">= 1.7.0"
  required_plugins {
    vsphere = {
      version = ">= 1.2.3"
      source  = "github.com/hashicorp/vsphere"
    }
  }

  required_plugins {
    windows-update = {
      version = ">= 0.14.3"
      source  = "github.com/rgl/windows-update"
    }
  }
}

source "vsphere-iso" "vsphere" {
  # VM Settings
  vm_name              = "Template-W2025-${var.build_type}-${var.install_language}-${local.build_time}"
  firmware             = "efi"
  CPUs                 = "${var.cpus}"
  cpu_cores            = "${var.cpu_cores}"
  CPU_reservation      = 0
  CPU_limit            = 0
  CPU_hot_plug         = true
  RAM                  = "${var.memory}"
  RAM_reserve_all      = false
  RAM_reservation      = 0
  RAM_hot_plug         = true
  guest_os_type        = "${var.guest_os_type}"
  vm_version           = "${var.vm_version}"
  disk_controller_type = ["pvscsi"]

  network_adapters {
    network      = "${var.vsphere_network}"
    network_card = "vmxnet3"
  }
  
  storage {
    disk_size             = "${var.disk_size}"
    disk_thin_provisioned = false
  }

  # vSphere Settings
  vcenter_server       = "${var.vsphere_vcenter_server}"
  username             = "${var.vsphere_username}"
  password             = "${var.vsphere_password}"
  datacenter           = "${var.vsphere_datacenter}"
  cluster              = "${var.vsphere_compute_cluster}"
  host                 = "${var.vsphere_host}"
  datastore            = "${var.vsphere_datastore}"
  folder               = "${var.vsphere_folder}"
  insecure_connection  = "${var.vsphere_insecure_connection}"

  ip_wait_timeout      = "3600s"
  floppy_files         = ["setup/${var.build_type}/autounattend.xml","setup/bootstrap.ps1"]
  iso_paths            = ["${var.iso_path}","${var.tools_path}"]
  communicator         = "ssh"
  ssh_username         = "Administrator"
  ssh_password         = "${var.ssh_password}"
  ssh_timeout          = "${var.ssh_timeout}"
  ssh_clear_authorized_keys = "true"

  boot_wait = "3s"
  boot_command = ["<spacebar><spacebar>"]

  remove_cdrom = true

  content_library_destination {
    library = "${var.vsphere_content_library}"
    name = "win2025-${var.build_type}-latest"
    ovf = true
    destroy = true
  }

}

build {
  sources = ["source.vsphere-iso.vsphere"]

  provisioner "powershell" {
    script   = "./provisioning/services.ps1"
  }

  provisioner "powershell" {
    script   = "./provisioning/customize.ps1"
  }

  provisioner "powershell" {
    script   = "./provisioning/cleanup.ps1"
  }
  
  provisioner "windows-shell" {
    inline = ["ipconfig"]
  }

  #provisioner "windows-update" {
  #  filters = [
  #    "exclude:$_.Title -like '*VMware*'",
  #    "include:$true"
  #  ]
  #}

}
packer {
  required_plugins {
    vmware = { version = ">=1.0.0", source = "github.com/hashicorp/vmware" }
  }
}

source "vmware-iso" "fusion-rl" {
  iso_url            = var.iso_url
  iso_checksum       = var.iso_checksum
  firmware           = "efi"
  version            = 21
  communicator       = "ssh"
  ssh_username       = "root"
  ssh_password       = "packer"
  ssh_wait_timeout   = "20m"
  boot_wait          = "5s"
  boot_command       = [
    "<tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks-fusion.cfg<enter><wait>"
  ]
  shutdown_command   = "shutdown -P now"
  disk_size          = 40960
  memory             = 2048
  cpus               = 2
  guest_os_type      = "rhel9_64Guest"
  http_directory     = "kickstart"
  vm_name            = "rocky-packer-fusion"
}

build {
  sources = ["source.vmware-iso.fusion-rl"]
}
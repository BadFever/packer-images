# variables.pkr.hcl

## GENERAL

variable "iso_path" { 
  type = string
  default = ""
}
variable "iso_checksum" { 
  type = string 
  default = "none"
}
variable "build_os" { 
  type = string 
}
variable "build_type" { 
  type = string 
}
variable "cd_files" { 
  type = list(string)
  default = []
}
variable "tools_path" { 
  type = string
  default = ""
}
variable "kickstart_path" { 
  type = string
  default = ""
}

## PROVISIONING SETTINGS

variable "ssh_timeout" { 
  type = string
  default = "30m" 
}
variable "boot_wait" { 
  type = string
  default = "1s" 
}
variable "mystic_user_ssh_public_key" { 
  type = string
  default = ""
}
variable "boot_command" { 
  type = list(string)
  default = []
}
variable "ssh_username" { 
  type = string
  default = "mystic"
}
variable "ssh_password" { 
  type = string
  sensitive = true
  default = "VMware1!"
}



# vm settings
variable "guest_os_type" { type = string }
variable "vm_version" { 
  type = number
  default = 21
}
variable "firmware" { 
  type = string
  default = "efi"
}
variable "disk_size" { 
  type = string
  default = "25600"
}
variable "thin_provisioned" { 
  type = bool
  default = true
}
variable "memory" { 
  type = string
  default = "4096"
}
variable "cpus" { 
  type = string
  default = "2"
}
variable "cpu_cores" { 
  type = string
  default = "1"
}
variable "cpu_reservation" { 
  type = number
  default = 0
}
variable "hot_plug" { 
  type = bool
  default = true
}
variable "memory_reservation" { 
  type = number
  default = 0
}

## VSPHERE SETTINGS

variable "vsphere_vcenter_server" { 
  type = string 
  default = ""
}
variable "vsphere_username" { 
  type = string
  default = ""
}
variable "vsphere_password" {
  type = string
  sensitive = true
  default = ""
}
variable "vsphere_insecure_connection" {
  type = bool
  default = true
}
variable "vsphere_datacenter" {
  type = string
  default = ""
}
variable "vsphere_datastore" { 
  type = string
  default = ""
}
variable "vsphere_host" {
  type = string
  default = "" 
}
variable "vsphere_network" { 
  type = string 
  default = ""
}
variable "vsphere_folder" { 
  type = string
  default = "/Discovered virtual machine"
}
variable "vsphere_compute_cluster" { 
  type = string
  default = ""
}
variable "vsphere_content_library" { 
  type = string
  default = ""
}

## LOCALS

locals {
  build_time = formatdate("YYYYMMDD'T'hhmmss",timestamp())
}
variable "iso_path" { 
  type        = string
  default     = ""
  description = "URL or path to the installation ISO image."
}
variable "iso_checksum" { 
  type        = string 
  default     = "none"
  description = "Checksum value for the ISO image to verify integrity."
}
variable "build_os" { 
  type        = string 
  description = "Operating system identifier for the build."
}
variable "build_type" { 
  type        = string 
  description = "Build type or variant (e.g., minimal, server, desktop)."
}
variable "cd_files" { 
  type        = list(string)
  default     = []
  description = "List of files to include on a virtual CD/DVD during build."
}
variable "tools_path" { 
  type        = string
  default     = ""
  description = "Path to VMware tools or guest agent installer files."
}
variable "kickstart_path" { 
  type        = string
  default     = ""
  description = "Path or URL to the kickstart/automated installation file."
}
variable "ssh_timeout" { 
  type        = string
  default     = "30m" 
  description = "Timeout duration for SSH connection during provisioning."
}
variable "boot_wait" { 
  type        = string
  default     = "1s" 
  description = "Wait time before sending boot commands after VM starts."
}
variable "mystic_user_ssh_public_key" { 
  type        = string
  default     = ""
  description = "SSH public key string for the 'mystic' user."
}
variable "boot_command" { 
  type        = list(string)
  default     = []
  description = "List of keystrokes to send to the VM during boot."
}
variable "ssh_username" { 
  type        = string
  default     = "mystic"
  description = "Username for SSH login during provisioning."
}
variable "ssh_password" { 
  type        = string
  sensitive   = true
  default     = "VMware1!"
  description = "Password for SSH login during provisioning."
}
variable "guest_os_type" { 
  type        = string 
  description = "Guest OS identifier for the virtual machine (e.g., centos9-64)."
}
variable "vm_version" { 
  type        = number
  default     = 21
  description = "VMware virtual hardware version."
}
variable "firmware" { 
  type        = string
  default     = "efi"
  description = "Firmware type for the VM (e.g., bios or efi)."
}
variable "disk_size" { 
  type        = string
  default     = "25600"
  description = "Disk size for the VM in megabytes."
}
variable "thin_provisioned" { 
  type        = bool
  default     = true
  description = "Whether the virtual disk should be thin provisioned."
}
variable "memory" { 
  type        = string
  default     = "4096"
  description = "Amount of memory assigned to the VM in megabytes."
}
variable "cpus" { 
  type        = string
  default     = "2"
  description = "Number of CPUs assigned to the VM."
}
variable "cpu_cores" { 
  type        = string
  default     = "1"
  description = "Number of cores per CPU."
}
variable "cpu_reservation" { 
  type        = number
  default     = 0
  description = "CPU resource reservation in MHz."
}
variable "hot_plug" { 
  type        = bool
  default     = true
  description = "Enable CPU and memory hot plug support."
}
variable "memory_reservation" { 
  type        = number
  default     = 0
  description = "Memory resource reservation in MB."
}
variable "vsphere_vcenter_server" { 
  type        = string 
  default     = ""
  description = "vCenter server hostname or IP address."
}
variable "vsphere_username" { 
  type        = string
  default     = ""
  description = "Username for vSphere authentication."
}
variable "vsphere_password" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Password for vSphere authentication."
}
variable "vsphere_insecure_connection" {
  type        = bool
  default     = true
  description = "Allow insecure SSL connections to vCenter (skip cert validation)."
}
variable "vsphere_datacenter" {
  type        = string
  default     = ""
  description = "Target vSphere datacenter for VM deployment."
}
variable "vsphere_datastore" { 
  type        = string
  default     = ""
  description = "Datastore name for VM files."
}
variable "vsphere_host" {
  type        = string
  default     = "" 
  description = "ESXi host for VM placement."
}
variable "vsphere_network" { 
  type        = string 
  default     = ""
  description = "Network name or portgroup for VM network adapter."
}
variable "vsphere_folder" { 
  type        = string
  default     = "/Discovered virtual machine"
  description = "Folder path inside vSphere inventory."
}
variable "vsphere_compute_cluster" { 
  type        = string
  default     = ""
  description = "Compute cluster for VM placement."
}
variable "vsphere_content_library" { 
  type        = string
  default     = ""
  description = "Content library to use for VM templates or ISO storage."
}
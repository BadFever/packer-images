packer {
  required_plugins {
    vsphere = {
      version = "~> 1"
      source  = "github.com/hashicorp/vsphere"
    }
    vmware = {
      version = "~> 1"
      source  = "github.com/hashicorp/vmware"
    }
    ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
    windows-update = {
      version = "~> 0.14.3"
      source  = "github.com/rgl/windows-update"
    }
  }
}
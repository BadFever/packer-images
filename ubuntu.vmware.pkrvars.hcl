# ubuntu.vmware
ssh_username    = "mystic"
ssh_password    = "VMware1!"
guest_os_type   = "ubuntu-64"
build_os        = "ubuntu"
build_type      = "efi"
iso_path        = "build/iso/ubuntu-24.04.2-live-server-amd64.iso"
disk_size       = 25600

boot_command    = [
        "<wait><wait><wait>c<wait><wait><wait>",
        "linux /casper/vmlinuz --- autoinstall ipv6.disable=1<enter><wait>",
        "initrd /casper/initrd<enter><wait>",
        "boot<enter><wait>"
        ]
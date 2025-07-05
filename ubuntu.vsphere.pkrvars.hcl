guest_os_type = "ubuntu64guest"
build_os = "ubuntu"

boot_command = [
        "<wait><wait><wait>c<wait><wait><wait>",
        "linux /casper/vmlinuz --- autoinstall ipv6.disable=1<enter><wait>",
        "initrd /casper/initrd<enter><wait>",
        "boot<enter><wait>"
        ]
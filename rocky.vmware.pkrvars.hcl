
ssh_username    = "mystic"
ssh_password    = "VMware1!"
guest_os_type   = "centos9-64"
build_os        = "rocky"
build_type      = "efi"
iso_path        = "https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.6-x86_64-minimal.iso"
iso_checksum    = "file:https://download.rockylinux.org/pub/rocky/9/isos/x86_64/CHECKSUM"


disk_size       = 25600

boot_command    = [
        "<tab> inst.text inst.ks=hd:fd0:/rocky.ks<enter>",
        ]
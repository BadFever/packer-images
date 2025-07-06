# Rocky Linux 9 automated installation
text
lang en_US.UTF-8
keyboard de
timezone UTC --isUtc
network --bootproto=dhcp --device=eth0 --activate
url --url=file:///run/install/repo

zerombr
clearpart --all --initlabel
autopart

# No root password, lock root
rootpw --lock

# Create user 'mystic' with password 'VMware1!'
user --name=mystic --password=VMware1! --plaintext --groups=wheel

# Enable SSH access
firewall --enabled --service=ssh
services --enabled=sshd

%packages
@^minimal-environment
openssh-server
%end

%post --log=/tmp/ks-post.log
dnf -y install cloud-init
systemctl enable sshd
%end

reboot
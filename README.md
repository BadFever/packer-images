# packer-images

Central collection of multiple packer builds.

## Setup

1. Install packer
2. Download git repositories
3. Populate a folder build/iso with the required iso image
4. Modify the pkrvars.hcl files to customize the builds
5. Start building images

## Images

- Windows Server 2025
- Ubuntu

## Build Images

```bash
packer build -var-file wins2025.vmware.pkrvars.hcl -only vmware-iso.wins2025 .
packer build -var-file ubuntu.vmware.pkrvars.hcl -only vmware-iso.ubuntu .
```
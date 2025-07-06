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
- Ubuntu 24
- Rocky 9
- Rocky 10

## Build Images

### Workstation Builds

VMware Workstation or Fusion builds should work without modifing the existing `pkrvars.hcl` files as no secrets are involved.

```bash
packer build -var-file wins2025.vmware.pkrvars.hcl -only vmware-iso.wins2025 .
packer build -var-file ubuntu.vmware.pkrvars.hcl -only vmware-iso.ubuntu .

packer build -var-file rocky9.vmware.pkrvars.hcl -only vmware-iso.rocky .
packer build -var-file rocky10.vmware.pkrvars.hcl -only vmware-iso.rocky .
```
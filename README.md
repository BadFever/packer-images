# packer-images

Central collection of multiple packer builds.

## Images

- Windows Server 2025
- Ubuntu

## Build Images

```bash
packer build -var-file wins2025.workstation.pkrvars.hcl -only vmware-iso.wins2025 .
```
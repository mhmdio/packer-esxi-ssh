# Packer Build on VMware ESXi

Use Packer to build VM on ESXi 7.0u1

- build machines directly on VMware vSphere Hypervisor using SSH (as opposed to the vSphere API)

## Building Requirements

- Packer
- ovftool
- ESXi host connectivity
- ESXi host username and password with permission

## ESXi Requirements

- enable ssh
- enable shell
- run `esxcli system settings advanced set -o /Net/GuestIPHack -i 1`

## Packer commands

```bash
cd OS_FOLDER
packer fmt .        # Rewrites HCL2 config files to canonical format 
packer validate .   # check that a template is valid
packer inspect .    # see components of a template
packer build .      # build image(s) from template
```

## ovftool

Download from [here](https://my.vmware.com/group/vmware/downloads/details?downloadGroup=OVFTOOL441&productId=742)

### macOS

```bash
ln -s /Applications/"VMware OVF Tool"/ovftool /usr/local/bin/ovftool
```

## Packer Templates

- LTS -> [linux-ubuntu-20.04](./linux-ubuntu-20.04/)
- [linux-ubuntu-20.10](./linux-ubuntu-20.10/)
- [linux-alpine](./linux-alpine/)

## Troubleshoot

- Networking: make sure VMs are getting IPv4 from DHCP.

## References

- (ubuntu autoinstall)[https://ubuntu.com/server/docs/install/autoinstall-reference]
- (packer vmware-iso source)[https://www.packer.io/docs/builders/vmware/iso]

## Generate Hash Password

user-data file (cloud-init) used hashed Password.

```bash
printf vagrant | mkpasswd -m sha-512 -S vagrant. -s
```

## Packer autoinstall

Packer autoinstall can be done with cloud-init by  passing meta-data and user-data with one of the following methods:

- via CD drive, you need to pass `autoinstall ds=nocloud;seedfrom=/cidata/` [not all OS reqiure this]
- via HTTP IP and HTTP Port, you need to pass `autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/`

## Build

Packer will generate OVA (OVF package) for each image in [build](./build) folder.

Tested import OVA on:

- macOS - VMware Fusion

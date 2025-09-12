---
title: "Cloud Hypervisor v48.0 Released!"
date: 2025-09-12T23:05:40Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in [v48.0 group](https://github.com/orgs/cloud-hypervisor/projects/6/views/4?filterQuery=release%3A%22Release+48%22) of our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6/).

### Experimental `fw_cfg` Device Support

This feature enables passing configuration data and files, such as VM
boot configurations (kernel, kernel cmdline, e820 memory map, and ACPI
tables), from the host to the guest. (#7117)

### Experimental `ivshmem` Device Support

Support for inter-VM shared memory has been added. For more information,
please refer to the [ivshmem documentation](docs/ivshmem.md). (#6703)

### Firmware Boot Support on `riscv64`

In addition to direct kernel boot, firmware boot support has been added
on `riscv64` hosts. (#7249)

### Increased vCPU Limit on x86_64/kvm

The maximum number of supported vCPUs on x86_64 hosts using KVM has been
raised from 254 to 8192. (#7299)

### Improved Block Performance with Small Block Sizes

Performance for `virtio-blk` with small block sizes (16KB and below)
is enhanced via submitting async IO requests in batches. (#7146)

### Faster VM Pause Operation

The VM pause operation now is significantly faster particularly for VMs
with a large number of vCPUs. (#7290)

### Updated Documentation on Windows Guest Support

Our Windows documentation now includes instructions to run Windows 11
guests, in addition to Windows Server guests. (#7218)

### Policy on AI Generated Code

We will decline any contributions known to contain contents generated or
derived from using Large Language Models (LLMs). Details can be found
in our [contributing documentation](CONTRIBUTING.md). (#7162)

### Removed SGX Support

The SGX support has been removed, as announced in the deprecation notice two
release cycles ago. (#7093)

### Notable Bug Fixes

* Seccomp filter fixes with glibc v2.42 (#7327)
* Various fixes related to  (#7331, #7334, #7335)

### Contributors

Many thanks to everyone who has contributed to our release:

*  Alex Orozco <alexorozco@google.com>
*  Alyssa Ross <hi@alyssa.is>
*  Anirudh Rayabharam <anrayabh@microsoft.com>
*  Bo Chen <bchen@crusoe.ai>
*  Demi Marie Obenour <demiobenour@gmail.com>
*  Lucas Grosche <lucas.grosche@cyberus-technology.de>
*  Muminul Islam <muislam@microsoft.com>
*  Oliver Anderson <oliver.anderson@cyberus-technology.de>
*  Peter Oskolkov <posk@google.com>
*  Philipp Schuster <philipp.schuster@cyberus-technology.de>
*  Ruoqing He <heruoqing@iscas.ac.cn>
*  Shubham Chakrawar <schakrawar@crusoe.ai>
*  Songqian Li <sionli@tencent.com>
*  Wei Liu <liuwe@microsoft.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v48.0">GitHub Release</a> for the release assets.

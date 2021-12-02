---
title: "Cloud Hypervisor v20.0 Released!"
date: 2021-12-02T16:15:22Z
draft: false
contributors: [Cloud Hypervisor Team]
---
# v20.0

This release has been tracked through the [v20.0
project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/23).

### Multiple PCI segments support

Cloud Hypervisor is no longer limited to 31 PCI devices. For both `x86_64` and
`aarch64` architectures, it is now possible to create up to 16 PCI segments,
increasing the total amount of supported PCI devices to 496.

### CPU pinning

For each vCPU, the user can define a limited set of host CPUs on which it is
allowed to run. This can be useful when assigning a 1:1 mapping between host and
guest resources, or when running a VM on a specific NUMA node.

### Improved VFIO support

Based on VFIO region capabilities, all regions can be memory mapped, limiting
the amount of triggered VM exits, and therefore increasing the performance of
the passthrough device.

### Safer code

Several sections containing unsafe Rust code have been replaced with safe
alternatives, and multiple comments have been added to clarify why the remaining
unsafe sections are safe to use.

### Extended documentation

The documentation related to VFIO has been updated while some new documents have
been introduced to cover the usage of `--cpus` parameter as well as how to run
Cloud Hypervisor on Intel TDX.

### Notable bug fixes

* Naturally align PCI BARs on relocation (#3244)
* Fix panic in SIGWINCH listener thread when no seccomp filter set (#3338)
* Use the tty raw mode implementation from libc (#3344)
* Fix the emulation of register D for CMOS/RTC device (#3393)

### Contributors

Many thanks to everyone who has contributed to our release:

* Alyssa Ross <hi@alyssa.is>
* Bo Chen <chen.bo@intel.com>
* Fabiano Fidêncio <fabiano.fidencio@intel.com>
* Michael Zhao <michael.zhao@arm.com>
* Muminul Islam <muislam@microsoft.com>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Wei Liu <liuwe@microsoft.com>
* Willen Yang <willenyang@gmail.com>
* William Douglas <william.douglas@intel.com>
* Ziye Yang <ziye.yang@intel.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v20.0">GitHub Release</a> for the release assets.

---
title: "Cloud Hypervisor v20.1 Released!"
date: 2021-12-13T15:06:54Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This is a bug fix release. The following issues have been addressed:

* Networking performance regression with `virtio-net` (#3450)
* Limit file descriptors sent in `vfio-user` support (#3401)
* Fully advertise PCI MMIO config regions in ACPI tables (#3432)
* Set the TSS and KVM identity maps so they don't overlap with firmware RAM
* Correctly update the `DeviceTree` on restore

### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v20.1">GitHub Release</a> for the release assets.

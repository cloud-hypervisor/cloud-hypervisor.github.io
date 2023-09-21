---
title: "Cloud Hypervisor v35.0 Released!"
date: 2023-09-21T14:47:24Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration v35.0.
The following user visible changes have been made:

### `virtio-vsock` Support for Linux Guest Kernel v6.3+

Since kernel v6.3, a vsock packet can be included in a single descriptor,
instead of being split over two descriptors. Our `virtio-vsock` implementation
now support both situations.

### User Specified Serial Number for `virtio-block`

A new option `serial` is added to the `--block` command that allows users to
specify a serial number for block devices which will be guest visible.

### vCPU TSC Frequency Included in Migration State

This ensures migration works correctly between hosts that have different TSC
frequencies if the guest is running with TSC as the source of timekeeping.

### Notable Bug Fixes

* Disallow concurrent CPU resizing (#5668)
* Handle APIC EOI message for MSHV (#5681)
* Use wrapping add for memory offset from instruction emulator (#5719)
* Add global spell check via the 'typos' GitHub action (#5720)
* Ensure probing reads are block size aligned (#5727)
* Multiple bug fixes around the latency counter for block devices
  (#5712, #5750, #5762, #5763)
* Replace unsound `static mut` with `once_cell` (#5772)

### Contributors

Many thanks to everyone who has contributed to our release:

*  Alyssa Ross <hi@alyssa.is>
*  Anatol Belski <anbelski@linux.microsoft.com>
*  Bo Chen <chen.bo@intel.com>
*  Christian Blichmann <cblichmann@google.com>
*  Jianyong Wu <jianyong.wu@arm.com>
*  Jinank Jain <jinankjain@microsoft.com>
*  Julian Stecklina <julian.stecklina@cyberus-technology.de>
*  Omer Faruk Bayram <omer.faruk@sartura.hr>
*  Philipp Schuster <philipp.schuster@cyberus-technology.de>
*  Rob Bradford <rbradford@rivosinc.com>
*  Ruslan Mstoi <ruslan.mstoi@intel.com>
*  Thomas Barrett <tbarrett@crusoeenergy.com>
*  Wei Liu <liuwe@microsoft.com>
*  Yi Wang <foxywang@tencent.com>
*  zhongbingnan <zhongbingnan@bytedance.com>

### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v35.0">GitHub Release</a> for the release assets.

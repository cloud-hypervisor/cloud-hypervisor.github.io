---
title: "Cloud Hypervisor v19.0 Released!"
date: 2021-10-14T15:36:27Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked through the [v19.0 project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/22).

### Improved PTY handling for serial and `virtio-console`

The PTY support for serial has been enhanced with improved buffering when the
the PTY is not yet connected to. Using `virtio-console` with PTY now results in
the console being resized if the PTY window is also resized.

### PCI boot time optimisations

Multiple optimisations have been made to the PCI handling resulting in
significant improvements in the boot time of the guest.

### Improved TDX support

When using the latest TDVF firmware the ACPI tables created by the VMM are now
exposed via the firmware to the guest. 

### Live migration enhancements

Live migration support has been enhanced to support migration with `virtio-mem`
based memory hotplug and the `virtio-balloon` device now supports live
migration.

### `virtio-mem` support with `vfio-user`

The use of `vfio-user` userspaces devices can now be used in conjunction with
`virtio-mem` based memory hotplug and unplug.

### AArch64 for `virtio-iommu`

A paravirtualised IOMMU can now be used on the AArch64 platform.

### Notable bug fixes

* ACPI hotplugged memory is correctly restored after a live migration or
  snapshot/restore (#3165)
* Multiple devices from the same IOMMU group can be passed through via VFIO
  (#3078 #3113)
* Live migration with large blocks of memory was buggy due to an in issue in
  the underlying crate (#3157)

### Contributors

Many thanks to everyone who has contributed to our release:

* Alyssa Ross <hi@alyssa.is>
* Bo Chen <chen.bo@intel.com>
* Henry Wang <Henry.Wang@arm.com>
* Hui Zhu <teawater@antfin.com>
* Jianyong Wu <jianyong.wu@arm.com>
* Li Yu <liyu.yukiteru@bytedance.com>
* Michael Zhao <michael.zhao@arm.com>
* Muminul Islam <muislam@microsoft.com>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Wei Liu <liuwe@microsoft.com>
* William Douglas <william.douglas@intel.com>
* Yu Li <liyu.yukiteru@bytedance.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v19.0">GitHub Release</a> for the release assets.

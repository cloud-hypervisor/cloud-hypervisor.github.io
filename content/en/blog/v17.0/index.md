---
title: "Cloud Hypervisor v17.0 Released!"
date: 2021-07-22T16:31:16Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked through the [v17.0
project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/20).

### ARM64 NUMA support using ACPI

The support for ACPI on ARM64 has been enhanced to include support for
specifying a NUMA configuration using the existing control options.

### `Seccomp` support for MSHV backend

The `seccomp` rules have now been extended to support running against the MSHV
hypervisor backend.

### Hotplug of `macvtap` devices

Hotplug of `macvtap` devices is now supported with the file descriptor for the
network device if opened by the user and passed to the VMM. The `ch-remote`
tool supports this functionality when adding a network device.

### Improved SGX support

The SGX support has been updated to match the latest Linux kernel support and
now supports SGX provisioning and associating EPC sections to NUMA nodes.

### Inflight tracking for `vhost-user` devices

Support for handling inflight tracking of I/O requests has been added to the
`vhost-user` devices allowing recovery after device reconnection.

### Notable bug fixes

* VFIO PCI BAR calculation code now correctly handles I/O BARs (#2821).
* The VMM side of `vhost-user` devices no longer advertise the
  `VIRTIO_F_RING_PACKED` feature as they are not yet supported in the VMM
(#2833).
* On ARM64 VMs can be created with more than 16 vCPUs (#2763).

### Contributors

Many thanks to everyone who has contributed to our release:

* Anatol Belski <anbelski@linux.microsoft.com>
* Arafatms <arafatms@outlook.com>
* Bo Chen <chen.bo@intel.com>
* Fei Li <lifei.shirley@bytedance.com>
* Henry Wang <Henry.Wang@arm.com>
* Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
* Jianyong Wu <jianyong.wu@arm.com>
* Li Hangjing <lihangjing@bytedance.com>
* Michael Zhao <michael.zhao@arm.com>
* Muminul Islam <muislam@microsoft.com>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Wei Liu <liuwe@microsoft.com>
* Yukiteru <wfly1998@sina.com>

### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v17.0">GitHub Release</a> for the release assets.

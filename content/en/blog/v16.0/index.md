---
title: "Cloud Hypervisor v16.0 Released!"
date: 2021-06-10T16:13:47Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked through the [v16.0 project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/19).

### Improved live migration support

The live migration support inside Cloud Hypervisor has been improved with the addition of the tracking of dirty pages written by the VMM to complement the tracking of dirty pages made by the guest itself. Further the internal state of the VMM now is versioned which allows the safe migration of VMs from one version of the VMM to a newer one. However further testing is required so this should be done with care. See the [live migration documentation](docs/live_migration.md) for more details.

### Improved `vhost-user` support

When using `vhost-user` to access devices implemented in different processes there is now support for reconnection of those devices in the case of a restart of the backend. In addition it is now possible to operate with the direction of the `vhost-user-net` connection reversed with the server in the VMM and the client in the backend. This is aligns with the default approach recommended by Open vSwitch.

### ARM64 ACPI and UEFI support

Cloud Hypervisor now supports using ACPI and booting from a UEFI image on ARM64. This allows the use of stock OS images without direct kernel boot.

### Notable bug fixes

* Activating fewer `virtio-net` queues than advertised is now supported. This appeared when using OVMF with an MQ enabled device (#2578).
* When using MQ with `virtio` devices Cloud Hypervisor now enforces a minimum vCPU count which ensures that the user will not see adverse guest performance (#2563).
* The KVM clock is now correctly handled during live migration / snapshot & restore.

### Removed functionality

The following formerly deprecated features have been removed:

* Support for booting with the "LinuxBoot" protocol for ELF and `bzImage`
  binaries has been deprecated. When using direct boot users should configure
  their kernel with `CONFIG_PVH=y`.

### Contributors

Many thanks to everyone who has contributed to our release including some new faces.

* Anatol Belski <anbelski@linux.microsoft.com>
* Bo Chen <chen.bo@intel.com>
* Dayu Liu <liu.dayu@zte.com.cn>
* Henry Wang <Henry.Wang@arm.com>
* Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
* Jianyong Wu <jianyong.wu@arm.com>
* Michael Zhao <michael.zhao@arm.com>
* Mikko Ylinen <mikko.ylinen@intel.com>
* Muminul Islam <muislam@microsoft.com>
* Ren Lei <ren.lei4@zte.com.cn>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Wei Liu <liuwe@microsoft.com>
* Yi Wang <wang.yi59@zte.com.cn>

### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v16.0">GitHub Release</a> for the release assets.

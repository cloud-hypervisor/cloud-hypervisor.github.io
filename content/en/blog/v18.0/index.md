---
title: "Cloud Hypervisor v18.0 Released!"
date: 2021-09-09T14:31:29Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked through the [v18.0 project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/21).

### Experimental User Device (`vfio-user`) support

Experimental support for running PCI devices in userspace via `vfio-user`
has been included. This allows the use of the SPDK NVMe `vfio-user` controller
with Cloud Hypervisor. This is enabled by `--user-device` on the command line.

### Migration support for `vhost-user` devices

Devices exposed into the VM via `vhost-user` can now be migrated using the live
migration support. This requires support from the backend however the commonly
used DPDK `vhost-user` backend does support this.

### VHDX disk image support

Images using the VHDX disk image format can now be used with Cloud Hypervisor.

### Device pass through on MSHV hypervisor

When running on the MSHV hypervisor it is possible to pass through devices from
the host through to the guest (e.g with `--device`)

### AArch64 for support `virtio-mem`

The reference Linux kernel we recommend for using with Cloud Hypervisor now supports `virtio-mem` on AArch64.

### Live migration on MSHV hypervisor

Live migration is now supported when running on the MSHV hypervisor including
efficient tracking of dirty pages.

### AArch64 CPU topology support

The CPU topology (as configured through `--cpu topology=`) can now be
configured on AArch64 platforms and is conveyed through either ACPI or device
tree.

### Power button support on AArch64

Use of the ACPI power button (e.g `ch-remote --api-socket=<API socket> power-button`) 
is now supported when running on AArch64.

### Notable bug fixes

* Using two PTY outputs e.g. `--serial pty --console pty` now works correctly (#3012)
* TTY input is now always sent to the correct destination (#3005)
* The boot is no longer blocked when using a unattached PTY on the serial console (#3004)
* Live migration is now supported on AArch64 (#3049)
* Ensure signal handlers are run on the correct thread (#3069)

### Contributors

Many thanks to everyone who has contributed to our release:

* Alyssa Ross <hi@alyssa.is>
* Anatol Belski <anbelski@linux.microsoft.com>
* Arafatms <arafatms@outlook.com>
* Bo Chen <chen.bo@intel.com>
* Fazla Mehrab <akm.fazla.mehrab@vt.edu>
* Henry Wang <Henry.Wang@arm.com>
* Jianyong Wu <jianyong.wu@arm.com>
* Jiaqi Gao <jiaqi.gao@intel.com>
* Markus Theil <markus.theil@tu-ilmenau.de>
* Muminul Islam <muislam@microsoft.com>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Wei Liu <liuwe@microsoft.com>
* Yu Li <liyu.yukiteru@bytedance.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v18.0">GitHub Release</a> for the release assets.

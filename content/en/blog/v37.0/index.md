---
title: "Cloud Hypervisor v37.0 Released!"
date: 2023-12-14T18:58:49Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration
v37.0. The following user visible changes have been made:

### Long Term Support (LTS) Release

This release is a LTS release. Point releases for bug fixes will be made
for the next 18 months; live migration and live upgrade will be
supported between the point releases of the LTS.

### Multiple PCI segments Support for 32-bit VFIO Devices

Now VFIO devices with 32-bit memory BARs can be attached to non-zero PCI
segments on the guest, allowing users to have more 32-bit devices and
assign such devices to appropriate NUMA nodes for better performance.

### Configurable Named TAP Devices

Named TAP devices now accepts IP configuration from users, such as IP
and MAC address, as long as the named TAP device is created by Cloud
Hypervisor (e.g. not existing TAP devices).

### TTY Output from Both Serial Device and Virtio Console

Now legacy serial device and virtio console can be set as TTY mode as
the same time. This allows users to capture early boot logs with the
legacy serial device without losing performance benefits of using
virtio-console, when appropriate kernel configuration is used (such as
using kernel command-line `console=hvc0 earlyprintk=ttyS0` on x86).

### Faster VM Restoration from Snapshots

The speed of VM restoration from snapshots is improved with a better
implementation of deserializing JSON files.

### Notable Bug Fixes

* Fix aio backend behavior for block devices when writeback cache
  disabled (#5930)
* Fix PvPanic device PCI BAR alignment (#5956)
* Bug fix to OpenAPI specification file (#5967)
* Error out early for live migration when TDX is enabled (#6025)

### Contributors

Many thanks to everyone who has contributed to our release:

* Bo Chen <chen.bo@intel.com>
* Jinank Jain <jinankjain@microsoft.com>
* Markus Sütter <markus.suetter@secunet.com>
* Michael Zhao <michael.zhao@arm.com>
* Muminul Islam <muislam@microsoft.com>
* Rob Bradford <rbradford@rivosinc.com>
* Rui Chang <rui.chang@arm.com>
* Ruslan Mstoi <ruslan.mstoi@intel.com>
* Thomas Barrett <tbarrett@crusoeenergy.com>
* Wei Liu <liuwe@microsoft.com>
* Yi Wang <foxywang@tencent.com>
* Yong He <alexyonghe@tencent.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v37.0">GitHub Release</a> for the release assets.

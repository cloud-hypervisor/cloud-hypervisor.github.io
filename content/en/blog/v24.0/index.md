---
title: "Cloud Hypervisor v24.0 Released!"
date: 2022-05-27T08:00:00Z
draft: false
contributors: [Cloud Hypervisor Team]
---

This release has been tracked through the [v24.0
project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/28).

### Bypass Mode for `virtio-iommu`

`virtio-iommu` specification describes how a device can be attached by default
to a bypass domain. This feature is particularly helpful for booting a VM with
guest software which doesn't support `virtio-iommu` but still need to access
the device. Now that Cloud Hypervisor supports this feature, it can boot a VM
with Rust Hypervisor Firmware or OVMF even if the `virtio-block` device exposing
the disk image is placed behind a virtual IOMMU.

### Ensure Identifiers Uniqueness

Multiple checks have been added to the code to prevent devices with identical
identifiers from being created, and therefore avoid unexpected behaviors at boot
or whenever a device was hot plugged into the VM.

### Sparse Mmap support

Sparse mmap support has been added to both VFIO and vfio-user devices. This
allows the device regions that are not fully mappable to be partially mapped.
And the more a device region can be mapped into the guest address space, the
fewer VM exits will be generated when this device is accessed. This directly
impacts the performance related to this device.

### Expose Platform Serial Number

A new `serial_number` option has been added to `--platform`, allowing a user to
set a specific serial number for the platform. This number is exposed to the
guest through the SMBIOS.

### Notable Bug Fixes

* Fix loading RAW firmware (#4072)
* Reject compressed QCOW images (#4055)
* Reject virtio-mem resize if device is not activated (#4003)
* Fix potential mmap leaks from VFIO/vfio-user MMIO regions (#4069)
* Fix algorithm finding HOB memory resources (#3983)

### Notable Improvements

* Refactor interrupt handling (#4083)
* Load kernel asynchronously (#4022)
* Only create ACPI memory manager DSDT when resizable (#4013)

### Deprecations

Deprecated features will be removed in a subsequent release and users should
plan to use alternatives

* The `mergeable` option from the `virtio-pmem` support has been deprecated
  (#3968)
* The `dax` option from the `virtio-fs` support has been deprecated (#3889)

### New on the Website

A new blog post [Achieving Bare Metal Performance Within a Virtual
Machine](https://www.cloudhypervisor.org/blog/achieving-bare-metal-performance-within-a-virtual-machine)
has been added to the Cloud Hypervisor website.

### Contributors

Many thanks to everyone who has contributed to our release:

* Anatol Belski <anbelski@linux.microsoft.com>
* Bo Chen <chen.bo@intel.com>
* Fabiano Fidêncio <fabiano.fidencio@intel.com>
* LiHui <andrewli@kubesphere.io>
* Maksym Pavlenko <pavlenko.maksym@gmail.com>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Steven Dake <steven.dake@gmail.com>
* Vincent Batts <vbatts@hashbangbash.com>
* Wei Liu <liuwe@microsoft.com>

### Download

 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v24.0">GitHub Release</a> for the release assets.
---
title: "Cloud Hypervisor v26.0 Released!"
date: 2022-08-17T16:48:15Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked through the [v26.0
project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/30).

### SMBIOS Improvements via `--platform`

`--platform` and the appropriate API structure has gained support for supplying
OEM strings (primarily used to communicate metadata to systemd in the guest)
(#4319, #4446) and support for specifying the UUID (#4389.)

### Unified Binary MSHV and KVM Support

Support for both the MSHV and KVM hypervisors can be compiled into the same
binary with the detection of the hypervisor to use made at runtime.

### Notable Bug Fixes

* The prefetchable flag is preserved on BARs for VFIO devices (#4353, #4454)
* PCI Express capabilties for functionality we do not support are now filtered
  out (#4456)
* GDB breakpoint support is more reliable (#4354, #4363)
* `SIGINT` and `SIGTERM` signals are now handled before the VM has booted
  (#4269, #4293)
* Multiple API event loop handling bug fixes (#4309, #4362)
* Incorrect assumptions in virtio queue numbering were addressed, allowing
  the`virtio-fs` driver in OVMF to be used (#4341, #4314)
* VHDX file format header fix (#4291)
* The same VFIO device cannot be added twice (#4453, #4463)
* SMBIOS tables were being incorrectly generated (#4442)

### Deprecations

Deprecated features will be removed in a subsequent release and users should
plan to use alternatives.

* The top-level `kernel` and `initramfs` members on the `VmConfig` have been
  moved inside a `PayloadConfig` as the `payload` member. The OpenAPI document
  has been updated to reflect the change and the old API members continue to
  function and are mapped to the new version. The expectation is that these old
  versions will be removed in the v28.0 release.

### Removals

The following functionality has been removed:

* The unused `poll_queue` parameter has been removed from `--disk` and
  equivalent. This was residual from the removal of the `vhost-user-block`
  spawning feature (#4402.)

### Contributors

Many thanks to everyone who has contributed to our release:

* Alyssa Ross <hi@alyssa.is>
* Anatol Belski <ab@php.net>
* Archana Shinde <archana.m.shinde@intel.com>
* Bo Chen <chen.bo@intel.com>
* lizhaoxin1 <Lxiaoyouling@163.com>
* Maximilian Nitsch <maximilian.nitsch@d3tn.com>
* Michael Zhao <michael.zhao@arm.com>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Steven Dake <sdake@lambdal.com>
* Wei Liu <liuwe@microsoft.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v26.0">GitHub Release</a> for the release assets.

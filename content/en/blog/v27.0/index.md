---
title: "Cloud Hypervisor v27.0 Released!"
date: 2022-09-29T18:02:19Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in our new [roadmap
project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration
v27.0.

### Community Engagement

A new mailing list has been created to support broader community discussions.
Please consider [subscribing](https://lists.cloudhypervisor.org/g/dev/); an
announcement of a regular meeting will be announced via this list shortly.

### Prebuilt Packages

Prebuilt packages are now available. Please see [this
document](https://github.com/cloud-hypervisor/obs-packaging/blob/main/README.md)
on how to install. These packages also include packages for the different
firmware options available.

### Network Device MTU Exposed to Guest

The MTU for the TAP device associated with a `virtio-net` device is now exposed
to the guest. If the user provides a MTU with `--net mtu=..` then that MTU is
applied to created TAP interfaces. This functionality is also exposed for
`vhost-user-net` devices including those created with the reference backend
(#4658, #4676.)

### Boot Tracing

Support for generating a trace report for the boot time has been added
including a script for generating an SVG from that trace (#4659.)

### Simplified Build Feature Flags

The set of feature flags, for e.g. experimental features, have been simplified:

* `msvh` and `kvm` features provide support for those specific hypervisors
  (with `kvm` enabled by default),
* `tdx` provides support for Intel TDX; and although there is no MSHV support
  now it is now possible to compile with the `mshv` feature (#4696,)
* `tracing` adds support for boot tracing,
* `guest_debug` now covers both support for gdbing a guest (formerly `gdb`
  feature) and dumping guest memory.

The following feature flags were removed as the functionality was enabled by
default: `amx`, `fwdebug`, `cmos` and `common` (#4679, #4632.)

### Asynchronous Kernel Loading

AArch64 has gained support for loading the guest kernel asynchronously like
x86-64. (#4538)

### GDB Support for AArch64

GDB stub support (accessed through `--gdb` under `guest_debug` feature) is now
available on AArch64 as well as as x86-64.

### Notable Bug Fixes

* This version incorporates a version of `virtio-queue` that addresses an issue
  where a rogue guest can potentially DoS the VMM (rust-vmm/vm-virtio#196.)
* Improvements around PTY handling for `virtio-console` and serial devices
  (#4520, #4533, #4535.)
* Improved error handling in virtio devices (#4626, #4605, #4509, #4631, #4697)

### Deprecations

Deprecated features will be removed in a subsequent release and users should
plan to use alternatives.

* Booting legacy firmware (compiled without a PVH header) has been deprecated.
  All the firmware options (Cloud Hypervisor OVMF and Rust Hypervisor Firmware)
  support booting with PVH so support for loading firmware in a legacy mode is no
  longer needed. This functionality will be removed in the next release.

### Contributors

Many thanks to everyone who has contributed to our release:

* Anatol Belski <anbelski@linux.microsoft.com>
* Bo Chen <chen.bo@intel.com>
* James O. D. Hunt <james.o.hunt@intel.com>
* Jianyong Wu <jianyong.wu@arm.com>
* Markus Napierkowski <markus.napierkowski@cyberus-technology.de>
* Michael Zhao <michael.zhao@arm.com>
* Nuno Das Neves <nudasnev@microsoft.com>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Smit Gardhariya <sgardhariya@microsoft.com>
* Wei Liu <liuwe@microsoft.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v27.0">GitHub Release</a> for the release assets.

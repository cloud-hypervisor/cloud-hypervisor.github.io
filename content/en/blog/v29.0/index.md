---
title: "Cloud Hypervisor v29.0 Released!"
date: 2023-01-14T12:46:39Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in our [roadmap
project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration
v29.0. The following user visible changes have been made:

### Release Binary Supports Both MSHV and KVM

On `x86-64` the binary included in releases supports both the KVM and MSHV
hypervisor with runtime detection to identify the correct hypervisor to use.

### Snapshot/Restore and Live Migration Improvements

Improvements have been made to the data structures used for both live migration
and snapshot/restore. Unfortunately this has broken compatibility with older
versions (support for migrating between major versions is not yet officially
supported but has worked for some versions.)

### Heap Allocation Improvements

Improvements have been made to the volume of heap allocations when running with
`virtio-block` devices along with a reduction in the peak heap size.

### `ch-remote` Improvements

Support for "pinging" the VMM and shutting the VMM down have been added to
`ch-remote`.

### `AArch64` Documentation Integration

The documentation for `AArch64` support has been integrated into the main
README.

### `virtio-block` Counters Enhancement

The counters for the `virtio-block` device has extended to include min/mean/max
latency counters.

### TCP Offload Control

The `virtio-net` device has gained support for controlling the enabling of
checksum and offloading. This allows the device to be used in environments
where the hardware lacks support for the offloading.

### Notable Bug Fixes

* Update dependencies including a version of `linux-loader` that addresses an
  infinite loop issue ([details](https://github.com/rust-vmm/linux-loader/security/advisories/GHSA-52h2-m2cf-9jh6))
* Fix bugs related to `virtio-net` including an integer overflow issue
  (#4924, #4949)
* Use host `cpuid` information for L2 cache for older KVM on x86 (#4920)
* Memory mapped into the guest is now marked as non-dumpable which prevents large core files (#5016)
* Fix QCOW2 refcount table size (#5034)
* Fix unpause support on MSHV in dual binary (#5037)
* Threads inside `virtio` devices are now shutdown on reboot (#5095)

### Removals

No functionality has been removed in this release.

### Deprecations

* Support for specifying a directory with `MemoryZoneConfig::file` or
  `MemoryConfig::file` has been deprecated. This was originally used for
  supporting huge pages or shared memory backing which is now natively supported
  (#5085)

### Contributors

Many thanks to everyone who has contributed to our release:

* Bo Chen <chen.bo@intel.com>
* Claudio Fontana <claudio.fontana@gmail.com>
* Hao Xu <howeyxu@tencent.com>
* Henry Wang <Henry.Wang@arm.com>
* Jinank Jain <jinankjain@microsoft.com>
* Michael Zhao <michael.zhao@arm.com>
* Muminul Islam <muislam@microsoft.com>
* Philipp Schuster <philipp.schuster@cyberus-technology.de>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Shuaiyi Zhang <zhangsy28@lenovo.com>
* Wei Liu <liuwe@microsoft.com>
* Yong He <alexyonghe@tencent.com>
* Yuji Hagiwara <yuuzi41@gmail.com>

### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v29.0">GitHub Release</a> for the release assets.

---
title: "Cloud Hypervisor v33.0 Released!"
date: 2023-06-29T17:32:25Z
draft: false
contributors: [Cloud Hypervisor Team]
---
# v33.0

This release has been tracked in our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration
v33.0. The following user visible changes have been made:

### D-Bus based API

A D-Bus based API has been added as an alternative to the existing REST
API. This feature is gated by the `dbus_api` feature. Details can be
found in the [API documentation](docs/api.md).

### Expose Host CPU Cache Details for AArch64

Now the CPU cache information on the host is properly exposed to the
guest on AArch64.

### Notable Bug Fixes

* Report errors explicitly to users when VM failed to boot (#5453)
* Fix VFIO on platforms with non-4k page size (#5450, #5469)
* Fix TDX initialization (#5454)
* Ensure all guest memory regions are page-size aligned (#5496)
* Fix seccomp filter lists related to virtio-console, serial and pty
  (#5506, #5524)
* Populate APIC ID properly (#5512)
* Ignore and warn TAP FDs in more situations (#5522)

### Contributors

Many thanks to everyone who has contributed to our release:

* Alyssa Ross <hi@alyssa.is>
* Anatol Belski <anbelski@linux.microsoft.com>
* Bo Chen <chen.bo@intel.com>
* Jianyong Wu <jianyong.wu@arm.com>
* Omer Faruk Bayram <omer.faruk@sartura.hr>
* Rafael Mendonca <rafaelmendsr@gmail.com>
* Ravi kumar Veeramally <ravikumar.veeramally@intel.com>
* Rob Bradford <rbradford@rivosinc.com>
* Ruslan Mstoi <ruslan.mstoi@intel.com>
* Yu Li <liyu.yukiteru@bytedance.com>
* zhongbingnan <zhongbingnan@bytedance.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v33.0">GitHub Release</a> for the release assets.

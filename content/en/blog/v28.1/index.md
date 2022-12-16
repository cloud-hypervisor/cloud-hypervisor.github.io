---
title: "Cloud Hypervisor v28.1 Released!"
date: 2022-12-14T11:20:23Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This is a bug fix release. The following issues have been addressed:

* Update dependencies including a version of `linux-loader` that
addresses an infinite loop issue ([details](https://github.com/rust-vmm/linux-loader/security/advisories/GHSA-52h2-m2cf-9jh6))
* Fix bugs related to `virtio-net` including an integer overflow issue
  (#4924, #4949)
* Use host `cpuid` information for L2 cache for older KVM on x86 (#4920)
* Improve README and documentation

### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v28.1">GitHub Release</a> for the release assets.

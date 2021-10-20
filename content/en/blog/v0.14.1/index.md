---
title: "Cloud Hypervisor v0.14.1 Released!"
date: 2021-03-31T16:11:23Z
draft: false
contributors: [Cloud Hypervisor Team]
---
Bug fix release branched off the v0.14.0 release. The following bugs
were fixed in this release:

* CPU hotplug on Windows failed due to misreported CPU state information and
  the lack of HyperV CPUID bit enabled (#2437, #2449, #2436)
* A seccomp rule was missing that was triggered on CPU unplug (#2455)
* A bounds check in VIRTIO queue validation was erroneously generating
  DescriptorChainTooShort errors in certain circumstances (#2450, #2424)
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v0.14.1">GitHub Release</a> for the release assets.

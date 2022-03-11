---
title: "Cloud Hypervisor v21.1 Released!"
date: 2022-03-11T09:08:36Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This is a bug fix release. The following issues have been addressed:

* Missing `openat()` syscall from seccomp filter (#3609)
* Ensure MMIO/PIO exits complete before pausing (#3658)
* Support DWORD writes to MSI-X control register (#3714)
* VFIO ioctl reordering to fix MSI on AMD platforms (#3827)
* Fix `virtio-net` control queue (#3829)

### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v21.1">GitHub Release</a> for the release assets.

---
title: "Cloud Hypervisor v20.2 Released!"
date: 2022-01-04T17:57:10Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This is a bug fix release. The following issues have been addressed:

* Don't error out when setting up the `SIGWINCH` handler (for console resize)
  when this fails due to older kernel (#3456)
* Seccomp rules were refined to remove syscalls that are now unused
* Fix reboot on older host kernels when `SIGWINCH` handler was not initialised
  (#3496)
* Fix `virtio-vsock` blocking issue (#3497)
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v20.2">GitHub Release</a> for the release assets.

---
title: "Cloud Hypervisor v23.1 Released!"
date: 2022-05-09T14:24:16Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This is a bug fix release. The following issues have been addressed:

* Add some missing seccomp rules
* Remove `virtio-fs` filesystem entries from config on removal
* Do not delete API socket on API server start (#4026)
* Reject `virtio-mem` resize if the guest doesn't activate the device
* Fix OpenAPI naming of I/O throttling knobs

### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v23.1">GitHub Release</a> for the release assets.

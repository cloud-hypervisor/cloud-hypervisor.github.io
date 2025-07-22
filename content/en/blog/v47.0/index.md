---
title: "Cloud Hypervisor v47.0 Released!"
date: 2025-07-22T22:48:05Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in [v47.0 group](https://github.com/orgs/cloud-hypervisor/projects/6/views/4?filterQuery=release%3A%22Release+47%22) of our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6/).

Block Device Error Reporting to the Guest
-----------------------------------------

Instead of exiting on I/O errors, the `virtio-block` device now reports
errors to the guest using `VIRTIO_BLK_S_IOERR`. It improves the user
experience particularly when the guest rootfs is not backed by the
affected block device. (#7107)

Nice Error Messages on Exit
---------------------------

We now have the chain of errors being reported and printed nicely, when
Cloud Hypervisor or ch-remote exits on errors. (#7066)

Alphabetically Sorted CLI Options for ch-remote
-----------------------------------------------

To improve readability, ch-remote now prints help information in
alphabetical order. (#7130)

Notable Bug Fixes
-----------------

* Error out early when block device serial is too long (#7124)
* Fix partial commands being discarded for `virtio-vsock` (#7195)
* Disable the broken interrupt support for the `rtc_pl031` device to
  prevent spurious guest interrupts (#7199)

Deprecations
------------

* A default IP (`192.168.249.1`) and mask (`255.255.255.0`) are
 currently assigned  to the `virtio-net` device if no value is specified
 by users. Such behavior is now deprecated.  Users of this behavior will
 receive a warning message and should make adjustments. The behavior
 will be removed in two release cycles (v49.0).
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v47.0">GitHub Release</a> for the release assets.

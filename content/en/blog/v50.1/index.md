---
title: "Cloud Hypervisor v50.1 Released!"
date: 2026-02-20T01:21:45Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This is a point release containing security fixes and bug fixes.

Security Fixes
--------------

This release fixes a security vulnerability in disk image handling.
Details can be found in [GHSA-jmr4-g2hv-mjj6](https://github.com/cloud-hypervisor/cloud-hypervisor/security/advisories/GHSA-jmr4-g2hv-mjj6).

* A new `backing_files=on|off` option has been added to `--disk` to
  explicitly control whether QCOW2 backing files are permitted. This
  defaults to `off` to prevent the loading of backing files entirely.
  (#7685)
* Explicit image type specification via the user interface, removing
  reliance on format autodetection (#7728).
* Prevent sector-zero writes for autodetected raw images (#7728).

Bug Fixes
---------

* Fix various inconsistencies in our OpenAPI specification file
  (#7716, #7726)
* Fix QCOW2 thread safety for multiple virtio queues
  (`num_queues > 1`) (#7661)
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v50.1">GitHub Release</a> for the release assets.

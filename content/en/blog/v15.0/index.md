---
title: "Cloud Hypervisor v15.0 Released!"
date: 2021-04-29T15:27:07Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked through the [v15.0 project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/18).

Highlights for `cloud-hypervisor` version v15.0 include:

### Version numbering and stability guarantees

This release is the first in a new version numbering scheme to represent that
we believe Cloud Hypervisor is maturing and entering a period of stability.
With this new release we are beginning our new stability guarantees:

* The API (including command line options) will not be removed or changed in a
  breaking way without a minimum of 2 releases notice. Where possible warnings
  will be given about the use of deprecated functionality and the deprecations
  will be documented in the release notes.
* Point releases will be made between individual releases where there are
  substantial bug fixes or security issues that need to be fixed.

Currently the following items are **not** guaranteed across updates:

* Snapshot/restore is not supported across different versions
* Live migration is not supported across different versions
* The following features are considered experimental and may change
  substantially between releases: TDX, SGX.

### Network device rate limiting

Building on our existing support for rate limiting block activity the network
device also now supports rate limiting. Full details of the controls are in the
[IO throttling documentation.](docs/io_throttling.md)

### Support for runtime control of `virtio-net` guest offload

The guest is now able to change the offload settings for the `virtio-net`
device. As well as providing a useful control this mitigates an issue in the
Linux kernel where the guest will attempt to reprogram the offload settings
even if they are not advertised as configurable (#2528).

### `--api-socket` supports file descriptor parameter

The `--api-socket` can now take an `fd=` parameter to specify an existing file
descriptor to use. This is particularly beneficial for frameworks that need to
programmatically control Cloud Hypervisor.

### Bug fixes

* A workaround has been put in place to mitigate a Linux kernel issues that
  results in the CPU thread spinning at 100% when using `virtio-pmem` (#2277).
* PCI BARs are now correctly aligned removing the need for the guest to
  reprogram them (#1797,#1798)
* Handle TAP interface not being writable within virtio-net (due to the buffer
  exhaustion on the host) (#2517)
* The recommended Linux kernel is now v5.12.0 as it contains a fix that
  prevents snapshot & restore working (#2535)

### Deprecations

Deprecated features will be removed in a subsequent release and users should plan to use alternatives

* Support for booting with the "LinuxBoot" protocol for ELF and `bzImage`
  binaries has been deprecated. When using direct boot users should configure
  their kernel with `CONFIG_PVH=y`. Will be removed in v16.0.

### Contributors

Many thanks to everyone who has contributed to our release including some new faces.

* Alyssa Ross <hi@alyssa.is>
* Anatol Belski <anbelski@linux.microsoft.com>
* Bo Chen <chen.bo@intel.com>
* Gaelan Steele <gbs@canishe.com>
* Jianyong Wu <jianyong.wu@arm.com>
* Michael Zhao <michael.zhao@arm.com>
* Muminul Islam <muislam@microsoft.com>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Wei Liu <liuwe@microsoft.com>
* William Douglas <william.douglas@intel.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v15.0">GitHub Release</a> for the release assets.

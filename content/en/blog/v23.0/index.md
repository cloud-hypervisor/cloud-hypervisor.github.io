---
title: "Cloud Hypervisor v23.0 Released!"
date: 2022-04-14T08:42:28Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked through the [v23.0
project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/27).

### vDPA Support

A vDPA device has a datapath that complies with the virtio specification but
with a vendor specific control path. The addition of `--vdpa` and the REST API
equivalent allows the use of these devices with Cloud Hypervisor.

### Updated OS Support list

The list of officially supported and tested OS versions has been updated to
include Ubuntu "jammy" 22.04 and EOLed versions removed.

### `AArch64` Memory Map Improvements

The memory map when running on `AArch64` has been improved for the handling of
the UEFI region which means that the booted guest OS now has full access to its
allocated RAM. (#3938)

### `AMX` Support

Under a compile time gate of `amx` it is possible compile in support for the
`AMX` instruction set extension for guest use. This also requires runtime
enabling with `--cpu features=amx`.

### Notable Bug Fixes

* Generate error when incorrect HTTP method used for some API endpoints (#3887)
* CMOS based reset is now available to support rebooting on "jammy" (#3914)
* ACPI tables are not produced for memory hotplug when running with
  `virtio-mem` (#3883)
* `virtio-iommu` backed PCI segments are now comprehensively placed behind the
  vIOMMU (#3870)
* Seccomp rules have been extended for `virtio-fs` to support direct access
  (#3848)

### Deprecations

Deprecated features will be removed in a subsequent release and users should
plan to use alternatives

* The `mergeable` option from the `virtio-pmem` support has been deprecated
  (#3968)
* The `dax` option from the `virtio-fs` support has been deprecated (#3889)

### Contributors

Many thanks to everyone who has contributed to our release:

* Bo Chen <chen.bo@intel.com>
* Fabiano Fidêncio <fabiano.fidencio@intel.com>
* Henry Wang <Henry.Wang@arm.com>
* Jianyong Wu <jianyong.wu@arm.com>
* LiHui <andrewli@kubesphere.io>
* Michael Zhao <michael.zhao@arm.com>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Wei Liu <liuwe@microsoft.com>
* William Douglas <william.douglas@intel.com>
* Yi Wang <wang.yi59@zte.com.cn>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v23.0">GitHub Release</a> for the release assets.

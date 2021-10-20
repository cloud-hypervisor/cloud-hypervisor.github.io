---
title: "Cloud Hypervisor v0.11.0 Released!"
date: 2020-10-29T17:55:41Z
draft: false
contributors: [Cloud Hypervisor Team]
---
# v0.11.0

This release has been tracked through the [0.11.0 project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/14).

Highlights for `cloud-hypervisor` version 0.11.0 include:

### `io_uring` support by default for `virtio-block`

Provided that the host OS supports it (Linux kernel 5.8+) then `io_uring` will
be used for a significantly higher performance block device. 

### Windows Guest Support

This is the first release where we officially support Windows running as a
guest. Full details of how to setup the image and run Cloud Hypervisor with a
Windows guest can be found in the dedicated [Windows
documentation](docs/windows.md).

### `vhost-user` "Self Spawning" Deprecation

Automatically spawning a `vhost-user-net` or `vhost-user-block` backend is now
deprecated. Users of this functionality will receive a warning and should make
adjustments. The functionality will be removed in the next release.

### `virtio-mmmio` Removal

Support for using the `virtio-mmio` transport, rather than using PCI, has been
removed. This has been to simplify the code and significantly
reduce the testing burden of the project.

### Snapshot/Restore support for ARM64

When running on the ARM64 architecture snapshot and restore has now been
implemented.

### Improved Linux Boot Time

The time to boot the Linux kernel has been significantly improved by the
identifying some areas of delays around PCI bus probing, IOAPIC programming and
MPTABLE issues. Full details can be seen in #1728.

### `SIGTERM/SIGINT` Interrupt Signal Handling

When the VMM process receives the `SIGTERM` or `SIGINT` signals then it will
trigger the VMM process to cleanly deallocate resources before exiting. The
guest VM will not be cleanly shutdown but the VMM process will clean up its
resources.

### Default Log Level Changed

The default logging level was changed to include warnings which should make it
easier to see potential issues. New [logging
documentation](docs/logging) was also added.

### New `--balloon` Parameter Added

Control of the setup of `virtio-balloon` has been moved from `--memory` to its
own dedicated parameter. This makes it easier to add more balloon specific
controls without overloading `--memory`.

### Experimental `virtio-watchdog` Support

Support for using a new `virtio-watchdog` has been added which can be used to
have the VMM reboot the guest if the guest userspace fails to ping the
watchdog. This is enabled with `--watchdog` and requires kernel support.

### Notable Bug Fixes

* MTRR bit was missing from CPUID advertised to guest
* "Return" key could not be used under `CMD.EXE` under Windows SAC (#1170)
* CPU identification string is now exposed to the guest
* `virtio-pmem` with`discard_writes=on` no longer marks the guest memory as
  read only so avoids excessive VM exits (#1795)
* PCI device hotplug after an unplug was fixed (#1802)
* When using the ACPI method to resize the guest memory the full reserved size
  can be used (#1803)
* Snapshot and restore followed by a second snapshot and restore now works
  correctly
* Snapshot and restore of VMs with more than 2GiB in one region now work
  correctly

### Contributors

Many thanks to everyone who has contributed to our 0.11.0 release including some new faces.

* Anatol Belski <anbelski@linux.microsoft.com>
* Bo Chen <chen.bo@intel.com>
* Daniel Verkamp <dverkamp@chromium.org>
* Henry Wang <Henry.Wang@arm.com>
* Hui Zhu <teawater@antfin.com>
* Jiangbo Wu <jiangbo.wu@intel.com>
* Josh Soref <jsoref@users.noreply.github.com>
* Julio Montes <julio.montes@intel.com>
* Michael Zhao <michael.zhao@arm.com>
* Muminul Islam <muislam@microsoft.com>
* pierwill <19642016+pierwill@users.noreply.github.com>
* Praveen Paladugu <prapal@microsoft.com>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Wei Liu <liuwe@microsoft.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v0.11.0">GitHub Release</a> for the release assets.

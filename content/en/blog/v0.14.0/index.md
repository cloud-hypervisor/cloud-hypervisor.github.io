---
title: "Cloud Hypervisor v0.14.0 Released!"
date: 2021-03-26T12:01:05Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked through the [0.14.0 project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/17).

Highlights for `cloud-hypervisor` version 0.14.0 include:

### Structured event monitoring

A new option was added to the VMM `--event-monitor` which reports structured
events (JSON) over a file or file descriptor at key events in the lifecycle of
the VM. The list of events is limited at the moment but will be further
extended over subsequent releases. The events exposed form part of the Cloud
Hypervisor API surface.

### MSHV improvements

Basic support has been added for running Windows guests atop the MSHV
hypervisor as an alternative to KVM and further improvements have been made to
the MSHV support.

### Improved aarch64 platform

The aarch64 platform has been enhanced with more devices exposed to the running
VM including an enhanced serial UART.

### Updated hotplug documentation

The documentation for the hotplug support has been updated to reflect the use
of the `ch-remote` tool and to include details of `virtio-mem` based hotplug as
well as documenting hotplug of paravirtualised and VFIO devices.

### PTY control for serial and `virtio-console`

The `--serial` and `--console` parameters can now direct the console to a PTY
allowing programmatic control of the console from another process through the
PTY subsystem.

### Block device rate limiting

The block device performance can now be constrained as part of the VM
configuration allowing rate limiting. Full details of the controls are in the
[IO throttling doumentation.](docs/io_throttling.md)


### Deprecations

Deprecated features will be removed in a subsequent release and users should plan to use alternatives

* Support for booting with the "LinuxBoot" protocol for ELF and `bzImage`
  binaries has been deprecated. When using direct boot users should configure
  their kernel with `CONFIG_PVH=y`.


### Contributors

Many thanks to everyone who has contributed to our 0.14.0 release including
some new faces.

* Bo Chen <chen.bo@intel.com>
* Henry Wang <Henry.Wang@arm.com>
* Iggy Jackson <iggy@theiggy.com>
* Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
* Michael Zhao <michael.zhao@arm.com>
* Muminul Islam <muislam@microsoft.com>
* Penny Zheng <Penny.Zheng@arm.com>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Vineeth Pillai <viremana@linux.microsoft.com>
* Wei Liu <liuwe@microsoft.com>
* William Douglas <william.r.douglas@gmail.com>
* Zide Chen <zide.chen@intel.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v0.14.0">GitHub Release</a> for the release assets.

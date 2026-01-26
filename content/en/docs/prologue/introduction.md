---
title: "Introduction"
description: "Cloud Hypervisor is an open source Virtual Machine Monitor (VMM) implemented in Rust that focuses on running modern, cloud workloads, with minimal hardware emulation."
lead: "Cloud Hypervisor is an open source Virtual Machine Monitor (VMM) implemented in Rust that focuses on running modern, cloud workloads, with minimal hardware emulation."
date: 2020-10-06T08:48:57+00:00
lastmod: 2020-10-06T08:48:57+00:00
draft: false
images: []
menu:
  docs:
    parent: "prologue"
weight: 100
toc: true
---

## Quick Start

See the [Quick Start →]({{< relref "quick-start" >}}) for a single page guide to getting started with Cloud Hypervisor.

## Go further

Currently the majority of the documentation is in the source tree but a user guide, which will be hosted on this website is planned.

### User documentation

Here are some documents related to particular features and functionality that a user of Cloud Hypervisor might be interested in:

* [HTTP API](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/api.md)
* [Virtual CPU configuration](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/cpu.md)
* [Using virtio-fs](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/fs.md)
* [How to hotplug devices](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/hotplug.md)
* [vIOMMU configuration](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/iommu.md)
* [I/O throttling for network and block devices](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/io_throttling.md)
* [Live migration](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/live_migration.md)
* [Using a MACvTAP bridge to place a VM on the host network](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/macvtap-bridge.md)
* [Advanced memory configuration](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/memory.md)
* [Snapshot & Restore of a VM](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/snapshot_restore.md)
* [Building a UEFI firmware for use with Cloud Hypervisor](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/uefi.md)
* [Using VFIO to passthrough PCI devices](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/vfio.md)
* [Emulated NVMe controller via vfio-user](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/vfio-user.md)
* [Using virtio-fs as as a root filesystem](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/virtiofs-root.md)
* [Running and debugging Windows guests](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/windows.md)

### Developer documentation

These documents are primarily for developers who are working on the project:

* [Updating the custom image](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/custom-image.md)
* [Debug port logging for performance testing](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/debug-port.md)
* [Correct use of logging](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/logging.md)
* [How to profile Cloud Hypervisor](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/profiling.md)
* [Seccomp filter debugging](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/seccomp.md)
* [Testing vhost-user-block](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/vhost-user-blk-testing.md)
* [Testing vhost-user-net](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/vhost-user-net-testing.md)

## Contributing

See the [CONTRIBUTING file](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/CONTRIBUTING.md) in the source tree for details of how to contribute.
## Help

Need help with Cloud Hypervisor? Open a [discussion thread on Github](https://github.com/cloud-hypervisor/cloud-hypervisor/discussions) or ask in [our Slack](https://join.slack.com/t/cloud-hypervisor/shared_invite/enQtNjY3MTE3MDkwNDQ4LWQ1MTA1ZDVmODkwMWQ1MTRhYzk4ZGNlN2UwNTI3ZmFlODU0OTcwOWZjMTkwZDExYWE3YjFmNzgzY2FmNDAyMjI).

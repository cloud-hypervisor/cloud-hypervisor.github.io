---
title: "Cloud Hypervisor v44.0 Released!"
date: 2025-02-03T19:34:45Z
draft: false
contributors: [Cloud Hypervisor Team]
---
# v44.0

This release has been tracked in our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration
v44.0. The following user visible changes have been made:

### Configurable `virtio-iommu` Address Width

The `iommu_address_width` option has been added to `--platform` to allow users
to limit the `virtio-iommu` address space in the guest. (#6900)

### Notable Performance Improvements

The `VIRTIO_BLK_F_SEG_MAX` feature has been enabled for `virtio-block` devices,
which brings significant performance improvements on throughput. (#6885)

The `io_uring` entries are no longer forced to use async helper workers,
delegating the decision to the kernel. This change resolved the issue of having
excessive amount of worker threads when `io_uring` is being used, which is
expected to improve performance, such as reducing memory usage and reduce CPU
contention.

### New Fuzzers

Our continuous fuzzing infrastructure is augmented with two new fuzzers to cover
x86 instruction emulator and `virtio-vsock`.

### Notable Bug Fixes

* Fix short read and short write that impact QCOW and VHDX support. (#6884)
* Various bug fixes on VHDX support. (#6890, #6899)

### Contributors

Many thanks to everyone who has contributed to our release:

* Arvind Vasudev <avasudev@crusoeenergy.com>
* Bo Chen <bo.arvin.chen@gmail.com>
* Nikolay Edigaryev <edigaryev@gmail.com>
* Rob Bradford <rbradford@rivosinc.com>
* Ruoqing He <heruoqing@iscas.ac.cn>
* Wei Liu <liuwe@microsoft.com>

# v43.0

This release has been tracked in our [roadmap
project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration
v43.0. The following user visible changes have been made:

### Live Migration over TCP Connections

Support has been added to enable direct live migration from two hosts via TCP
connections. This supplements the existing support for migrating over a UNIX
socket which can then be tunnelled as desired. The documentation has been
updated. (#6850)

### Notable Performance Improvements

The `VIRTIO_RING_F_INDIRECT_DESC` feature has been enabled for `virtio-block`
devices. This significantly increases the throughput of the devices with a
small negative impact on latency. (#6826)

### Notable Bug Fixes

* Cloud Hypervisor now accepts VFIO devices that use I/O PCI BARs on non x86-64
  architectures. Whether they function depends on the host PCI host bridge
  support - previously they would be rejected even if the driver did not use
  these BARs. (#6871)
* Command line groups were adjusted to ensure that at least one payload
  parameter was provided if any other VM parameters provided. (#6832)

### Contributors

Many thanks to everyone who has contributed to our release:

* Alyssa Ross <hi@alyssa.is>
* Andrew Consroe <aconz2@gmail.com>
* Bo Chen <bo.arvin.chen@gmail.com>
* Jinrong Liang <cloudliang@tencent.com>
* Julian Stecklina <julian.stecklina@cyberus-technology.de>
* Muminul Islam <muislam@microsoft.com>
* Rob Bradford <rbradford@rivosinc.com>
* Ruoqing He <heruoqing@iscas.ac.cn>
* Wojtek Czekalski <wczekalski@me.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v44.0">GitHub Release</a> for the release assets.

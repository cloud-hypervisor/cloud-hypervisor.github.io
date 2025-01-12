---
title: "Cloud Hypervisor v43.0 Released!"
date: 2024-12-18T21:31:26Z
draft: false
contributors: [Cloud Hypervisor Team]
---
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
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v43.0">GitHub Release</a> for the release assets.

---
title: "Cloud Hypervisor v0.3.0 Released!"
date: 2019-10-18T11:21:46Z
draft: false
contributors: [Cloud Hypervisor Team]
---
# v0.3.0

This release has been tracked through the [0.3.0 project](https://github.com/intel/cloud-hypervisor/projects/3).

Highlights for `cloud-hypervisor` version 0.3.0 include:

### Block device offloading

We continue to work on offloading paravirtualized I/O to external processes, and we added support for [vhost-user-blk](https://access.redhat.com/solutions/3394851) backends.
This enables `cloud-hypervisor` users to plug a `vhost-user` based block device like [SPDK](https://spdk.io)) into the VMM as their paravirtualized storage backend.

### Network device backend

The previous release provided support for [vhost-user-net](https://access.redhat.com/solutions/3394851) backends. Now we also provide a TAP based vhost-user-net backend, implemented in Rust. Together with the vhost-user-net device implementation, this will eventually become the Cloud Hypervisor default paravirtualized networking architecture.

### Virtual sockets

In order to more efficiently and securely communicate between host and guest, we added an hybrid implementation of the [VSOCK](http://man7.org/linux/man-pages/man7/vsock.7.html) socket address family over virtio. Credits go to the [Firecracker](https://github.com/firecracker-microvm/firecracker/blob/master/docs/vsock.md) project as our implementation is a copy of theirs.

### HTTP based API

In anticipation of the need to support asynchronous operations to Cloud Hypervisor guests (e.g. resources hotplug and guest migration), we added a HTTP based API to the VMM. The API will be more extensively documented during the next release cycle.

### Memory mapped virtio transport

In order to support potential PCI-free use cases, we added support for the [virtio MMIO](https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-1440002) transport layer. This will allow us to support simple, minimal guest configurations that do not require a PCI bus emulation.

### Paravirtualized IOMMU

As we want to improve our nested guests support, we added support for exposing a [paravirtualized IOMMU](https://github.com/intel/cloud-hypervisor/blob/master/docs/iommu.md) device through virtio. This allows for a safer nested virtio and directly assigned devices support.

To add the IOMMU support, we had to make some CLI changes for Cloud Hypervisor users to be able to specify if devices had to be handled through this virtual IOMMU or not. In particular, the `--disk` option now expects disk paths to be prefixed with a `path=` string, and supports an optional `iommu=[on|off]`
setting.

### Ubuntu 19.10

With the latest [hypervisor firmware](https://github.com/intel/rust-hypervisor-firmware), we can now support the latest [Ubuntu 19.10 (Eoan Ermine)](http://releases.ubuntu.com/19.10/) cloud images.

### Large memory guests

After simplifying and changing our guest address space handling, we can now support guests with large amount of memory (more than 64GB).
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v0.3.0">GitHub Release</a> for the release assets.

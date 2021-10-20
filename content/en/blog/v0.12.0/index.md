---
title: "Cloud Hypervisor v0.12.0 Released!"
date: 2020-12-10T18:56:49Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked through the [0.12.0 project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/15).

Highlights for `cloud-hypervisor` version 0.12.0 include:

### ARM64 enhancements

The use of `--watchdog` is now fully supported as is the ability to reboot the
VM from within the guest when running Cloud Hypervisor on an ARM64 system.

### Removal of `vhost-user-net` and `vhost-user-block` self spawning

In order to use `vhost-user-net` or `vhost-user-block` backends the user is now
responsible for starting the backend and providing the socket for the VMM to
use. This functionality was deprecated in the last release and how now been
removed.

### Migration of `vhost-user-fs` backend

The `vhost-user-fs` backend is no longer included in Cloud Hypervisor and it is
instead hosted in [it's own
repository](https://gitlab.com/virtio-fs/virtiofsd-rs)

### Enhanced "info" API

The `vm.info` HTTP API endpoint has been extended to include the details of the
devices used by the VM including any VFIO devices used.

### Contributors

Many thanks to everyone who has contributed to our 0.12.0 release:

* Anatol Belski <anbelski@linux.microsoft.com>
* Julio Montes <julio.montes@intel.com>
* Michael Zhao <michael.zhao@arm.com>
* Muminul Islam <muislam@microsoft.com>
* Rob Bradford <robert.bradford@intel.com>
* Samuel Ortiz <sameo@linux.intel.com>
* Wei Liu <liuwe@microsoft.com>

### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v0.12.0">GitHub Release</a> for the release assets.

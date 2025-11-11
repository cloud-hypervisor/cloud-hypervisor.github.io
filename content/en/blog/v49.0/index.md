---
title: "Cloud Hypervisor v49.0 Released!"
date: 2025-11-09T05:36:56Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in [v49.0 group](https://github.com/orgs/cloud-hypervisor/projects/6/views/4?filterQuery=release%3A%22Release+49%22) of our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6/).

### MSHV Support Improvements

On AArch64 with MSHV, firmware boot (#7391) and graceful guest shutdown
(#7354) are now supported, and CI coverage has been added (#7381).

### Logging Improvements

Logs now use an improved timestamp format (#7355), emit an explicit
message on graceful shutdown (#7346), and reduce noisy warnings with
newer guest kernels (#7423).

### Removed Default IP and Mask for `virtio-net` Devices

The implicit default IP (192.168.249.1) and netmask (255.255.255.0) for
`virtio-net` devices have been removed, as previously announced in the
deprecation notice two releases ago (#7365).  Users now can create
`virtio-net` devices with no IP and netmask assigned.

### Notable Bug Fixes

* Prevent crash on malformed vsock connect requests (#7310)
* Drop the VFIO container when no VFIO devices are active (#7364)
* Gracefully close preserved file descriptors on hot device removal (#7371)
* Fix race condition in pause–resume cycles (#7397)
* Add NetConfig offload parameters to the OpenAPI spec file (#7445)
* Fix seccomp filter violation from the http-server thread (#7454)

### Contributors

Many thanks to everyone who has contributed to our release:

* Aastha Rawat <aastharawat@microsoft.com>
* Alyssa Ross <hi@alyssa.is>
* Anirudh Rayabharam <anrayabh@microsoft.com>
* Ariel Chenet <apchenet@gmail.com>
* Bo Chen <bchen@crusoe.ai>
* Can Zhang <icloud9957@gmail.com>
* Eugene Korenevsky <ekorenevsky@aliyun.com>
* Maximilian Güntner <code@mguentner.de>
* Muminul Islam <muislam@microsoft.com>
* Oliver Anderson <oliver.anderson@cyberus-technology.de>
* Philipp Schuster <philipp.schuster@cyberus-technology.de>
* Rob Bradford <rbradford@rivosinc.com>
* Ruoqing He <heruoqing@iscas.ac.cn>
* Wei Liu <liuwe@microsoft.com>
* Yi Wang <foxywang@tencent.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v49.0">GitHub Release</a> for the release assets.

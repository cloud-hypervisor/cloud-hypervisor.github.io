---
title: "Cloud Hypervisor v41.0 Released!"
date: 2024-08-16T12:17:19Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in our [roadmap
project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration
v41.0. The following user visible changes have been made:

### Experimental "Pvmemcontrol" Support

VMM support has been added for this experimental functionality (requires
currently out of tree Linux kernel patches) to allow guests to control its
physical memory properties to allow optimisations and security features.
(#6318, #6467)

### Sandboxing With Landlock Support

Support for restricting the VMM process using the Linux kernel "Landlock" API
has been added  - this can be used to restrict the files (and the read/write
permissions) that the VMM process can access. This adds another layer of
security alongside the existing sycall filters (`seccomp`) - this can be
enabled with `--landlock` and [fully documentated](docs/landlock.md). (#5170)

### Notable Performance Improvements

* Reduced heap allocations in `virtio-net` via the use of a cache of `Iovec`
  structures (#6636)
* Notification suppression ("`EVENT_IDX`") support has been added to
  `virtio-block` giving a 60% improvement in single queue block throughput and
  IOPs performance (#6580)
* Correct size used for `status` field in `virtio-block` state (#6586)

### Notable Bug Fixes

* Avoid panic on out-of-bounds PCI MSI-X access (#6657)
* Fix undefined behaviour on AArch64 leading to wrong optimisation on KVM API
  access (#6647)
* Rust v1.80.0 added use of `fcntl` syscall on debug assertions so this is now
  included in the virtio-device seccomp filters for tests that use this (#6648)
* Short reads are now handled correctly in the `virtio-vsock` device (#6621)
* Fix undefined behaviour on TTY ioctl leading to wrong optimisation (#6568)

### Contributors

Many thanks to everyone who has contributed to our release:  

* Alyssa Ross <hi@alyssa.is>
* Bo Chen <chen.bo@intel.com>
* Changyuan Lyu <changyuanl@google.com>
* Jinank Jain <jinankjain@microsoft.com>
* Julian Stecklina <julian.stecklina@cyberus-technology.de>
* Muminul Islam <muislam@microsoft.com>
* Nuno Das Neves <nudasnev@microsoft.com>
* Praveen K Paladugu <prapal@linux.microsoft.com>
* Rob Bradford <rbradford@rivosinc.com>
* Songqian Li <sionli@tencent.com>
* Wei Liu <liuwe@microsoft.com>
* Yuanchu Xie <yuanchu@google.com>
* ihciah <ihciah@gmail.com>
* wuxinyue <wuxinyue.wxy@antgroup.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v41.0">GitHub Release</a> for the release assets.

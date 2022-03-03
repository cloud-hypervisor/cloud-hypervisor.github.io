---
title: "Cloud Hypervisor v22.0 Released!"
date: 2022-03-03T18:10:22Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked through the [v22.0
project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/25).

### GDB Debug Stub Support

Cloud Hypervisor can now be used as debug target with GDB. This is controlled
by the `gdb` compile time feature and details of how to use it can be found in
the [gdb
documentation](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/gdb.md).


### `virtio-iommu` Backed Segments

In order to facilitate hotplug devices that require being behind an IOMMU (e.g.
QAT) there is a new option `--platform iommu_segments=<list_of_segments>` that
will place all the specified segments behind the IOMMU.

### Before Boot Configuration Changes

It is now possible to change the VM configuration (e.g. add or remove devices,
resize) before the VM is booted.

### `virtio-balloon` Free Page Reporting

If `--balloon free_page_reporting=on` is used then the guest can report pages
that is it not using to the VMM. The VMM will then notify the host OS that
those pages are no longer in use and can be freed. This can result in improved
memory density.

### Support for Direct Kernel Booting with TDX

Through the use of `TD-Shim` lightweight firmware it is now possible to
directly boot into the kernel with TDX. The [TDX
documentation](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/intel_tdx.md#tdshim)
has been updated for this usage.

### PMU Support for AArch64

A PMU is now available on AArch64 for guest performance profiling. This will be
exposed automatically if available from the host.

### Documentation Under CC-BY-4.0 License

The documentation is now licensed under the "Creative Commons Attribution 4.0
International" license which is aligned with the project charter under the
Linux Foundation.

### Deprecation of "Classic" `virtiofsd`

The use of the Rust based [virtiofsd](https://gitlab.com/virtio-fs/virtiofsd)
is now recommended and we are no longer testing against the C based "classic"
version.

### Notable Bug Fixes

* Can now be used on kernels without `AF_INET` support (#3785)
* `virtio-balloon` size is now validated against guest RAM size (#3689)
* Ensure that I/O related KVM VM Exits are correctly handled (#3677)
* Multiple TAP file descriptors can be used for `virtio-net` device hotplug (#3607)
* Minor API improvements and fixes (#3756, #3766, #3647, #3578)
* Fix sporadic seccomp violation from glibc memory freeing (#3610, #3609)
* Fix Windows 11 on AArch64 due to wider MSI-X register accesses (#3714, #3720)
* Ensure `vhost-user` features are correct across migration (#3737)
* Improved vCPU topology on AArch64 (#3735, #3733)

### Contributors

Many thanks to everyone who has contributed to our release:

* Akira Moroo <retrage01@gmail.com>
* Barret Rhoden <brho@google.com>
* Bo Chen <chen.bo@intel.com>
* Fabiano Fidêncio <fabiano.fidencio@intel.com>
* Feng Ye <yefeng@smartx.com>
* Henry Wang <Henry.Wang@arm.com>
* Jianyong Wu <jianyong.wu@arm.com>
* lizhaoxin1 <Lxiaoyouling@163.com>
* Michael Zhao <michael.zhao@arm.com>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Wei Liu <liuwe@microsoft.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v22.0">GitHub Release</a> for the release assets.

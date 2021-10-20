---
title: "Cloud Hypervisor v0.9.0 Released!"
date: 2020-08-06T14:30:07Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked through the [0.9.0 project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/12).

Highlights for `cloud-hypervisor` version 0.9.0 include:

### `io_uring` Based Block Device Support

If the `io_uring` feature is enabled and the host kernel supports it then `io_uring` will be used for block devices. This results a very significant performance improvement.

### Block and Network Device Statistics

Statistics for activity of the `virtio` network and block devices is now exposed through a new `vm.counters` HTTP API entry point. These take the form of simple counters which can be used to observe the activity of the VM.

### HTTP API Responses

The HTTP API for adding devices now responds with the name that was assigned to the device as well the PCI BDF.

### CPU Topology

A `topology` parameter has been added to `--cpus` which allows the configuration of the guest CPU topology allowing the user to specify the numbers of sockets, packages per socket, cores per package and threads per core.

### Release Build Optimization

Our release build is now built with LTO (*Link Time Optimization*) which results in a ~20% reduction in the binary size.

### Hypervisor Abstraction

A new abstraction has been introduced, in the form of a `hypervisor` crate so as to enable the support of additional hypervisors beyond `KVM`.

### Snapshot/Restore Improvements

Multiple improvements have been made to the VM snapshot/restore support that was added in the last release. This includes persisting more vCPU state and in particular preserving the guest paravirtualized clock in order to avoid vCPU hangs inside the guest when running with multiple vCPUs.

### Virtio Memory Ballooning Support
 
A `virtio-balloon` device has been added, controlled through the `resize` control, which allows the reclamation of host memory by resizing a memory balloon inside the guest.

### Enhancements to ARM64 Support

The ARM64 support introduced in the last release has been further enhanced with support for using PCI for exposing devices into the guest as well as multiple bug fixes. It also now supports using an initramfs when booting.

### Intel SGX Support

The guest can now use Intel SGX if the host supports it. Details can be found in the dedicated [SGX documentation](docs/intel_sgx.md).

### `Seccomp` Sandbox Improvements

The most frequently used virtio devices are now isolated with their own `seccomp` filters. It is also now possible to pass `--seccomp=log` which result in the logging of requests that would have otherwise been denied to further aid development.

### Notable Bug Fixes

* Our `virtio-vsock` implementation has been resynced with the implementation from Firecracker and includes multiple bug fixes.
* CPU hotplug has been fixed so that it is now possible to add, remove, and re-add vCPUs (#1338)
* A workaround is now in place for when KVM reports MSRs available MSRs that are in fact unreadable preventing snapshot/restore from working correctly (#1543).
* `virtio-mmio` based devices are now more widely tested (#275).
* Multiple issues have been fixed with virtio device configuration (#1217)
* Console input was wrongly consumed by both `virtio-console` and the serial. (#1521)

### Contributors

Many thanks to everyone who has contributed to our 0.9.0 release including some new faces.

* Anatol Belski <ab@php.net>
* Bo Chen <chen.bo@intel.com>
* Dr. David Alan Gilbert <dgilbert@redhat.com>
* Henry Wang <Henry.Wang@arm.com>
* Howard Zhang <howard.zhang@arm.com>
* Hui Zhu <teawater@antfin.com>
* Jianyong Wu <jianyong.wu@arm.com>
* Jose Carlos Venegas Munoz <jose.carlos.venegas.munoz@intel.com>
* LiYa'nan <oliverliyn@gmail.com>
* Michael Zhao <michael.zhao@arm.com>
* Muminul Islam <muislam@microsoft.com>
* Praveen Paladugu <prapal@microsoft.com>
* Ricardo Koller <ricarkol@gmail.com>
* Rob Bradford <robert.bradford@intel.com>
* Samuel Ortiz <sameo@linux.intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Stefano Garzarella <sgarzare@redhat.com>
* Wei Liu <liuwe@microsoft.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v0.9.0">GitHub Release</a> for the release assets.

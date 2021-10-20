---
title: "Cloud Hypervisor v0.13.0 Released!"
date: 2021-02-12T11:02:35Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked through the [0.13.0 project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/16).

Highlights for `cloud-hypervisor` version 0.13.0 include:

### Wider VFIO device support

It is now possible to use Cloud Hypervisor's VFIO support to passthrough PCI
devices that do not support MSI or MSI-X and instead rely on INTx interrupts.
Most notably this widens the support to most NVIDIA cards with the proprietary
drivers.

### Improve huge page support

Through the addition of `hugepage_size` on `--memory` it is now possible to
specify the desired size of the huge pages used when allocating the guest
memory. The user is required to ensure they have sufficient pages of the
desired size in their pool.

### MACvTAP support

It is now possible to provide file descriptors using the `fd` parameter to
`--net` which point at TAP devices that have already been opened by the user.
This aids integration with `libvirt` but also permits the use of MACvTAP
support. This is documented in dedicated [macvtap documentation](docs/macvtap-bridge.md).

### VHD disk image support

It is now possible to use VHD (fixed) disk images as well as QCOWv2 and raw
disk image with Cloud Hypervisor.

### Improved Virtio device threading

Device threads are now derived from the main VMM thread which allows more
restrictive seccomp filters to be applied to them. The threads also have a
predictable name derived from the device id.

### Clean shutdown support via synthetic power button

It is now possible to request that the guest VM shut itself down by triggering
a synthetic ACPI power button press from the VMM. If the guest is listening for
such an event (e.g. using systemd) then it will process the event and cleanly
shut down. This functionality is exposed through the HTTP API and can be
triggered via `ch-remote --api-socket=<API socket> power-button`.

### Contributors

Many thanks to everyone who has contributed to our 0.13.0 release including
some new faces.

* Bo Chen <chen.bo@intel.com>
* Mikko Ylinen <mikko.ylinen@intel.com>
* Muminul Islam <muislam@microsoft.com>
* Rob Bradford <robert.bradford@intel.com>
* Samuel Ortiz <sameo@linux.intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Vineeth Pillai <viremana@linux.microsoft.com>
* Wei Liu <liuwe@microsoft.com>
* William Douglas <william.r.douglas@gmail.com>
* Xie Yongji <xieyongji@bytedance.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v0.13.0">GitHub Release</a> for the release assets.

---
title: "Cloud Hypervisor v38.0 Released!"
date: 2024-02-16T18:20:29Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in our [roadmap
project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration
v38.0. The following user visible changes have been made:

### Group Rate Limiter on Block Devices

Users now can throttle a group of block devices with the new
`--rate-limiter-group` option. Details can be found from the [I/O
Throttling documentation](docs/io_throttling.md)

### CPU Pinning Support for Block Device Worker Thread

Users now have the option to pin virt-queue threads for block devices
to specific host cpus.

### Optimized Boot Time with Parallel Memory Prefault

The boot time with `prefault` option enabled is optimized via parallel
memory prefault.

### New 'debug-console' Device

A 'debug-console' device is added to provide a user-configurable debug
port for logging guest information. Details can be found from the [Debug
IO Ports documentation](docs/debug-port.md).

### Improved VFIO Device Support

All non-emulated MMIO regions of VFIO devices are now mapped to the VFIO
container, allowing PCIe P2P between all VFIO devices on the same
VM. This is required for a wide variety of multi-GPU workloads involving
GPUDirect P2P (DMA between two GPUs), GPUDirect RDMA (DMA between a GPU
and an IB device).

### Extended CPU Affinity Support

Users now can set the vcpu affinity to a host CPU with index larger
than 255.

### Notable Bug Fixes

* Enable HTT flag to avoid crashing cpu topology enumeration software
such as hwloc in the guest (#6146)
* Fix several security advisories from dependencies (#6134, #6141)
* Handle non-power-of-two CPU topology properly (#6062)
* Various bug fixes around `virtio-vsock`(#6080, #6091, #6095)
* Enable nested virtualization on AMD if supported (#6106)
* Align VFIO devices PCI BARs naturally (#6196)

### Contributors

Many thanks to everyone who has contributed to our release:
* Alyssa Ross <hi@alyssa.is>
* Bo Chen <chen.bo@intel.com>
* Daniel Farina <daniel@ubicloud.com>
* Jinank Jain <jinankjain@microsoft.com>
* Muminul Islam <muislam@microsoft.com>
* Peteris Rudzusiks <rye@stripe.com>
* Philipp Schuster <philipp.schuster@cyberus-technology.de>
* Ravi kumar Veeramally <ravikumar.veeramally@intel.com>
* Rob Bradford <rbradford@rivosinc.com>
* Ruslan Mstoi <ruslan.mstoi@intel.com>
* Sean Banko <sbanko@crusoeenergy.com>
* Thomas Barrett <tbarrett@crusoeenergy.com>
* Wei Liu <liuwe@microsoft.com>
* Yi Wang <foxywang@tencent.com>
* acarp <acarp@crusoeenergy.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v38.0">GitHub Release</a> for the release assets.

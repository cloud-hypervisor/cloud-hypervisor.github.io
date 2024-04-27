---
title: "Cloud Hypervisor v39.0 Released!"
date: 2024-04-27T13:40:07Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in our [roadmap
project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration
v39.0. The following user visible changes have been made:

### Variable Sizing of PCI Apertures for Segments

It is now possible to use `--pci-segment` to adjust the aperture size that
devices 32-bit and 64-bit PCI device BARs will be allocated from. Previously
the address space was equally distributed across all the segments which may
leave insufficient space for devices that require a large 32-bit space. With
this change the weighting per segment can be adjusted. (#6387)

### Direct Booting with bzImages

Support for directly booting Linux from bzImages has been added.(#6200)

### Support for NVIDIA GPUDirect P2P Support

The `x_nv_gpudirect_clique` option was added to `--device` to allow the
configuration of device P2P support with NVIDIA GPUs. (#6235)

### Guest NMI Injection Support

A new API endpoint and `ch-remote` option added for injecting an NMI into the
guest. (#6047)

### Notable Bug Fixes

* Workaround for kernel bug affecting guest IRQ masking on AMD (#6353)
* Correctly cleanup `sigwinch_listener` process (#6208)
* Graceful shutdown of HTTP API thread (#6248, #6247)
* Fix `queue_affinity` option in OpenAPI metadata (#6268)
* Fix documentation to indicate only stream mode is supported by `virtio-vsock`
  (#6306)
* Fix `virtio-fs` tag validation (#6358, #6359)
* Add missing `pvpanic` device to OpenAPI metadata (#6372)
* Fixes for nested virtualization with VFIO devices (#6110, #6298, #6297,
  #6319)
* Fix for backing file for `virtio-mem` regions with snapshot/restore (#6337,
  #6338)
* Explicitly mark FDs used for network devices as invalid across
  snapshot/restore (#6332, #6286)
* Improve `event-monitor` events around reboot (#6277, #6274)
* Fix potential deadlock around paused devices during live migration (#6293)
* Fix panic when running `ch-remote` with no subcommand (#6230)
* Fix hotplug of `virtio` devices after snapshot/restore and live migration
  (#6326, #6265)
  
### Contributors

Many thanks to everyone who has contributed to our release:  

* Alexandru Matei <alexandru.matei@uipath.com>
* Andrew Carp <acarp@crusoeenergy.com>
* Bo Chen <chen.bo@intel.com>
* Bouke van der Bijl <i@bou.ke>
* Chris Webb <chris@arachsys.com>
* Jinank Jain <jinankjain@microsoft.com>
* Lucas Jacques <contact@lucasjacques.com>
* Muminul Islam <muislam@microsoft.com>
* Nuno Das Neves <nudasnev@microsoft.com>
* Ravi kumar Veeramally <ravikumar.veeramally@intel.com>
* Rob Bradford <rbradford@rivosinc.com>
* Ruslan Mstoi <ruslan.mstoi@intel.com>
* Stefan Nuernberger <stefan.nuernberger@cyberus-technology.de>
* Thomas Barrett <tbarrett@crusoeenergy.com>
* Wei Liu <liuwe@microsoft.com>
* Yi Wang <foxywang@tencent.com>

### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v39.0">GitHub Release</a> for the release assets.

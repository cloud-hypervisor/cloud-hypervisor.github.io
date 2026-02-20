---
title: "Cloud Hypervisor v51.0 Released!"
date: 2026-02-20T01:34:50Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in [v51.0 group](https://github.com/orgs/cloud-hypervisor/projects/6/views/6?filterQuery=release%3A%22Release+51%22) of our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6/).

Security Fixes
--------------

This release fixes a security vulnerability in disk image handling.
Details can be found in [GHSA-jmr4-g2hv-mjj6](https://github.com/cloud-hypervisor/cloud-hypervisor/security/advisories/GHSA-jmr4-g2hv-mjj6).

* A new `backing_files=on|off` option has been added to `--disk` to
  explicitly control whether QCOW2 backing files are permitted. This
  defaults to `off` to prevent the loading of backing files entirely.
  (#7685)
* Explicit image type specification via the user interface, removing
  reliance on format autodetection (#7728).
* Prevent sector-zero writes for autodetected raw images (#7728).

Significant QCOW2 v3 Improvements
---------------------------------

A large number of QCOW2 v3 specification features have been implemented:

* RAW backing file support for QCOW2 overlays (#7570)
* Zero bit in L2 entries (#7627)
* Incompatible feature bit validation (#7612)
* Dirty bit support (#7636)
* Variable refcount widths (1 to 64-bit) (#7633)
* Corrupt bit detection and marking (#7639)
* Autoclear feature bits handling (#7648)
* Thread safety fix for multiple virtio queues (`num_queues > 1`)
  (#7661)
* Correct zero-fill for reads beyond backing file size (#7678)
* Live disk resize support (#7687)

ACPI Generic Initiator Support
------------------------------

ACPI Generic Initiator Affinity (SRAT Type 5) support has been added
to associate VFIO-PCI devices with dedicated memory/CPU-less NUMA
nodes. This enables the guest OS to make NUMA-aware memory allocation
decisions for device workloads. A new `device_id` parameter has been
added to `--numa` for specifying VFIO devices. (#7626)

Block Device DISCARD and WRITE_ZEROES Support
---------------------------------------------

The `virtio-blk` device now supports `DISCARD` and `WRITE_ZEROES`
operations for QCOW2 and RAW image formats. This enables thin
provisioning and efficient space reclamation when guests trim
filesystems. A new `sparse=on|off` option has been added to `--disk` to
control disk space management: `sparse=on` (default) enables thin
provisioning with space reclamation, while `sparse=off` provides thick
provisioning with consistent I/O latency. (#7666)

Notable Performance Improvements
--------------------------------

* Transparent Huge Pages (THP) support has been extended to cover
  anonymous shared memory (`shared=on`) via `madvise`. Previously, THP
  was only used for non-shared memory. (#7646)
* The `vhost-user-net` device now uses the default set of vhost-user
  virtio features, including `VIRTIO_F_RING_INDIRECT_DESC`, which
  provides a performance improvement. (#7653)

MSHV Support Improvements
-------------------------

* Optimize CPU state update after emulation by only updating special
  registers when changed (#7603)
* Enable SMT for guests with `threads_per_core > 1` (#7668)
* Stub `save_data_tables()` to unblock VM pause/resume (#7692)
* Handle `GHCB_INFO_SPECIAL_DBGPRINT` VMG exit in SEV-SNP guest exit
  handler (#7703)
* Fix CVM boot failure on MSHV (#7548)
* Fix CPU topology detection for multithreaded configurations (#7576)

Notable Bug Fixes
-----------------

* Fix VFIO device hot-remove leaving group and container file
  descriptors open, preventing re-add (#7676)
* Fix snapshot restore when backing file is on read-only storage with
  `shared=false` (#7674)
* Enforce `VIRTIO_BLK_F_RO` even if guest does not negotiate it
  (#7705)
* Fix read-only block device FLUSH requests from OVMF preventing VMs
  from booting (#7706)
* Fix vhost-user device not properly dropping unowned file descriptors
  (#7679)
* Fix `vhost-user-block` `get_config` interoperability (#7617)
* Fix vsock TOCTOU race condition by copying packet header from guest
  memory before processing (#7530)
* Fix vsock handling of large TX packets spanning multiple data
  descriptors (#7680)
* Add `gettid()` to all seccomp filters (#7596)
* Fix MAC address parsing that wrongly allowed `+` instead of hex
  characters (#7579)
* Improve UUID parse error message and `--net` fd help text (#7702)
* Fix various inconsistencies in our OpenAPI specification file
  (#7716, #7726)
* Various documentation fixes (#7602, #7606)

Contributors
------------

Many thanks to everyone who has contributed to our release:

* Aastha Rawat <aastharawat@microsoft.com>
* Alyssa Ross <hi@alyssa.is>
* Anatol Belski <anbelski@linux.microsoft.com>
* Anirudh Rayabharam <anrayabh@microsoft.com>
* Bo Chen <bchen@crusoe.ai>
* Champ-Goblem <cameron@northflank.com>
* Changyuan Lyu <changyuanl@google.com>
* Damian Barabonkov <dbctl@pm.me>
* Demi Marie Obenour <demiobenour@gmail.com>
* Leander Kohler <leander.kohler@cyberus-technology.de>
* Muminul Islam <muislam@microsoft.com>
* Philipp Schuster <philipp.schuster@cyberus-technology.de>
* Rob Bradford <rbradford@meta.com>
* Rowen-Ye <rowenye1@gmail.com>
* Saravanan D <saravanand@crusoe.ai>
* Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
* Thomas Leroy <thomas.leroy.mp@gmail.com>
* Wei Liu <liuwe@microsoft.com>
* Yi Wang <foxywang@tencent.com>
* Zhibin Li <banlu.lzb@antgroup.com>
* stevenhorsman <steven@uk.ibm.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v51.0">GitHub Release</a> for the release assets.

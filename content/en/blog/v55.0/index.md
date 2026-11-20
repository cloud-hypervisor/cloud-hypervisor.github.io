---
title: "Cloud Hypervisor v55.0 Released!"
date: 2026-11-19T22:56:26Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in [v55.0 group](https://github.com/orgs/cloud-hypervisor/projects/6/views/6?filterQuery=release%3A%22Release+55%22) of our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6/).

### Security Fixes

This release fixes a use-after-free vulnerability in `virtio-pmem` during VM
shutdown (#9326), which is also fixed in v53.1 and v54.1. See
[GHSA-3r3x-6hgg-2m38](https://github.com/cloud-hypervisor/cloud-hypervisor/security/advisories/GHSA-3r3x-6hgg-2m38)
for details.

### AArch64 Nested Virtualization

AArch64 guests on KVM can now run VMs with `--cpus nested=on`. This requires
hardware with `FEAT_NV2` and a host kernel in VHE mode booted with
`kvm-arm.mode=nested`. Snapshot/restore and live migration are not supported
for such guests yet (#8921).

### VFIO Peer-to-Peer DMA with dma-buf

Peer-to-peer DMA between VFIO devices now uses VFIO dma-buf with `iommufd`
where the host kernel supports it, and keeps using `VFIO_DMA_MAP` otherwise
(#9141).

### CPU Hotplug for SEV-SNP Guests on KVM

SEV-SNP guests on KVM now support CPU hotplug. They now also require ACPI
tables supplied through `fw_cfg` (#9111).

### `vsock` SEQPACKET Support

The `vsock` device now supports `SOCK_SEQPACKET` connections in addition to
`SOCK_STREAM` (#9377).

### Higher vCPU Limit on AArch64

The vCPU limit on KVM/AArch64 has been raised from 255 to 990 (#9125, #9225).

### `pvmemcontrol` Improvements

The `pvmemcontrol` device now supports `MADV_HUGEPAGE`, `MADV_NOHUGEPAGE`,
`MADV_DONTNEED_LOCKED` (also in batches) and `MLOCK_ONFAULT` requests from the
guest (#9067).

### Snapshot/Restore and Live Migration Improvements

* Postcopy migration now supports `vhost-user` devices, including the reference
  `vhost_user_block` and `vhost_user_net` backends, and restores ballooned
  pages as zero pages (#9094, #9391, #9039).
* Snapshots of VMs restored with `memory_restore_mode=copyonwrite` only write
  the pages changed since the restore, on filesystems with reflink support
  (#9000).
* A new `memory_restore_mode=ondemand_no_background_fetch_pages` restores on
  demand without fetching the remaining pages in the background (#9435).
* Live migration is faster and no longer hangs on unresponsive peers (#8944,
  #9204, #9219).
* The output of the serial port and `virtio-console` can be changed on
  `restore` and `receive-migration` (#9358).
* Add CPUID compatibility checks for AMD-specific leaves, which may reject
  migrations that appeared to work before (#9350, #9364, #9418).

### New Command-Line and API Options

* `restore` and `receive-migration` gained an `external_fds` option, on the
  command line and in the API, that takes all replacement file descriptors in
  one list (#8833).
* `--guest-shutdown-action` and `--guest-reset-action` control what the VMM
  does when the guest shuts down or resets (#9161).
* `--serial` and `--console` accept `tcp=<ip>:<port>` to listen on a loopback
  TCP address (#8874, #9367).
* CPU profiles can be loaded from a file with `--cpus profile=path:<file>`, and
  CPUID leaves can be overridden with `x-cpuid-overrides`, to migrate VMs
  between hosts with different CPUs. Both are experimental and x86_64 only
  (#9076, #9078).
* The rate limiter supports bounded bursts through the new
  `{bw,ops}_burst_rate`, `{bw,ops}_burst_seconds` and
  `{bw,ops}_burst_recharge_seconds` options (#9135).
* `--cpus kvm_hint_realtime=on` advertises `KVM_HINTS_REALTIME` to guests whose
  vCPUs run on dedicated host CPUs (#9156).
* The D-Bus API gained disk resize and NMI requests (#9319).
* `--landlock` no longer requires a VM payload (#9121).
* `vm.counters` now reports a `device_type` string for each device, next to its
  integer counters (#9434).

### Notable Performance Improvements

* `vsock` receive buffers are filled in batches, and a starved backend is no
  longer polled (#9306).
* VHDX reads run concurrently and scale with the number of queues (#9412).
* Serial output is faster (#9189).
* `virtio-iommu` UNMAP requests no longer scan all mappings of a domain, which
  speeds up passthrough devices with many mappings (#9431).

### Deprecations and Removals

* Host kernels older than 6.8 are no longer supported. The previous minimum was
  5.13 (#9106, #9109).
* Intel TDX support has been removed, pending a new implementation (#9112).
* The `--platform` options `serial_number` and `uuid` and the generic
  `vhost-user` option `virtio_id` have been removed (#9096).
* The ignored `file` option of `--memory` has been removed (#9331).
* Legacy VFIO (container/group) is deprecated in favor of the `vfio-cdev` mode
  with `iommufd` (#9402).
* ACPI memory hotplug is deprecated in favor of
  `--memory hotplug_method=virtio-mem` (#9443).
* `--no-shutdown` is deprecated in favor of
  `--guest-shutdown-action=shutdown-vm` (#9161).
* The `net_fds`, `vfio_fds` and `iommufd_fd` options of `restore` and
  `receive-migration` are deprecated in favor of `external_fds`. Unused file
  descriptor entries are now rejected (#8833).
* Restoring a VM with VFIO devices through their saved device paths is no
  longer supported. `restore` now requires their file descriptors through
  `external_fds`, like `receive-migration` (#9281).

### Security Hardening

* Trap the PCI configuration space mirror in BAR0 of NVIDIA GPUs instead of
  mapping it into the guest (#9365).
* Enforce mapping permissions in `virtio-iommu` (#9397).
* Enforce the virtio PCI queue configuration lifecycle (#9099), reject feature
  writes after `FEATURES_OK` (#9324), and require `VIRTIO_F_ACCESS_PLATFORM` to
  be accepted when offered (#9136).
* Reject `virtio-net` offloads that were not negotiated (#9323, #9327), and
  validate RX and control queue descriptors (#9147, #9155).
* Validate `virtio-block` request headers (#9184) and `virtio-rtc` buffers
  (#9400).
* Bound `pvmemcontrol` hole punching to guest memory (#9117), don't expose
  uninitialized bytes (#9123), and check pvpanic access sizes (#9190).
* Restrict the `io_uring` operations of the block backends (#9129).
* Narrow the Landlock rules for read-only disks and the `vsock` socket
  directory (#9119).
* Harden QCOW2 parsing (#9073, #9097, #9172, #9249), and reject encrypted
  images and writable images with internal snapshots (#9170, #9159).
* Harden VHDX BAT validation (#9148, #9157, #9185, #9198), and reject images
  with an active log (#9199).

### Notable Bug Fixes

* Various fixes for NVIDIA Grace-Blackwell (GB) platforms (#9105, #9098, #9114,
  #9110).
* Return zeros for punched QCOW2 clusters with a backing file (#9162), and
  don't leak preallocated zero clusters (#9192).
* Fix a stack overflow in the refcount handling of large QCOW2 images (#9441).
* Fix reads and writes beyond 4 GiB in VHDX images. Data that earlier releases
  wrote there is not found at the corrected location (#9328).
* Report I/O errors for rejected `virtio-block` requests and short completions
  (#9268, #9255), fail writethrough writes whose `fsync` fails (#9231), and pad
  disk serials to 20 bytes (#9164).
* Further robustness fixes for `virtio-block` and `virtio-net` (#9197).
* Fix stale memory after a migration with `vhost-user` devices (#9131), fix
  snapshots on hosts with nested virtualization disabled (#9116), and don't
  resume devices on the migration source during teardown (#9221).
* Fix late guest timers and RCU stall warnings after a restore (#9300, #9273,
  #9351).
* Save and restore more device state, such as platform devices, hotplug
  controllers, and the AArch64 GIC (#9363, #9339, #9415, #9425, #9417, #9318,
  #9312, #9270, #9305, #9337).
* Handle devices that the guest already ejected in `remove-device` and on
  restore (#9293).
* Send the host RARP announcement only on the first TAP queue after a restore
  or migration, avoiding duplicates and a host kernel warning (#9436).
* Fix `vhost-user` devices staying stopped after a failed backend state save
  (#9362).
* Drop features that a driver no longer accepts on renegotiation, fixing
  OpenBSD guests with `offload_tso=on` (#9384).
* Fix hangs when `DRIVER_OK` is written over MMCONFIG (#9361) and when a device
  thread misses a pause request (#9308).
* Honor the window offset of the virtio PCI configuration access capability
  (#9088), and return correct `virtio-iommu` request statuses (#9246).
* Align PCI BARs to their size (#9389), and fix phantom 64-bit BAR
  reprogramming (#9087) and byte writes to the MSI-X message control (#9396).
* Fix device hotplug failing when it races with a guest BAR move, and failed
  hotplugs blocking a retry with the same ID (#9428, #9419, #9440).
* Fix `vfio-user` MSI-X emulation when relocation enlarged the BAR (#9416).
* Populate the FDT `iommu-map` for all PCI segments on AArch64 (#9314).
* Use the QEMU subsystem ID for pvpanic and ivshmem, so the Windows pvpanic
  driver binds (#9075).
* Fix 16550 interrupt handling, which stopped the console output of FreeBSD
  guests (#9187, #9263, #9347).
* Don't fail memory hotplug with a disconnected `vhost-user` backend (#9205).
* Fix a deadlock between memory resize and device eject (#9201), and validate
  resize requests against the VM configuration (#9248).
* Release guest memory after a failed VFIO attachment and on SEV-SNP teardown
  (#9297).
* Fix Landlock with VFIO devices (#9405) and with TAP devices passed by name
  (#9413).
* Fix a race on the API socket lock file (#9203).
* Honor the system timezone in local log timestamps (#9257).
* Don't warn about an existing TAP device without `ip=` (#9093).
* Reject zero vCPUs, zero queues, invalid `max_phys_bits` and overflowing CPU
  topologies (#9317, #9330, #9336, #9321).
* Return errors instead of panicking in several places (#9214, #9215, #9176,
  #9138, #9140).
* Fix x86 emulator bugs on MSHV (#9084, #9193, #9207, #9346, #9433, #9445), and
  validate the IGVM CPUID page (#9158).
* On KVM, only finalize SVE when available (#9171), handle capability query
  errors (#9149), and fail early without SEV-SNP capabilities (#9142).
* OpenAPI specification fixes (#9370, #9160).
* Documentation improvements and fixes (#9368, #9372, #9373, #9385, #9357,
  #9383).

### Contributors

Many thanks to everyone who has contributed to our release:

* Alex Turner <alex@turntrout.com>
* Anatol Belski <anbelski@linux.microsoft.com>
* Bert Belder <bert@deno.com>
* Bo Chen <bchen@crusoe.ai>
* Changyuan Lyu <changyuanl@google.com>
* Chit Mitra <chittajit@google.com>
* CMGS <ilskdw@gmail.com>
* Daniel Guns <danbguns@gmail.com>
* doge <me@crackerben.com>
* Erick Bourgeois <erick@jeb.ca>
* Gabi Villalonga Simon <gvillalongasimon@cloudflare.com>
* Hong <78775577+snghong@users.noreply.github.com>
* Isaku Yamahata <iyamahata@crusoe.ai>
* Julian Schindel <julian.schindel@cyberus-technology.de>
* Leander Kohler <leander.kohler@cyberus-technology.de>
* Lukas Frank <lukas.frank@sap.com>
* Martin Tutko <martin@tutko.dev>
* Matt Braun <matt@fly.io>
* nagendramohan <nagendramohan1990@gmail.com>
* Oliver Anderson <oliver.anderson@cyberus-technology.de>
* Pascal Scholz <pascal.scholz@cyberus-technology.de>
* Philipp Schuster <philipp.schuster@cyberus-technology.de>
* Rob Bradford <rbradford@meta.com>
* Ruben Hakobyan <hruben@meta.com>
* Sahana Bogar <sahana@digiscrypt.com>
* Samyazz <49154465+Samyazz@users.noreply.github.com>
* Sebastien Boeuf <sboeuf@meta.com>
* Simon Lucido <simonlucido@meta.com>
* Tianrui Liu <daisyltr@google.com>
* Umang Pokhriyal <umangpokhriyall@gmail.com>
* Vasilis Liaskovitis <vliaskov@gmail.com>
* Virtainer <320955747+virtainer@users.noreply.github.com>
* Wei Liu <liuwe@microsoft.com>
* Weinan Liu <wnliu@google.com>
* Xia Chao <shapirolutts@gmail.com>
* Yuhan Deng <dyuhan@google.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v55.0">GitHub Release</a> for the release assets.

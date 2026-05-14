---
title: "Cloud Hypervisor v52.0 Released!"
date: 2026-05-14T21:58:11Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in [v52.0 group](https://github.com/orgs/cloud-hypervisor/projects/6/views/6?filterQuery=release%3A%22Release+52%22) of our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6/).

Security Fixes
--------------

This release fixes a use-after-free vulnerability in the
`virtio-block` async I/O completion path (#8220). Details can be found
in GHSA-f47p-p25q-83rh (CVE-2026-45782).

Confidential VM Support: KVM SEV-SNP
------------------------------------

AMD SEV-SNP confidential VMs can now be launched on KVM in addition to
MSHV. Cloud Hypervisor uses `guest_memfd` to back private memory and
loads an IGVM-packaged firmware (e.g. Oak stage0) to bring up an
SEV-SNP guest on real hardware (#7942).

Measured-boot support has been completed for KVM SEV-SNP guests,
bringing parity with the QEMU launch flow: the kernel, command line,
and initrd are reflected in the launch measurement, and a signed SNP
ID block can be passed so the guest (or a remote attestor) can verify
the launch (#8123).

VFIO Device Passthrough via `iommufd` and `vfio-cdev`
----------------------------------------------------

Cloud Hypervisor now supports the modern Linux VFIO device-access
model based on the `iommufd` subsystem and per-device `vfio-cdev`
character devices (available since Linux v6.6). This unlocks the
advanced IOMMU features exposed by modern hardware and enables fully
accelerated IOMMU support inside the guest. The legacy
`container/group`-based path continues to be supported (#7981).

In addition, several VFIO/PCI improvements have landed:

* A new `host_mmap_bars` option allows selective mapping of VFIO BARs
  into the guest, so devices that expose registers that should not be
  fast-pathed can be selectively trapped (#7991).
* Sub-page VFIO BARs are now expanded to a full page for `mmap()`,
  avoiding spurious failures on devices with small BARs (#7939).
* `VfioMsix::cap` and `VfioMsix::bar` are now kept synchronized to
  avoid stale MSI-X state (#7993).
* VFIO MMIO regions are now reliably cleared in `DeviceManager::drop`
  (#8063).
* Deferred PCI BAR reprogramming state is now part of the saved
  device state (#7945).
* GSIs for MSI/MSI-X interrupt vectors are now allocated lazily,
  reducing GSI consumption for VMs with many devices (#7940).

Multi-Connection TCP Live Migration
-----------------------------------

The `send-migration` HTTP command now accepts a `connections`
parameter (defaults to `1`) that controls how many parallel TCP
connections are used for the live migration data transfer. On
servers with high-bandwidth (e.g. 100G) network links, multiple
connections significantly increase migration throughput (#7669).

Userfaultfd Demand-Paged Snapshot Restore
-----------------------------------------

A new `memory_restore_mode` option on the restore path allows guest
memory to be populated lazily via `userfaultfd` instead of reading
the entire memory snapshot before the VM resumes. This dramatically
reduces restore-to-resume latency for large guests, at the cost of
faulting pages in on demand after resume (#7800).

Configurable PCI BDFs for Devices
----------------------------------

Users now can configure the PCI slot/device number, the middle
part of the PCI BDF, through the CLI and API; bus and function
remain fixed at `0`. This covers virtio devices (except balloon),
VFIO devices, vfio-user device, and generic vhost-user devices
(#8175, #7965, #8174, #8163).

AIO Block Backend `write_zeroes` and `punch_hole` Support
---------------------------------------------------------

The AIO block backend now implements `write_zeroes` and `punch_hole`,
fixing a v51.0 regression that affected guests on hosts with
`io_uring` disabled (e.g. RHEL 9 / CentOS Stream 9, where
`kernel.io_uring_disabled=2` is a common hardening default)
(#7817).

Asynchronous QCOW2 Backend with `io_uring`
-----------------------------------------

A new `QcowDiskAsync` backend uses `io_uring` for data I/O on QCOW2
images and is automatically selected when `io_uring` is available
(falling back to the synchronous backend otherwise). Each virtio
queue gets its own ring and its own duplicated file descriptor,
enabling parallel data I/O across queues; QCOW2 metadata is shared
behind an `Arc<RwLock<_>>` (#7882).

Generic `vhost-user` Device Support
-----------------------------------

A new generic `vhost-user-generic` device type has been added.
All information about the device (number of queues, queue size,
feature bits, etc.) is provided to Cloud Hypervisor via the
command line or API, allowing arbitrary vhost-user backends to be
attached without device-type-specific support in the VMM (#7221).

Core Scheduling for vCPU Threads
--------------------------------

A new `core_scheduling` option on `--cpus` controls how vCPU threads
are placed on SMT siblings via the kernel's core-scheduling feature,
which is useful for mitigating cross-thread side-channel attacks
without disabling SMT outright. Three modes are supported: `vm`
(default — all vCPU threads share one cookie), one-cookie-per-vCPU,
and a configurable grouping mode (#7747).

Snapshot/Restore and Live Migration Improvements
-----------------------------------------------

* Snapshot and restore now treat the memory backing file as a sparse
  file: on snapshot the backing FD is sought with
  `SEEK_DATA`/`SEEK_HOLE` to skip unallocated regions, and on restore
  the on-disk file is read as sparse. Pages the guest never touched
  remain as holes in the backing file, substantially reducing both
  snapshot size and restore time (#8113).
* Paused VMs can now be migrated (#8099).
* User-configurable downtime and timeout parameters for live
  migration (#7835), and improved downtime observability (#7979).
* A new option to automatically resume the VM on restore, useful
  when restoring from the VMM command line without an API socket
  (#7857).
* Snapshot/restore support for `vhost-user` devices has been filled
  out (#7908), including migration support for `virtio-fs` (#7937).
* Vsock connections are now reset on snapshot restore to avoid stale
  half-open connections on the guest side (#7958).
* The KVM clock is now restored before vCPUs are resumed (#7932),
  and `notify_guest_clock_paused` is called for Hyper-V guests
  (#7933), eliminating clock jumps observed after restore.
* `vhost-user` devices receive a guest interrupt on resume so that
  in-flight I/O is not stalled across pause/resume (#7851), and
  activated queue eventfds are signaled on resume for all virtio
  devices (#8004).
* `UFFDIO_WAKE` and `UFFD_FEATURE_MISSING_HUGETLBFS` are now handled
  correctly (#8016).

New Command-Line and API Options
--------------------------------

* `--no-shutdown` keeps the VMM process running when the guest
  triggers a shutdown. This is useful for higher-level management
  layers that need full control over the VMM process (#8025).
* fw_cfg now supports inline string items via
  `--fw-cfg name=...,string=...`, matching QEMU's syntax (#7825).
* A new per-zone `mergeable` option on `--memory-zone` lets KSM
  merging be controlled per memory zone instead of only globally
  (#7983).
* Disk lock granularity is now configurable via `--disk` (#7763).
* `--cpus threads_per_core` is now enforced to be at most two
  (#8078), matching the hardware constraint.
* `--log-format` controls the log output format, complementing
  existing log-level controls (#8172). Wallclock log timestamps
  now use UTC (#8193).
* The HTTP API now logs error responses (#8181), and the
  `user_devices` configuration is included in the OpenAPI spec
  (#8072).

MSHV Support Improvements
-------------------------

* `SVM_EXIT_CPUID`, `SVM_EXIT_MSR`, and `GHCB_MSR_TERM_REQ` handlers
  have been added to the SEV-SNP exit path (#7934).
* Guest MTRR MSRs are now preserved on KVM (#7944).
* Nested-virtualization control fixes on AMD (#7783).

Deprecations
------------

Auto-detection of disk image types is now deprecated and will be
removed in a future release. Specify the image type explicitly via
the `--disk image_type=...` CLI option or the `image_type` field
on `DiskConfig` in the HTTP/D-Bus API to avoid the deprecation
warning (#8219).

Notable Bug Fixes
-----------------

* Fix a guest-triggerable VMM panic via an out-of-bounds
  `queue_select` in the MSI-X vector access path on the virtio PCI
  common config (#7918).
* Saturate instead of underflowing on a malformed balloon `actual`
  value reported by the guest (#7903).
* IOMMU address translation now returns errors instead of panicking
  on malformed guest input (#8023).
* Several virtio device error paths now reset queues instead of
  panicking or exiting the worker (#8128); additional device
  manager paths avoid guest-induced panics (#8186).
* Virtio barriers are now sized from the number of queues actually
  activated by the guest, fixing pause hangs (#7881).
* Spec compliance fixes for virtio device config layouts (#7805).
  and other small spec deviations (#8066). Console descriptor-chain
  processing has been fixed (#7802). dword writes to the MSI-X
  control register are now handled (#7956).
* PCI segment ACPI `_UID` values now match the segment ID (#7992).
* Fix VHDX multiqueue data corruption (#7746).
* Fix block-device resize-disk (#7948) and the writeback-mode
  update flow (#7949).
* Fix vdpa RX failure after device reset by always using base 0
  (#7964).
* Fix rebooting with landlock and a pty console (#7911).
* Reject rate limiting with `vhost-user` (#8135).
* Fix a deadlock between `CpuManager::pause()` and MMIO writes to
  the ACPI CPU hotplug controller (#7990, #8092).
* Cancel `vhost-user` reconnection if the device has been unplugged
  (#8182).
* Remove the API socket path when `start_vmm` fails (#8018).
* Add missing ID validation for the virtio-rng device (#9a46affc3).
* Fix UB in `MemoryRangeTable::read_from` (#7828) and `load_igvm()`
  (#8129).
* `memory_actual_size` reflects hot-plug state, removing a slow
  recomputation path (#7969).
* DIO alignment is now queried directly from the underlying file
  rather than assumed (#7767).
* QCOW2 metadata access is now thread-safe with `num_queues > 1`
  (#7744).
* Block devices unconditionally assume sparse support, matching
  QEMU and avoiding a non-existent probe ioctl (#7757).
* Multi-value CLI options now use `.action(ArgAction::Append)` so
  that repeating an option appends rather than replacing (#7778).
* AIO completions are batched in `next_completed_request` for the
  block backend, reducing per-completion overhead (#7864).
* Roll back the PCI BAR address on a failed `move_bar` so that an
  out-of-range MMIO address programmed by the guest leaves the
  device functional rather than crashing the VMM (#7950).
* Fix O_DIRECT writes failing with `EINVAL` on the synchronous
  QCOW2 backend (#8012).
* Fix O_DIRECT reads failing with `EINVAL` on the async `io_uring`
  QCOW2 read path (#8051).
* Move QCOW2 compressed-cluster decompression out of the metadata
  lock, removing a bottleneck for compressed images (#8061).
* Clamp the balloon's reported range to its region before
  processing unused pages (#8098).
* Validate the requested balloon size against total guest RAM
  (#8116).
* Reject `--memory-zone` configurations that set both `mergeable`
  and `shared` (#8126).
* Disable sector 0 writes for autodetected VHD images (#8218).

Contributors
------------

Many thanks to everyone who has contributed to our release:

* Alyssa Ross <hi@alyssa.is>
* Anatol Belski <anbelski@linux.microsoft.com>
* Andrei Vagin <avagin@google.com>
* Anirudh Rayabharam <anrayabh@microsoft.com>
* Bo Chen <bchen@crusoe.ai>
* CMGS <ilskdw@gmail.com>
* Changyuan Lyu <changyuanl@google.com>
* Chinmoy <daschinmoyy21@gmail.com>
* Damian Barabonkov <dbctl@pm.me>
* Demi Marie Obenour <demiobenour@gmail.com>
* Dylan Reid <dgreid@dylanreid.com>
* Dylan Reid <dgreid@fb.com>
* Emir Beganovic <beganovic.emir@gmail.com>
* JP Kobryn <inwardvessel@gmail.com>
* Jared White <git@jaredwhite.dev>
* Julian Schindel <julian.schindel@cyberus-technology.de>
* Julian Schindel <mail@arctic-alpaca.de>
* Keith Adler <kadler@cloudflare.com>
* Kevin Hui <kevinhui@meta.com>
* Leander Kohler <leander.kohler@cyberus-technology.de>
* Max Makarov <maxpain@linux.com>
* Muminul Islam <muislam@microsoft.com>
* Nguyen Dinh Phi <phind.uet@gmail.com>
* Pascal Scholz <pascal.scholz@cyberus-technology.de>
* Peter Oskolkov <posk@google.com>
* Philipp Schuster <philipp.schuster@cyberus-technology.de>
* Rob Bradford <rbradford@meta.com>
* Roberto Campesato <render@metalabs.org>
* Ruben Hakobyan <hruben@meta.com>
* Saravanan D <saravanand@crusoe.ai>
* Sebastian Eydam <sebastian.eydam@cyberus-technology.de>
* Sebastian Walz <sebastian.walz@secunet.com>
* Shayon Mukherjee <shayonj@gmail.com>
* Souradeep <schakrabarti@microsoft.com>
* Souradeep Chakrabarti <schakrabarti@microsoft.com>
* Stepan Rabotkin <epicstyt@gmail.com>
* Thomas Prescher <thomas.prescher@cyberus-technology.de>
* Tobias Kässer <t.kaesser@gmail.com>
* Victor Vieux <vieux@repl.it>
* Vincent Thomas <vincent@v-thomas.com>
* Wei Liu <liuwe@microsoft.com>
* Zhiheng Tao <junchuan.tzh@antgroup.com>
* dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
* sohakpt <sohakpt@outlook.com>
* wuxinyue <wuxinyue.wxy@antgroup.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v52.0">GitHub Release</a> for the release assets.

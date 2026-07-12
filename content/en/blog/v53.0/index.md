---
title: "Cloud Hypervisor v53.0 Released!"
date: 2026-07-12T21:55:39Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in [v53.0 group](https://github.com/orgs/cloud-hypervisor/projects/6/views/6?filterQuery=release%3A%22Release+53%22) of our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6/).

### Snapshot/Restore and Live Migration Improvements

* An offloaded snapshot/restore daemon has been introduced, allowing snapshot
  and restore to be carried out by an external process. The live migration
  protocol has been extended so page faults can be serviced from the source.
  This enables *postcopy* for remote live migration and *on-demand paging* for
  the offload daemon, both built on `userfaultfd`, bringing the offload daemon
  to parity with the internal snapshot/restore implementation (#8403, #8264,
  #8556).
* Snapshot pages can now be prefaulted in the background after a
  `userfaultfd`-based restore, combining a fast restore-to-resume with fully
  faulted-in memory shortly afterwards. The number of prefault threads scales
  with the available parallelism (#8150, #8538, #8484).
* Live migration data can now be encrypted using mutual TLS (#8053).
* VFIO migration v2 is now supported for same-host snapshot and restore of
  migratable VFIO devices (for example ConnectX VFs bound to `mlx5_vfio_pci`)
  (#8303).
* Migrated guests now issue post-migration network announcements so that
  connectivity on the new host is refreshed within milliseconds rather than
  taking up to 20 seconds to recover (#8263).
* The `vm.send-migration` API endpoint now returns immediately rather than
  blocking for the duration of the migration (#8021).

### Nested Hyper-V (Windows Guest) Support

Windows guests can now run nested Hyper-V as used by WSL2 on the KVM backend
(#8481).

### `virtio-rtc` Device Support

Support for `virtio-rtc` devices has been added (via `--rtc`), providing a
Real Time Clock to the guest. This is primarily useful for, and only enabled by
default on, MSHV guests that do not have access to `kvmclock` (#7795).

### Guest Clock Updates Across Snapshot/Restore and Migration

The guest clock is now advanced to account for the elapsed wall-clock time when
a VM is resumed after a snapshot-restore or a live migration so the guest sees
the correct time of day immediately rather than lagging behind by the downtime.
On x86 the kvmclock realtime flag is preserved so that the kernel adjusts the
clock automatically (#8256). On ARM64 the guest counter is advanced using the
`KVM_REG_ARM_TIMER_CNT` interface (#8343). vCPU TSC offsets are also
re-synchronized on restore (#8437).

### Buffered Serial Output for Late-Connecting Clients

In socket serial mode (`--serial socket=...`) the output produced before a
client connects is now buffered so a console client that attaches after boot
sees the earlier output (#8322).

### New Command-Line and API Options

* A `reserve=on|off` option has been added to `--memory` and
  `--memory-zone` (default `off`). When enabled, guest RAM is mapped
  without `MAP_NORESERVE` so an overcommitted configuration fails cleanly at VM
  creation with `ENOMEM` (#8350).
* The SMBIOS/DMI fields exposed via `--platform` have been extended and scoped
  to specific SMBIOS structures, for workloads that consume this data for
  licensing, inventory, or host identification (#8259).
* The VMM can now consume pre-opened VFIO `cdev` and `iommufd` file descriptors
  supplied by the caller, letting a privileged orchestrator open the device
  nodes once and hand the FDs to an unprivileged VMM at boot or at runtime.
  This is also a prerequisite for live migration of VMs using VFIO devices
  (#8287).
* A "glog style" log format has been added, with a single-character level and
  local or UTC timestamps (#8265).
* A new `--seccomp=errno` option has been added that will result in filtered
  syscalls to set `errno` to `EPERM`. This can be used when the killing of the
  process with `SIGSYS` is not desired (#8578).

### Deprecations

* The legacy `--platform` SMBIOS keys `serial_number` and `uuid` are
  deprecated in favor of the new SMBIOS-structure-scoped keys. The
  legacy keys continue to be accepted, with a warning, and will be
  removed in a future release (#8259).
* The generic `vhost-user` device's `virtio_id` command-line
  parameter is deprecated in favor of `device_type`, matching the API
  and configuration naming. `virtio_id` is retained as an alias that
  logs a warning and will be removed in a later release (#8564).

### Notable Bug Fixes

* Revert `create memfd for private mappings`, which caused a serious memory
  consumption regression without hugepages or `shared=on` (#8246).
* Advertise the mandatory Hyper-V partition privileges so Windows
  guests enable the reference TSC page instead of taking a VM exit on
  every clock read (#8380).
* Correctly save and restore ARM64 SVE registers (#8268).
* Set the guest physical address space size correctly on AMD (#8291).
* Sparse align the initial PCI BAR placement to avoid a Windows rebalancing
  deadlock (#8205).
* Various TPM fixes, including for Windows guests (#8305, #8312).
* Preserve `WRITE_ZEROES` on QCOW2 images with backing files (#8245)
  and fix `WriteZeroes` sector arithmetic overflow (#8388).
* Improve `O_DIRECT` handling so that `direct=on` is usable on hosts
  requiring 4K alignment, including opening fixed VHD images (#8335).
* Resolve relative QCOW2 backing file paths correctly (#8196).
* Drain block I/O before the device is paused (#8356) and retry
  locking when interrupted by `EINTR` (#8402).
* Fix VHDX region-table overlap detection (#8483) and an incomplete
  bounds check in the VHDX synchronous I/O worker (#8529).
* Fix a guest deadlock by signalling `DEVICE_NEEDS_RESET` and
  releasing the activation barrier when a virtio device fails to
  activate (#8295).
* Handle short and misaligned MMIO/PIO accesses without panicking:
  validate the MMIO access size (#8506), return all-ones for
  unregistered MMIO/PIO reads (#8237), correct `fw_cfg` short and long
  reads (#8507), respect the PCI CFG capability length for BAR access
  (#8272, #8238), and reject incorrect MSI-X table and PBA reads (#8417).
* Translate virtio-iommu buffers that span adjacent mappings (#8520),
  and add centralized virtio descriptor-range validation (#8232).
* Handle a guest/host half-close on vsock connections (#8372).
* Avoid a guest-triggerable VMM panic by replacing asserts on ACPI
  device accesses with checks (#8405).
* Emit a complete ACPI `_S5_` sleep package, fixing an early-boot
  fault on OpenBSD guests (#8426).
* Transfer post-snapshot guest memory changes during live migration to
  avoid corruption with `vhost-user` devices (#8361).
* Improve configuration validation to return errors instead of
  panicking on malformed input (#8511), require the `ch-remote`
  snapshot/restore config arguments instead of panicking (#8331),
  reject resizing below the boot memory size (#8428), reject removal of
  an already-removed device (#8559), and fix generic `vhost-user`
  parsing (#8564).
* Don't leak a file descriptor when ejecting a VFIO device (#8367),
  and fix a PCI device hotplug race by deferring device visibility
  (#8369).
* Fix PCI segment ID validation (#8377) and make the PCI BDF
  configurable for the balloon and ivshmem devices (#8310).
* Return HTTP 404 for API requests against a VM that has not been
  created (#8320), and omit unset optional fields from API responses so
  that strict client generators accept them (#8321).
* Clean up a stale API socket under a lock before binding (#8325).
* Cache the local timezone before installing seccomp filters (#8327).
* Enhance the ACPI PPTT with cache topology information (#7893).
* Correct several OpenAPI specification entries: the
  `iommu_address_width` field name (#8244), integer schema formats
  (#8278), `GenericVhostUserConfig` properties (#8543), a parameter
  name (#8544), and the `vmm.nmi` to `vm.nmi` endpoint (#8571).
* Deduplicate `VmConfig::preserved_fds` (#8271).

### Contributors

Many thanks to everyone who has contributed to our release:

* Aastha Rawat <aastharawat@microsoft.com>
* Adel-Ayoub <adelayoub.maaziz@gmail.com>
* Alexander Lvov <alexander.lvov.git@gmail.com>
* Alyssa Ross <hi@alyssa.is>
* Anatol Belski <anbelski@linux.microsoft.com>
* Andrei Vagin <avagin@google.com>
* Anirudh Rayabharam <anrayabh@microsoft.com>
* Atish Patra <atishp@meta.com>
* Bo Chen <bchen@crusoe.ai>
* Cameron Baird <cameronbaird@microsoft.com>
* Chris Webb <chris@arachsys.com>
* CMGS <ilskdw@gmail.com>
* Damian Barabonkov <dbctl@pm.me>
* Daniel Verkamp <drv@meta.com>
* doge <me@crackerben.com>
* Dylan Reid <dgreid@fb.com>
* Gauthier Jolly <contact@gjolly.fr>
* Henry Hrvoje Tonkovac <htonkovac@gmail.com>
* Ian Klemm <hi@ianklemm.de>
* Julian Schindel <julian.schindel@cyberus-technology.de>
* Leander Kohler <leander.kohler@cyberus-technology.de>
* Max Makarov <maxpain@linux.com>
* Meng Zhuo <mengzhuo@iscas.ac.cn>
* Muminul Islam <muislam@microsoft.com>
* Nikolas Kyx <55556836+nyx191@users.noreply.github.com>
* Oliver Anderson <oliver.anderson@cyberus-technology.de>
* Pascal Scholz <pascal.scholz@cyberus-technology.de>
* Philipp Schuster <philipp.schuster@cyberus-technology.de>
* Rob Bradford <rbradford@meta.com>
* Roman <roman@vanesyan.com>
* Rowen-Ye <rowenye1@gmail.com>
* Ruben Hakobyan <hruben@meta.com>
* Saravanan D <saravanand@crusoe.ai>
* Sayed Kaif <metsw24@gmail.com>
* Sebastian Eydam <sebastian.eydam@cyberus-technology.de>
* Sebastien Boeuf <sboeuf@meta.com>
* tchaton <thomas.chaton.ai@gmail.com>
* Thomas Prescher <thomas.prescher@cyberus-technology.de>
* tonic <tonicbupt@gmail.com>
* Tushar Khatri <hello@tusharkhatri.in>
* wangyf0611 <wangyufeng@iscas.ac.cn>
* Wei Liu <liuwe@microsoft.com>
* wuxinyue <wuxinyue.wxy@antgroup.com>
* yanjianqing <yanjianqing@kylinos.cn>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v53.0">GitHub Release</a> for the release assets.

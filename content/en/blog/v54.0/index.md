---
title: "Cloud Hypervisor v54.0 Released!"
date: 2026-10-14T09:44:13Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in [v54.0 group](https://github.com/orgs/cloud-hypervisor/projects/6/views/6?filterQuery=release%3A%22Release+54%22) of our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6/).

### Live Migration Version Compatibility

Starting with this release, Cloud Hypervisor guarantees that live migrations
from the two previous releases are accepted ("n-2"). For example, v54.0 accepts
migrations from v52.0 and v53.0. Upgrades spanning more releases might work,
but incremental upgrades, for example from v54.0 to v56.0 to v58.0, are
strongly recommended. New functionality is added in a way that keeps VMs from
older releases working, so only newly created VMs can use it. The migration
protocol version is now an internal detail (#8751, #8787).

**Migrating back to an older release is not officially supported.** It might
work, depending on the VMM and VM configuration, but there is no guarantee.

This is another important step on our live migration roadmap. This effort is tracked
in [#7111](https://github.com/cloud-hypervisor/cloud-hypervisor/issues/7111).

### VFIO Device Live Migration

VMs with migratable VFIO devices, for example ConnectX VFs bound to
`mlx5_vfio_pci`, can now be live migrated. The device state is transferred
together with the guest, and memory written by the device is tracked during the
migration. This requires `--platform iommufd=on` and a host driver with
migration support. On the destination, pre-opened VFIO device and `iommufd`
file descriptors can be passed through the new `vfio_fds` and `iommufd_fd`
options of `receive-migration` and `restore`. VFIO devices behind a virtual
IOMMU cannot be migrated yet (#8528).

### Live Migration Cancellation

An ongoing live migration can now be cancelled with the new
`vm.cancel-migration` API endpoint or the `ch-remote cancel-migration` command.
This lets management software abort a migration that does not converge, whose
destination is no longer the best choice, or that puts too much load on the
network. The VM keeps running on the source and a `vm.migration-cancelled`
event is emitted. After a failed or cancelled migration, Cloud Hypervisor
attempts to restore the source VM to its pre-migration state if it has not
already moved to the destination (#8455, #8935).

### Event Monitor Improvements

The event monitor (`--event-monitor`) is now properly documented, including its
format and all events (#8888). We aim to keep the events stable, so that
management software can rely on them. A new `vmm.started` event signals that
the VMM is ready to serve API requests (#8888). The live migration events have
been refined: the new `vm.migration-starting` and
`vm.migration-receive-starting` events are emitted when a migration attempt
begins, `vm.migration-started` now means that the handshake succeeded, and
`vm.migration-receive-failed` is emitted for every failure (#8850).

### Emulated ARM SMMUv3 (Experimental)

On AArch64, passthrough devices can now be placed behind an emulated ARM SMMUv3
with `--device ...,iommu=smmuv3`. Unlike with virtio-iommu, the guest uses its
stock `arm-smmu-v3` driver, and the translation is offloaded to the physical
SMMUv3 through `iommufd`. This makes it possible to assign devices that use the
IOMMU themselves, such as NVIDIA Grace-Blackwell GPUs. The feature requires
KVM, `--platform iommufd=on` and a host kernel with nested translation support
for ARM SMMUv3. Hotplug, snapshot/restore and live migration are not supported,
and `iommu=smmuv3` cannot be mixed with `iommu=virtio` (#8955, #8805, #8919,
#8790).

### Flat VMDK Disk Image Support

Flat VMDK disk images (`monolithicFlat` and `twoGbMaxExtentFlat`) are now
supported through `--disk image_type=vmdk`. A VMDK image consists of a
descriptor file that references one or more extent files holding the data.
Because the descriptor refers to other files by path, VMDK images are only
opened when `backing_files=on` marks the image as trusted, and relative extent
paths are confined to the descriptor's directory. Only synchronous I/O is
supported, and with Landlock the extent paths must be allowed through
`--landlock-rules` (#8599, #8714, #8886, #8885, #8691).

### Balloon Statistics

Statistics reported by the guest's `virtio-balloon` driver can now be queried
through the new `vm.balloon-stats` API endpoint, the `ch-remote balloon-stats`
command and the D-Bus API. They give management software insight into the
guest's memory usage, for example to size the balloon. The guest driver must
support balloon statistics for this to work (#8603).

### `virtio-console` Over a Unix Socket

The `virtio-console` device can now be exposed over a Unix socket with
`--console socket=<path>`. It works the same way as `--serial socket=<path>`,
and one client can be connected at a time. Configurations that pass a socket
path without selecting socket mode, or the other way round, are now rejected
for both `--serial` and `--console` (#8687).

### AArch64 Boot Improvements

AArch64 now supports firmware-aided direct kernel boot. When both `--firmware`
and `--kernel` are given together with `--fw-cfg-config`, the firmware receives
the kernel, command line and initramfs through the `fw_cfg` interface and boots
the kernel. This requires a build with the `fw_cfg` feature (#8910). Direct
kernel boot can also use ACPI using EFI tables supplied by Cloud Hypervisor
when `acpi=on` is added to the kernel command line. This enables features such
as PCI hotplug without a firmware, and a new ACPI Time and Alarm Device
provides the RTC to such guests (requires Linux 7.1 or newer with
`CONFIG_ACPI_TAD`) (#9013). Finally, AArch64 guests now receive SMBIOS tables
including the `--platform` values, which requires an updated EDK2 `CloudHv`
firmware (#8786).

### Faster Memory Prefault

Prefaulting guest memory (`prefault=on`) is now considerably faster on large
hosts. Memory zones are now prefaulted in parallel on their host NUMA nodes,
which reduced the prefault time of a 3 TiB guest on a two-socket host from 51.8
s to 7.4 s. This applies to both VM boot and snapshot restore. In addition,
prefaulted memory is now backed by transparent huge pages when the host THP
policy is `madvise` (#8785, #8962, #8915).

### VM Generation ID Device

On x86_64 and AArch64, VMs now have a VM Generation ID device whose value
changes on every restore and incoming live migration. Before, all VMs restored
from the same snapshot started with the same random number generator state and
produced the same `/dev/urandom` output until something reseeded it. Guest
kernels built with `CONFIG_VMGENID` now reseed after a restore. The device is
always present and needs no configuration. With direct kernel boot on AArch64,
the guest needs `acpi=on` on the kernel command line. Applications that seeded
their own random number generator keep that state and have to draw fresh
randomness themselves after a restore (#8907).

### Snapshot/Restore and Live Migration Improvements

* Saving and restoring vCPU state is now up to 5-9 times faster for VMs with
  many vCPUs, which shortens snapshot, restore and live migration downtime
  (#8961).
* Live migration downtime and total migration time have been reduced further,
  in particular for VMs with QCOW2 disks and for VMs with shared file-backed
  memory (#8898, #8943, #8982, #8589).
* Memory zones can be remapped to different host NUMA nodes on
  `receive-migration` and `restore` through the new `zone_updates` option
  (#8370).
* A new `memory_restore_mode=copyonwrite` maps the snapshot memory file
  copy-on-write, so VMs restored from the same snapshot share the page cache
  (#8581).
* A new `preserve_source=on` option of `send-migration` leaves the source VM
  paused instead of shutting it down after an offload snapshot (#8623).
* Serialized VM state is about 29% smaller for a VM with 16 disks. The
  previous PCI configuration state representation is still accepted when
  restoring snapshots (#8904).

### Device and Platform Improvements

* SEV-SNP VMs with VFIO devices now use roughly half as much host memory.
  Memory and CPU hotplug, huge pages and a virtual IOMMU are now rejected for
  SEV-SNP guests (#8501).
* On x86_64, the AMD HyperTransport range (1012 GiB to 1 TiB) is now reserved
  in the guest memory layout, so VFIO DMA mappings no longer fail for guests
  with more than 1011 GiB of memory (#8902).
* A PCI host bridge is now only created on PCI segment 0, which allows
  endpoints on other segments to be assigned PCI device 0 as needed by NVIDIA
  Grace GPUs (#8747).
* `vhost-user-net` devices now use the MAC address and MTU from the backend's
  configuration space when the backend provides them, and the reference
  backend gained a `mac=` option (#8684).
* VMs with passthrough GPUs start faster, by about 400 ms per GPU (#8975).

### New Command-Line and API Options

* A `guest_block_size` option has been added to `--disk` to override the
  logical block size advertised to the guest, for example to expose a 512-byte
  image stored on 4K-native storage (#8595).
* `reserve` now defaults to `on` for `--memory` and `--memory-zone` when
  `hugepages=on` is set, so a shortage of huge pages fails at VM creation
  instead of causing a `SIGBUS` at runtime. An explicit `reserve=off` is
  still honoured (#8770).

### Changed Default Behavior

* Nested virtualization is now disabled by default on all architectures. It
  widens the attack surface of the host kernel, and most users do not need it.
  Guests that use hardware virtualization themselves now need `--cpus nested=on`
  (#9045).
* The `virtio-net` offloads (`offload_csum`, `offload_tso` and `offload_ufo`)
  are now disabled by default, because they make the host do more work for
  the guest's packets. They can be enabled again with
  `--net ...,offload_csum=on,offload_tso=on,offload_ufo=on` (#9041).
* Both new defaults apply to the command line and the API. VMs restored from
  a snapshot or received through live migration keep their configured
  values.

### Deprecations and Removals

* Disk image type autodetection, deprecated since v52.0, has been removed.
  `image_type` must now be specified for every disk that is not a
  `vhost-user` disk, and it must match the image format (#8794, #8798).
* The `memory_mode` option of `receive-migration` has been removed. The
  sender now announces the memory mode through the migration protocol
  (#8819).
* The `local=on` option of `send-migration` is deprecated in favor of
  `memory_mode=memfds` (#8820).
* The per-device `iommu=on` option is deprecated in favor of `iommu=virtio`.
  In the API, the `iommu` fields change from a boolean to an
  `"Off"`, `"Virtio"` or `"Smmuv3"` value. Booleans are still accepted but
  deprecated, as is the top-level `iommu` field of `VmConfig` (#8955).
* Unaligned requests to raw and fixed VHD disks with `direct=on` are no
  longer emulated with read-modify-write cycles, which caused bugs and
  security issues. Such requests now fail with an I/O error. Linux and EDK2
  guests are not affected, because their requests are multiples of the
  advertised logical block size, which now also accounts for the direct I/O
  alignment of host block devices. `guest_block_size` values below the
  backing block size are now also rejected for read-only raw and fixed VHD
  disks (#9064).

### Security Hardening

* A security policy and a threat model describing trusted and untrusted
  entities have been added (#8384).
* A malicious `vhost-user` backend can no longer crash the VMM by resizing the
  guest memory files (#8841).
* Validate `vfio-user` sparse mmap areas against the region size, and enforce
  domain ownership on virtio-iommu detach (#8840).
* Validate that `KVM_HC_MAP_GPA_RANGE` hypercalls from SEV-SNP guests stay
  within guest memory (#8992).
* Fix guest-triggerable VMM panics in TPM register reads (#8816) and in VFIO
  DMA ranges spanning sparse mmap areas (#8734).
* Reads from unbacked PIO/MMIO addresses now return zeros instead of stale data
  (#8817), and `fw_cfg` DMA requests are decoded correctly and no longer allow
  a guest-controlled out-of-bounds offset (#8994).
* Harden QCOW2, VHD, VHDX and VMDK image parsing against malformed images
  (#8679, #8799).
* Release `vsock` local ports only to their owner (#8612).
* Bump `rustls` to fix RUSTSEC-2026-0285, which affects TLS-encrypted live
  migration (#8883).
* The main thread now runs under its own seccomp filter once it has started
  the worker threads. Before, it ran without a filter (#9062).
* A warning is now logged when TCP live migration runs without TLS
  (`tls_dir`). Plain TCP migration is unencrypted and unauthenticated, so
  anyone who can reach the destination can send it a VM. The documentation
  now uses TLS in all TCP migration examples (#9066).

### Notable Bug Fixes

* Fix several QCOW2 data integrity bugs: data loss from a stale punch-hole
  (#8624), double allocations after a failed L2 relocation or a failed write
  (#8637, #8748), and L2 table refcount ordering after a failed write (#8721).
* Fix unbounded QCOW2 image growth and space leaks (#8597, #8951), and use the
  whole refcount table the header declares (#8952).
* Flush cached QCOW2 metadata on device pause so snapshots and shared-disk
  migrations do not miss completed writes (#8607). Only clear the QCOW2 dirty
  bit when the last user of the image is destroyed (#8647), and open QCOW2
  backing files with `O_DIRECT` when `direct=on` (#8673).
* Fix VHDX sector size handling and reject images with 4K logical sectors
  (#8565), and fsync the image on guest flush (#8719).
* Fall back to `write` when `fallocate` returns `EOPNOTSUPP`, for example on
  tmpfs (#8604).
* Make a disk resize by a `vhost-user-blk` backend visible to the guest
  (#8824).
* Correctly snapshot the AArch64 GIC redistributor and ICC state of every
  vCPU (#8638), restore nested virtualization state in the right order
  (#8996), and save and restore the guest shadow stack pointer (#8924).
* Preserve queue indices across device resume (#8626), and fix a panic when
  restoring a VM with an unused virtio queue (#8702).
* Fix on-demand restore with THP (#8694) and of fully file-backed VMs (#8849),
  and poison guest pages that a failed on-demand restore never served (#8928).
* Fix restoring a VM with TAP networking without `CAP_NET_ADMIN` (#8605).
* Fix short reads and writes across the codebase, which could truncate
  snapshot files or hang a restore (#8897).
* Fix silent data corruption after a live migration: disk reads and received
  network frames that were written into guest memory during pre-copy could
  arrive with stale content on the destination (#9015).
* Fix hangs of TCP live migration on worker failure (#8795), detect dead
  connections (#8660), and clean up receiver threads after a failed migration
  (#8656).
* Don't resume the source VM after a failed postcopy migration when the guest
  already runs on the destination (#8890), and reject postcopy and on-demand
  restore for VMs with VFIO, vDPA, `vfio-user` or `vhost-user` devices
  (#9020).
* Allow `vhost-user` devices to be migrated again after a migration (#8920).
* Add missing CPUID compatibility checks for live migration and restore
  (leaf 0x7 sub-leaves, AMX and XSAVE state components). This may reject
  migrations to hosts that previously appeared to work (#8659, #8726, #8854).
* Reinstate the gap between boot RAM and the hotplug memory region (#8780).
* Exclude the COM1 and `fw_cfg` ports from the PCI I/O window, fixing Windows
  guests that did not start their virtio devices (#8980), and accept balloon
  requests with more than 256 pages, fixing the balloon with Windows guests
  (#9007).
* Set the virtio PCI ISR configuration bit on configuration changes (#9011).
* Fix the MSI-X pending bit array for vectors 31 to 63 of every 64-vector
  block, where setting or clearing a pending bit changed the wrong bits
  (#9058).
* Only attach the negotiated `virtio-net` queue pairs, avoiding dropped frames
  (#8772), and drop TX frames instead of exiting the VM when the TAP device
  returns `EIO` (#8723).
* Don't reply to `vsock` RST packets with an RST (#8692).
* Recognize masked PCI BAR size probes, fixing OpenBSD boot (#8598), and fix
  16-bit writes to the PCI configuration address port (#8818).
* Fix the guest cache topology for multi-package guests on x86_64 (#8731) and
  AArch64 (#8617).
* Set the PMU interrupt in the AArch64 ACPI MADT (#8861), fix the ACPI SRAT
  Generic Initiator handle for PCI devices (#8766), and propagate clean
  shutdowns on AArch64 (#8710).
* Handle `SystemEvent` exits on riscv64 (#8941).
* Fix SEV-ES/SEV-SNP boot on newer host kernels (#8884).
* Reclaim balloon memory with private file-backed memory zones (#8909).
* Improve `vhost-user` reconnection by retrying the complete handshake,
  replaying in-order queues and aborting the retry on device teardown (#8613,
  #8592, #8759, #8463).
* Make device removal retryable (#8739), reject the removal of devices
  attached to the virtio-iommu (#8650), and only eject the vCPU the guest is
  expected to eject (#8611).
* Fix CPU affinity with 128 or more vCPUs on musl (#8972), and reject CPU
  affinity values beyond `CPU_SETSIZE` instead of panicking (#8843).
* Raise the HTTP API request body limit from 50 KiB to 4 MiB (#8752).
* Allow several missing syscalls in the seccomp filters that killed the VMM
  with `SIGSYS` (#8681, #8682, #8779, #8808, #8814, #8832, #8954, #8957).
* Return correct HTTP status codes: 400 or 409 for invalid configurations
  (#8665, #8946), 404 for unknown devices or disks (#8640), and 409 for
  requests conflicting with the VM state (#8851).
* Fix the OpenAPI specification for `generic_vhost_user` (#8674) and the
  `BreakPoint` VM state (#8675), and omit `virtio-block` latency counters
  before the first request (#8878).
* Clean up a stale serial socket under a lock before binding (#8733), and
  reuse the serial socket listener across reboot (#8823).
* Update the MSHV crates, fixing boot on older Microsoft Hypervisor versions
  (#8809).
* Use host page size for dirty ranges (#9040).

### Contributors

Many thanks to everyone who has contributed to our release:

* aiqubits <aiqubits@hotmail.com>
* Alexander Lvov <alexander.lvov.git@gmail.com>
* Alyssa Ross <hi@alyssa.is>
* Anatol Belski <anbelski@linux.microsoft.com>
* Andrew Onyshchuk <oandrew@meta.com>
* Atish Patra <atishp@meta.com>
* Bo Chen <bchen@crusoe.ai>
* Chinmoy <daschinmoyy21@gmail.com>
* CMGS <ilskdw@gmail.com>
* Demi Marie Obenour <demiobenour@gmail.com>
* doge <me@crackerben.com>
* Evan Almloff <evanalmloff@gmail.com>
* Gauravpawar101 <Gauravpawar2522@gmail.com>
* Goran Draganić <goran@daytona.io>
* Isaku Yamahata <iyamahata@crusoe.ai>
* Jan Vokas <jan.vokas@zerops.io>
* Julian Schindel <julian.schindel@cyberus-technology.de>
* Leander Kohler <leander.kohler@cyberus-technology.de>
* leo03164 <leo03164@gmail.com>
* Leo Li <cheerleaderleo@outlook.com>
* Lily Goscha <lilygoscha@gmail.com>
* Max Makarov <maxpain@linux.com>
* Muminul Islam <muislam@microsoft.com>
* Oliver Anderson <oliver.anderson@cyberus-technology.de>
* Pascal Scholz <pascal.scholz@cyberus-technology.de>
* Peter Delevoryas <pdel@meta.com>
* Philipp Schuster <philipp.schuster@cyberus-technology.de>
* Rob Bradford <rbradford@meta.com>
* Rogelio Ruiz <rruiz@techxagon.io>
* Ruben Hakobyan <hruben@meta.com>
* Saravanan D <saravanand@crusoe.ai>
* Sebastien Boeuf <sboeuf@meta.com>
* Shatrughan Rai <polyglot.dev@outlook.com>
* Simon Lucido <simonlucido@meta.com>
* Stepan Rabotkin <epicstyt@gmail.com>
* Sumedh Alok Sharma <sumsharma@microsoft.com>
* Thomas Prescher <thomas.prescher@cyberus-technology.de>
* tonic <tonicbupt@gmail.com>
* Tynan Daly <tynan.s.daly@gmail.com>
* Umang Pokhriyal <umangpokhriyall@gmail.com>
* vans163 <vans554@gmail.com>
* Victor Vieux <vieux@repl.it>
* Wei Liu <liuwe@microsoft.com>
* windsornguyen <win@dedaluslabs.ai>
* Yilei Zheng <trilith.zheng@gmail.com>
* Yi Wang <foxywang@tencent.com>
* ZenAlexa <zimingwang945@gmail.com>

### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v54.0">GitHub Release</a> for the release assets.

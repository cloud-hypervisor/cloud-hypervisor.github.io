---
title: "Cloud Hypervisor v34.0 Released!"
date: 2023-08-10T16:44:32Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration v34.0. The following user visible changes have been made:

### Paravirtualised Panic Device Support

A new device has been added that can communicate when the guest kernel has panicked and share those details with the VMM. This is controlled with a new `--pvpanic` command line option and JSON API change equivalent. (#5526)

### Improvements to VM Core Dump

Requesting to dump the guest memory as core dump will now transparently pause the VM if required; returning to the original state after. (#5604)

### QCOW2 Support for Backing Files

The support for QCOW2 files has been enhanced to include support for using backing files. (#5573)

### Minimum Host Kernel Bump

The minimum supported host kernel is now 5.13 in order to incorporate a bug fix for `KVM_FEATURE_ASYNC_PF_INT` functionality. (#5626)

### Notable Bug Fixes

* The x86 emulator is only compiled in if MSHV is compiled in (the kernel carries out this job with KVM) (#5561).
* A regression has been fixed in VFIO support for devices that use MSI rather  than MSI-X (#5658).
* When triggering a VM shutdown or reset via I/O the vCPU thread will be  blocked until that asynchronous event has been received (#5645).
* Pausing a VM is now a synchronous action with the request only completing  when all vCPUs are paused (#5611).
* Event monitor support now correctly supports concurrent access (#5633).
* Bug fixes for the QCOW2 file support (#5573).

### Contributors

Many thanks to everyone who has contributed to our release:

* Alyssa Ross <hi@alyssa.is>
* Anatol Belski <anbelski@linux.microsoft.com>
* Bo Chen <chen.bo@intel.com>
* Changyuan Lyu <changyuanl@google.com>
* Christian Blichmann <cblichmann@google.com>
* Manish Goregaokar <manishsmail@gmail.com>
* Omer Faruk Bayram <omer.faruk@sartura.hr>
* Philipp Schuster <philipp.schuster@cyberus-technology.de>
* Praveen K Paladugu <prapal@linux.microsoft.com>
* Rob Bradford <rbradford@rivosinc.com>
* Ruslan Mstoi <ruslan.mstoi@intel.com>
* Yi Wang <foxywang@tencent.com>
* Yong He <alexyonghe@tencent.com>
* Yu Li <liyu.yukiteru@bytedance.com>
* dom.song <dom.song@amperecomputing.com>

### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v34.0">GitHub Release</a> for the release assets.

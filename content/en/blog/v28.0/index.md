---
title: "Cloud Hypervisor v28.0 Released!"
date: 2022-11-17T16:59:00Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in our new [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration v28.0.

### Community Engagement (Reminder)

Just a reminder that we have a new mailing list to support broader community discussions.  Please consider [subscribing](https://lists.cloudhypervisor.org/g/dev/). We plan to use this to announce a regular meeting for those interested in talking about Cloud
Hypervisor development.

### Long Term Support (LTS) Release

This is the first version of Cloud Hypervisor to be released under the LTS release process. Point releases for bug fixes will be made for the next 18 months; live migration and live upgrade will be supported between the point releases of the LTS.

### Virtualised TPM Support

Support for adding an emulated CRB TPM has been added. This has it's own [TPM documentation](docs/tpm.md).

### Transparent Huge Page Support

By default, but controllable through `--memory thp=off` if it possible to back the guest memory with Transparent Huge Pages (no file backing/`shared=off`) then this will be used resulting in improved boot performance.

### README Quick Start Improved

The README has been refreshed with the quick start guide updated to reflect the different firmware options and to recommend the use of pre-built binaries.

### Notable Bug Fixes

* Inappropriate Copy-on-Write of pinned pages (e.g. VFIO) leading to higher
  memory consumption (#4835)
* Multiple `virtio` device bug fixes found through fuzzing (#4859, #4799)
* Large QCOW files (> 4TiB) are now supported (#4767)
* Support for > 31 vCPUS on aarch64 (#4863)
* Multiple fixes to OpenAPI specification file (#4720, #4811)
* Programming of the MSI-X table has been optimised leading to faster boot on
  newer Linux kernels (#4744)
* Error on reboot from race to close TAP devices (#4871)
* Non-spec compliant virtio-block read-only support (#4888)
  
### Removals

The following functionality has been removed:

* Support for non-PVH firmware booting has been removed (#4511)
* I/O ports used for older versions of firmware have been removed (#3926)
* Deprecated API options for kernel/cmdline/initramfs have been removed (#4737)
 
### Contributors

Many thanks to everyone who has contributed to our release:

* Anatol Belski <anbelski@linux.microsoft.com>
* Bo Chen <chen.bo@intel.com>
* Fabiano Fidêncio <fabiano.fidencio@intel.com>
* Jianyong Wu <jianyong.wu@arm.com>
* Jinank Jain <jinankjain@microsoft.com>
* Jinrong Liang <cloudliang@tencent.com>
* lv.mengzhao <lv.mengzhao@zte.com.cn>
* Michael Zhao <michael.zhao@arm.com>
* Muminul Islam <muislam@microsoft.com>
* Praveen K Paladugu <prapal@linux.microsoft.com>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Wei Liu <liuwe@microsoft.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v28.0">GitHub Release</a> for the release assets.

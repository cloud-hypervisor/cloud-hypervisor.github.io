---
title: "Cloud Hypervisor v30.0 Released!"
date: 2023-02-24T01:10:15Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration
v30.0. The following user visible changes have been made:

### Command Line Changes for Reduced Binary Size

The `clap` crate was replaced by the `argh` crate to create our command
line, which reduced our release binary size from 3.6MB to 3.3MB. There
were several syntax changes:

* All `--option=value` commands now are `--option value`.
* The `--disk DISK1 DISK2` command now is `--disk DISK1 --disk DISK2`.
* The  `-vvv` command now is `-v -v -v`

### Basic vfio-user Server Support

Our `vfio-user` crate is extended to provide basic server side support
with an example of gpio vfio-user device. This crate now is moved to [its
own repository](https://github.com/rust-vmm/vfio-user) under the
`rust-vmm` organization.

### Heap Profiling Support

A new building target is added for profiling purposes with examples of
heap profiling using `dhat` gated by the `dhat-heap` feature.

### Documentation Improvements

The documentation on Intel TDX is expanded with details of the building
and using [TD-Shim](https://github.com/confidential-containers/td-shim),
references to [TDX Tools](https://github.com/intel/tdx-tools), and
version information of guest/host kernel/TDVF/TDShim being tested. Also,
a new 'heap profiling' documentation is added with improvements on the
existing 'profiling' documentation.

### Notable Bug Fixes

* Close FDs for TAP devices that are provided to VM (#5199, #5206)
* Set vcpu thread status properly and signal `exit_evt` upon thread exit (#5211)
* Populate CPUID leaf 0x4000_0010 (TSC frequency) (#5178, #5179)
* Inform the TPM guest driver upon failed TPM requests on the host (#5151)
* Bug fix to OpenAPI specification file (#5186)

### Contributors

Many thanks to everyone who has contributed to our release:

* Anatol Belski <anbelski@linux.microsoft.com>
* Anirudh Rayabharam <anrayabh@linux.microsoft.com>
* Bo Chen <chen.bo@intel.com>
* Jinank Jain <jinankjain@microsoft.com>
* Kaihang Zhang <kaihang.zhang@smartx.com>
* Michael Zhao <michael.zhao@arm.com>
* Muminul Islam <muislam@microsoft.com>
* Philipp Schuster <philipp.schuster@cyberus-technology.de>
* Praveen K Paladugu <prapal@linux.microsoft.com>
* Ravi kumar Veeramally <ravikumar.veeramally@intel.com>
* Rob Bradford <robert.bradford@intel.com>
* Ruslan Mstoi <ruslan.mstoi@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Wei Liu <liuwe@microsoft.com>
* Yong He <alexyonghe@tencent.com>
* Yu Li <liyu.yukiteru@bytedance.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v30.0">GitHub Release</a> for the release assets.

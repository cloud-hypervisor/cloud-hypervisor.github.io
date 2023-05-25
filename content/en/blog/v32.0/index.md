---
title: "Cloud Hypervisor v32.0 Released!"
date: 2023-05-18T18:13:12Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration v32.0. The following user visible changes have been made:

### Increased PCI Segment Limit

The maximum number of PCI segments that can be used is now 96 (up from 16).

### API Changes

* The VmmPingResponse now includes the PID as well as the build details.  (#5348)

### Notable Bug Fixes

* Ignore and warn TAP FDs sent via the HTTP request body (#5350)
* Properly preserve and close valid FDs for TAP devices (#5373)
* Only use `KVM_ARM_VCPU_PMU_V3` if available (#5360)
* Only touch the tty flags if it's being used (#5343)
* Fix seccomp filter lists for vhost-user devices (#5361)
* The number of vCPUs is capped at the hypervisor maximum (#5357)
* Fixes for TTY reset (#5414)
* CPU topology fixes on MSHV (#5325)
* Seccomp fixes for older distributions (#5397)

### Contributors

Many thanks to everyone who has contributed to our release:

* Alyssa Ross <hi@alyssa.is>
* Anatol Belski <anbelski@linux.microsoft.com>
* Bo Chen <chen.bo@intel.com>
* Hao Xu <howeyxu@tencent.com>
* Muminul Islam <muislam@microsoft.com>
* Omer Faruk Bayram <omer.faruk@sartura.hr>
* Rafael Mendonca <rafaelmendsr@gmail.com>
* Rob Bradford <rbradford@rivosinc.com>
* Ruslan Mstoi <ruslan.mstoi@intel.com>
* Smit Gardhariya <gardhariya.smit@gmail.com>
* Wei Liu <liuwe@microsoft.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v32.0">GitHub Release</a> for the release assets.

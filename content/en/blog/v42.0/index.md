---
title: "Cloud Hypervisor v42.0 Released!"
date: 2024-10-25T09:20:04Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in our [roadmap
project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration
v42.0. The following user visible changes have been made:

### SVE/SVE2 Support on AArch64

The SVE and SVE2 feature bits are now propagated through to the guest on
AArch64. (#6678, #6691)

### Notable Bug Fixes

* Reduce latency notification when rate limited (#6672)
* Fix `virtio-console` resizing (#6704)
* Fix resizing when console uses TTY (#6754)
* Avoid deadlock in PCI BAR reprogramming that can occur when adding a new
  `virtio` device to a VM that has been restored (#6775)
* Fix console resizing after VM restore (#6748)
* Fix memory resize error due to incorrect bounds checks (#6736)

### Sponsorships

During this release cycle a new VFIO CI worker has been provided by Crusoe
Energy and a new ARM64 CI worker has been provided by Ubicloud.

### Contributors

Many thanks to everyone who has contributed to our release:

* Alexandru Matei <alexandru.matei@uipath.com>
* Alyssa Ross <hi@alyssa.is>
* Anirudh Rayabharam <anrayabh@microsoft.com>
* BharatNarasimman <bharatn@microsoft.com>
* Bo Chen <chen.bo@intel.com>
* Jinank Jain <jinankjain@microsoft.com>
* Jonas Scholz <Jonas.Scholz@bbscholz.de>
* Nuno Das Neves <nudasnev@microsoft.com>
* Praveen K Paladugu <prapal@linux.microsoft.com>
* Purna Pavan Chandra <paekkaladevi@microsoft.com>
* Rob Bradford <rbradford@rivosinc.com>
* Ruoqing He <heruoqing@iscas.ac.cn>
* Songqian Li <sionli@tencent.com>
* Tom Dohrmann <erbse.13@gmx.de>
* Wei Liu <liuwe@microsoft.com>
* Wenyu Huang <huangwenyuu@outlook.com>
* Yuhong Zhong <yz@cs.columbia.edu>
* wuxinyue <wuxinyue.wxy@antgroup.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v42.0">GitHub Release</a> for the release assets.

---
title: "Cloud Hypervisor v40.0 Released!"
date: 2024-06-21T11:12:02Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in our [roadmap
project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration
v40.0. The following user visible changes have been made:

### Support for Restoring File Descriptor Backed Network Devices

It is now possible to pass file descriptors over the HTTP API (and using
`ch-remote`) when restoring to update the file descriptors for network devices.
This enables snapshot & restore functionality for guests using `macvtap` or
other file descriptor backed network devices. (#6286)

### Notable Bug Fixes

* Default values have been removed from required fields in the OpenAPI metadata
  (#6495)
* The help syntax of `ch-remote remove-device` has been improved (#6456)
* A double close of file descriptors has been fixed when using `--serial`
  (#6486)
* To prevent loops a limit on the nesting level for QCOW2 backing files has
  been introduced (#6482)
* Boot time performance has been improved with multiple cores by avoiding
  `cpuid` instructions and by seeding the in kernel file descriptor table
  (#6498, #6478)
* L1 cache details are more likely to be propagated into the guest (#6523)
* The default topology for guests now uses multiple cores rather than sockets
  (#6504)

### Contributors

Many thanks to everyone who has contributed to our release:  

* Alexandru Matei <alexandru.matei@uipath.com>
* Bo Chen <chen.bo@intel.com>
* Jinank Jain <jinankjain@microsoft.com>
* Josh Soref <2119212+jsoref@users.noreply.github.com>
* Muminul Islam <muislam@microsoft.com>
* Nuno Das Neves <nudasnev@microsoft.com>
* Omer Faruk Bayram <omer.faruk@sartura.hr>
* Praveen K Paladugu <prapal@linux.microsoft.com>
* Purna Pavan Chandra <paekkaladevi@linux.microsoft.com>
* Rob Bradford <rbradford@rivosinc.com>
* SamrutGadde <samrut.gadde@gmail.com>
* Sean Banko <sbanko@crusoe.ai>
* Songqian Li <sionli@tencent.com>
* Wei Liu <liuwe@microsoft.com>
* Yi Wang <foxywang@tencent.com>
* Yu Li <liyu.yukiteru@bytedance.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v40.0">GitHub Release</a> for the release assets.

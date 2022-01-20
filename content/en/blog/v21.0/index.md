---
title: "Cloud Hypervisor v21.0 Released!"
date: 2022-01-20T15:31:31Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked through the [v21.0 project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/24).

### Efficient Local Live Migration (for Live Upgrade)

In order to support fast live upgrade of the VMM an optimised path has been added in which the memory for the VM is not compared from source to destination. This is activated by passing `--local` to the `ch-remote send-migration` command. This means that the live upgrade can complete in the order of 50ms vs 3s. (#3566)

### Recommended Kernel is Now 5.15

Due to an issue in the `virtio-net` code in 5.14 the recommended Linux kernel is now 5.15. (#3530)

### Notable Bug fixes

* Multiple fixes were made to the OpenAPI YAML file to match the implementaion (#3555,#3562)
* Avoid live migration deadlock when triggered during the kernel boot (#3585)
* Support live migration within firmware (#3586)
* Validate the `virtio-net` desciptor chain (#3548)
* `direct=on` (`O_DIRECT`) can now be used with a guest that makes unaligned accesses (e.g. firmware) (#3587)

### Contributors

Many thanks to everyone who has contributed to our release:

* Anatol Belski <anbelski@linux.microsoft.com>
* Barret Rhoden <brho@google.com>
* Bo Chen <chen.bo@intel.com>
* Fabiano Fidêncio <fabiano.fidencio@intel.com>
* Henry Wang <Henry.Wang@arm.com>
* Liang Zhou <zhoul110@chinatelecom.cn>
* Michael Zhao <michael.zhao@arm.com>
* Muhammad Falak R Wani <falakreyaz@gmail.com>
* Muminul Islam <muislam@microsoft.com>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Wei Liu <liuwe@microsoft.com>
* Ziye Yang <ziye.yang@intel.com>
 
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v21.0">GitHub Release</a> for the release assets.

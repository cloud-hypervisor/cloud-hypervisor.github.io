---
title: "Cloud Hypervisor v45.0 Released!"
date: 2025-03-30T17:28:57Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in [v45.0 group](https://github.com/orgs/cloud-hypervisor/projects/6/views/4?filterQuery=release%3A%22Release+45%22) of our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6/).

Experimental `riscv64` Architecture Support
-------------------------------------------

Cloud Hypervisor now has experimental `riscv64` architecture
support. Details can be found from the [riscv
documentation](docs/riscv.md).

Alphabetically Sorted CLI Options
---------------------------------

To improve the readability of CLI options, the output of the `--help`
now is alphabetically sorted. (#6988)

Improved Downtime of VM Live Migration
--------------------------------------

The downtime of VM live migration is reduced via delaying some of the
tearing down process of the source VM after the destination VM is up and
running. (#6987)

Notable Bug Fixes
-----------------

* Fix seccomp filters related to http-api thread (#6967)
* Handle cross-page access in the emulator for mshv (#6968)

Contributors
------------

Many thanks to everyone who has contributed to our release:

* Anatol Belski <anbelski@linux.microsoft.com>
* Andrew Consroe <aconz2@gmail.com>
* Bo Chen <bchen@crusoe.ai>
* Jinank Jain <jinankjain@microsoft.com>
* Jinrong Liang <cloudliang@tencent.com>
* Philipp Schuster <philipp.schuster@cyberus-technology.de>
* Ruoqing He <heruoqing@iscas.ac.cn>
* Stefan Kober <stefan.kober@cyberus-technology.de>
* Wei Liu <liuwe@microsoft.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v45.0">GitHub Release</a> for the release assets.

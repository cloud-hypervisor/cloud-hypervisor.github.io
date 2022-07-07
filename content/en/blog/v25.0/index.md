---
title: "Cloud Hypervisor v25.0 Released!"
date: 2022-07-07T14:59:55Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked through the [v25.0
project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/29).

### `ch-remote` Improvements

The `ch-remote` command has gained support for creating the VM from a JSON
config and support for booting and deleting the VM from the VMM.

### VM "Coredump" Support

Under the `guest_debug` feature flag it is now possible to extract the memory
of the guest for use in debugging with e.g. the `crash` utility. (#4012)

### Notable Bug Fixes

* Always restore console mode on exit (#4249, #4248)
* Restore vCPUs in numerical order which fixes aarch64 snapshot/restore (#4244)
* Don't try and configure `IFF_RUNNING` on TAP devices (#4279)
* Propagate configured queue size through to vhost-user backend (#4286)
* Always Program vCPU CPUID before running the vCPU to fix running on Linux
  5.16 (#4156)
* Enable ACPI MADT "Online Capable" flag for hotpluggable vCPUs to fix newer
  Linux guest

### Removals

The following functionality has been removed:

* The `mergeable` option from the `virtio-pmem` support has been removed
  (#3968)
* The `dax` option from the `virtio-fs` support has been removed (#3889)

### Contributors

Many thanks to everyone who has contributed to our release:

* Dylan Bargatze <dbargatz@users.noreply.github.com>
* Jinank Jain <jinankjain@microsoft.com>
* Michael Zhao <michael.zhao@arm.com>
* Rob Bradford <robert.bradford@intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Wei Liu <liuwe@microsoft.com>
* Yi Wang <wang.yi59@zte.com.cn>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v25.0">GitHub Release</a> for the release assets.

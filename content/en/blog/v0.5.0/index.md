---
title: "Cloud Hypervisor v0.5.0 Released!"
date: 2020-02-07T15:42:54Z
draft: false
contributors: [Cloud Hypervisor Team]
---

This release has been tracked through the [0.5.0 project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/6).

Highlights for `cloud-hypervisor` version 0.5.0 include:

### Virtual Machine Dynamic Resizing

With 0.4.0 we added support for CPU hot plug, and 0.5.0 adds CPU hot unplug and memory hot plug as well. This allows to dynamically resize Cloud Hypervisor guests which is needed for e.g. Kubernetes related use cases.
The memory hot plug implementation is based on the same framework as the CPU hot plug/unplug one, i.e. hardware-reduced ACPI notifications to the guest.

Next on our VM resizing roadmap is the PCI devices hotplug feature.

### Multi-Queue, Multi-Threaded Paravirtualization

We enhanced our virtio networking and block support by having both devices use multiple I/O queues handled by multiple threads. This improves our default paravirtualized networking and block devices throughput.

### New Interrupt Management Framework

We improved our interrupt management implementation by introducing an Interrupt Manager framework, based on the currently on-going [rust-vmm vm-device](https://github.com/rust-vmm/vm-device) crates discussions. This move made the code significantly cleaner, and allowed us to remove several KVM related dependencies from crates like the PCI and virtio ones.

### Development Tools

In order to provide a better developer experience, we worked on improving our build, development and testing tools.
Somehow similar to the excellent [Firecracker's devtool](https://github.com/firecracker-microvm/firecracker/blob/master/tools/devtool), we now provide a [dev_cli script](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/master/scripts/dev_cli.sh).

With this new tool, our users and contributors will be able to build and test Cloud Hypervisor through a containerized environment.

### Kata Containers Integration

We spent some significant time and efforts debugging and fixing our integration with the [Kata Containers](https://github.com/kata-containers) project. Cloud Hypervisor is now a fully supported Kata Containers hypervisor, and is integrated into the project's CI.

### Contributors

Many thanks to everyone that contributed to the 0.5.0 release:

* Bo Chen <chen.bo@intel.com>
* Cathy Zhang <cathy.zhang@intel.com>
* Qiu Wenbo <qiuwenbo@phytium.com.cn>
* Rob Bradford <robert.bradford@intel.com>
* Samuel Ortiz <sameo@linux.intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Sergio Lopez <slp@redhat.com>
* Yang Zhong <yang.zhong@intel.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v0.5.0">GitHub Release</a> for the release assets.

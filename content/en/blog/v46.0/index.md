---
title: "Cloud Hypervisor v46.0 Released!"
date: 2025-05-23T22:07:00Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in [v46.0 group](https://github.com/orgs/cloud-hypervisor/projects/6/views/4?filterQuery=release%3A%22Release+46%22) of our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6/).

File-level Locking Support with `--disk`
----------------------------------------

Now file-level locking is enforced for disk images, provided by users
with `--disk`. This ensures that only a single Cloud Hypervisor instance
can obtain write access to a given disk image at any time, preventing
misconfiguration and avoiding potential data corruption. (#6974)

Improved Error Reporting with VM Resizing
-----------------------------------------

Instead of returning a generic error `400` (e.g. `BadRequest`), users
now get a more specific error `429` (e.g. `TooManyRequests`) when a
pending VM resizing is not completed. This allows users to better handle
different errors, say retrying the request when applicable. (#7043)

IPv6 Address Support with `--net`
---------------------------------

It is now possible to specify an IPv6 address and mask when creating a
network interface with `--net`. (#7048)

Experimental AArch64 Support with the MSHV Hypervisor
-----------------------------------------------------

It is now possible to start VMs on AArch64 platforms when using MSHV
hypervisor. (#7055)

Deprecated SGX Support
----------------------

The SGX support now is deprecated with a warning message if it being
used, with the intention to remove its support from our code base in two
release cycles (e.g. v48.0). (#7090)

Notable Bug Fixes
-----------------

* Remove `path` as required for `DiskConfig` from the OpenAPI spec file
  (#7017)
* Properly parse PCI capabilities (#7018)
* Reprogram PCI device BAR when its MSE bit is set (#7063)
* Update IOMMU mappings of MMIO regions with BAR reprogram for VFIO
  devices (#7064)
* Avoid resizing VMs to zero vCPUs (#7086)
* Fix extended topology enumeration leaf exposed to the guest (#7087)

Contributors
------------

Many thanks to everyone who has contributed to our release:

* Bingxin Li <bl497@cam.ac.uk>
* Bo Chen <bchen@crusoe.ai>
* Fabiano Fidêncio <fidencio@northflank.com>
* Gregory Anders <ganders@cloudflare.com>
* Jinank Jain <jinankjain@microsoft.com>
* Julian Stecklina <julian.stecklina@cyberus-technology.de>
* Muminul Islam <muislam@microsoft.com>
* Paolo Bonzini <pbonzini@redhat.com>
* Philipp Schuster <philipp.schuster@cyberus-technology.de>
* Rob Bradford <rbradford@rivosinc.com>
* Ruoqing He <heruoqing@iscas.ac.cn>
* Thomas Prescher <thomas.prescher@cyberus-technology.de>
* abm-77 <andrewmiller77@protonmail.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v46.0">GitHub Release</a> for the release assets.

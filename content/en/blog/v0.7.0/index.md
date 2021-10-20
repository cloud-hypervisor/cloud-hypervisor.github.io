---
title: "Cloud Hypervisor v0.7.0 Released!"
date: 2020-04-30T15:52:08Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked through the [0.7.0 project](https://github.com/cloud-hypervisor/cloud-hypervisor/projects/7).

Highlights for `cloud-hypervisor` version 0.7.0 include:

### Block, Network, Persistent Memory (PMEM), VirtioFS and Vsock hotplug

Further to our effort to support modifying a running guest we now support
hotplug and unplug of the following virtio backed devices: block, network,
pmem, virtio-fs and vsock. This functionality is available on the (default) PCI
based tranport and is exposed through the HTTP API. The `ch-remote` utility
provides a CLI for adding or removing these device types after the VM has
booted. User can use the `id` parameter on the devices to choose names for
devices to ease their removal.

### Alternative `libc` Support

Cloud Hypervisor can now be compiled with the `musl` C library and this release
contains a static binary compiled using that toolchain.

### Multithreaded Multi Queued `vhost-user` Backends

The `vhost-user` backends for network and block support that are shipped by
Cloud Hypervisor have been enhanced to support multiple threads and queues to
improve throughput. These backends are used automatically if `vhost_user=true`
is passed when the devices are created.

### Initial RamFS Support

By passing the `--initramfs` command line option the user can specify a file to
be loaded into the guest memory to be used as the kernel initial filesystem.
This is usually used to allow the loading of drivers needed to be able to
access the real root filesystem but it can also be used standalone for a very
minimal image.

### Alternative Memory Hotplug: `virtio-mem`

As well as supporting ACPI based hotplug Cloud Hypervisor now supports using
the `virtio-mem` hotplug alternative. This can be controlled by the
`hotplug_method` parameter on the `--memory` command line option. It currently
requires kernel patches to be able to support it.

### `Seccomp` Sandboxing

Cloud Hypervisor now has support for restricting the system calls that the
process can use via the `seccomp` security API. This on by default and is
controlled by the `--seccomp` command line option.

### Updated Distribution Support

With the release of Ubuntu 20.04 we have added that to the list of supported
distributions and is part of our regular testing programme.

### Command Line and API Changes

This is non exhaustive list of HTTP API and command line changes

* New `id` fields added for devices to allow them to be named to ease removal.
  If no name is specified the VMM chooses one.
* Use `--memory`'s `shared` and `hugepages` controls for determining backing
  memory instead of providing a path.
* The `--vsock` parameter only takes one device as the Linux kernel only
  supports a single Vsock device. The REST API has removed the vector for this
  option and replaced it with a single optional field.
* There is enhanced validation of the command line and API provided
  configurations to ensure that the provided options are compatible e.g. that
  shared memory is in use if any attempt is made to used a `vhost-user` backed
  device.
* `ch-remote` has added `add-disk`, `add-fs`, `add-net`, `add-pmem` and
  `add-vsock` subcommands. For removal `remove-device` is used. The REST API
  has appropriate new HTTP endpoints too.
* Specifying a `size` with `--pmem` is no longer required and instead the size
  will be obtained from the file. A `discard_writes` option has also been added
  to provide the equivalent of a read-only file.
* The parameters to `--block-backend` have been changed to more closely align
  with those used by `--disk`.

### Contributors

Many thanks to everyone who has contributed to our 0.7.0 release including some new faces.

* Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
* Bo Chen <chen.bo@intel.com>
* Cathy Zhang <cathy.zhang@intel.com>
* Damjan Georgievski <gdamjan@gmail.com>
* Dean Sheather <dean@coder.com>
* Eryu Guan <eguan@linux.alibaba.com>
* Hui Zhu <teawater@antfin.com>
* Jose Carlos Venegas Munoz <jose.carlos.venegas.munoz@intel.com>
* Martin Xu <martin.xu@intel.com>
* Muminul Islam <muislam@microsoft.com>
* Rob Bradford <robert.bradford@intel.com>
* Samuel Ortiz <sameo@linux.intel.com>
* Sebastien Boeuf <sebastien.boeuf@intel.com>
* Sergio Lopez <slp@redhat.com>
* Yang Zhong <yang.zhong@intel.com>
* Yi Sun <yi.y.sun@linux.intel.com>

### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v0.7.0">GitHub Release</a> for the release assets.

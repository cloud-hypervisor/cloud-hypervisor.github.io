---
title: "Cloud Hypervisor v31.0 Released!"
date: 2023-04-06T14:47:15Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration
v31.0. The following user visible changes have been made:

### Update to Latest `acpi_tables`

Adapted to the latest [acpi_tables](https://github.com/rust-vmm/acpi_tables). There has been significant API changes in
the crate.

### Update Reference Kernel to 6.2

Updated the recommended guest kernel version from 6.1.6 to 6.2.

### Improvements on Console `SIGWINCH` Handler

A separate thread had been created to capture the `SIGWINCH` signal and resize
the guest console. Now the thread is skipped if the console is not resizable.

Two completely different code paths existed for handling console resizing, one
for `tty` and the other for `pty`. That makes the understanding of the console
handling code unnecessarily complicated. Now the code paths are unified. Both
`tty` and `pty` are supported in single `SIGWINCH` handler. And the new handler
can works with kernel versions earlier than v5.5.

### Remove Directory Support from `MemoryZoneConfig::file`

Setting a directory to `MemoryZoneConfig::file` is no longer supported.

Before this change, user can set a directory to `file` of the `--memory-zone`
option. In that case, a temporary file will be created as the backing file for
the `mmap(2)` operation. This functionality has been unnecessary since we had
the native support for hugepages and allocating anonymous shared memory.

### Documentation Improvements

* Various improvements in API document
* Improvements in Doc comments
* Updated Slack channel information in README

### Notable Bug Fixes

* Fixed the offset setting while removing the entire mapping of `vhost-user` FS
  client.
* Fixed the `ShutdownVmm` and `Shutdown` commands to call the correct API
  endpoint.

### Contributors

Many thanks to everyone who has contributed to our release:

* Alyssa Ross <hi@alyssa.is>
* Bo Chen <chen.bo@intel.com>
* Daniel Farina <daniel@fdr.io>
* Dom <peng6662001@163.com>
* Hao Xu <howeyxu@tencent.com>
* Muminul Islam <muislam@microsoft.com>
* Omer Faruk Bayram <omer.faruk@sartura.hr>
* Ravi kumar Veeramally <ravikumar.veeramally@intel.com>
* Rob Bradford <rbradford@rivosinc.com>
* Ruslan Mstoi <ruslan.mstoi@intel.com>
* Smit Gardhariya <gardhariya.smit@gmail.com>
* Yang <ailin.yang@intel.com>
* Yong He <alexyonghe@tencent.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v31.0">GitHub Release</a> for the release assets.

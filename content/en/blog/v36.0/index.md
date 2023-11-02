---
title: "Cloud Hypervisor v36.0 Released!"
date: 2023-11-02T16:06:15Z
draft: false
contributors: [Cloud Hypervisor Team]
---
This release has been tracked in our [roadmap project](https://github.com/orgs/cloud-hypervisor/projects/6) as iteration
v36.0. The following user visible changes have been made:

### Command Line Changes

We switched back to use the `clap` crate to create our command line,
since the `argh` crate is barely maintained. There were several syntax
changes:

* All `--option value` commands now are `--option=value`.
* The `--disk DISK1 --disk DISK2` command now is `--disk DISK1 DISK2`.
* The `-v -v -v`command now is `-vvv`.

Note: the released binary size increased around 0.3M due to this change.

### Enabled Features Reported via API Endpoint and CLI

Now the enabled (Cargo) features of the running Cloud Hypervisor
instance can be queried via API endpoint (`/vmm.ping`) and CLI
(`--version -v`).

### NUMA Support for PCI segments

The `--numa` command is augmented with a new option `pci_segment=`, so
that users can define the relationship between PCI segments and NUMA
nodes. Examples can be found from the [memory documentation](docs/memory.md)

### CPU Topology Support on AMD Platforms

Now the CPU topology on x86_64 platforms supports multiple vendors.

### Unix Socket Backend for Serial Port

The `--serial` command is augmented with a new option `socket=`, allowing
users to access the serial port using a Unix socket.

### AIO Backend for Block Devices

An AIO backend is added for `virtio-block` devices to improve block
device performance when the `io_uring` feature is not supported by the
host Operating System.

### Documentation Improvements

* New [documentation](docs/coverage.md) for collecting coverage data
* Various typo fixes

### Notable Bug Fixes

* Fix a deadlock when TDX is enabled (#5845)
* Only advertise AMX feature bits to guest when the AMX cpu feature is
  enabled (#5834)
* Correct default value for vCPU topology on AArch64 (#5893)

### Contributors

Many thanks to everyone who has contributed to our release:

*  Anatol Belski <anbelski@linux.microsoft.com>
*  Bo Chen <chen.bo@intel.com>
*  Dario Nieuwenhuis <dirbaio@dirbaio.net>
*  Jianyong Wu <jianyong.wu@arm.com>
*  Jinank Jain <jinankjain@microsoft.com>
*  Muminul Islam <muislam@microsoft.com>
*  Praveen K Paladugu <prapal@linux.microsoft.com>
*  Ravi kumar Veeramally <ravikumar.veeramally@intel.com>
*  Rob Bradford <rbradford@rivosinc.com>
*  Thomas Barrett <tbarrett@crusoeenergy.com>
*  Wei Liu <liuwe@microsoft.com>
*  Yi Wang <foxywang@tencent.com>
*  dom.song <dom.song@amperecomputing.com>
### Download
 See the <a href="https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v36.0">GitHub Release</a> for the release assets.

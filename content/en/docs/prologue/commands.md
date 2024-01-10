---
title: "Commands"
description: "Cloud Hypervisor is composed of multiple binaries. This document shows what they are and their help output."
lead: "Cloud Hypervisor is composed of multiple binaries. This document shows what they are and their help output."
date: 2020-10-13T15:21:01+02:00
lastmod: 2020-10-13T15:21:01+02:00
draft: false
images: []
menu:
  docs:
    parent: "prologue"
weight: 130
toc: true
---

## cloud-hypervisor binary

The main `cloud-hypervisor` has the following help output (as of v37.0):

```
cloud-hypervisor --help
Launch a cloud-hypervisor VMM.

Usage: cloud-hypervisor [OPTIONS]

Options:
      --cpus <cpus>                    boot=<boot_vcpus>,max=<max_vcpus>,topology=<threads_per_core>:<cores_per_die>:<dies_per_package>:<packages>,kvm_hyperv=on|off,max_phys_bits=<maximum_number_of_physical_bits>,affinity=<list_of_vcpus_with_their_associated_cpuset>,features=<list_of_features_to_enable> [default: boot=1,max_phys_bits=46]
      --platform <platform>            num_pci_segments=<num_pci_segments>,iommu_segments=<list_of_segments>,serial_number=<dmi_device_serial_number>,uuid=<dmi_device_uuid>,oem_strings=<list_of_strings>
      --memory <memory>                Memory parameters "size=<guest_memory_size>,mergeable=on|off,shared=on|off,hugepages=on|off,hugepage_size=<hugepage_size>,hotplug_method=acpi|virtio-mem,hotplug_size=<hotpluggable_memory_size>,hotplugged_size=<hotplugged_memory_size>,prefault=on|off,thp=on|off" [default: size=512M]
      --memory-zone <memory-zone>...   User defined memory zone parameters "size=<guest_memory_region_size>,file=<backing_file>,shared=on|off,hugepages=on|off,hugepage_size=<hugepage_size>,host_numa_node=<node_id>,id=<zone_identifier>,hotplug_size=<hotpluggable_memory_size>,hotplugged_size=<hotplugged_memory_size>,prefault=on|off"
      --firmware <firmware>            Path to firmware that is loaded in an architectural specific way
      --kernel <kernel>                Path to kernel to load. This may be a kernel or firmware that supports a PVH entry point (e.g. vmlinux) or architecture equivalent
      --initramfs <initramfs>          Path to initramfs image
      --cmdline <cmdline>              Kernel command line
      --disk <disk>...                 Disk parameters "path=<disk_image_path>,readonly=on|off,direct=on|off,iommu=on|off,num_queues=<number_of_queues>,queue_size=<size_of_each_queue>,vhost_user=on|off,socket=<vhost_user_socket_path>,bw_size=<bytes>,bw_one_time_burst=<bytes>,bw_refill_time=<ms>,ops_size=<io_ops>,ops_one_time_burst=<io_ops>,ops_refill_time=<ms>,id=<device_id>,pci_segment=<segment_id>"
      --net <net>...                   Network parameters "tap=<if_name>,ip=<ip_addr>,mask=<net_mask>,mac=<mac_addr>,fd=<fd1,fd2...>,iommu=on|off,num_queues=<number_of_queues>,queue_size=<size_of_each_queue>,id=<device_id>,vhost_user=<vhost_user_enable>,socket=<vhost_user_socket_path>,vhost_mode=client|server,bw_size=<bytes>,bw_one_time_burst=<bytes>,bw_refill_time=<ms>,ops_size=<io_ops>,ops_one_time_burst=<io_ops>,ops_refill_time=<ms>,pci_segment=<segment_id>offload_tso=on|off,offload_ufo=on|off,offload_csum=on|off"
      --rng <rng>                      Random number generator parameters "src=<entropy_source_path>,iommu=on|off" [default: src=/dev/urandom]
      --balloon <balloon>              Balloon parameters "size=<balloon_size>,deflate_on_oom=on|off,free_page_reporting=on|off"
      --fs <fs>...                     virtio-fs parameters "tag=<tag_name>,socket=<socket_path>,num_queues=<number_of_queues>,queue_size=<size_of_each_queue>,id=<device_id>,pci_segment=<segment_id>"
      --pmem <pmem>...                 Persistent memory parameters "file=<backing_file_path>,size=<persistent_memory_size>,iommu=on|off,discard_writes=on|off,id=<device_id>,pci_segment=<segment_id>"
      --serial <serial>                Control serial port: off|null|pty|tty|file=</path/to/a/file>|socket=</path/to/a/file> [default: null]
      --console <console>              Control (virtio) console: "off|null|pty|tty|file=</path/to/a/file>,iommu=on|off" [default: tty]
      --device <device>...             Direct device assignment parameters "path=<device_path>,iommu=on|off,id=<device_id>,pci_segment=<segment_id>"
      --user-device <user-device>...   Userspace device socket=<socket_path>,id=<device_id>,pci_segment=<segment_id>"
      --vdpa <vdpa>...                 vDPA device "path=<device_path>,num_queues=<number_of_queues>,iommu=on|off,id=<device_id>,pci_segment=<segment_id>"
      --vsock <vsock>                  Virtio VSOCK parameters "cid=<context_id>,socket=<socket_path>,iommu=on|off,id=<device_id>,pci_segment=<segment_id>"
      --pvpanic                        Enable pvpanic device
      --numa <numa>...                 Settings related to a given NUMA node "guest_numa_id=<node_id>,cpus=<cpus_id>,distances=<list_of_distances_to_destination_nodes>,memory_zones=<list_of_memory_zones>,sgx_epc_sections=<list_of_sgx_epc_sections>,pci_segments=<list_of_pci_segments>"
      --watchdog                       Enable virtio-watchdog
  -v...                                Sets the level of debugging output
      --log-file <log-file>            Log file. Standard error is used if not specified
      --api-socket <api-socket>        HTTP API socket (UNIX domain socket): path=</path/to/a/file> or fd=<fd>.
      --event-monitor <event-monitor>  File to report events on: path=</path/to/a/file> or fd=<fd>
      --restore <restore>              Restore from a VM snapshot.
                                       Restore parameters "source_url=<source_url>,prefault=on|off"
                                       `source_url` should be a valid URL (e.g file:///foo/bar or tcp://192.168.1.10/foo)
                                       `prefault` brings memory pages in when enabled (disabled by default)
      --seccomp <seccomp>              [default: true] [possible values: true, false, log]
      --tpm <tpm>                      TPM device "(UNIX Domain Socket from swtpm) socket=</path/to/a/socket>"
      --sgx-epc <sgx-epc>...           SGX EPC parameters "id=<epc_section_identifier>,size=<epc_section_size>,prefault=on|off"
  -V, --version                        Print version
  -h, --help                           Print help
```

## ch-remote binary

The `ch-remote` binary that is used for controlling an running Virtual Machine has the following help output (as of v37.0):

```
ch-remote --help
Remotely control a cloud-hypervisor VMM.

Usage: ch-remote [OPTIONS] [COMMAND]

Commands:
  add-device         Add VFIO device
  add-disk           Add block device
  add-fs             Add virtio-fs backed fs device
  add-pmem           Add persistent memory device
  add-net            Add network device
  add-user-device    Add userspace device
  add-vdpa           Add vDPA device
  add-vsock          Add vsock device
  remove-device      Remove VFIO device
  info               Info on the VM
  counters           Counters from the VM
  pause              Pause the VM
  reboot             Reboot the VM
  power-button       Trigger a power button in the VM
  resize             Resize the VM
  resize-zone        Resize a memory zone
  resume             Resume the VM
  boot               Boot a created VM
  delete             Delete a VM
  shutdown           Shutdown the VM
  snapshot           Create a snapshot from VM
  restore            Restore VM from a snapshot
  coredump           Create a coredump from VM
  send-migration     Initiate a VM migration
  receive-migration  Receive a VM migration
  create             Create VM from a JSON configuration
  ping               Ping the VMM to check for API server availability
  shutdown-vmm       Shutdown the VMM
  help               Print this message or the help of the given subcommand(s)

Options:
      --api-socket <api-socket>  HTTP API socket path (UNIX domain socket).
  -h, --help                     Print help
  -V, --version                  Print version
```

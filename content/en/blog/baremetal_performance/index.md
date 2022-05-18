---
title: "Achieving Bare Metal Performance Within a Virtual Machine"
date: 2022-05-19T08:00:00Z
draft: false
contributors: [Sebastien Boeuf]
---

There are use cases for which a workload needs to access specific hardware such
as accelerators, GPU or network adapters to maximise potential performance. And
since these workloads run inside virtual machines (VM) for security reasons, the
challenge is to make this hardware available from within the VM, but without
degrading the performance that can be achieved from bare metal.

### VFIO, the Ideal Choice

This is a mature framework allowing a PCI device to be bound to the `vfio-pci`
driver instead of the default driver it is usually attached to.

It exposes an ioctl interface so that a userspace program can interact with the
device and retrieve all the information it needs. In the virtualization case,
this userspace program is the Virtual Machine Monitor (VMM), Cloud Hypervisor
for instance, which after it got all the information from the device, exposes
them to the guest. And that is how the workload can access the device inside the
VM, exactly the same way it would if it was directly running on bare metal.

Now that we've covered the functional aspect, let's have a look at the way we
can achieve bare metal performance from the guest.

The main idea for not degrading performance is to avoid as much as possible to
trigger VM exits when the workload interacts with the device, as well as when
it receives interrupts from it.

#### Base Address Registers

First, we can look at the PCI Base Address Registers (BAR). We need to prevent
a BAR access from generating a VM exit. This is done by mapping the device
region directly into the VMM virtual address space, and make this same region a
user memory region at the hypervisor level. This means we tell KVM to inform
the CPU it can find the pages related to this region directly at a specific
address in physical RAM. Once this is properly configured, any memory access
from guest workload to one of the device's PCI BARs will result in a direct
access to physical RAM from the CPU as it can find the pages from the Extended
Page Table (EPT).

There's one small part of the BARs for which we can't avoid VM exits, the MSI-X
tables. MSI-X specification expects the vector table and pending bit array to be
part of the device BARs. But the VMM needs to trap every access to these tables
since it's responsible for configuring the interrupts both at the KVM and VFIO
levels. This is important to note this doesn't impact the performance of the
device when being used by the guest. The interrupt vectors are only configured
during the initialization of the device driver, which is already completed at
the time the workload interacts with the device.

#### Direct Memory Accesses

The second aspect, the main one actually, is how Direct Memory Access (DMA) is
performed securely without generating any VM exit. DMA is the standard way for
a device to access physical RAM without involving CPU cycles, which allows the
device to achieve very high performance. In the context of virtualization, we
want to reuse this mechanism, but without allowing a malicious guest to use this
device to reach every address from physical RAM. That's where the IOMMU comes
into play, as the gatekeeper of RAM accesses from any device on the machine.
The VMM is responsible for configuring the IOMMU through the VFIO interface. It
provides the set of pages that can be accessed from a specific device, which
usually means the entire guest RAM. This information is stored in the DMA
Remapping (DMAR) table as part of the IOMMU. Whenever the workload initiate a
DMA transfer between the device and the guest RAM, the IOMMU will allow such
access, but if the address is outside the authorized range, the IOMMU will
prevent the transfer from happening. That's how security is enforced in the
virtualization context.

Since DMA doesn't involve CPU to access the memory, a DMA transfer doesn't
trigger any VM exit, providing identical performance to what can be observed
on bare metal.

#### Interrupts

Third and last aspect, the interrupts. Depending on the type of device, we can
see a lot of interrupts being generated, which can trigger a large amount of VM
exits, affecting directly the performance of the device inside the VM.

The way to avoid such disruption is by relying on fairly recent hardware to
leverage a feature called Posted Interrupts (PI). This is both part of the CPU
with the virtual APIC (APICv) and the IOMMU through the Interrupt Remapping (IR)
table. When the hardware supports it, the hypervisor on behalf of the VMM will
configure the IOMMU by adding new entries to the IR table. Later on, whenever
an interrupt is triggered, the IOMMU will check the IR table to find out the PI
descriptor associated with it. It then triggers the correct interrupt inside the
guest relying on the APICv. This whole chain of events is entirely handled in
hardware, meaning there's no VM exit involved, which doesn't lead to any drop
in performance.

#### How To Use VFIO

For more details on how to use VFIO with Cloud Hypervisor, refer to the
following [documentation](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/vfio.md).

### vDPA, an Interesting Alternative

vDPA stands for virtio Data Path Acceleration, and the main reason this new
framework exists is its ability to simplify the migration process. The whole
concept behind vDPA relies on the virtio specification, which is what makes it
more suited for migration.

#### Control Path

On the one hand, the virtio control path is used for configuring the virtqueues
and getting information about the device. This is achieved through the ioctl
interface that is accessible through the device node `/dev/vhost-vdpa`. The
userspace program, the VMM again, retrieves all the information it needs so it
can expose the correct type of virtio device to the guest, with the right amount
of queues, the size of each queue, and the virtio configuration associated with.

#### Data Path

On the other hand, the virtio data path, effectively the virtqueues themselves,
is used to transfer the data between frontend in the guest and backend from the
host. But in this very special case, the virtqueues are directly part of the
physical device, allowing DMA transfers to be initiated by the guest. And the
same way it works with VFIO because the device is also attached to a physical
IOMMU, the guest can perform secure and efficient memory accesses from the
device.

#### Migration (experimental)

Providing a simpler path for migrating physical devices from one VM to another
is one of the main reason vDPA was created. Because of the design relying on
virtqueues, most of the migration complexity can be handled by the VMM, without
the need for the vDPA device to provide an opaque blob of data that will have to
be restored on the destination VM. That's where it differentiates from the VFIO
approach, which will require every vendor to implement the VFIO migration API as
part of their driver, providing an opaque blob specific to each device.

It's important to note that VFIO migration API is very recent and not heavily
tested and deployed, meaning you might want to wait for a bit before jumping
to it.

For vDPA, which is a very recent addition to the Linux kernel, the migration
isn't fully figured out yet by the maintainers since it still requires some
extra support through the virtio specification that will allow to stop a device
before it can be migrated.
There's an alternative approach implemented in software part of the Data Plan
Development Kit (DPDK). It shadows the virtqueues to have complete knowledge of
what is happening inside the queues, and therefore at any point in time it can
stop the device and start migrating.

#### How To Use vDPA

For more details on how to use vDPA with Cloud Hypervisor, refer to the
following [documentation](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/vdpa.md).
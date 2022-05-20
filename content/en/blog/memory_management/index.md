---
title: "Memory Management Techniques"
date: 2022-07-07T08:00:00Z
draft: false
contributors: [Sebastien Boeuf]
---

Depending on the expectations around the workload running in a Virtual Machine
(VM), as well as the agreement between a customer and an operator, multiple use
cases related to memory management between host and guest arise and they can be
addressed through different techniques.

### Host Managed

This section is about how memory can be managed by the host, as it knows the VM
is going to need more or less memory during its runtime.

This is particularly well illustrated by the Cloud Native use case, involving
containers being created or destroyed, leading to the need to adjust the amount
of memory available.

We can also take the example of users running a single VM with a certain amount
of RAM until they need more because a different type of workload requires a
larger amount of memory.

We don't want to run a very large VM just in case we might need more memory
later because the larger the VM, the more expensive the cost. And that's why
having access to such flexibility is very convenient for our users.

#### Ballooning

This technique was the former way of performing some sort of hot plug/unplug
without dealing with the complexity associated with adding or removing memory
slots. The logic is reversed in a sense, as the VM is created with the maximum
amount of memory that can be expected, and a balloon is inflated inside the
guest, in order to reduce the available amount of memory.

From a host perspective, if the system is running low on memory, inflating the
balloon from one or several VMs can help the host getting some memory back to
keep the system afloat.
On the other hand if the host has enough spare memory to give some more to one
of its VMs, it can deflate the balloon.

It is important to note that until recently (introduction of `virtio-mem`),
ballooning was the only reliable way of removing memory from a running VM.

#### Hot Plug

This is the proper technique for adding or removing memory to a VM, without
using a tool like a balloon. And there are two different ways of performing
memory hot plug, one is through `ACPI` and the other is with `virtio-mem`.

##### ACPI

This has been the standard way for hot plugging some memory into a VM for quite
some time. This is because the mechanism is part of the ACPI specification and
has been implemented in guest OSes such as Linux and Windows years ago.

Depending on the guest OS, limitations might differ, but for instance with Linux
there is no way to plug a memory DIMM smaller than 128 MiB. This doesn't allow
for fine grained hot plug, but that's good enough for practical use cases, as we
usually increase a VM's memory using gigabyte as the unit.

The main drawback is the hot unplug really. This is inconvenient and complicated
for such operation to succeed because we must remove an entire memory DIMM. For
instance, if we plug an extra 2 GiB to a running VM, and later on we want to
remove only 1 GiB, this won't be possible as we can only remove 2 GiB. Of course
we could have plugged the extra 2 GiB splitting it into 16 DIMMs of 128 MiB, but
we would hit the limit on how many memory slots are actually supported.
And even if we could work around this limitation, main part of the complexity
comes from the fact we have no way to ensure the guest isn't using any of the
memory slot we're trying to remove.
This makes hot unplug a non supported feature with `ACPI` hot plug mechanism.
This is the reason why before `virtio-mem` came into the picture, we could
combine `ACPI` hot plug with `balloon`, so that we would use the `ACPI`
mechanism for hot plugging while the balloon would be used for both hot unplug
and fine grained operations.

##### virtio-mem

This fairly recent solution has been introduced to address all use cases we
mentioned so far. It is a full hot plug/unplug solution as it doesn't have any
of the drawbacks from `balloon` and `ACPI` hot plug. It allows for fine grained
hot plug/unplug, relying on the `virtio-mem` driver in the guest to manage small
chunks of memory. Unless you have strong reasons not to use `virtio-mem` (guest
kernel not recent enough for instance), this should be the standard way of
dynamically managing a VM's memory. This feature is available starting with
Linux 5.8.

### Guest Driven

Now that we've covered how the host can manage the guest memory allocated to a
VM, let's look at the way the guest can notify the host for accurate memory
management.

#### Free Page Reporting

In general, when a VM is created with a certain amount of memory, only a small
portion of what is available is actually consumed by the VM after boot. But as
soon as one or multiple workloads run inside the guest, the memory starts being
paged. At this point, let's say 90% of the VM's memory have been allocated, the
guest might start freeing some pages after the workloads have been stopped. This
will have no impact on the amount of memory consumed from a host perspective, as
it has no way to know which pages the guest might have freed.

When looking for a way to overcommit memory, meaning when running multiple VMs
and the sum of all guest RAMs is higher than what the physical RAM can offer,
being able to free pages based on guest's input is a must. And that's what the
feature `free page reporting` has been added for in the `virtio-balloon`
specification.

This feature requires a `virtio-balloon` device to be created, but it doesn't
require any balloon because inflating or deflating operations are not part of
the mechanism. When enabled, the guest will have a way of notifying the VMM
about set of pages being freed. Based on this information, the VMM will advise
the host that these pages are no longer in use, which effectively gives some
memory back to the host.

One small drawback of this feature is that depending on how frequently the guest
reports back to the host, the VMM will have more work and be slightly less
efficient. And that's because the slight drop in performance that could be
observed that we didn't enable this feature by default on Cloud Hypervisor.

#### Deflate on OOM

When running critical workloads that must not fail, particularly because of
memory pressure in the guest, the feature `deflate on OOM` can be very
convenient as it will give the guest the power to deflate the `balloon` when
an Out Of Memory (OOM) event happens.

Of course this means the `balloon` must have been previously inflated, otherwise
the guest will have nothing to deflate and no way to release the memory
pressure.

### References

If you want to use these features with Cloud Hypervisor, please refer to the
following documentation:
- [Memory Ballooning](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/balloon.md)
- [Memory Hot Plug](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/memory.md)
- [Guest Features](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/balloon.md)

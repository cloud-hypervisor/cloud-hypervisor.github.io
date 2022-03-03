---
title: "Quick Start"
description: "One page summary of how to get started with Cloud Hypervisor"
lead: "One page summary of how to get started with Cloud Hypervisor"
date: 2020-11-16T13:59:39+01:00
lastmod: 2020-11-16T13:59:39+01:00
draft: false
images: []
menu:
  docs:
    parent: "prologue"
weight: 110
toc: true
---

## Setup

We create a folder to build and run `cloud-hypervisor` at `$HOME/cloud-hypervisor`

```shell
export CLOUDH=$HOME/cloud-hypervisor
# Add this to .bashrc so it is available for subsequent bash sessions
echo "export CLOUDH=$HOME/cloud-hypervisor" >> ~/.bashrc
mkdir $CLOUDH
```

## Install prerequisites

You need to install some prerequisite packages in order to build and test Cloud Hypervisor.
Here, all the steps are based on Ubuntu, for other Linux distributions please replace the
package manager and package name.

```shell
# Install git
sudo apt install git
# Install rust tool chain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# Install build-essential
sudo apt install build-essential
# Install qemu
apt install qemu qemu-utils
```

You will need to restart bash to get `rustup` into your path, or add it manually.

```shell
# If you want to build statically linked binary please add musl target
apt install musl musl-tools
rustup target add x86_64-unknown-linux-musl
```

## Clone and build

First you need to clone and build the cloud-hypervisor repo:

```shell
pushd $CLOUDH
git clone https://github.com/cloud-hypervisor/cloud-hypervisor.git
cd cloud-hypervisor
cargo build --release

# We need to give the cloud-hypervisor binary the NET_ADMIN capabilities for it to set TAP interfaces up on the host.
sudo setcap cap_net_admin+ep ./target/release/cloud-hypervisor

# If you want to build statically linked binary
cargo build --release --target=x86_64-unknown-linux-musl --all
popd
```

This will build a `cloud-hypervisor` binary under `$CLOUDH/cloud-hypervisor/target/release/cloud-hypervisor`.

### Containerized builds and tests

If you want to build and test Cloud Hypervisor without having to install all the
required dependencies (The rust toolchain, cargo tools, etc), you can also use
Cloud Hypervisor's development script: `dev_cli.sh`. Please note that upon its
first invocation, this script will pull a fairly large container image.

For example, to build the Cloud Hypervisor release binary:

```shell
pushd $CLOUDH
cd cloud-hypervisor
./scripts/dev_cli.sh build --release
```

With `dev_cli.sh`, one can also run the Cloud Hypervisor CI locally. This can be
very convenient for debugging CI errors without having to fully rely on the
Cloud Hypervisor CI infrastructure.

For example, to run the Cloud Hypervisor unit tests:

```shell
./scripts/dev_cli.sh tests --unit
```

Run the `./scripts/dev_cli.sh --help` command to view all the supported
development script commands and their related options.

## Run

You can run a guest VM by either using an existing cloud image or booting into your own kernel and disk image.

### Cloud image

Cloud Hypervisor supports booting disk images containing all needed
components to run cloud workloads, a.k.a. cloud images. To do that we rely on
the [Rust Hypervisor
Firmware](https://github.com/cloud-hypervisor/rust-hypervisor-firmware) project to provide
an ELF
formatted KVM firmware for `cloud-hypervisor` to directly boot into.

We need to get the latest `rust-hypervisor-firmware` release and also a working cloud image. Here we will use a Ubuntu image:

```shell
pushd $CLOUDH
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
qemu-img convert -p -f qcow2 -O raw focal-server-cloudimg-amd64.img focal-server-cloudimg-amd64.raw
wget https://github.com/cloud-hypervisor/rust-hypervisor-firmware/releases/download/0.3.2/hypervisor-fw
popd
```

```shell
pushd $CLOUDH
sudo setcap cap_net_admin+ep ./cloud-hypervisor/target/release/cloud-hypervisor
./cloud-hypervisor/target/release/cloud-hypervisor \
	--kernel ./hypervisor-fw \
	--disk path=focal-server-cloudimg-amd64.raw \
	--cpus boot=4 \
	--memory size=1024M \
	--net "tap=,mac=,ip=,mask="
popd
```

Multiple arguments can be given to the `--disk` parameter.

### Custom kernel and disk image

#### Building your kernel

Cloud Hypervisor also supports direct kernel boot into a `vmlinux` ELF kernel. In order to support virtio-iommu we have our own development branch. You are of course able to use your own kernel but these instructions will continue with the version that we develop and test against.

To build the kernel:

```shell

# Clone the Cloud Hypervisor Linux branch
pushd $CLOUDH
git clone --depth 1 https://github.com/cloud-hypervisor/linux.git -b ch-5.14 linux-cloud-hypervisor
pushd linux-cloud-hypervisor

# Use the cloud-hypervisor kernel config to build your kernel
cp $CLOUDH/cloud-hypervisor/resources/linux-config-x86_64 .config
make bzImage -j `nproc`
popd
```

The `vmlinux` kernel image will then be located at `linux-cloud-hypervisor/arch/x86/boot/compressed/vmlinux.bin`.

#### Disk image

For the disk image, we will use a Ubuntu cloud image that contains a root partition:

```shell
pushd $CLOUDH
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
qemu-img convert -p -f qcow2 -O raw focal-server-cloudimg-amd64.img focal-server-cloudimg-amd64.raw
popd
```

#### Booting the guest VM

Now we can directly boot into our custom kernel and make it use the Ubuntu root partition.
If we want to have 4 vCPUs and 1024 MBytes of memory:

```shell
pushd $CLOUDH
sudo setcap cap_net_admin+ep ./cloud-hypervisor/target/release/cloud-hypervisor
./cloud-hypervisor/target/release/cloud-hypervisor \
	--kernel ./linux-cloud-hypervisor/arch/x86/boot/compressed/vmlinux.bin \
	--disk path=focal-server-cloudimg-amd64.raw \
	--cmdline "console=hvc0 root=/dev/vda1 rw" \
	--cpus boot=4 \
	--memory size=1024M \
	--net "tap=,mac=,ip=,mask="
```

The above example use the `virtio-console` device as the guest console, and this
device may not be enabled soon enough by the guest kernel to get early kernel
debug messages.

When in need for earlier debug messages, using the legacy serial device based
console is preferred:

```
./cloud-hypervisor/target/release/cloud-hypervisor \
	--kernel ./linux-cloud-hypervisor/arch/x86/boot/compressed/vmlinux.bin \
	--console off \
	--serial tty \
	--disk path=focal-server-cloudimg-amd64.raw \
	--cmdline "console=ttyS0 root=/dev/vda1 rw" \
	--cpus boot=4 \
	--memory size=1024M \
	--net "tap=,mac=,ip=,mask="
```

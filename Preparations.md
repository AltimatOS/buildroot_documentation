| Navigation |||
| --- | --- | --- |
| [Previous](Introduction.md) | [HOME](README.md) | [Next](CrossToolChain.md) |

# Preparations

There are a couple things that need prepared for before starting to build an AltimatOS build root. These will be discussed below.

## Creating the New Partition

Like any other operating system, AltimatOS will need a separate on-disk partition for it to run on. If the build root is only ever intended to run in chroot mode, this can be skipped. However, it is recommended to make AltimatOS bootable, and therefore will require a separate partition to ensure that the system can be tested before a release is announced to end-users.

Like most unix-like operating systems, AltimatOS uses a single-root heirarchy parented at '/'. The base operating system uses a single partition mounted at the heirarchy root to hold the files of the OS, and by default also houses the user home directories on the same partition along with the system's pagefile.

While AltimatOS is designed to run on hardware that uses the UEFI firmware standard, you only need one EFI partition on a machine, and can use the one already existing from your current OS to house the bootloader.

A minimal AltimatOS install needs around 32GiB of space to accommodate the base software, logs, and pagefile, however to be safe during compilations and other tasks during builds, it is recommended to have at least a 64GiB partition for the base operating system.

By default, AltimatOS is designed to use the XFS filesystem, originally from SGI's IRIX operating system and ported to Linux. This filesystem has a number of performance benefits for end-users that create media, such as video and audio files. In addition, it is one of the few filesystems supported by the Linux kernel to offer project (directory) based quotas.

As the `root` user, use a partitioning tool to either shrink your existing operating system's partition to accomodate the needed space, or add another hard disk to your computer (prefereably an internally attached SATA disk) and partition that with at minimum 64GiB of space as a `Linux filesystem` type.

Jot down or remember what the partition's node name is (eg. `/dev/sda1`), since you'll need that for later, when we mount the partition for use.

## Creating the Filesystem

Having created an empty partition, we need to format it with the appropriate filesystem for AltimatOS.

As discussed earlier, AltimatOS is designed to use an XFS filesytem by default. To format the new partition with it, with administrative privileges, run the following command:

```bash
mkfs.xfs -m crc=1,rmapbt=1 -L AltimatOS$X /dev/$DEVICE_NODE
```

The `$X` variable must be replaced with a monotonically unique number of zero or above that allows the label to be unique on your machine. For example, if you're already running AltimatOS as the host operating system, the operating system root disk will normally be labeled AltimatOS0. To ensure that new installation drives do not collide with the host's existing one, increment $X by 1, as appropriate.

Finally, replace `$DEVICE_NODE` with the node name that was created during partitioning.

## Mounting the Filesystem

To make the new filesystem available for use, you'll need to mount it, and configure your computer to mount it at boot.

First, to mount it, with administrative privileges run the following commands:

```bash
mkdir -pv /AltimateOS
mount -v -t xfs -L AltimatOS$X --target /AltimatOS -o attr2,usrquota,prjquota
```

As above, replace the `$X` variable with the appropriate number used when labelling the filesystem.

| Navigation |||
| --- | --- | --- |
| [Previous](Introduction.md) | [HOME](README.md) | [Next](CrossToolChain.md) |

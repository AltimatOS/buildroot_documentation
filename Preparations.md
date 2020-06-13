| Navigation |||
| --- | --- | ---: |
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

## Final Pre-Build Preparation

There are a few final preparation steps involved in getting ready to build the base build root. These include creating the directories used for creating the source, tools, and cross-tools directories, and creating the `builder` user and it's group, `builders`, and applying the needed permissions on the source, tools, and cross-tools directories to allow the `builder` user to do the needed work of building and installing the tools.

### Creating the `builder` User

To safely build AltimatOS' build root and core operating system, the builds themselves should be run as a non-privileged user. To ensure that the environment is clean, follow the steps below to create the `builder` user.

Using administrative privileges, run the following commands:

```bash
groupadd builders
useradd -s /bin/bash -g builders -d /Users/builder -M -N builder
mkdir -pv /Users/builder
chown -v builder:builders /Users/builder
cat <<EOF > /etc/sudoers.d/builder
builder ALL=(ALL) NOPASSWD: ALL
EOF
```

The use of `/Users` for the parent directory for the account is to match the directory heirarchy of AltimatOS for user home directories. Additionally, the Sudo snippet is needed to avoid unnecessary password requests during installation of software tools. All rights elevations with `sudo` are logged.

Now that the account is created, a strong password should be set for the account to protect it, as it is a privileged account and as the remaining steps should be done using this account, either interactively, or using some CI automation.

### Setting up Environment Files

After logging in as the `builder` user, we need to set up some configuration of the user to keep it's environment clean to avoid excessive interference from the host's toolchain. To do so, run the following commands:

```bash
cat > ~/.bash_profile << "EOF"
exec env -i HOME=${HOME} TERM=${TERM} PS1='\u:\w\$ ' /bin/bash
EOF
```

The previous command forces the command shell to be loaded with a completely clean environment. Since we have no environment, we need to set up a limited one to establish `$PATH` and other important variables we'll use for building the tools. To do this, run the following commands:

```bash
cat > ~/.bashrc << "EOF"
set +h
umask 022
BLDROOT=/AltimatOS
HOME=/Users/builder
LC_ALL=POSIX
PATH=/cross-tools/bin:/bin:/usr/bin
export BLDROOT LC_ALL PATH HOME
unset CFLAGS CXXFLAGS PKG_CONFIG_PATH

# build variables
BLD_HOST=$(echo ${MACHTYPE} | sed -e 's/-[^-]*/-cross/')
BLD_TARGET="x86_64-unknown-linux-gnu"
BLD_TARGET32="i686-pc-linux-gnu"
BUILD32="-m32"
BUILD64="-m64"

# now export the vars
export BLD_HOST
export BLD_TARGET
export BLD_TARGET32
export BUILD32
export BUILD64
EOF
```

These settings will ensure that once a package is built, the installed tools will be used instead of the host's toolchain. Additionally, the umask and `$LC_ALL` variable ensures a sane default permission and language file set to avoid problems during the builds.

Now that this is complete, either log out of the `builder` user, or source the newly created `~/.bash_profile` file to setup the environment as is needed:

```bash
source ~/.bash_profile
```

### Creating the `source`, `tools`, and `cross-tools` Directories

After logging in as the `builder` user, run the following commands to create the needed directories for building the system and to set appropriate permissions on them:

```bash
for dir in "sources" "tools" "cross-tools"; do
    sudo mkdir -pv "/AltimatOS/$dir"
    sudo chmod -v 0775 "/AltimatOS/$dir"
    sudo setfacl -m g:builders:rwx "/AltimatOS/$dir"
    sudo setfacl -dm g:builders:rwx "/AltimatOS/$dir"
    sudo ln -sv "/AltimatOS/$dir" "/$dir"
    ln -sv "/AltimatOS/$dir" "$HOME/$dir"
done
```

| Navigation |||
| --- | --- | ---: |
| [Previous](Introduction.md) | [HOME](README.md) | [Next](CrossToolChain.md) |

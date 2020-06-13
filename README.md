# buildroot_documentation

Documentation for building AltimatOS's build roots. This is largely based off the build process for CLFS, but with changes, as needed for the differences in how AltimatOS is designed, versus the generic multi-lib build process for CLFS.

## Table of Contents:

1. [Preface](Preface.md#preface)
1. [Introduction](#introduction)
1. [Preparations](#preparations)
   1. [Creating the new Partition](#creating-the-new-partition)
   1. [Final Pre-build Preparation](#final-pre-build-preparation)
1. [Building the Cross Tool Chain](#building-the-cross-tool-chain)
1. [Building the Basic Build Root](#building-the-basic-build-root)
1. [Preparing the Chroot Environment](#preparing-the-chroot-environment)
1. [Building AltimatOS' Core](#building-altimatos'-core)
   1. [Building the Testsuite Tools](#building-the-testsuite-tools)
   1. [Building the Core System Software](#building-the-core-system-software)
   1. [System Configuration](#system-configuration)
   1. [Network Configuration](#network-configuration)
   1. [Make AltimatOS Bootable](#make-altimatos-bootable)
1. [Afterward](#afterward)

## Contributing

Issues and patches are always welcomed, as either GitHub Issue requests or as Pull Requests.

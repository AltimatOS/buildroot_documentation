| Navigation |||
| --- | --- | ---: |
| [Previous](README.md) | [HOME](README.md) | [Next](Introduction.md) |

# Preface

This documentation is based heavily off the documentation of the CLFS project, and modified accordingly when needed for AltimatOS's unique requirements.

This documentation assumes that the reader has a fairly good grasp of how to build and troubleshoot software on UNIX and unix-like systems. It is mainly for reference when building the initial build roots for AltimatOS's core operating system. Any use beyond that, is up to the reader to expand on.

## Host System requirements

To build AltimatOS' build root, or the core operating system itself, there are certain packages that must be available. Note, the cross-tool chain can be built on just about any unix-like OS, whether that be a system in the BSD, SysV, Linux, or other UNIX heritage. By default, we recommend using a Linux host as the base to avoid certain build gotchas, however. Additionally, while any Linux distribution can be used for building the OS, we currently have only tested these instructions on openSUSE Leap and Tumbleweed. Any needed patches or steps required to make it work on other UNIX platforms or Linux distributions are welcomed as patches to this documentation.

The pacakges that are required and their minimum versions are listed below:

| Software Package | Minimum Version |
| --- | --- |
| Bash | 2.05a |
| Binutils | 2.12 |
| Bison | 1.875 |
| Bzip2 | 1.0.2 |
| Coreutils | 5.0 |
| Diffutils | 2.8 |
| Findutils | 4.1.20 |
| Gawk | 3.1.5 |
| GCC: | 4.1.2 |
| G++ | 4.1.2 |
| Glibc | 2.2.5 |
| Grep | 2.5 |
| Gzip | 1.2.4 |
| Make | 3.80 |
| Ncurses | 5.3 |
| Patch | 2.5.4 |
| Sed | 3.0.2 |
| GNU Tar | 1.22 |
| Texinfo or TexLive | 4.7 or 2020 repectively |
| XZ Utils | 4.999.8beta |
| ZLib | 1.2.0 |

| Navigation |||
| --- | --- | ---: |
| [Previous](README.md) | [HOME](README.md) | [Next](Introduction.md) |

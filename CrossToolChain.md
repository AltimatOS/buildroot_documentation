| Navigation |||
| --- | --- | ---: |
| [Previous](Preparations.md) | [HOME](README.md) | [Next](BasicToolChain.md) |

# Building the Cross Tool Chain

This part of the build is integral to ensure that host toolchain influence is reduced, to allow all tools built during the next stage can remove the last of the influence of the host toolchain.

Each of the packages for the cross-compile toolchain are built using a series of scripts, which will be documented per package. Additionally, a JSON file will be present to define each package, so that in a later iteration, an automation tool can be used to build each component.

## Packages to build

The table below lists each package to build and their respective versions, along with the link to their build instructions.

| Package | Version | Page |
| --- | --- | --- |
| File | 5.38 | [build instructions](crosscompile-tools-pkgs/File/) |
| Linux Headers | 5.6.18 | [build instructions](crosscompile-tools-pkgs/LinuxHeaders/) |
| M4 | 1.4.18 | [build instructions](crosscompile-tools-pkgs/M4/) |
| NCurses | 6.2 | [build instructions](crosscompile-tools-pkgs/NCurses/) |
| PkgConf | 1.7.3 | [build instructions](crosscompile-tools-pkgs/PkgConf/) |


| Navigation |||
| --- | --- | ---: |
| [Previous](Preparations.md) | [HOME](README.md) | [Next](BasicToolChain.md) |

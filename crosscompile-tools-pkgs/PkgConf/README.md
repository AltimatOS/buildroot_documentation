| Navigation |||
| --- | --- | ---: |
| [Previous](../NCurses/) | [HOME](../../README.md) | [Next](../GMP/) |

# PkgConf - A more efficient version of pkg-config

The `pkgconf` tool is a more efficient version of the pkg-config tool from the FreeDesktop foundation. It is used to assist configuring compiler and linker flags when building software.

To build it, run the following command as the `builder` user:

```bash
pushd /source
    tar xvf pkgconf-1.7.3.tar.gz
    pushd ncurses-6.2

    popd
popd
```

- [Build JSON](build.json)
- [Build Script](build.sh)

**NOTE:** We will not build the test suits of various packages during the cross-compile phase as they will not accurately run in many cases.

| Navigation |||
| --- | --- | ---: |
| [Previous](../NCurses/) | [HOME](../../README.md) | [Next](../GMP/) |

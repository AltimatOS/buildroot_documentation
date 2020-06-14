| Navigation |||
| --- | --- | ---: |
| [Previous](../File/file.md) | [HOME](../../README.md) | [Next](../M4/m4.md) |

# Linux Headers - C headers describing built-in system calls

The `Linux Headers` package is a set of Kernel headers that are to be used to define low-level C system calls.

To build it, run the following command as the `builder` user:

```bash
pushd /source
    tar xvf linux-5.6.18.tar.xz
    pushd linux-5.6.18
        make mrproper
        make ARCH=x86_64 headers_check
        make ARCH=x86_64 INSTALL_HDR_PATH=/tools headers_install
    popd
popd
```

- [Build JSON](build.json)
- [Build Script](build.sh)

**NOTE:** We will not build the test suits of various packages during the cross-compile phase as they will not accurately run in many cases.

| Navigation |||
| --- | --- | ---: |
| [Previous](../File/file.md) | [HOME](../../README.md) | [Next](../M4/m4.md) |

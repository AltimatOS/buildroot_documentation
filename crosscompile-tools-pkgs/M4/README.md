| Navigation |||
| --- | --- | ---: |
| [Previous](../LinuxHeaders/) | [HOME](../../README.md) | [Next](../NCurses/) |

# M4 - A Macro Processing Language

The `m4` package provides a macro processor used heavily by the GNU Make utility.

To build it, run the following command as the `builder` user:

```bash
pushd /source
    tar xvf m4-1.4.18.tar.xz
    pushd make-1.4.18
        ./configure --prefix=/cross-tools
        make
        make install
    popd
popd
```

- [Build JSON](build.json)
- [Build Script](build.sh)

**NOTE:** We will not build the test suits of various packages during the cross-compile phase as they will not accurately run in many cases.

| Navigation |||
| --- | --- | ---: |
| [Previous](../LinuxHeaders/) | [HOME](../../README.md) | [Next](../NCurses/) |

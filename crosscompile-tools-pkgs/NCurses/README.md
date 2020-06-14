| Navigation |||
| --- | --- | ---: |
| [Previous](../M4/) | [HOME](../../README.md) | [Next](../PkgConf/) |

# NCurses - Terminal output and input library and utilities

The `ncurses` library is used to control drawing output and managing input on terminal screens. 

To build it, run the following command as the `builder` user:

```bash
pushd /source
    tar xvf ncurses-6.2.tar.xz
    pushd ncurses-6.2
        AWK=gawk ./configure --prefix=/cross-tools --without-debug
        make -C include
        make -C progs tic
        install -v -m755 progs/tic /cross-tools/bin
    popd
popd
```

- [Build JSON](build.json)
- [Build Script](build.sh)

**NOTE:** We will not build the test suits of various packages during the cross-compile phase as they will not accurately run in many cases.

| Navigation |||
| --- | --- | ---: |
| [Previous](../M4/) | [HOME](../../README.md) | [Next](../PkgConf/) |

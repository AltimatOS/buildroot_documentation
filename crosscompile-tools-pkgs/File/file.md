| Navigation |||
| --- | --- | ---: |
| [Previous](CrossToolChain.md) | [HOME](README.md) | [Next](../LinuxHeaders/linuxheaders.md) |

# File - A tool for discovering the type of a file

The `file` command is used for determining the type of a file or collection of files. More details are covered in the later build for the basic toolchain.

To build it, run the following command as the `builder` user:

```bash
pushd /source
    tar xvf file-5.38.tar.gz
    pushd file-5.38
        ./configure --prefix=/cross-tools
        make
        make install
    popd
popd
```

**NOTE:** We will not build the test suits of various packages during the cross-compile phase as they will not accurately run in many cases.

| Navigation |||
| --- | --- | ---: |
| [Previous](CrossToolChain.md) | [HOME](README.md) | [Next](../LinuxHeaders/linuxheaders.md) |

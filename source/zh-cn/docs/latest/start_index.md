title: Zephyr 入门指导
---

> 翻译：[tidyjiang8](http://github.com/tidyjiang8/)

Zephyr 项目支持如下操作系统：
- Linux
- Mac OS
- Windows

请先按照下面的步骤搭建一个开发环境，然后再继续后续的操作。
- [在 Linux 下搭建开发环境](start_linux.html)
- [在 Mac OS 下搭建开发环境](start_mac.html)
- [在 Windows 下设置开发环境](start_win.html)

# 下载源代码

Zephyr 的源代码托管在 GitHub 的仓库上，您可以通过 git 工具进行匿名克隆。

要匿名克隆 Zephyr 的代码仓库，请输入：

```bash
git clone https://github.com/zephyrproject-rtos/zephyr.git
```

然后，您将在您的本地机器上成功地检出源代码的一份副本。

# 编译、运行应用程序

下面的章节将利用一个简单的 "Hello World" 作为基础模型，向您展示创建一个 Zephyr 应用程序所涉及到的内容。

各种操作系统上编译、运行 Zephyr 应用程序的过程是类似的。尽管如此，不同操作系统的命令终究会略有区别。本节所有的命令都是基于 Linux 开发环境的，如果您使用的是其它操作系统，请使用该操作系统所对应的命令。

## 编译一个简单的应用程序

请按照下面的步骤编译一个简单的应用程序例程：

1. export 下列环境变量，以确保您的环境被正确地设置。以 Linux 为例，输入：
```bash
export ZEPHYR_GCC_VARIANT=zephyr
export ZEPHYR_SDK_INSTALL_DIR=<sdk installation directory>
```

2. 进入项目主目录：
```bash
cd zephyr
```

3. 对环境变量文件执行 source 操作，使其生效：
```bash
source zephyr-env.sh
```

4. 以编译 [Hello World](https://www.zephyrproject.org/doc/samples/hello_world/README.html#hello-world) 为例，输入：
```bash
cd $ZEPHYR_BASE/samples/hello_world
make
```

上面的 make 命令将使用在应用程序 Makefile 中的定义来编译 [Hello World](https://www.zephyrproject.org/doc/samples/hello_world/README.html#hello-world) 例程。您可以通过指定变量 BOARD 为不同的开发板编译不同的程序，例如：
```bash
make BOARD=arduino_101
```

关于 Zephyr 所支持的开发板，请参考[这里](https://www.zephyrproject.org/doc/boards/boards.html)。您也可以输入以下命令查看 Zephyr 所支持的开发板。
```bash
make help
```

目录 `$ZEPHYR_BASE/samples` 下包含了 Zephyr 各种功能特性的例程工程。当应用程序编译成功后，您可以在应用程序根目录下的 `outdir` 子目录中看到编译生成的文件。

编译系统默认会生成名为 `zephyr.elf` 的可执行文件。您也可以在应用程序的配置文件中进行配置，为不同的硬件和开发板指定不同的可执行文件名字。

## 使用自定义/三方交叉编译器

为了便于使用，Zephyr 提供了一套软件开发工具（SDK）。Zephyr SDK 为所有所支持的操作系统都提供了交叉编译器，因此您无需进行额外的配置。

如果您想使用自定义的交叉编译器，或者如果您想使用厂家提供的 SDK，您可以按照下列步骤进行设置。

1. 为了避免与 Zephyr SDK 冲突，先输入如下命令：
```bash
unset ZEPHYR_GCC_VARIANT
unset ZEPHYR_SDK_INSTALL_DIR
```

2. 我们以 [GCC ARM Embedded](https://launchpad.net/gcc-arm-embedded) 编译器为例。从 [GCC ARM Embedded](https://launchpad.net/gcc-arm-embedded) 下载一个适合您的操作系统的软件包，然后将其解压到您的文件系统中。假设该编译器被解压到： `~/gcc-arm-none-eabi-5_3-2016q1/`。

3. 进入项目主目录：
```bash
cd zephyr
```

4. 对项目环境文件执行 source 操作：
```bash
source zephyr-env.sh
```

5. 以编译 [Hello World](https://www.zephyrproject.org/doc/samples/hello_world/README.html#hello-world) 为例，依次执行（注，编译时在命令行中指明了变量 CROSS_COMPILE 的值）：
```bash
export GCCARMEMB_TOOLCHAIN_PATH="~/gcc-arm-none-eabi-5_3-2016q1/"
export ZEPHYR_GCC_VARIANT=gccarmemb
cd $ZEPHYR_BASE/samples/hello_world
make CROSS_COMPILE=~/gcc-arm-none-eabi-5_3-2016q1/bin/arm-none-eabi- BOARD=arduino_due
```

上面的命令将使用您从 [GCC ARM Embedded](https://launchpad.net/gcc-arm-embedded) 下载的工具链编译应用例程。

另外，您也可以使用已存在的支持 GCC ARM Embedded 的工具链：
```bash
export GCCARMEMB_TOOLCHAIN_PATH="~/gcc-arm-none-eabi-5_3-2016q1/"
export ZEPHYR_GCC_VARIANT=gccarmemb
cd zephyr
source zephyr-env.sh
cd $ZEPHYR_BASE/samples/hello_world
make BOARD=arduino_due
```

## 在 QEMU 中运行应用程序例程

为了在开发环境中进行快速测试，您可以使用 qemu 仿真器。qemu 仿真器支持 x86 和 ARM Cortex-M3 等架构。进行 qemu 仿真非常简单，您只需要在编译应用程序时指定一个目标，编译系统会自动调用 QEMU 进行编译。

如果要使用 x86 qemu 仿真开发板配置(qemu_x86)编译应用程序，输入：
```bash
make BOARD=qemu_x86 run
```
如果要使用 ARM qemu_cortex_m3 开发板配置编译应用程序，输入：
```bash
make BOARD=qemu_cortex_m3 run
```

QEMU 并非支持所有的开发板和 SoC。当为一个特定硬件开发应用时，您需要在实际的硬件平台上进行测试，而不要仅仅依赖于 QEMU 仿真环境。

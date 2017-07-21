title: 在 Windows 下搭建开发环境
---

> 翻译：[tidyjiang8](http://github.com/tidyjiang8/)

本节描述如何在微软的 Windows 环境下配置您的开发环境并编译 Zephyr 应用程序。

我们在 Win7、Win8.1 和 Win10 上面测试过示例程序 Hello World。

# 更新您的操作系统

在编译之前，请确保您所运行的 Windows 系统已经安装了最新的更新包。

# 安装需求和依赖
## 使用 MSYS2

Windows 上面的 Zephyr 开发环境依赖于 MSYS2。MSYS2 是 Windows 平台模拟 UNIX 环境的一个软件。请按照下面的步骤安装并设置 MSYS2。

1. 从 [MSYS2 官网](http://www.msys2.org/)下载适合您操作系统（32 位或者 64 位）的安装器安装 MSYS2。在安装的最后一个界面，点击“立即运行 MSYS2”。安装完成后，会启动 MSYS2 shell 控制台。请遵循 MSYS2 官网的指令更新软件包数据库和核心系统软件包。如果它提示您“终止 MSYS2 并再次检查更新”，请直接关闭 `MSYS2 MSYS Shell` 桌面应用程序并再次运行它，以完成更新。
2. 从开始菜单启动 `MSYS2 MSYS Shell` 桌面应用程序。

  > 注意1：需要启动的是 `MSYS2 MSYS Shell`，而不是 `MSYS2 MinGW Shell`。

  > 注意2：本教程中多次出现了 `export` 语句。为了避免多次输入，您可以在您的 `~/.bash_profile` 文件的顶部替换掉它们。

3. 如果您开启了防火墙，您可以需要指定一个代理来访问 Internet 资源：
  ```bash
$ export http_proxy=http://proxy.mycompany.com:123
$ export https_proxy=$http_proxy
  ```

4. 安装编译 Zephyr 所需依赖：
  ```bash
  $ pacman -S git make gcc diffutils ncurses-devel python3
  ```
5. 安装 Python 模块需要的 pip：
   ```bash
$ curl -O 'https://bootstrap.pypa.io/get-pip.py'
$ ./get-pip.py
$ rm get-pip.py

$ pip install pyaml   
   ```
6. 编译设备树编译器（DTC）

  对于 Zephyr 源代码目录 `dts/` 下面所列举的架构和开发板，需要 DTC 才能编译 Zephyr 的应用程序。请安装下面的指令设置 DTC。

  - 安装所需编译工具：
    ```bash
$ pacman -S bison
$ pacman -R flex
$ pacman -U http://repo.msys2.org/msys/x86_64/flex-2.6.0-1-x86_64.pkg.tar.xz
    ```

  - 克隆并编译 DTC：
  ```bash
$ cd ~
$ git clone https://git.kernel.org/pub/scm/utils/dtc/dtc.git
$ cd dtc
$ make
```

  - 导出 DTC 所在路径： 
  ```
$ export DTC=~/dtc/dtc
```

7. 编译系统现在可以与您的系统中的任何工具链一起工作了。下一步，我们将介绍如何安装编译 x86 和 ARM 应用程序所需工具链。

8. 安装交叉编译器工具链。
  
  - 对于 x86，请从 Intel 开发者社区下载并安装 [2017 Windows ISSM 工具链](https://software.intel.com/en-us/articles/issm-toolchain-only-download)。您可以使用浏览器下载工具链的 `.tar.gz` 压缩文件。</br>

    </br>您需要 tar 应用程序来解压这个文件。在 `MSYS2 MSYS` 的控制台中，安装 `tar` 并使用它来解压工具链压缩包：

      ```bash
$ pacman -S tar
$ tar -zxvf /c/Users/myusername/Downloads/issm-toolchain-windows-2017-01-15.tar.gz -C /c
    
    ```

    请使用您下载的文件的名字替换掉上面的 .tar.gz 路径名。

    > 注意：ISSM 工具集只支持开发 Intel® Quark™ 微控制器，例如 Arduino 101 开发板。（请在文档[Getting Started on Arduino 101 with ISSM](https://software.intel.com/en-us/articles/getting-started-arduino-101genuino-101-with-intel-system-studio-for-microcontrollers) 中查看 “Zephyr Development Environment Setup” 的相关内容。）如果想要使用 ISSM GUI，则还需要进行额外的设置。

  - 对于 ARM，请从 ARM 开发者社区安装 GNU ARM Embedded：[GNU ARM Embedded](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads)

9. 在 *MSYS2 MSYS Shell* 控制台中，使用 Git 克隆一份 Zephyr 源代码到您的 home 目录：

  ```bash
$ cd ~
$ git clone https://github.com/zephyrproject-rtos/zephyr.git  
  ```
10. 还是在 MSYS 控制台中，为所安装的工具链和 Zephyr 环境设置环境变量（使用所提供的 shell 脚本）。

  - 对于 x86：

    ```
$ export ZEPHYR_GCC_VARIANT=issm
$ export ISSM_INSTALLATION_PATH=/c/issm0-toolchain-windows-2017-01-25
  ```

  在上面的命令中，请使用解压后的 ISSM 工具链的路径。

  - 对于 ARM：

    ```bash
$ export ZEPHYR_GCC_VARIANT=gccarmemb
$ export GCCARMEMB_TOOLCHAIN_PATH=/c/gccarmemb  
  ```

  - 对于其它平台，请运行所提供的脚本来舍子 zephyr 项目相关的变量：

    ```bash
$ unset ZEPHYR_SDK_INSTALL_DIR
$ source ~/zephyr/zephyr-env.sh  
  ```
11. 然后，您就能编译示例程序 [Hello World](https://www.zephyrproject.org/doc/samples/hello_world/README.html#hello-world) 了。

  编译  Intel® Quark™ (x86-based) Arduino 101：

    ```bash
$ cd $ZEPHYR_BASE/samples/hello_world
$ make BOARD=arduino_101    
    ```

  编译基于 ARM 的 Nordic nRF52 开发套件：

    ```bash
$ cd $ZEPHYR_BASE/samples/hello_world
$ make BOARD=nrf52_pca10040    
    ```

  至此，您就可以看到开发 Zephyr 所需的工具和工具链都已经安装并配置好了。

## 使用 Windows 10 WSL (Win10 Linux 子系统)

如果您使用的是最新版的 win10，您可以利用其内置功能在标准的命令行提示符中运行原生的 Ubuntu 二进制镜像文件。这样，您就不需要安装虚拟机，直接就可以安装标准的 Zephyr SDK 并编译所有所支持的架构。

  1. 按照微软官网上的说明安装 Win10 Linux 子系统：[安装 WSL](https://msdn.microsoft.com/en-us/commandline/wsl/install_guide)

    > 注意： 要确保 Zephyr SDK 能正常工作，请安装 Win 10 build 15002 或更新版。您可以在系统设置的 “Abou your PC” 中查看您运行的是哪个版本的 Win 10。如果您运行的是老版本的 Win 10，您可能需要安装更新。

  2. 按照 Linux 入门指南中的说明安装对应于 Ubuntu 的 SDK：[在 Linux 上搭建开发环境](start_linux.html)

title: 在 Linux 下搭建开发环境
---

> 翻译：[tidyjiang8](http://github.com/tidyjiang8/)

本节描述如何搭建一个 Linux 开发环境。

完成这些操作后，您将能够在如下 Linux 发行版上编译、运行您的 Zephyr 应用程序：
- Ubuntu 16.04 LTS 64-bit
- Fedora 25 64-bit

您应该根据需要选择 Ubuntu 或者 Fedora 的指令。

# 安装主机操作系统

Zephyr 项目的软件组件（包括内核）已经在 Ubuntu 和 Fedora 上面测试通过了。安装 Ubuntu 和 Fedora 的方法不在本文档的讨论范围内。

# 更新您的操作系统

在进行编译前，请先确保您的操作系统已经更新到最新了。对于 Ubuntu，您需要先更新可用软件包的本地数据库列表：
```bash
sudo apt-get update
sudo apt-get upgrade
```

对于 Fedora：
```bash
sudo dnf upgrade
```

# 安装需求和依赖

请按照下面的方法使用 apt-get 或者 dnf 进行安装。

对于 Ubuntu：
```bash
sudo apt-get install git make gcc g++ python3-ply ncurses-dev \
      python3-yaml dfu-util device-tree-compiler
```

对于 Fedora：
```bash
sudo dnf group install "Development Tools"
sudo dnf install git make gcc glibc-static \
      libstdc++-static python3-ply ncurses-devel \
      python-yaml dfu-util dtc
```

## 安装 Zephyr 软件开发套件（SDK）

Zephyr 的 SDK 中包含为其支持的所有架构编译内核所需的工具和交叉编译器。此外，它还包括主机上的工具，例如定制的 QEMU 以及编译主机工具的主机编译器。SDK 支持如下架构：
- X86
- X86 IAMCU ABI
- ARM
- ARC
- NIOS II
- Xtensa

按照下面的步骤就能在您的 Linux 主机系统上安装 SDK。

1. 下载最新的 SDK 自解压二进制文件。

  访问 [Zephyr SDK archive](https://zephyrproject.org/downloads/tools) 可查找到所有可有的（包括最新的） SDK。

  您也可以使用下面的命令来下载所需的版本(您可以将 0.9.1 替换为您想下载的版本号)。

  ```bash
wget https://github.com/zephyrproject-rtos/meta-zephyr-sdk/releases/download/0.9.1/zephyr-sdk-0.9.1-setup.run
```

2. 运行自解压二进制文件

 > 请先确保你已经安装前面[安装需求和依赖](#安装需求和依赖)中所述方法在您的主机系统中安装了所有的依赖包，否则安装 SDK 时会失败。

  ```bash
chmod +x zephyr-sdk-<version>-setup.run
./zephyr-sdk-<version>-setup.run
```
  如果将 SDK 安装到用户的 home 目录，则没有必要是使用 *sudo* 权限。

3. 按照屏幕上提上的指令进行操作。工具链的默认安装路径位于 `/opt/zephyr-sdk/`。如果要安装到默认路径，您需要使用 sudo。推荐将 SDK 安装到您的 home 目录，而不是系统目录。

4. 要使用 Zephyr SDK，您还需要 export 如下的环境变量，并指明 SDK 的安装路径，输入：
   ```bash
export ZEPHYR_GCC_VARIANT=zephyr
export ZEPHYR_SDK_INSTALL_DIR=<sdk installation directory>
```

如果您希望将来在新的会话中也是使用该工具链，您可以上面的设置添加到文件 `$HOME/.zephyrrc` 中，例如：
  ```bash
cat <<EOF > ~/.zephyrrc
export ZEPHYR_GCC_VARIANT=zephyr
export ZEPHYR_SDK_INSTALL_DIR=/opt/zephyr-sdk
EOF
```
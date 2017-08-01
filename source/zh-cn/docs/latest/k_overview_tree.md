title: 源码树结构
---

> 翻译：[tidyjiang8](http://github.com/tidyjiang8/)

理解 Zephyr 源码树的结构有助于快速定位 Zephyr 相关功能的代码。

Zephyr 源码树提供了如下顶层目录，且每个目录可能还包括一个或多个子目录：

**`arch`**
　　架构相关的内核以及 SoC 相关的代码。每个所支持的架构（例如 x86 和 ARM）都有一个自己的子目录。每个子目录还包括如下功能的子目录：
　　　- 架构相关的内核源文件
　　　- 架构相关的内核头文件和私有 API
　　　- SoC 相关的代码<br/>

**`boards`**
　　开发板相关的代码和配置文件。

**`doc`**
　　Zephyr 的技术文档源文件，以及产生网页[ http://zephyrproject.org/doc ](http://zephyrproject.org/doc)工具。

**`drivers`**
　　设备驱动的代码。

**`dts`**
　　设备树源文件，用于描述之前直接在 OS 源码中编写的开发板相关的硬件细节。

**`ext`**
　　集成到 Zephyr 中的外部源代码，例如厂商提供的硬件接口代码、密码库代码等。

**`include`**
　　除 `lib` 外的所公有 API 的头文件。

**`kernel`**
　　架构无关的内核代码。

**`lib`**
　　包括最小化 C 库在内的库代码。

**`misc`**
　　不属于任何顶层目录的杂项代码。

**`samples`**
　　演示 Zephyr 功能特性的应用程序例程。

**`scripts`**
　　各种程序以及用于编译、测试 Zephyr 应用程序的其它文件。

**`subsys`**
　　Zephyr 功能特性的测试代码。

**`tests`**
　　Zephyr 的子系统包括：
　　　- USB 设备栈代码。 
　　　- 网络代码，包括蓝牙协议栈和网络协议栈。 
　　　- 文件系统代码。 
　　　- 蓝牙主机和控制器。
title: Zephyr™ 宣布支持蓝牙 Mesh
date: 2017-08-21 19:25:11
---

> 翻译：[tidyjiang8](https://github.com/tidyjiang8)

2017 年 7 月底，蓝牙组织联盟 SIG 发布了 [蓝牙 Mesh 协议规范](https://www.bluetooth.com/specifications/mesh-specifications) ；今天，Zephyr 宣布已经实现了该规范(感谢 Intel 的积极贡献)。相关代码目前位于 Zephyr 官方的 [master](https://github.com/zephyrproject-rtos/zephyr/tree/master/subsys/bluetooth/host/mesh) 上游分支代码仓库中，这部分代码也会在 2017 年 9 月初的 [Zephyr OS 1.9](https://www.zephyrproject.org/downloads) 版本中发布。

您可以在 [这里](https://github.com/zephyrproject-rtos/zephyr/blob/master/include/bluetooth/mesh.h) 查看蓝牙 Mesh 的公用 API 接口。

此外，Zephyr 还提供了 [示例程序](https://github.com/zephyrproject-rtos/zephyr/tree/master/samples/bluetooth) 和 [测试程序](https://github.com/zephyrproject-rtos/zephyr/tree/master/tests/bluetooth)。

# 蓝牙 Mesh 概述

蓝牙 Mesh 是一个新标准，它开启了一个全新的低功耗无线应用案例。它将通信范围由单一的点对点连接扩展为一个网状拓扑结构，因此可以覆盖范围更广，例如整栋楼宇建筑。这为智能家居以及工业自动化奠定了良好的基础。蓝牙 Mesh 的典型应用场景包括控制公寓里的灯或调节恒温器。尽管去年年底发布了蓝牙5，但蓝牙 Mesh 可以在任何支持蓝牙 4 或更高版本的设备上实现，这意味着我们可能很快就会在市场看到该技术。

![](mesh.jpg)

您可以在这里查看蓝牙 [Mesh 协议规范](https://www.bluetooth.com/specifications/mesh-specifications)。

# 具体实现

Zephyr OS 实现了蓝牙 Mesh 的所有层协议以及大部分的可选功能。下面这个列表列举出了其中一部分可选功能及其对应的源代码：
- GATT & Advertising bearers (proxy.c & adv.c)
- Network Layer (net.c)
- Lower and Upper Transport Layers (transport.c)
- Access Layer (access.c)
- Foundation Models, Server role (health.c & cfg.c)
- Both PB-ADV and PB-GATT based provisioning (prov.c)
- Low Power Node support (lpn.c)
- Relay support (net.c)
- GATT Proxy (proxy.c)

下面这些可选功能目前还未实现：
- Friend support (initial bits are already in place in friend.c)
- Provisioner support (low-value for typical Zephyr devices)
- Foundation Client models (low-value for typical Zephyr devices)
- GATT Client (low-value for typical Zephyr devices)

我们将会在今后的发行版本中支持这些功能。

## 对 Zephyr 配置

为了使基于 Zephyr OS 的设备具有 mesh 节点的功能，需要给它配置网络安全密钥以及唯一的单播地址。由于 Zephyr OS 当前不能作为其它设备的供应者(Provisioner)，其它非基于 Zephyr OS 的设备必须手动配置。在原型实现阶段，可以直接将密钥和地址写在应用程序中 —— 您可以参考 [`mesh_demo`](https://github.com/zephyrproject-rtos/zephyr/tree/master/samples/bluetooth/mesh_demo) 这个例程。

在实践中，可以通过下面的方法配置基于 Zephyr OS 的设备：
- 自配置(只适用于原型设计阶段，还不能用于产品生产阶段)
- [Silicon Labs Android Mesh 应用](https://play.google.com/store/apps/details?id=com.siliconlabs.bluetoothmesh)
- [Bluetooth PTS](https://www.bluetooth.com/develop-with-bluetooth/test-tools/profile-tuning-suite) (用于规范的一致性测试)
- BlueZ meshctl 工具。该工具会出现在 BlueZ 的下一个发行版(BlueZ 5.47)中

## 集成蓝牙 Mesh

Mesh 网络由一个相当复杂的分层结构组成，加入到这个网络中的每个设备都被叫做一个**节点**。每个节点包含一到多个元素(element)。元素是在 mesh 网络中可唯一寻址的实体。反过来，每个元素都有一套所谓的模型，这个模型既可以是标准模型，也可以由厂家提供。

从本质上讲，模型定义了特定的状态和行为，这些状态和行为会受到发送/接收消息的影响。Mesh 属性规范包含一个所有节点都必须支持的基础模型。

Zephyr 已经实现了这些功能，因此应用程序开发者只需要在这方面做非常少的工作。应用程序开发者剩下需要做的就是选择实现合适的标准模型(在 mesh 模型规范中可以找到)或者如果在标准模型不适用时创建自定义的厂商模型。

在 Zephyr 中，模型是由宏 `BT_MESH_MODEL()` 进行定义的。应用程序需要提供的参数包括：模型标识符、消息句柄数组、消息发布上下文以及传递给消息句柄的用户数据(可选)。模型反过来又包含在由其它模型构成的数组中，这些模型共同构成元素。在初始化的过程中，应用程序需要调用 API `bt_mesh_init()` 来进行与 mesh 相关的初始化。

如果要插入应用程序所需的基础模型，可以使用宏 `BT_MESH_MODEL_CFG_SRV()` 或者 `BT_MESH_MODEL_HEALTH_SRV()`　替换之前的宏 `BT_MESH_MODEL()`。

# 更多

如果想要更深入地了解 Zephyr 中蓝牙 Mesh 相关的知识，或者想要知道在实际中如何使能这些功能，请查看 [mesh](https://github.com/zephyrproject-rtos/zephyr/blob/master/include/bluetooth/mesh.h) 的代码以及 [示例程序](https://github.com/zephyrproject-rtos/zephyr/tree/master/samples/bluetooth/mesh)。
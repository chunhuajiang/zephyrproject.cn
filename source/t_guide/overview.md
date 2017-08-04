title: 单步调试 Zephyr 程序
---

这里主要讲解一些常用开发板的入门、调试方法。

Zephyr OS 自带了 GDB Server，因此我们可以利用它配合 Eclipse 来进行单步调试。

无论你使用的是哪块开发板，为了更好的理解整个调试的过程，最好都先阅读并理解这篇文章：
- [Qume+Eclipse+Ubuntu 进行单步调试](qemu.html)

通过理解这篇文章，相信大家会对其过程有一定的了解，然后在自己遇到问题的时候才知道如何去解决。

另外，精力和板子有限（当然，最重要的是能力有限），还有很多板子不知道怎么调试，**希望其它小伙伴儿能将自己的板子的调试方法总结到这里，以方便后来的学习者**。

这部分的源码位于 [本网站仓库](https://github.com/tidyjiang8/zephyrproject.cn/tree/master/source/t_guide) 的 `source/t_guide/` 目录下面。如果提交自己的文章，请在该目录下面新建对应的 markdown 文件，然后提交 Pull Request。

</br>
# Zephyr Project 中文社区 

提供一个 Zephyr OS 学习平台，让越来越多的小伙伴能够快速入门并深入学习。

## 提交新博客/教程

社区所有文章均采用 Markdown 格式，欢迎大家提交博客/教程。

#### 博客提交步骤
- fork 本仓库，并将你 fork 的仓库克隆到本地。
- 在仓库的 `source/blog/` 目录下面新增一个 Markdown 文档用于编写你的博客。文档名的格式为`year-month-day-author-title.md`，例如`2017-07-25-tidyjiang8-hello-world.md`。
  > 如果文档需要引用图片，请在该目录下建立一个同名的目录`year-month-day-author-title`（不需要后缀`.md`），并将你的图片存放到该目录中。
- 编写博客文档并提交 Pull Request。

<br/>

*关于 Markdown 格式的额外要求*：
- 请在文档首部添加类似 `title: Zephyr 简介` 标签。注意，冒号`:`后面必须留有一个英文空格，否则在编译文档源码时会报错。
- 你可以在标签后面、文章前面添加你自己的链接，当然也欢迎无名英雄。
- 示例：
  ```
  title: Zephyr 简介
  ---

  > 作者：[tidyjiang8](https://github.com/tidyjiang8/)

  然后，就可以从这里开始写你的博客了。
  ...
  ```



#### 精华教程提交步骤：
- TODO

## 目录结构

本仓库的目录/文件包括两类：
- 网站中所有文档的源码，即 `source` 目录下面的文件。
- 网站自身的源码，用于设置网站布局、样式等，即除 `source` 之外的所有目录及文件。

文档的目录结构：
```
work@ubuntu:~/zephyrproject.cn/source$ tree -d
.
├── blog         // 存放网站`博客`栏目的目录
├── _data        // 用来定义页面的一些内容
├── icon         // 网站的一些图标
├── news         // 一些关于Zephyr的新闻
├── opensource   // 在github上找到的一些关于zephyr的开源项目
├── _posts
├── tutorial     // 教程
│   ├── deep
│   └── guide
└── zh-cn        // 存放zephyr的中文文档
    └── docs
        └── latest
             └── index

```

## 学习交流
- Zephyr OS 学习交流 QQ 群：580070214



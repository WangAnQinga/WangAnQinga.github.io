---
title: mvc和mvvm
categories:
tags:
---

## MVX

MVX 的差异多在于 第 3 步

1. MVC：Model 直接通知 View 更新 (不同 MVC 实现不同)
2. MVP：Model 通知 Presenter 通知 View， Presenter 切断了 Model 和 View 的联系
3. MVVW： 和 MVP 类似，不同点在于 Viewport 与 View 有一个绑定机制, 不需要 Viewport 显式通知 View 更新

**MVX 的差别在于 Model 和 View 之间数据传递的方**

## MVC

如何设计一个程序的结构，这是一门专门的学问，叫做"架构模式"（architectural pattern），属于编程的方法论。

MVC 模式就是架构模式的一种，它对我的启发特别大。我觉得它不仅适用于开发软件，也适用于其他广泛的设计和组织工作。

下面是我对 MVC 模式的一些个人理解，不一定正确，主要用来整理思路。

MVC 是三个单词的首字母缩写，它们是 Model（模型）、View（视图）和 Controller（控制）。所有通信都是单向的。

这个模式认为，程序不论简单或复杂，从结构上看，都可以分成三层。

```
1）最上面的一层，是直接面向最终用户的"视图层"（View）。它是提供给用户的操作界面，是程序的外壳。

2）最底下的一层，是核心的"数据层"（Model），也就是程序需要操作的数据或信息。

3）中间的一层，就是"控制层"（Controller），它负责根据用户从"视图层"输入的指令，选取"数据层"中的数据，然后对其进行相应的操作，产生最终结果。
```

这三层是紧密联系在一起的，但又是互相独立的，每一层内部的变化不影响其他层。每一层都对外提供接口（Interface），供上面一层调用。这样一来，软件就可以实现模块化，修改外观或者变更数据都不用修改其他层，大大方便了维护和升级。

控制器（Controller）- 负责转发请求，对请求进行处理。
视图（View） - 界面设计人员进行图形界面设计。
模型（Model） - 程序员编写程序应有的功能（实现算法等等）、数据库专家进行数据管理和数据库设计(可以实现具体的功能)。
![]()

## MVP

### MVVM

MVVM 模式将 Presenter 改名为 ViewModel，基本上与 MVP 模式完全一致。

唯一的区别是，它采用双向绑定（data-binding）：View 的变动，自动反映在 ViewModel，反之亦然。Angular 和 Ember 都采用这种模式。

相关阅读：
[https://www.kancloud.cn/lixianshengdezhanghao/interview/904696](https://www.kancloud.cn/lixianshengdezhanghao/interview/904696)

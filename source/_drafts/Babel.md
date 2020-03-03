---
title: Babel
categories:
tags:
---

## Babel 是什么？

#### Babel 是一个 JavaScript 编译器

Babel 是一个工具链，主要用于将 ECMAScript 2015+ 版本的代码转换为向后兼容的 JavaScript 语法，以便能够运行在当前和旧版本的浏览器或其他环境中

下面列出的是 Babel 能为你做的事情：

- 语法转换
- 通过 Polyfill 方式在目标环境中添加缺失的特性 (通过 @babel/polyfill 模块)
- 源码转换 (codemods)
- 更多！

## 插件

Babel 是一个编译器（输入源码 => 输出编译后的代码）。就像其他编译器一样，编译过程分为三个阶段：解析、转换和打印输出。

现在，Babel 虽然开箱即用，但是什么动作都不做。它基本上类似于 const babel = code => code; ，将代码解析之后再输出同样的代码。如果想要 Babel 做一些实际的工作，就需要为其添加插件。

除了一个一个的添加插件，你还可以以 preset 的形式启用一组插件。

## 预设（Presets）

不想自己动手组合插件？没问题！preset 可以作为 Babel 插件的组合，甚至可以作为可以共享的 options 配置。

官方 Preset
我们已经针对常用环境编写了一些 preset：

- @babel/preset-env
- @babel/preset-flow
- @babel/preset-react
- @babel/preset-typescript

## 总结：

我们使用 @babel/cli 从终端运行 Babel，利用 @babel/polyfill 来模拟所有新的 JavaScript 功能，而 env preset 只对我们所使用的并且目标浏览器中缺失的功能进行代码转换和加载 polyfill。

## 相关

[core-js@3](https://juejin.im/post/5e355be0f265da3e491a53c5)

---
title: Vue 组件库
categories:
tags:
---

## UMD (Universal Module Definition),

希望提供一个前后端跨平台的解决方案(支持 AMD 与 CommonJS 模块方式)。

UMD 的实现很简单：

- 先判断是否支持 Node.js 模块格式（exports 是否存在），存在则使用 Node.js 模块格式。
- 再判断是否支持 AMD（define 是否存在），存在则使用 AMD 方式加载模块。
- 前两个都不存在，则将模块公开到全局（window 或 global）。

`
// if the module has no dependencies, the above pattern can be simplified to
(function (root, factory) {
if (typeof define === 'function' && define.amd) {
// AMD. Register as an anonymous module.
define([], factory);
} else if (typeof exports === 'object') {
// Node. Does not work with strict CommonJS, but
// only CommonJS-like environments that support module.exports,
// like Node.
module.exports = factory();
} else {
// Browser globals (root is window)
root.returnExports = factory();
}
}(this, function () {

    // Just return a value to define the module export.
    // This example returns an object, but the module
    // can return a function as the exported value.
    return {};

}));
`

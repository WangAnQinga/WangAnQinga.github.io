---
title: vue3ts
categories:
tags:
  - vue
  - typescript
---

## 插件

[vue-class-component](https://github.com/vuejs/vue-class-component)
强化 Vue 组件，使用 TypeScript/装饰器 增强 Vue 组件
[vue-property-decorator](https://github.com/kaorun343/vue-property-decorator)
在 vue-class-component 上增强更多的结合 Vue 特性的装饰器
[vuex-class](https://github.com/ktsn/vuex-class)
基于 vue-class-component 对 Vuex 提供的装饰器

## 在已创建的项目中安装

```
vue3.0

vue add @vue/typescript
```

## 相关文件解释

**shims-tsx.d.ts，允许你以.tsx 结尾的文件，在 Vue 项目中编写 jsx 代码,, 在全局变量 global 中批量命名了数个内部模块**

**shims-vue.d.ts 主要用于 TypeScript 识别.vue 文件，Ts 默认并不支持导入 vue 文件，这个文件告诉 ts 导入.vue 文件都按 VueConstructor<Vue>处理。**

**declare：当使用第三方库时，我们需要引用它的声明文件，才能获得对应的代码补全、接口提示等功能。**

这里列举出几个常用的：

```declare var 声明全局变量
declare function 声明全局方法
declare class 声明全局类
declare enum 声明全局枚举类型
declare global 扩展全局变量
declare module 扩展模块
复制代码 namespace：“内部模块”现在称做“命名空间”
module X { 相当于现在推荐的写法 namespace X {)
```

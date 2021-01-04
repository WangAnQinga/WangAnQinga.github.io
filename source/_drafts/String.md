---
title: String
categories:
tags:
---

## 字符串字面两

```javascript
const a = `1234`;
const b = `${a}56789`;
```

## 转义字符

除了普通的可打印字符以外，一些有特殊功能的字符可以通过转义字符的形式放入字符串中：

Code Output
\0 空字符
\' 单引号
\" 双引号
\\ 反斜杠
\n 换行
\r 回车
\v 垂直制表符
\t 水平制表符
\b 退格
\f 换页
\uXXXX unicode 码
\u{X} ... \u{XXXXXX} unicode codepoint
\xXX Latin-1 字符(x 小写)

`和其他语言不同，javascript 的字符串不区分单引号和双引号，所以不论是单引号还是双引号的字符串，上面的转义字符都能运行`

## 描述

<!-- ### 获取字符串某个字符

1. charAt
2. 字符串当作一个类似数组的对象，其中的每个字符对应一个数值索引

```
const cat = 'cat'
console.log(cat.charAt(1),cat[1]) // a,a
```

### 字符串的比较

使用> < = >= <= 比较

### 基本字符串和字符串对象的区别 -->

## String 实例

### 属性

**String.prototype.constructor**
用于创造对象的原型对象的特定的函数。

**String.prototype.length**
返回了字符串的长度。

### 方法

跟 HTML 无关的方法

**String.prototype.charAt()**
返回特定位置的字符。

**String.prototype.charCodeAt()**
返回表示给定索引的字符的 Unicode 的值。

**String.prototype.concat()**
连接两个字符串文本，并返回一个新的字符串。

**String.prototype.includes()**
判断一个字符串里是否包含其他字符串。

这个方法已经被加入到 ECMAScript 6 标准中，但未必在所有的 JavaScript 实现中都可以使用。然而，你可以轻松地 polyfill 这个方法：

```javascript
if (!String.prototype.includes) {
  String.prototype.includes = function (search, start) {
    "use strict";
    if (typeof start !== "number") {
      start = 0;
    }

    if (start + search.length > this.length) {
      return false;
    } else {
      return this.indexOf(search, start) !== -1;
    }
  };
}
```

**String.prototype.endsWith()**
判断一个字符串的是否以给定字符串结尾，结果返回布尔值。

这个方法已经加入到 ECMAScript 6 标准当中，但是可能还没有在所有的 JavaScript 实现中可用。然而，你可以通过如下的代码片段扩展 String.prototype.endsWith() 实现兼容：

```javascript
if (!String.prototype.endsWith) {
  String.prototype.endsWith = function (search, this_len) {
    if (this_len === undefined || this_len > this.length) {
      this_len = this.length;
    }
    return this.substring(this_len - search.length, this_len) === search;
  };
}
```

**String.prototype.indexOf()**
从字符串对象中返回首个被发现的给定值的索引值，如果没有找到则返回-1。

**String.prototype.lastIndexOf()**
从字符串对象中返回最后一个被发现的给定值的索引值，如果没有找到则返回-1。

**String.prototype.match()**
使用正则表达式与字符串相比较。

**String.prototype.replace()**
被用来在正则表达式和字符串直接比较，然后用新的子串来替换被匹配的子串。

**String.prototype.slice()**
摘取一个字符串区域，返回一个新的字符串。

**String.prototype.split()**
通过分离字符串成字串，将字符串对象分割成字符串数组。

**String.prototype.startsWith()**
判断字符串的起始位置是否匹配其他字符串中的字符。

**String.prototype.substr()**
通过指定字符数返回在指定位置开始的字符串中的字符。

**String.prototype.substring()**
返回在字符串中指定两个下标之间的字符。

**String.prototype.toLowerCase()**
将字符串转换成小写并返回。

**String.prototype.toUpperCase()**
将字符串转换成大写并返回。

**String.prototype.trim()**
从字符串的开始和结尾去除空格。参照部分 ECMAScript 5 标准。

**String.prototype.trimStart()**
从字符串的左侧去除空格。

**String.prototype.trimEnd()**
从字符串的右侧去除空格。

**String.prototype.valueOf()**
返回特定对象的原始值。重写 Object.prototype.valueOf 方法。

**String.prototype.toString()**
返回用字符串表示的特定对象。重写 Object.prototype.toString 方法。

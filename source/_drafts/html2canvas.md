---
title: html2canvas
categories:
tags:
---

本文写一下在项目中遇到的问题：

## 加载外链的图片 + 使用 cdn 路径的图片

useCORS:true

```
html2canvas(mydiv, {
    useCORS:true
}).then((canvas)=>{
    // your onrendered function code here
})
```

## 图像显示隐藏问题

利用属性 onclone: 在克隆出来的 html 中操作，某些元素显示隐藏，这样不会影响原来的 html

```
html2canvas(mydiv, {
    onclone: function (clonedDoc) {
        clonedDoc.getElementById('mydiv').style.display = 'block';
    }
}).then((canvas)=>{
    // your onrendered function code here
})
```

## toDataUrl 返回 data;

bug: 在 ios，toDataUrl 返回 `data;`,在浏览器和 android 中返回正常的 base64 格式。
原因：ios 限制了图片的像素

目前处理办法： 控制 retina 屏幕 DPR 为 3，设置 scal 为 2

```
html2canvas(mydiv, {
    scale: window.devicePixelRatio > 2 ? 2 : window.devicePixelRatio  // scale默认为window.devicePixelRatio
}).then((canvas)=>{
    // your onrendered function code here
})
```

## 文字上下不居中的问题，错位问题

可能是字体的原因，好像不支持大部分的字体
试试别的字体

## 文字重叠问题

查询资料，有人说是居中（text-align:center）导致的,改成 text-align:left,我在项目中不是这个问题导致的，如果出现可以试试，
我解决的办法依旧是换字体，修改了 font-family,字体重叠问题就解决了。

## 相关阅读

[https://stackoverflow.com/questions/20605269/screenshot-of-hidden-div-using-html2canvas/51049443#51049443](https://stackoverflow.com/questions/20605269/screenshot-of-hidden-div-using-html2canvas/51049443#51049443)
[https://github.com/niklasvh/html2canvas/issues/1725](https://github.com/niklasvh/html2canvas/issues/1725)

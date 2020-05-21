---
title: hls技术和m3u8格式视频播放问题
categories:
  - 前端
tags:
  - video
date: 2020-05-21 17:04:55
---


## 什么是 HLS

HTTP Live Streaming（缩写是 HLS）是由苹果公司提出基于 HTTP 的流媒体网络传输协议。是苹果公司 QuickTime X 和 iPhone 软件系统的一部分。它的工作原理是`把整个流分成一个个小的基于 HTTP 的文件来下载`，`每次只下载一些`。当媒体流正在播放时，客户端可以选择从许多不同的备用源中以不同的速率下载同样的资源，允许流媒体会话适应不同的数据速率。在开始一个流媒体会话时，客户端会下载一个包含元数据的 extended M3U (m3u8) playlist 文件，用于寻找可用的媒体流。

HLS 只请求基本的 HTTP 报文，与实时传输协议（RTP）不同，HLS 可以穿过任何允许 HTTP 数据通过的防火墙或者代理服务器。它也很容易使用内容分发网络来传输媒体流。 FROM：维基百科

## 什么是 m3u8

首先提一下`M3U`,M3U 是一种播放多媒体列表的文件格式(M3U 文件是一种纯文本文件，可以指定一个或多个多媒体文件的位置，其文件扩展名是“M3U”或者“m3u”)，它的设计初衷是为了播放音频文件，比如 MP3，但是越来越多的软件现在用来播放视频文件列表，M3U 也可以指定在线流媒体音频源。很多播放器和软件都支持 M3U 文件格式。

M3U8 是 Unicode 版本的 M3U，用 UTF-8 编码。"M3U"和"M3U8"文件都是苹果公司使用的 HTTP Live Streaming 格式的基础，这种格式可以在 iPhone 和 Macbook 等设备播放。

## m3u8 兼容性

[https://caniuse.com/#search=m3u8](https://caniuse.com/#search=m3u8)

移动端浏览器大部分支持，PC 端几乎不支持（2020-02-24）

## m3u8 格式文件

m3u8 区分未加密和加密两种，加密的 m3u8 在格式上多了#EXT-X-KEY，通过#EXT-X-KEY 的值去获取加密密钥，密钥文件由客户端从服务器请求认证获得(#EXT-X-KEY = url)

**未加密的 mu38**

```
#EXTM3U // 开始必须是这个 表示其为m3u8格式
#EXT-X-VERSION:3 // 版本
#EXT-X-MEDIA-SEQUENCE:0 // 序号，从哪个开始播放，对应ts文件的序号
#EXT-X-ALLOW-CACHE:YES
#EXT-X-TARGETDURATION:22

#EXTINF:9.009, // 时长，单位(秒)
http://m3u8.example.com/0.ts
#EXTINF:9.009, // 时长，单位(秒)
http://m3u8.example.com/1.ts
#EXTINF:3.003, // 时长，单位(秒)
http://m3u8.example.com/2.ts
#EXTINF:3.003, // 时长，单位(秒)
/2.ts                        // 默认是以链接名为域名
#EXT-X-ENDLIST // 时长，单位(秒)

```

**加密的 mu38**

一种是对 TS 切片文件直接加密；另一种是对 H.264 编码文件中类型为 1 和 5 的 NAL 单元进行加密，其它类型的 NAL 单元不加密[2]。
URI 直接返回文本格式的密钥，而不是 json 格式的对象。

**划重点：加密的 m3u8 视频播放，播放器会主动调用 URI 中的链接，获取密钥，项目部署和 URI 在不同域下，这可能存在跨域问题！这可能存在跨域问题！这可能存在跨域问题！你细品！**
**https 的问题也需要注意**

```

#EXTM3U
#EXT-X-VERSION:3  // 版本
#EXT-X-MEDIA-SEQUENCE:0 //  队列
#EXT-X-ALLOW-CACHE:YES // 是否允许缓存
#EXT-X-TARGETDURATION:22
#EXT-X-KEY:METHOD=AES-128,URI="https://cdn.xxx.com/static/js/key.text",IV=0x6f827308c0b2cf37bd8f22f457a852d2 // METHOD 加密方式  URI 加密密钥的链接 IV
#EXTINF:21.200000, // 时长，单位(秒)
http://m3u8.example.com/0.ts
#EXT-X-KEY:METHOD=AES-128,URI="https://cdn.xxx.com/static/js/key.text",IV=0x27fa8d760c73864ca85a43a0b2d833ac
#EXTINF:18.000000, // 时长，单位(秒)
http://m3u8.example.com/1.ts
#EXT-X-KEY:METHOD=AES-128,URI="https://cdn.xxx.com/static/js/key.text",IV=0x27fa8d760c73864ca85a43a0b2d833ac
#EXTINF:18.000000, // 时长，单位(秒)
http://m3u8.example.com/1.ts
#EXT-X-ENDLIST

```

## 播放问题

前面提到了 m3u8 格式，在移动端大部分是兼容的，在 PC 端不兼容

1. 原生 video 播放
2. videojs + videojs-contrib-hls
   直接在网页中生效
   vue 中暂时没有自己实践
3. hls.js
4. 奇舞：**移动端**：chimee-mobile-player **PC 端**：chimee-player
   ** 注意需要手动引入 css**

```
// PC
import ChimeePlayer from "chimee-player";
import "chimee-player/lib/chimee-player.min.css";

// 移动端
import ChimeeMobilePlayer from "chimee-mobile-player";
import "chimee-mobile-player/lib/chimee-mobile-player.browser.css";
```

## 总结

需要了解基本概念, m3u8 的播放和 mp4 等别的播放，最大问题就是兼容问题，然后就是加密的 m3u8 注意获取 key 的过程，浏览器访问 URI，不会显示在浏览器的 xhr 请求里面（在浏览器 ALL 里面可以查看的，在 webview 页面中调试，请抓包，
未加密的 m3u8 肯定会比 mp4 加载速度快很快，毕竟切片了

## 相关阅读

[知乎大神回答](https://www.zhihu.com/question/21087379)
[掘金大神文章](https://juejin.im/post/5be1629ce51d4514d5607357#heading-2)

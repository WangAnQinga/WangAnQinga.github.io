---
title: Event Loop
categories:
tags:
  - javascript
---

## js 执行机制

javascript 是一门单线程语言，意味着，同一个时间只能做一件事。

## 任务队列（消息队列）

单线程就意味着，所有任务需要排队，前一个任务结束，才会执行后一个任务。如果前一个任务耗时很长，后一个任务就不得不一直等着。

所有任务可以分成两种：一种是同步任务（synchronous），另一种是异步任务（asynchronous）。

同步任务在主线程上执行，形成执行栈。异步任务则放在"任务队列"中，等待主线程中同步任务完成再执行.

"任务队列"是一个事件的队列（也称为消息队列），是一个先进先出的队列，它里面存放着各种消息，即**异步操作的回调函数**，**异步操作会将相关回调添加到任务队列中**。

不同的异步操作添加到任务队列的时机也不同，如 onclick，setTimeout，ajax 处理的方式都不同，这些异步操作都是由浏览器不同线程（前面的浏览器文章有讲到过）来执行的：

事件触发线程：onclick 由浏览器内核的 DOM Binding 模块来处理，当事件触发的时候，回调函数会立即添加到任务队列中；
定时触发器线程：setTimeout 会由浏览器内核的 timer 模块来进行延时处理，当时间到达的时候，才会将回调函数添加到任务队列中；
异步 http 请求线程：ajax 会由浏览器内核的 network 模块来处理，在网络请求完成返回之后，才将回调添加到任务队列中;

## 事件轮询

事件轮询的工作是监听执行栈，并确定执行栈是否为空。如果执行栈是空的，它将检查任务队列（消息队列），看看是否有任何挂起的回调等待执行。

**请记住 setTimeout 不是 JS 引擎的一部分，它是 Web Api 的一部分，如果了解浏览器有哪些线程就知道了。 setTimeout、setInterval、Fetch、DOM Events**

**事件轮询、web api 和消息队列不是 JavaScript 引擎的一部分，而是浏览器的 JavaScript 运行时环境或 Nodejs JavaScript 运行时环境的一部分(对于 Nodejs)。在 Nodejs 中，web api 被 c/c++ api 所替代。**

<!-- 1. JS 引擎线程会维护一个执行栈，同步代码会依次加入到执行栈中依次执行并出栈。
2. JS 引擎线程遇到异步函数，会将异步函数交给相应的 Webapi，而继续执行后面的任务。
3. Webapi 会在条件满足的时候，将`异步对应的回调`加入到消息队列中，等待执行。
4. 执行栈为空时，JS 引擎线程会去取消息队列中的回调函数（如果有的话），并加入到执行栈中执行。
5. 完成后出栈，执行栈再次为空，重复上面的操作，这就是事件循环(event loop)机制。 -->

1. 所有同步任务都在主线程上执行，形成一个执行栈（execution context stack）。
2. 主线程之外，还存在一个"任务队列"（task queue）。只要异步任务有了运行结果，就在"任务队列"之中放置一个事件。
3. 一旦"执行栈"中的所有同步任务执行完毕，系统就会读取"任务队列"，看看里面有哪些事件。那些对应的异步任务，于是结束等待状态，进入执行栈，开始执行。
4. 主线程不断重复上面的第三步。

**Webapi 会在条件满足的时候，将`异步对应的回调`加入到消息队列中，等待执行。**

![](/images/eventLoop.webp)

## 宏任务与微任务

macro-task(宏任务)、micro-task(微任务)

<!-- 现在标准称呼可以认为是 tasks 和 jobs -->

宏任务：script 全部代码（全局任务）, setTimeout, setInterval, setImmediate, I/O, UI rendering.
微任务：process.nextTick, Promise, Object.observer, MutationObserver.

宏任务优先级：主代码块 > setImmediate > MessageChannel > setTimeout / setInterval
微任务优先级：process.nextTick > Promise > MutationObserver

<!-- 整个在 script 中的代码也是一个宏任务 -->

setImmediate 目前在 IE10 有用

除了广义的同步任务和异步任务，其实对异步任务还有更细致的划分
macro-task(宏任务)和 microtask（微任务）属于对异步任务的分类，不同的 API 注册的异步任务会依次进入自身对应的队列中，然后等待 Event Loop 将它们依次压入执行栈中执行。
微任务和宏任务皆为异步任务，但是他们将进入两个不同的异步队列里，而且微任务队列的优先级比宏任务的优先级要高。

有歧义：
script 全部代码属不属于宏任务。

个人观点:
script 属于宏任务。

我理解的 eventloop:

## setTimeout

**setTimeout(fn,0)的含义是，指定某个任务在主线程最早可得的空闲时间执行，也就是说，尽可能早得执行。它在"任务队列"的尾部添加一个事件，因此要等到同步任务和"任务队列"现有的事件都处理完，才会得到执行。**

HTML5 标准规定了 setTimeout()的第二个参数的最小值（最短间隔），不得低于 4 毫秒，如果低于这个值，就会自动增加。在此之前，老版本的浏览器都将最短间隔设为 10 毫秒。另外，对于那些 DOM 的变动（尤其是涉及页面重新渲染的部分），通常不会立即执行，而是每 16 毫秒执行一次。这时使用 requestAnimationFrame()的效果要好于 setTimeout()。

需要注意的是，setTimeout()只是将事件插入了"任务队列"，必须等到当前代码（执行栈）执行完，主线程才会去执行它指定的回调函数。要是当前代码耗时很长，有可能要等很久，所以并没有办法保证，回调函数一定会在 setTimeout()指定的时间执行。

## 相关阅读

[EventLoop](https://javascript.info/event-loop)
[microtask](https://javascript.info/microtask-queue)
[http://www.ruanyifeng.com/blog/2014/10/event-loop.html](http://www.ruanyifeng.com/blog/2014/10/event-loop.html)

<!-- [事件轮训](https://segmentfault.com/a/1190000020400736)
[event loop](https://www.jianshu.com/p/de7aba994523)
[https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/7](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/7)
[https://github.com/gauseen/blog/issues/6](https://github.com/gauseen/blog/issues/6)
[https://www.cnblogs.com/jiangyuzhen/p/11064408.html](https://www.cnblogs.com/jiangyuzhen/p/11064408.html)
[https://www.ruphi.cn/archives/350/](https://www.ruphi.cn/archives/350/) -->

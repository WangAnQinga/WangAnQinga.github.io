---
title: async await、Promise、setTimeout执行顺序
categories:
tags:
  - javascript
---

**同步代码(包括 promise 的构造函数) -> promise.then -> setTimeout**

```
async function async1(){
   console.log('async1 start');
    await async2();
    console.log('async1 end')
}
async function async2(){
    console.log('async2')
}
console.log('script start');
setTimeout(function(){
    console.log('setTimeout')
},0);
async1();
new Promise(function(resolve){
    console.log('promise1');
    resolve();
}).then(function(){
    console.log('promise2')
});
console.log('script end')
```

## async await

async 函数在 await 之前的代码都是同步执行的，可以理解为 await 之前的代码属于 new Promise 时传入的代码，await 之后的所有代码都是在 Promise.then 中的回调

```
解析：
console.log('script start');
console.log('async1 start');
console.log('async2')
console.log('promise1');
console.log('async1 end')
console.log('script end')
console.log('promise2')
 console.log('setTimeout')

```

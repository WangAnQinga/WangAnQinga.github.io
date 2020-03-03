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

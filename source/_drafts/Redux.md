---
title: Redux 。
categories:
tags:
---

## 设计思想

Redux 的设计思想很简单，就两句话。

1. Web 应用是一个状态机，视图与状态是一一对应的。

2. 所有的状态，保存在一个对象里面。

## 基本原则

整个应用只有唯一一个可信数据源，也就是只有一个 Store
State 只能通过触发 Action 来更改
State 的更改必须写成纯函数，也就是每次更改总是返回一个新的 State，在 Redux 里这种函数称为 Reducer

## 基本概念和 API

### Store

Store 就是保存数据的地方，你可以把它看成一个容器。整个应用只能有一个 Store。

Redux 提供 createStore 这个函数，用来生成 Store。

import { createStore } from 'redux';
const store = createStore(fn);

上面代码中，createStore 函数接受另一个函数(reducer)作为参数，返回新生成的 Store 对象。

### state

const state = store.getState();
视图通过获取最新的 state 来改变视图

### action

Action 是一个对象。其中的 type 属性是必须的，表示 Action 的名称。

```
const action = {
    type: 'ADD_TODO',
    payload: 'Learn Redux'
};

dispath(action)

const addToDO = (text)=>{
    return{
        type:"add_todo,
        text
    }
}

dispath(addToDo('Learn Redux'))
```

### reducer

简单的说，就是集中处理 state 的地方
接受两个参数 state,action

### getState

获取 state 中的值

### dispath

分发 action；

```
dispath(addToDo('Learn Redux'));
dispath(action)
```

### subscribe

store.subscribe(fn)；
当 state 值被修改是，会触发 fn 中的方法

## Data Flow 单向数据流

store.dispatch(action) -> reducer(state, action) -> store.getState() 其实就构成了一个“单向数据流”。

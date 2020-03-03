---
title: React
categories:
tags:
---

#### sass 和 less

`npm init react-app xxx`
默认安装 sass,如果需要使用 less,则需要另外安装

#### styled-jsx && styled-jsx-plugin-less || style-jsx-plugin-sass

个人建议使用 styled-jsx 处理 css

遇到的问题:

```
// npm init react-app xxx 直接使用styled-jsx就会出现这个问题。如果恢复webpack配置，npm run eject 则不会出现这个bug,暂时还不知道什么原因

index.js:1 Warning: Received `true` for a non-boolean attribute `jsx`.

If you want to write it to the DOM, pass a string instead: jsx="true" or jsx={value.toString()}.
    in style (at App.js:25)
    in App (at src/index.js:7)
```

[https://stackoverflow.com/questions/57261540/warning-received-true-for-a-non-boolean-attribute-jsx-zeit-styled-jsx](https://stackoverflow.com/questions/57261540/warning-received-true-for-a-non-boolean-attribute-jsx-zeit-styled-jsx)

#### 文件目录

好像不能 import src 之外的文件夹

[https://stackoverflow.com/questions/44114436/the-create-react-app-imports-restriction-outside-of-src-directory?noredirect=1](https://stackoverflow.com/questions/44114436/the-create-react-app-imports-restriction-outside-of-src-directory?noredirect=1)

#### 按需加载

[https://github.com/ant-design/ant-design-mobile/issues/3094](https://github.com/ant-design/ant-design-mobile/issues/3094)

#### hooks 表单

`npm install react-hook-form`

#### react 组件

[https://juejin.im/entry/59a4eca4f265da24951798a5](https://juejin.im/entry/59a4eca4f265da24951798a5)

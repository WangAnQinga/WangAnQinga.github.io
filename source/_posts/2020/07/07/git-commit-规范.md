---
title: git-commit 规范和代码风格检查
categories:
  - 前端
tags:
  - git
date: 2020-07-07 10:05:39
---


**本文思路：**

1. commit 规范是什么
2. 使用 commit 规范
3. 什么时候检查提交的规范
4. 提交之前添加代码风格检验
5. 附加：commit 工具

## commit 简介

Git 每次提交代码，都要写 Commit message（提交说明），否则就不允许提交。
目前，社区有多种 Commit message 的写法规范。Angular 规范是目前使用最广的写法，比较合理和系统化，并且有配套的工具。

---

## commit 格式

目前规范使用较多的是 Angular 团队的规范, 继而衍生了 Conventional Commits specification. 很多工具也是基于此规范, 它的 message 格式如下:

```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>

```

我们通过 git commit 命令带出的 vim 界面填写的最终结果应该类似如上这个结构, 大致分为三个部分(使用空行分割):

- 标题行: 必填, 描述主要修改类型和内容
- 主题内容: 描述为什么修改, 做了什么样的修改, 以及开发的思路等等
- 页脚注释: 放 Breaking Changes 或 Closed Issues

分别由如下部分构成:

- type: commit 的类型
  - upd：更新某功能（不是 feat, 不是 fix）
  - feat: 新特性
  - fix: 修改问题
  - refactor: 代码重构
  - docs: 文档修改
  - style: 代码格式修改, 注意不是 css 修改
  - test: 测试用例修改
  - chore: 其他修改, 比如构建流程, 依赖管理.
  - scope: commit 影响的范围, 比如: route, component, utils, build...
- subject: commit 的概述, 建议符合 50/72 formatting
- body: commit 具体修改内容, 可以分为多行, 建议符合 50/72 formatting
- footer: 一些备注, 通常是 BREAKING CHANGE 或修复的 bug 的链接.

这样一个符合规范的 commit message, 就好像是一份邮件.

```bash
git commit -m "fix: 修复了 XXX 功能"
git commit -m "feat: 增加了 XXX 功能"
```

---

## husky

husky 会在 git 的钩子 pre-commit 进行相关操作

安装 husky：

```bash
npm install husky -D -S
```

然后修改 package.json，增加配置：

```
"husky": {
    "hooks": {
      "pre-commit": "eslint --ext .js,.vue src"
    }
  }
```

---

## commitlint

代码检验工具,需配合上面的 husky 使用

```bash
# Install commitlint cli and conventional config
npm install --save-dev @commitlint/{config-conventional,cli}
# For Windows:
npm install --save-dev @commitlint/config-conventional @commitlint/cli

# Configure commitlint to use conventional config
echo "module.exports = {extends: ['@commitlint/config-conventional']}" > commitlint.config.js
```

```
{
  "husky": {
    "hooks": {
       "pre-commit": "eslint --ext .js,.vue src"
      "commit-msg": "commitlint -E HUSKY_GIT_PARAMS"
    }
  }
}
```

[https://github.com/conventional-changelog/commitlint](https://github.com/conventional-changelog/commitlint)

这个时候加入了 eslint 代码风格检验, **但这样会有一个问题，就是这次提交，我可能只修改了一个文件，比如我就修改了 package.json 的内容，但它依然会校验所有 src 下面的.js 文件，非常的不友好。**

---

## lint-staged

解决 husky 的痛点就需要使用 lint-staged 了。它只会校验检查你提交或者说你修改的部分内容。

安装 lint-staged:

```bash
npm install lint-staged -D -S
```

修改 package.json 配置：

```
"husky": {
  "hooks": {
    "pre-commit": "lint-staged",
    "commit-msg": "commitlint -E HUSKY_GIT_PARAMS"
  }
},
"lint-staged": {
    "src/**/*.{js,vue}": [
      "eslint --fix",
      "git add"
    ]
  }
```

---

## commitizen

代码提交规范工具：commitizen/cz-cli, 我们需要借助它提供的 git cz 命令替代我们的 git commit 命令, 帮助我们生成符合规范的 commit message.
除此之外, 我们还需要为 commitizen 指定一个 Adapter 比如: cz-conventional-changelog (一个符合 Angular 团队规范的 preset). 使得 commitizen 按照我们指定的规范帮助我们生成 commit message.

commitizen 作用: Simply use git cz instead of git commit when committing.

安装依赖

```bash
npm install -g commitizen cz-conventional-changelog
```

**这个工具可用可不用，看个人喜好**

如上配置，每次它只会在你本地 commit 之前，校验你提交的内容是否符合你本地配置的 eslint 规则(这个见文档 ESLint )，如果符合规则，则会提交成功。如果不符合它会自动执行 eslint --fix 尝试帮你自动修复，如果修复成功则会帮你把修复好的代码提交，如果失败，则会提示你错误，让你修好这个错误之后才能允许你提交代码

## 最终的流程

达到上述效果，执行的流程如下：

1. 待提交的代码 git add 添加到暂存区;
2. 执行 git cz; // 也可以用原来的 git commit -m "fix: 修复了 XXX 功能"
3. husky 注册在 git pre-commit 的钩子函数被调用，执行 lint-staged 和 commit 信息检查;
4. Lint-staged 保证只对当前 add 到 git stage 区的文件进行扫描操作，这样做的原因在于，如果对全工程的文件进行扫描的话，并且之前的前端工程并未注重代码规则的检测的话，很大可能性会出现成百上千的 error，基本上心里是崩溃的。
   因此，只对当前 add 的文件进行检测，达到及时止损的目的，历史代码可以切到新的分支进行修复后再进行合并。
5. 如果有错误（没通过 ESlint 检查）则停止任务，同时打印错误信息，等待修复后再执行 commit;
6. 成功 commit，可 push 到远程

##### 相关依赖

`commitizen` `husky` `lint-staged` `commitlint`

## 相关阅读

[阮一峰 commit_message_change 文章](https://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)
[https://github.com/XXHolic/blog/issues/16](https://github.com/XXHolic/blog/issues/16)

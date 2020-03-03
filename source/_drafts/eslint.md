---
title: eslint
categories:
tags:
  - eslint
---

#Eslint

**eslint 相关的文件在根目录下 `.editorconfig` `.eslintignore` `.eslintrc.js`**

`.editorconfig`： xxx 文件
`.eslintignore`： eslint 忽略校验的配置文件
`.eslintrc.js`： eslint 关键的配置文件

##### 配置根目录下的`.editorconfig`文件

[https://editorconfig.org/](https://editorconfig.org/)

```

root = true

[*]
charset = utf-8
end_of_line = lf
indent_size = 2
indent_style = space
insert_final_newline = true
max_line_length = 80
trim_trailing_whitespace = true

[*.md]
max_line_length = 0
trim_trailing_whitespace = false
```

##### 配置根目录下的`.eslintignore`文件

```
dist
node_modules
```

##### 配置根目录下的`.eslintrc.js`文件

```
module.exports = {
  root: true,
  // vue 里面
  parser: "vue-eslint-parser",
  env: {
    es6: true,
    browser: true,
    node: true
  },
  // parserOptions来指定语言版本为和模块类型
  parserOptions: {
    parser: "babel-eslint",
    //  ecm版本
    ecmaVersion: 6,
    // 模块类型sourceType为module，如此便支持export和import来导出并引用文件
    sourceType: "module",
    ecmaFeatures: {
      jsx: true,
      modules: true,
      experimentalObjectRestSpread: true
    }
  },
  globals: {
  },
  extends: "eslint:recommended",
  // vue:  extends: "plugin:vue-libs/recommended","@vue/typescript","eslint:recommended"
  // required to lint *.vue files
  plugins: ["html"],
  // add your custom rules here
  rules: {
    "no-console": "off"
  }
};

```

##### 文章参考

[https://larrylu.blog/improve-code-quality-using-eslint-742cf1f384f1](https://larrylu.blog/improve-code-quality-using-eslint-742cf1f384f1)

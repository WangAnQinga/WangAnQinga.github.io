---
title: vue 打包优化
categories:
tags:
  - vue
  - 性能优化
---

关键词:
`webpack开启gzip压缩`、`nginx开启gzip压缩`、`使用cdn`、`vue懒加载`

## 项目打包

#### webpack-bundle-analyzer

**如何分析问题**

首先我们先了解一下`webpack-bundle-analyzer`这个插件，[npm](https://www.npmjs.com/package/webpack-bundle-analyzer)、[github](https://github.com/webpack-contrib/webpack-bundle-analyzer),详细的知识点看 github 官网就好,**一遍看不懂就多看几遍!!!** **一遍看不懂就多看几遍!!!** **一遍看不懂就多看几遍!!!**

这里分别讲解一下`vue-cli2.0`和`vue-cli3.0`中具体的用法

##### **vue-cli2.0 中`webpack-bundle-analyzer`的用法**

1. 安装 webpack-bundle-analyzer， `cnpm i -D webpack-bundle-analyzer`
2. 在`package.json`文件中的 scripts 字段中加入
   `"analyze": "NODE_ENV=production npm_config_report=true npm run build"`

   <!-- 命令的意思是：设置`NODE_ENV`为`production` 、`npm_config_report`为`true`，然后运行`npm run build` -->

3. 打开`build`目录中的`webpack.prod.conf.js`，加入如下代码

   ```
   自定义配置：
   if (process.env.npm_config_report) {
     const BundleAnalyzerPlugin = require("webpack-bundle-analyzer").BundleAnalyzerPlugin;
     webpackConfig.plugins.push(
       new BundleAnalyzerPlugin({
         analyzerMode: "server",
         analyzerHost: "127.0.0.1",
         analyzerPort: 8887,
         reportFilename: "report.html",
         defaultSizes: "parsed",
         openAnalyzer: true,
         generateStatsFile: false,
         statsFilename: "stats.json",
         statsOptions: null,
         logLevel: "info"
       })
     );
   }

   默认配置：
   if (process.env.npm_config_report) {
     const BundleAnalyzerPlugin = require("webpack-bundle-analyzer").BundleAnalyzerPlugin;
     webpackConfig.plugins.push(BundleAnalyzerPlugin);
   }
   ```

4. 运行命令`npm run analyze`，浏览器会自动打开[http://127.0.0.1:8887](http://127.0.0.1:8887)(根据第三步配置的参数)

##### **vue-cli3.0 中`webpack-bundle-analyzer`的用法**

1. 安装 webpack-bundle-analyzer `cnpm i -D webpack-bundle-analyzer`
2. 在`package.json`文件中的 scripts 字段中加入
   `"analyze": "npm_config_report=true npm run build"`
   <!-- 命令的意思是：设置`NODE_ENV`为`production` 、`npm_config_report`为`true`，然后运行`npm run build` -->
3. 打开`vue.config.js`文件,加入如下代码

   ```
    自定义配置：
    chainWebpack: config => {
      if(process.env.npm_config_report){
        const BundleAnalyzerPlugin = require("webpack-bundle-analyzer").BundleAnalyzerPlugin;
        config.plugin("webpack-bundle-analyzer").use(
          new BundleAnalyzerPlugin({
              analyzerMode: "server",
              analyzerHost: "127.0.0.1",
              analyzerPort: 8887,
              reportFilename: "report.html",
              defaultSizes: "parsed",
              openAnalyzer: true,
              generateStatsFile: false,
              statsFilename: "stats.json",
              statsOptions: null,
              logLevel: "info"
          })
        );
      }
    }
    默认配置：
    chainWebpack: config => {
      if(process.env.npm_config_report){
        const BundleAnalyzerPlugin  = require("webpack-bundle-analyzer").BundleAnalyzerPlugin;
        config.plugin("webpack-bundle-analyzer").use(BundleAnalyzerPlugin);
      }
    }
   ```

4. 运行命令`npm run analyze`，浏览器会自动打开默认[http://127.0.0.1:8888](http://127.0.0.1:8887)

![](/images/webpack-bundle-analyzer.gif)

{% asset_img webpack-bundle-analyzer.gif This is an example image %}

我们观察上图中哪些包太大，就可以优化哪些，比如上图的 loadsh.js

##### vue2.0 中配置，

1. 打开 build 目录下的 webpack.base.conf.js,加入如下代码

```
  externals: {
    loadsh: "_",
  }
```

2. 在根目录下的 idnex.html 引入 cdn 的相关文件

```
<script src="https://cdn.bootcss.com/lodash.js/4.17.15/lodash.js"></script>
```

打包之后包的大小
主要看 vendor 包的大小，缩小了内容，我们使用 cdn，使其存在于外部环境。
由于 externals 属性，是将依赖排除，本该将 node_modules 中依赖包打入到 vendor bundle 中，变成外部扩展。

## nginx 开启 gzip 压缩

gzip 的压缩页面需要浏览器和服务器双方都支持，实际上就是服务器端压缩，传到浏览器后浏览器解压并解析。

```
# 开启gzip
gzip on;
# 启用gzip压缩的最小文件，小于设置值的文件将不会压缩
gzip_min_length 1k;
# gzip 压缩级别，1-10，数字越大压缩的越好，也越占用CPU时间，后面会有详细说明
gzip_comp_level 2;
# 进行压缩的文件类型。javascript有多种形式。其中的值可以在 mime.types 文件中找到。
gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png font/ttf font/otf image/svg+xml;
# 是否在http header中添加Vary: Accept-Encoding，建议开启
gzip_vary on;
# 禁用IE 6 gzip
gzip_disable "MSIE [1-6]\.";

# 开启缓存
location ~* ^.+\.(ico|gif|jpg|jpeg|png)$ {
    access_log   off;
    expires      30d;
}

location ~* ^.+\.(css|js|txt|xml|swf|wav)$ {
    access_log   off;
    expires      24h;
}
location ~* ^.+\.(html|htm)$ {
    expires      1h;
}

location ~* ^.+\.(eot|ttf|otf|woff|svg)$ {
    access_log   off;
    expires max;
}

# 格式
# expires 30s;
# expires 30m;
# expires 2h;
# expires 30d;

```

然后在 vue 项目中也开始 zip 压缩，下面介绍 vue-cli2.0 和 vue-cli3.0,相关模块`compression-webpack-plugin`

##### vue-cli2.0 Gzip

2.0 版本应该默认有相关的配置，在 build 目录下的 webpack.prod.conf.js 中有如下代码

```
if (config.build.productionGzip) {
 const CompressionWebpackPlugin = require("compression-webpack-plugin");

 webpackConfig.plugins.push(
   new CompressionWebpackPlugin({
     asset: "[path].gz[query]",
     algorithm: "gzip",
     test: new RegExp(
       "\\.(" + config.build.productionGzipExtensions.join("|") + ")$"
     ),
     threshold: 10240,
     minRatio: 0.8
   })
 );
}
```

上面的代码可以看出，如果 config.build.productionGzip 为 true 的话，则开始 gzip,所以我们只需配置 config.build.productionGzip 为 true.

##### vue-cli3.0

3.0 版本先手动安装`compression-webpack-plugin`模块，然后打开 vue.config.js 文件，配置如下代码：

```
const CompressionPlugin = require("compression-webpack-plugin")
module.exports = {
configureWebpack:config=>{
        if(progress.env.NODE_ENV === 'production'){
            return{
                plugins: [

                    new CompressionPlugin({
                        test:/\.js$|\.html$|.\css/, //匹配文件名
                        threshold: 10240,//对超过10k的数据压缩
                        deleteOriginalAssets: false //不删除源文件
                    })
                ]
            }
        }

    },
}
```

## Vue 异步组件

组件正常引入：

```
import CustomSql from '@/components/CustomSql'

export default {
  components: {
    CustomSql
  }
}
```

组件异步引入：

```
export default {
  components: {
    CustomSql: () => import('./CustomSql')
  }
}
```

## 组件按需加载

```
`vue-router// prev const component1 = () => import('@/components/**')//now
利用webpack require.ensure comst component2 = r => require.ensure([], () => r(require('@/components/+'**'+.vue'))`

```

## 首屏加载慢

```
vue-router// prev
const component1 = () => import('@/components/**')//now 利用webpack   require.ensure
comst component2 = r => require.ensure([], () => r(require('@/components/+'**'+.vue'))
```

> Vue 中路由懒加载就是使用异步组件和 Webpack 的代码分割功能实现的。

// 打包后文件的 css、js 存放的静态文件，在 main 目录下
assetsSubDirectory: 'static',
// 静态文件的引用路径
assetsPublicPath: './',

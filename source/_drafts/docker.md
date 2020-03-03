---
title: docker
categories:
tags:
---

## 查看 docker 版本

```bash
$ docker --version
Docker version 19.03.1, build 74b1e89

$ docker-compose --version
docker-compose version 1.24.1, build 4667896b

$ docker-machine --version
docker-machine version 0.16.1, build cce350d7

```

## 查看 docker 容器

```bash
// 查看所有的容器
$ docker ps -a

// 查看已运行的容器
$ docker ps
```

## 创建一个新的容器并运行一个命令

```bash

// 使用docker镜像nginx:latest以后台模式启动一个容器,并将容器命名为mynginx。
docker run --name mynginx -d nginx:latest

// 使用镜像nginx:latest以后台模式启动一个容器,并将容器的80端口映射到主机随机端口。
docker run -P -d nginx:latest


//使用镜像 nginx:latest，以后台模式启动一个容器,将容器的 80 端口映射到主机的 80 端口,主机的目录 /data 映射到容器的 /data。
docker run -p 80:80 -v /data:/data -d nginx:latest

// 绑定容器的 8080 端口，并将其映射到本地主机 127.0.0.1 的 80 端口上。
$ docker run -p 127.0.0.1:80:8080/tcp ubuntu bash

使用镜像nginx:latest以交互模式启动一个容器,在容器内执行/bin/bash命令。
$ docker run -it nginx:latest /bin/bash


```

## 进入容器（需要已运行） 未运行进去不

```bash
$ docker exec -it xxxx /bin/bash

```

## 启动容器（未运行）

```bash
$ docker start xxx

```

## 停止容器

```bash
$ docker stop xxx

```

## 删除容器 (必须先暂停容器)

```bash
$ docker rm xxx
```

## 查看 docker 镜像 images

```bash
$ docker images
```

## 删除镜像 images

```bash
$ docker rmi -f xxx
```

## 将容器打包成镜像

```bash
$ docker commit

OPTIONS说明：
-a :提交的镜像作者；
-c :使用Dockerfile指令来创建镜像；
-m :提交时的说明文字；
-p :在commit时，将容器暂停。

docker commit -a "提交镜像的作者" -m "提交的说明" 容器名称或id  仓库名称/打包的镜像名称:标签


注意：

docker commit 命令除了学习之外，还有一些特殊的应用场合，比如被入侵后保存现场等。但是，不要使用 docker commit 定制镜像，定制镜像应该使用 Dockerfile 来完成。

使用 docker commit 意味着所有对镜像的操作都是黑箱操作，生成的镜像也被称为 黑箱镜像，换句话说，就是除了制作镜像的人知道执行过什么命令、怎么生成的镜像，别人根本无从得知。而且，即使是这个制作镜像的人，过一段时间后也无法记清具体在操作的。虽然 docker diff 或许可以告诉得到一些线索，但是远远不到可以确保生成一致镜像的地步。这种黑箱镜像的维护工作是非常痛苦的。
```

## 将镜像推送到 docker 仓库 （需要登录 docker login）

```bash
$ docker push 仓库名称/打包的镜像名称:标签
```

## 将本地镜像改名字 （标记本地镜像，将其归入某一仓库。）

```bash
$ docker tag IMAGEID(镜像id) REPOSITORY:TAG（仓库：标签）
```

## docker build 命令用于使用 Dockerfile 创建镜像。

```bash

OPTIONS说明：
--build-arg=[] :设置镜像创建时的变量；

--cpu-shares :设置 cpu 使用权重；

--cpu-period :限制 CPU CFS周期；

--cpu-quota :限制 CPU CFS配额；

--cpuset-cpus :指定使用的CPU id；

--cpuset-mems :指定使用的内存 id；

--disable-content-trust :忽略校验，默认开启；

-f :指定要使用的Dockerfile路径；

--force-rm :设置镜像过程中删除中间容器；

--isolation :使用容器隔离技术；

--label=[] :设置镜像使用的元数据；

-m :设置内存最大值；

--memory-swap :设置Swap的最大值为内存+swap，"-1"表示不限swap；

--no-cache :创建镜像的过程不使用缓存；

--pull :尝试去更新镜像的新版本；

--quiet, -q :安静模式，成功后只输出镜像 ID；

--rm :设置镜像成功后删除中间容器；

--shm-size :设置/dev/shm的大小，默认值是64M；

--ulimit :Ulimit配置。

--tag, -t: 镜像的名字及标签，通常 name:tag 或者 name 格式；可以在一次构建中为一个镜像设置多个标签。

--network: 默认 default。在构建期间设置RUN指令的网络模式



使用当前目录的 Dockerfile 创建镜像，标签为 runoob/ubuntu:v1。

$ docker build -t runoob/ubuntu:v1 .



有提到指令最后一个 . 是上下文路径

上下文路径，是指 docker 在构建镜像，有时候想要使用到本机的文件（比如复制），docker build 命令得知这个路径后，会将路径下的所有内容打包。

解析：由于 docker 的运行模式是 C/S。我们本机是 C，docker 引擎是 S。实际的构建过程是在 docker 引擎下完成的，所以这个时候无法用到我们本机的文件。这就需要把我们本机的指定目录下的文件一起打包提供给 docker 引擎使用。

如果未说明最后一个参数，那么默认上下文路径就是 Dockerfile 所在的位置。

注意：上下文路径下不要放无用的文件，因为会一起打包发送给 docker 引擎，如果文件过多会造成过程缓慢。
```

## Docker Mechine

Docker Machine 是一个工具，用来在虚拟主机上安装 Docker Engine，并使用 docker-machine 命令来管理这些虚拟主机。

# plugins

将测试自动化构建为 Helm Chart，用来轻松部署测试工作负载。

## 准备工作

Fork上游repo

检出代码

查看 `pytest/templates/pod.yaml` 文件内容

主要包含:

- 一个运行测试的主容器
- 一个Sidecar同步报告的容器
- 相关配置如命令、环境变量等

## 要求

- Kubernetes
- Helm

## 创建 Chart

我们创建一个名为 test-chart 的 Chart:

```shell  
helm create test-chart
```

这将生成Chart所需的基本目录和文件。

### 填充模板

删除无用文件

```shell
rm -rf test-chart/templates/tests
rm -rf test-chart/templates/*
```

在 templates 目录下创建 auto-test.yaml 文件

复制上游repo中的 `pytest/templates/pod.yaml` 内容进来

运行测试的主容器引用 `values.yaml` 中参数:

```yaml
image: {{ .Values.image }}
command: {{ .Values.command }}
```

### 配置 values.yaml

复制上游repo中的 `pytest/values.yaml` 内容覆盖 `test-chart/values.yaml`

在 `test-chart/values.yaml` 中添加image、command等变量。并配置默认值。

### 调试运行

通过命令 helm install 来安装调试该 Chart。

```shell
helm install -g test-chart
```

### 发布Chart

在Chart.yaml中完成元信息描述,然后就可以发布到Chart仓库中啦!

```shell
helm package test-chart

```

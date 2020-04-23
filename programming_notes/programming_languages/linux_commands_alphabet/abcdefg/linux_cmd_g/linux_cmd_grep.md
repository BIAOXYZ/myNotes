
Linux: grep多个关键字“与”和“或” https://blog.csdn.net/mmbbz/article/details/51035401
```shell
1、或操作

grep -E '123|abc' filename  // 找出文件（filename）中包含123或者包含abc的行
egrep '123|abc' filename    // 用egrep同样可以实现
awk '/123|abc/' filename   // awk 的实现方式

2、与操作

grep pattern1 files | grep pattern2 //显示既匹配 pattern1 又匹配 pattern2 的行。

3、其他操作

grep -i pattern files   //不区分大小写地搜索。默认情况区分大小写，
grep -l pattern files   //只列出匹配的文件名，
grep -L pattern files   //列出不匹配的文件名，
grep -w pattern files  //只匹配整个单词，而不是字符串的一部分（如匹配‘magic’，而不是‘magical’），
grep -C number pattern files //匹配的上下文分别显示[number]行，
```

```sh
// 个人实战了下，通过管道后的grep多个关键词也是可以的。

// 准备阶段：含有cmd的文件有84个；含有printing的文件有2个
root@myopenshift:operator-sdk$ git ls-files | grep cmd | wc -l
84
root@myopenshift:operator-sdk$ git ls-files | grep printing | wc -l
2

// 三种求“或”（并集）的方式
root@myopenshift:operator-sdk$ git ls-files | grep -E 'cmd|printing' | wc -l
85
root@myopenshift:operator-sdk$ git ls-files | egrep 'cmd|printing' | wc -l
85
root@myopenshift:operator-sdk$ git ls-files | awk '/cmd|printing/' | wc -l
85

// 求“与”（交集）的方式
root@myopenshift:operator-sdk$ git ls-files | grep cmd | grep printing | wc -l
1

----------------------------------------------------------------------------------------------------

// 另一个实战：同时grep多个端口占用情况：

[root@cloudsec4 ~]# netstat -lntp | grep 2379
tcp        0      0 9.186.102.73:2379       0.0.0.0:*               LISTEN      2150/etcd
[root@cloudsec4 ~]# netstat -lntp | grep 2380
tcp        0      0 9.186.102.73:2380       0.0.0.0:*               LISTEN      2150/etcd
[root@cloudsec4 ~]# netstat -lntp | grep 10250
tcp        0      0 9.186.102.73:10250      0.0.0.0:*               LISTEN      17881/kubelet
[root@cloudsec4 ~]#
[root@cloudsec4 ~]# netstat -nltp | grep -E "2379|2380|10250"
tcp        0      0 9.186.102.73:10250      0.0.0.0:*               LISTEN      17881/kubelet
tcp        0      0 9.186.102.73:2379       0.0.0.0:*               LISTEN      2150/etcd
tcp        0      0 9.186.102.73:2380       0.0.0.0:*               LISTEN      2150/etcd
```

grep命令:匹配多个单词 https://www.jianshu.com/p/747c97f4b4ac



grep 命令系列：grep 中的正则表达式 https://linux.cn/article-6941-1.html


【grep的-n -A -B】 Helm Package Manager https://www.katacoda.com/javajon/courses/kubernetes-pipelines/helm
```sh
master $ cat app-chart/templates/deployment.yaml | grep 'kind:' -n -B1 -A5
1-apiVersion: apps/v1
2:kind: Deployment
3-metadata:
4-  name: {{ include "app-chart.fullname" . }}
5-  labels:
6-    {{- include "app-chart.labels" . | nindent 4 }}
7-spec:
master $ cat app-chart/templates/deployment.yaml | grep 'image:' -n -B3 -A3
25-        - name: {{ .Chart.Name }}
26-          securityContext:
27-            {{- toYaml .Values.securityContext | nindent 12 }}
28:          image: "{{ .Values.image.repository }}:{{ .Chart.AppVersion }}"
29-          imagePullPolicy: {{ .Values.image.pullPolicy }}
30-          ports:
31-            - name: http
master $
```

```sh
# 目录用星号【*】似乎是等于当前目录【.】？

root@temptest hellovault $ grep -ir "name" *
job.yamlbak:  name: pi
job.yamlbak:      - name: pi
job.yamlbak2:  name: pi
job.yamlbak2:      - name: pi
root@temptest hellovault $ grep -ir "name" .
./job.yamlbak:  name: pi
./job.yamlbak:      - name: pi
./job.yamlbak2:  name: pi
./job.yamlbak2:      - name: pi
root@temptest hellovault $
```

## `-R` 与 `-r`

What's the difference between grep -r and -R https://stackoverflow.com/questions/22763579/whats-the-difference-between-grep-r-and-r

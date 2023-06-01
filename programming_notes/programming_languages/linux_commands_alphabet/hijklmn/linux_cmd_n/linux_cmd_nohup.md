
# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

Linux 后台运行任务 nohup 结合&用法以及如何精准查找进程并 kill 后台任务实践 https://www.v2ex.com/t/628260

nohup, &作用 https://segmentfault.com/a/1190000014653953
- > 最近看了58沈剑的文章"一分钟了解nohup和&的功效", "明明打印到文件了，为啥tail -f看不到", 对常用的nohup和&的了解更多了一些，结合这两篇文章，做些记录和总结。
  >> 明明打印到文件了，为啥tail -f看不到 https://mp.weixin.qq.com/s/l2GDtJqcaup8cdQ0j7Ivuw

# 问题

## `nohup.out` 里没有 python `print` 的内容

Python - nohup.out don't show print statement https://stackoverflow.com/questions/25674613/python-nohup-out-dont-show-print-statement

用nohup执行python程序时，print无法输出 https://blog.csdn.net/sunlylorn/article/details/19127107
- > `nohup python test.py > nohup.out 2>&1 &` <br> 发现 `nohup.out` 中显示不出来python程序中 `print` 的东西。这是因为python的输出有缓冲，导致 `nohup.out` 并不能够马上看到输出。
- > python 有个 `-u` 参数，使得python不启用缓冲。
- > `nohup python -u test.py > nohup.out 2>&1 &`

## `nohup` 和 `time` 不能同时用

bash time with nohup https://unix.stackexchange.com/questions/199879/bash-time-with-nohup

How can I 'nohup' a command and log the output of 'time' https://stackoverflow.com/questions/26427908/how-can-i-nohup-a-command-and-log-the-output-of-time

How do I use nohup and time together? https://stackoverflow.com/questions/65468796/how-do-i-use-nohup-and-time-together

## 已经启动的程序，没有 `nohup`

耗时很长的程序忘加nohup就运行了怎么办？ - ipid君的回答 - 知乎 https://www.zhihu.com/question/586298694/answer/2991647868
- > 总结：Ctrl + Z、bg、disown 三连即可！当你熟练之后，甚至可以直接在终端里面敲下 bg;disown，这样不仅一次能执行两条命令，还不会被程序的输出干扰。
- > 上述方案的最大问题，就是关掉终端后就再也看不到命令输出了，而且除非一直 ps，否则根本不知道这条命令到底执行完了没有。
- > 所以…还是要记得加上 nohup，或者养成使用 tmux、screen 的好习惯啊！

# 个人实战

## 1

### 1.1

最常见的用法就是`nohup <your_cmd> &`直接放后台执行，然后期间通过`tail -f nohup.out`看看执行的情况。例如下面这个例子：
```sh
[root@oprinstall-inf offline]# nohup cloudctl case launch \
>   --case $HOME/offline/${CASE_ARCHIVE} \
>   --inventory ${CASE_INVENTORY_SETUP} \
>   --action mirror-images \
>   --args "--registry ${PORTABLE_DOCKER_REGISTRY} --inputDir $HOME/offline" \
>   --tolerance 1 &
[1] 29399
[root@oprinstall-inf offline]# nohup: ignoring input and appending output to 'nohup.out'

[root@oprinstall-inf offline]#
[root@oprinstall-inf offline]# tail -f nohup.out
uploading: 9.30.68.37:82/cp/cp4mcm/cp4mcm-grc-risk sha256:7e976fb4f609a6d952c8b9e5ae50f9a366e14fc564c2b6ba08aec3ae80f66b02 737.8KiB
uploading: 9.30.68.37:82/cp/cp4mcm/cp4mcm-grc-risk sha256:793a599bfe0274f987fbcb56ab612a1d54f2e68d6db8f21a4a7d37c83456f35c 733.8KiB
uploading: 9.30.68.37:82/cp/cp4mcm/cp4mcm-grc-risk sha256:1487969eddbf6b98e77a4c390e6a2fadaec72e41af1e6309371a6993569ed1a6 733.7KiB
uploading: 9.30.68.37:82/cp/cp4mcm/cp4mcm-grc-risk sha256:9b409f7229f2ef104f5fa3038932b4fc7409dd60f05c45d044af51f2007c7198 2.462MiB
uploading: 9.30.68.37:82/cp/cp4mcm/cp4mcm-grc-risk sha256:e811b70bf467785ba3d381461aa9277a4be0bd734228cb6b592b201f54638fa3 78.01MiB
uploading: 9.30.68.37:82/cp/cp4mcm/cp4mcm-grc-risk sha256:1d1c83118b643115a5d1cdf7e409bd2867fafd7275ac363977b2943365e1b3e1 8.776MiB
uploading: 9.30.68.37:82/cp/cp4mcm/cp4mcm-grc-risk sha256:99d74e27d373c9984418301349a1034033525e32d8bbd3b2e44ea4a30a0c7977 135.6MiB
uploading: 9.30.68.37:82/cp/cp4mcm/cp4mcm-grc-risk sha256:81b760445d2ad30fd5d2bfd3f898e3d8ecc02997ac6aebd14d9c6903b1577472 62.47MiB
uploading: 9.30.68.37:82/cp/cp4mcm/cp4mcm-grc-risk sha256:11b0a4714febea8effe8e9f77fc872a4b673663f4e3d9d81a8079cfb27dd1c2d 16.47MiB
uploading: 9.30.68.37:82/cp/cp4mcm/cluster-api-provider-aks sha256:1c9f515fc6ab2b7ebfcaffd8af681b68869d78a3b19c69e87c296363ab1bc2fe 72.7MiB
uploading: 9.30.68.37:82/cp/cp4mcm/cluster-api-provider-aks sha256:65d4bdbf45bc05da94b960c725723813c8d890fa2c672376b7def653c14badfa 8.765MiB
uploading: 9.30.68.37:82/cp/cp4mcm/cluster-api-provider-aks sha256:efa8423a1b64055d814b2980afdcaa2523b40c28742ee0cfb4df941346fbbbe3 7.768MiB
uploading: 9.30.68.37:82/cp/cp4mcm/cluster-api-provider-aks sha256:4c742e47cb5f4452c2d502b1bcf57f0d8431a1d780f8e1f29318b2d8f8b53b9d 76.58MiB
uploading: 9.30.68.37:82/cp/cp4mcm/cluster-api-provider-aks sha256:584c2af4fa17bebcc80eeb646a81639f2d7935a88f5b500ddb4344e598cd11fa 73.01MiB
uploading: 9.30.68.37:82/cp/cp4mcm/cluster-api-provider-aks sha256:357af4de1d029ebdb7ad17ea5669d5b8276b2584bd8403189ade12c9d5108026 8.534MiB
uploading: 9.30.68.37:82/cp/cp4mcm/cluster-api-provider-aks sha256:47950128b883c5213b01a74cab338ff65f72bd7f6efdef7c39fb5fce49fed120 80.1MiB
sha256:2ca5e69e244d2da7368f7088ea3ad0653c3ce7aaccd0b8823d11b0d5de956002 9.30.68.37:82/cp/cp4mcm/busybox:2.1.3-ibm-management-kong-amd64
sha256:ce5a79b993692ec92344dbf99d1778a93e4856f9b9a70c9dbd453212a17006cb 9.30.68.37:82/cp/cp4mcm/cam-install-operator:2.1.3-ibm-management-cam-install-ppc64le
sha256:1383206c2dd0a2f3f8a81b521cc1fe466e24acd948622ba6e54adadcea8d0c50 9.30.68.37:82/cp/cp4mcm/cam-install-operator:2.1.3-ibm-management-cam-install-amd64
uploading: 9.30.68.37:82/cp/cp4mcm/config-parser sha256:5381955e35b0492dff8705a54328590b7a98cd373de8bef3cba5a20c89265335 73.04MiB
uploading: 9.30.68.37:82/cp/cp4mcm/config-parser sha256:368277e598ecf22aeeec01da3139969cf89354a4a75b51538dc773aaf7bb9cee 5.157MiB
uploading: 9.30.68.37:82/cp/cp4mcm/config-parser sha256:fada17719cd7c18d0a626aa3b5938c7b459fb90a766b6cccb35f6dd0c8d5d11b 6.809MiB
uploading: 9.30.68.37:82/cp/cp4mcm/config-parser sha256:c9fa7d57b9028d4bd02b51cef3c3039fa7b23a8b2d9d26a6ce66b3428f6e2457 72.71MiB
uploading: 9.30.68.37:82/cp/cp4mcm/config-parser sha256:fdab9a2f008dc4d16c4509fe33d22ce21f60fa1cce24949a3a92fd64e9fb8b33 2.357MiB
^C
[root@oprinstall-inf offline]#
```
> 注意，上面那个例子里`nohup`和`&`引导的语句因为换行了不是那么清晰，其实去掉换行和末尾斜杠就是下面这个样子，符合`nohup <your_cmd> &`的结构：
>> `nohup cloudctl case launch --case $HOME/offline/${CASE_ARCHIVE} --inventory ${CASE_INVENTORY_SETUP} --action mirror-images --args "--registry ${PORTABLE_DOCKER_REGISTRY} --inputDir $HOME/offline" --tolerance 1 &`

### 1.2

再补个更清晰简单的例子：
```sh
{root@bandore1 tmp}$ export YOURCMD='ping -c 100 www.google.com'
{root@bandore1 tmp}$ echo $YOURCMD
ping -c 100 www.google.com
{root@bandore1 tmp}$
{root@bandore1 tmp}$ nohup $YOURCMD &
[1] 19683
{root@bandore1 tmp}$ nohup: ignoring input and appending output to ‘nohup.out’

{root@bandore1 tmp}$
{root@bandore1 tmp}$ tail -f nohup.out
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=6 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=7 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=8 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=9 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=10 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=11 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=12 ttl=100 time=49.2 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=13 ttl=100 time=50.4 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=14 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=15 ttl=100 time=53.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=16 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=17 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=18 ttl=100 time=49.1 ms
^C
{root@bandore1 tmp}$
```

执行完成后`nohup.out`文件还在，并且可以查看完整的内容：
```sh
{root@bandore1 tmp}$ ls
nohup.out
{root@bandore1 tmp}$ cat nohup.out
PING www.google.com (172.217.11.228) 56(84) bytes of data.
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=1 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=2 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=3 ttl=100 time=49.4 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=4 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=5 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=6 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=7 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=8 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=9 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=10 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=11 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=12 ttl=100 time=49.2 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=13 ttl=100 time=50.4 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=14 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=15 ttl=100 time=53.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=16 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=17 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=18 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=19 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=20 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=21 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=22 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=23 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=24 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=25 ttl=100 time=49.2 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=26 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=27 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=28 ttl=100 time=54.3 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=29 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=30 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=31 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=32 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=33 ttl=100 time=48.9 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=34 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=35 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=36 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=37 ttl=100 time=49.5 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=38 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=39 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=40 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=41 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=42 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=43 ttl=100 time=49.2 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=44 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=45 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=46 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=47 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=48 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=49 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=50 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=51 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=52 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=53 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=54 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=55 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=56 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=57 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=58 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=59 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=60 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=61 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=62 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=63 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=64 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=65 ttl=100 time=49.2 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=66 ttl=100 time=49.2 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=67 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=68 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=69 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=70 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=71 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=72 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=73 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=74 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=75 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=76 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=77 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=78 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=79 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=80 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=81 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=82 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=83 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=84 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=85 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=86 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=87 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=88 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=89 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=90 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=91 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=92 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=93 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=94 ttl=100 time=48.9 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=95 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=96 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=97 ttl=100 time=49.0 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=98 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=99 ttl=100 time=49.1 ms
64 bytes from den02s01-in-f4.1e100.net (172.217.11.228): icmp_seq=100 ttl=100 time=49.1 ms

--- www.google.com ping statistics ---
100 packets transmitted, 100 received, 0% packet loss, time 99113ms
rtt min/avg/max/mdev = 48.991/49.229/54.308/0.683 ms
{root@bandore1 tmp}$
```

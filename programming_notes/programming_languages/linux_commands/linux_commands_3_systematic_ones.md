

# SELinux

- 查看SELinux状态&关闭SELinux https://blog.csdn.net/GGxiaobai/article/details/53505095
```
1.1 getenforce
    getenforce 命令是单词get（获取）和enforce(执行)连写，可查看selinux状态，与setenforce命令相反。
    setenforce 命令则是单词set（设置）和enforce(执行)连写，用于设置selinux防火墙状态，如： setenforce 0用于关闭selinux防火墙，但重启后失效
1.2 /usr/sbin/sestatus
    SELinux status：selinux防火墙的状态，enabled表示启用selinux防火墙
    Current mode： selinux防火墙当前的安全策略，enforcing 表示强

2.1 临时关闭
    setenforce 0 ：用于关闭selinux防火墙，但重启后失效。
2.1 永久关闭
    修改selinux的配置文件，重启后生效。
```

```
实战：

test@cloudsec1 ~ $ getenforce
Permissive
test@cloudsec1 ~ $ sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   permissive
Mode from config file:          permissive
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Max kernel policy version:      31

//将 /etc/selinux/config 的 SELINUX= 改为enforcing
root@cloudsec1 ~ $ vi /etc/selinux/config
root@cloudsec1 ~ $ reboot

test@cloudsec1 ~ $ getenforce
Enforcing
test@cloudsec1 ~ $ sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   enforcing
Mode from config file:          enforcing
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Max kernel policy version:      31
```

- 一文彻底明白linux中的selinux到底是什么 https://blog.csdn.net/yanjun821126/article/details/80828908
- Selinux详细讲解及相关的配置 https://blog.csdn.net/Kangshuo2471781030/article/details/79294506
- Selinux小结 https://blog.csdn.net/gulinxieying/article/details/78677139

# sed

linux sed命令详解 https://www.cnblogs.com/ggjucheng/archive/2013/01/13/2856901.html
```
[root@www ~]# sed [-nefr] [动作]
选项与参数：
-n ：使用安静(silent)模式。在一般 sed 的用法中，所有来自 STDIN 的数据一般都会被列出到终端上。但如果加上 -n 参数后，则只有经过sed 特殊处理的那一行(或者动作)才会被列出来。
-e ：直接在命令列模式上进行 sed 的动作编辑；
-f ：直接将 sed 的动作写在一个文件内， -f filename 则可以运行 filename 内的 sed 动作；
-r ：sed 的动作支持的是延伸型正规表示法的语法。(默认是基础正规表示法语法)
-i ：直接修改读取的文件内容，而不是输出到终端。

动作说明： [n1[,n2]]function
n1, n2 ：不见得会存在，一般代表『选择进行动作的行数』，举例来说，如果我的动作是需要在 10 到 20 行之间进行的，则『 10,20[动作行为] 』

function：
a ：新增， a 的后面可以接字串，而这些字串会在新的一行出现(目前的下一行)～
c ：取代， c 的后面可以接字串，这些字串可以取代 n1,n2 之间的行！
d ：删除，因为是删除啊，所以 d 后面通常不接任何咚咚；
i ：插入， i 的后面可以接字串，而这些字串会在新的一行出现(目前的上一行)；
p ：列印，亦即将某个选择的数据印出。通常 p 会与参数 sed -n 一起运行～
s ：取代，可以直接进行取代的工作哩！通常这个 s 的动作可以搭配正规表示法！例如 1,20s/old/new/g 就是啦！
```

## 以行为单位的新增/删除

> 将 /etc/passwd 的内容列出并且列印行号，同时，请将第 2~5 行删除！
```
[root@www ~]# nl /etc/passwd | sed '2,5d'
1 root:x:0:0:root:/root:/bin/bash
6 sync:x:5:0:sync:/sbin:/bin/sync
7 shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
.....(后面省略).....
```

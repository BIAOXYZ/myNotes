
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

```
实战2：只是改完但不重启的话，/etc/selinux/config文件是改了，
但是sestatus命令显示结果上有一点不同，getenforce命令显示结果不变，其他影响未知。

[root@openshiftsingle ~]# getenforce
Permissive
[root@openshiftsingle ~]# sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   permissive
Mode from config file:          permissive
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Max kernel policy version:      31

----------------------------------------------------------------------------------------------------

//看看未修改前的/etc/selinux/config文件。
[root@openshiftsingle ~]# cd /etc/selinux/
[root@openshiftsingle selinux]# cat config

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=permissive
# SELINUXTYPE= can take one of three two values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted

----------------------------------------------------------------------------------------------------

//用sed语句直接修改。
[root@openshiftsingle selinux]# sed -i 's/SELINUX=permissive/SELINUX=enforcing/' /etc/selinux/config

----------------------------------------------------------------------------------------------------

//改完后看下/etc/selinux/config文件，文件内容肯定是已经改了的————只有一处，非常明显。
[root@openshiftsingle selinux]# cat config

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=enforcing
# SELINUXTYPE= can take one of three two values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted

----------------------------------------------------------------------------------------------------

//注意这里Current mode的值还是permissive，但是Mode from config file的值已经是enforcing了。
[root@openshiftsingle ~]# getenforce
Permissive
[root@openshiftsingle selinux]# sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   permissive
Mode from config file:          enforcing
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Max kernel policy version:      31
```

- 一文彻底明白linux中的selinux到底是什么 https://blog.csdn.net/yanjun821126/article/details/80828908
- Selinux详细讲解及相关的配置 https://blog.csdn.net/Kangshuo2471781030/article/details/79294506
- Selinux小结 https://blog.csdn.net/gulinxieying/article/details/78677139

# AppArmor

AppArmor https://zh.wikipedia.org/wiki/AppArmor

AppArmor https://wiki.archlinux.org/index.php/AppArmor

# 小专题

## Linux输密码时显示星号

如何在Linux中输入Sudo密码时显示星号 https://www.howtoing.com/show-asterisks-sudo-password-in-linux

## 脚本彩色输出

shell脚本输出输出带颜色内容 https://blog.csdn.net/David_Dai_1108/article/details/70478826

【by 直死之邪王灼眼】 Linux之Shell脚本自动化编程四（命令排序，元字符，echo实现彩色输出和printf） https://www.bilibili.com/read/cv933397/

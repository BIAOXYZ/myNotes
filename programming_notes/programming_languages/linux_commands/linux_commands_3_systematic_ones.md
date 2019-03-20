

## SELinux

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
```

- 一文彻底明白linux中的selinux到底是什么 https://blog.csdn.net/yanjun821126/article/details/80828908
- Selinux详细讲解及相关的配置 https://blog.csdn.net/Kangshuo2471781030/article/details/79294506
- Selinux小结 https://blog.csdn.net/gulinxieying/article/details/78677139



# 源头

CDL的x86 quota已经满了，然后某天新员工突然跟我说她看到P类型的机器还有很多quota，问那个能行吗？

# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

# 个人实战

```sh
# 我哪想到Power的OCP集群连OS都直接是RH 8。。。
[root@powerocp-inf ~]# arch
ppc64le
[root@powerocp-inf ~]# cat /etc/os-release
NAME="Red Hat Enterprise Linux"
VERSION="8.2 (Ootpa)"
ID="rhel"
ID_LIKE="fedora"
VERSION_ID="8.2"
PLATFORM_ID="platform:el8"
PRETTY_NAME="Red Hat Enterprise Linux 8.2 (Ootpa)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:redhat:enterprise_linux:8.2:GA"
HOME_URL="https://www.redhat.com/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"

REDHAT_BUGZILLA_PRODUCT="Red Hat Enterprise Linux 8"
REDHAT_BUGZILLA_PRODUCT_VERSION=8.2
REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux"
REDHAT_SUPPORT_PRODUCT_VERSION="8.2"
[root@powerocp-inf ~]#

# 对比下另一台x86机器的查询结果
[root@anaemia-inf ~]# arch
x86_64
```

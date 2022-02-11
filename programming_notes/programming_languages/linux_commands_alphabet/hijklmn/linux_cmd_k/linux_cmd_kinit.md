
# 源头

# 相关命令
- [`klist`](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/klist)

# 官方链接

Q: How do I configure SSH to always delegate my Kerberos tickets? http://kb.mit.edu/confluence/pages/viewpage.action?pageId=4981397

How to configure kerberos and SSH https://www.pdc.kth.se/support/documents/login/configuration.html

# 已有书籍类链接

# 相关wiki链接

Kerberos https://zh.wikipedia.org/wiki/Kerberos

kinit(1) - Linux man page https://linux.die.net/man/1/kinit

# 其他博客类链接

Kerberos+SSH安装配置使用教程 https://www.cnblogs.com/lsdb/p/11309245.html

# 个人实战

## 1.

```sh
$ cat login.sh
#!/bin/bash
CURR_DIR=$(dirname $0)
$CURR_DIR/remoteMachine.exp
ssh <your_user_name_on_remote_machine>@<your_ip_or_host_name>
$ 
$ cat remoteMachine.exp
#!/usr/bin/expect
spawn kinit <your_user_name_of_email>@<email_server_suffix>
expect "<your_user_name_of_email>@<email_server_suffix>'s password:"
send "<your_password>\n"
interact
$ 
$ ./login.sh
```

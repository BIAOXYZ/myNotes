
# 相关命令

- `sudo`
- `visudo`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

su (Unix) https://en.wikipedia.org/wiki/Su_(Unix)
```sh
john@localhost:~$ su jane
Password:
jane@localhost:/home/john$ exit
logout
john@localhost:~$

When used with a hyphen (su -) it can be used to start a login shell. In this mode users can assume 
the user environment of the target user:

john@localhost:~$ su - jane
Password:
jane@localhost:~$
```
- > The command sudo is related, and executes a command as another user but observes a set of constraints about which users can execute which commands as which other users (generally in a configuration file named /etc/sudoers, best editable by the command visudo). Unlike su, sudo authenticates users against their own password rather than that of the target user (to allow the delegation of specific commands to specific users on specific hosts without sharing passwords among them and while mitigating the risk of any unattended terminals).
- > Some Unix-like systems implement the user group wheel, and only allow members to become root with su. This may or may not mitigate these security concerns, since an intruder might first simply break into one of those accounts. GNU su, however, does not support the group wheel for philosophical reasons. Richard Stallman argues that because the group would prevent users from utilizing root passwords leaked to them, the group would allow existing admins to ride roughshod over ordinary users. 

su (Unix) https://zh.wikipedia.org/wiki/Su_(Unix)
- > 相关的命令sudo也可以允许以另一个用户的身份执行命令，但遵守一组的限制，以决定哪些用户可以以什么用户身份执行什么命令（通常是在配置文件/etc/sudoers中，最好使用visudo编辑）。与su不同的是，sudo验证的是用户自己的密码，而不是目标用户的（允许特定主机上的特定用户执行特定命令，而不用共享密码，同时减轻无人值守终端的风险）。
- > 一些类Unix系统有wheel组，且只允许组内用户su到root。很难说这是否会降低安全风险，因为入侵者可能会轻易入侵其中一个帐户。然而，由于理念不同，GNU su不支持wheel组。理查德·斯托曼认为，由于wheel组会阻止用户使用泄露给他们root密码，现有的管理员就可以欺压普通用户。

# 其他博客类链接

Linux su命令 https://www.runoob.com/linux/linux-comm-su.html 

Linux下su与su -命令的区别 https://www.cnblogs.com/gaoxinzhan/p/4344681.html
- > 在启动服务器ntpd服务时遇到一个问题：使用 su root 切换到root用户后，不可以使用service命令；使用 su - 后，就可以使用service命令了。
- > su命令和su -命令区别就是：
  * > su只是切换了root身份，但Shell环境仍然是普通用户的Shell；而su -连用户和Shell环境一起切换成root身份了。只有切换了Shell环境才不会出现PATH环境变量错误，报command not found的错误。
  * > su切换成root用户以后，pwd一下，发现工作目录仍然是普通用户的工作目录；而用su -命令切换以后，工作目录变成root的工作目录了。

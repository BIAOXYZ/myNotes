
# 相关命令

- `sudo`

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

# 其他博客类链接

Linux su命令 https://www.runoob.com/linux/linux-comm-su.html 

Linux下su与su -命令的区别 https://www.cnblogs.com/gaoxinzhan/p/4344681.html
- > 在启动服务器ntpd服务时遇到一个问题：使用 su root 切换到root用户后，不可以使用service命令；使用 su - 后，就可以使用service命令了。
- > su命令和su -命令区别就是：
  * > su只是切换了root身份，但Shell环境仍然是普通用户的Shell；而su -连用户和Shell环境一起切换成root身份了。只有切换了Shell环境才不会出现PATH环境变量错误，报command not found的错误。
  * > su切换成root用户以后，pwd一下，发现工作目录仍然是普通用户的工作目录；而用su -命令切换以后，工作目录变成root的工作目录了。

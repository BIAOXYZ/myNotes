
# 相关命令

- `spawn`
- `send`
- `tclsh`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

每次进步一点点——linux expect 使用 https://blog.csdn.net/houmou/article/details/53102051
```sh
yum 安装
yum install -y expect

源码编译安装
expect 依赖于 tcl, 所以需要首先安装 tcl。可以使用rpm检查是否已经安装tcl:
rpm -qa | grep tcl
```

使用expect在script中切换到root用户 https://www.cnblogs.com/gx-303841541/archive/2012/11/08/2761679.html

Ubuntu使用Spawn和expect实现ssh自动登陆 https://blog.csdn.net/donglynn/article/details/51536212
```sh
使用以下代码检测expect是否已经安装
ls /usr/bin | grep expect 

如果显示为空，则使用以下命令安装
sudo apt-get install tcl tk expect
```

Linux下使用expect命令编写自动化交互脚本 https://www.jb51.net/article/151099.htm

# 个人实战

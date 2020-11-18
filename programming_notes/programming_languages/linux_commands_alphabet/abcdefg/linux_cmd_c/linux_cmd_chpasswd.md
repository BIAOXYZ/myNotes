
# 源头

SUSE修改密码出现“passwd: Have exhausted maximum number of retries for service” https://blog.csdn.net/lufeisan/article/details/54018824
```console
host1:~ # echo password|passwd --stdin username
Changing password for username
passwd: Have exhausted maximum number of retries for service

方法一：修改/etc/pam.d/common-password
password        required        pam_pwhistory.so        remember=5 retry=3
修改remember参数为1，修改完密码之后再将参数恢复。

若方法一不生效：
可以尝试改用密码chpasswd修改username的密码：
echo 'username:password' |chpasswd
```

>> //notes：尽管我是在CentOS 7.6碰到这个问题的，但是解决方法和上面帖子里那个Suse的一样。我是直接用chpasswd替代，根本没试那个改配置文件的方法，没必要。

# 相关命令

- `passwd`
- `useradd`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

# 个人实战

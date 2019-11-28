
# 相关命令

- `ls`
- `vdir`
- `dirs` // 这个只是长得像，`dirs`是和`pushd`，`popd`一起用的。

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

Difference between 'dir' and 'ls' terminal commands? https://askubuntu.com/questions/103913/difference-between-dir-and-ls-terminal-commands
```
`dir` and `ls` are part of `coreutils` and `dir` is almost the same as `ls`, just with different default options.
    The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system. 
    These are the core utilities which are expected to exist on every operating system.

`info dir` says:
    `dir` is equivalent to `ls -C -b`; that is, by default files are listed in columns, sorted vertically, 
    and special characters are represented by backslash escape sequences.

Oh and there is also `vdir`! `info vdir` says:
    `vdir` is equivalent to `ls -l -b`; that is, by default files are listed in long format and special characters are 
    represented by backslash escape sequences.

Most likely `dir` exists for backwards compatibility or due to historical reasons.
```

# 个人实战

```sh
harbor3:/etc/zypp # dir
total 32
drwxr-xr-x 1 root root     0 Jun 30  2017 credentials.d
drwxr-xr-x 1 root root     0 Jun 30  2017 multiversion.d
drwxr-xr-x 1 root root    88 Nov  5 16:48 repos.d
drwxr-xr-x 1 root root     0 Jun 30  2017 services.d
-rw-r--r-- 1 root root   360 Nov 29  2016 systemCheck
drwxr-xr-x 1 root root     0 Jun 30  2017 systemCheck.d
drwxr-xr-x 1 root root     0 Jun 30  2017 vendors.d
-rw-r--r-- 1 root root 19584 Apr 21  2017 zypp.conf
-rw-r--r-- 1 root root  7301 Nov 29  2016 zypper.conf

# 注：vdir显示的目录也是白色的，和文件的颜色一样。
harbor3:/etc/zypp # vdir
total 32
drwxr-xr-x 1 root root     0 Jun 30  2017 credentials.d
drwxr-xr-x 1 root root     0 Jun 30  2017 multiversion.d
drwxr-xr-x 1 root root    88 Nov  5 16:48 repos.d
drwxr-xr-x 1 root root     0 Jun 30  2017 services.d
-rw-r--r-- 1 root root   360 Nov 29  2016 systemCheck
drwxr-xr-x 1 root root     0 Jun 30  2017 systemCheck.d
drwxr-xr-x 1 root root     0 Jun 30  2017 vendors.d
-rw-r--r-- 1 root root 19584 Apr 21  2017 zypp.conf
-rw-r--r-- 1 root root  7301 Nov 29  2016 zypper.conf

harbor3:/etc/zypp # ls
credentials.d  multiversion.d  repos.d  services.d  systemCheck  systemCheck.d  vendors.d  zypp.conf  zypper.conf
harbor3:/etc/zypp # ls -C -b
credentials.d  multiversion.d  repos.d  services.d  systemCheck  systemCheck.d  vendors.d  zypp.conf  zypper.conf
harbor3:/etc/zypp # ls -l -b
total 32
drwxr-xr-x 1 root root     0 Jun 30  2017 credentials.d
drwxr-xr-x 1 root root     0 Jun 30  2017 multiversion.d
drwxr-xr-x 1 root root    88 Nov  5 16:48 repos.d
drwxr-xr-x 1 root root     0 Jun 30  2017 services.d
-rw-r--r-- 1 root root   360 Nov 29  2016 systemCheck
drwxr-xr-x 1 root root     0 Jun 30  2017 systemCheck.d
drwxr-xr-x 1 root root     0 Jun 30  2017 vendors.d
-rw-r--r-- 1 root root 19584 Apr 21  2017 zypp.conf
-rw-r--r-- 1 root root  7301 Nov 29  2016 zypper.conf
```

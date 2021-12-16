
# 相关命令

- `su`
- `visudo`
- `chroot`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

sudo https://en.wikipedia.org/wiki/Sudo

# 其他博客类链接

关于 sudo 命令的一些配置和使用技巧 http://kuanghy.github.io/2019/11/17/linux-sudo || https://github.com/kuanghy/kuanghy.github.io/blob/master/_posts/2019-11-17-linux-sudo.md
- > `sudo` 表示 “superuser do”。 它允许已验证的用户以其他用户的身份来运行命令。其他用户可以是普通用户或者超级用户。然而，大部分时候我们用它来提权运行命令，以替代直接使用 root 用户的操作。
- > `sudo` 命令与安全策略配合使用，安全策略可以通过文件 `/etc/sudoers` 来配置。其安全策略具有高度可拓展性，支持插件扩展。
- > 默认情况下 `/etc/sudoers` 是不能被任何人直接编辑的，因为它的权限是 440，虽然也可以对其赋予写权限后再编辑，但推荐使用 `visudo` 命令编辑该文件。

如何在 Linux 中配置 sudo 访问权限 https://linux.cn/article-10746-1.html || How To Configure sudo Access In Linux? https://www.2daygeek.com/how-to-configure-sudo-access-in-linux/

linux 为普通用户配置sudo权限 https://www.cnblogs.com/renshengdezheli/p/13950504.html

# 个人实战

## 技巧1：不用root密码切换到root用户
```sh
# 可以从master节点连到work1节点的core用户： ssh core@worker1.apmsvtocp5.os.fyre.ibm.com
# 但是连过去以后直接执行 find / -name klusterlet 会得到一堆 Permission denied
# work1节点的root密码保密不能说，此时可以用 sudo su - 无密码直接切换到root（应该是core用户必须在sudo组才行，见下述cat命令）

[core@worker1 kubernetes]$ sudo su -
Last login: Wed Mar  4 02:40:31 UTC 2020 on pts/0
[root@worker1 ~]#
[root@worker1 ~]# find / -name klusterlet
find: ‘/proc/102157’: No such file or directory
/sysroot/ostree/deploy/rhcos/var/lib/containers/storage/overlay/e50303f798c337e80e83e84ebcbc533bff192269f021531de59d790a1e9a9e93/diff/run/klusterlet
find: ‘/sysroot/ostree/deploy/rhcos/var/lib/containers/storage/overlay/f0ca9d0215d53ec49009038f47327851027cc94cf1eaa89ae37f13adb67eec4f’: No such file or directory
/sysroot/ostree/deploy/rhcos/var/lib/containers/storage/overlay/5e34dba0bbab18f7537a002a79d7bf86ac1e5268412d4ed7c0482a3d4f7f32c5/diff/run/klusterlet
find: ‘/sysroot/ostree/deploy/rhcos/var/lib/containers/storage/overlay/60a7abec4c29fedab984aeeb7f0e81e751fe2cb48a6f12a3aa2be5f8b1488a51’: No such file or directory
/sysroot/ostree/deploy/rhcos/var/lib/containers/storage/overlay/f2e0cbc182b69c80dba6c8a6846211fab824da7d7966991d109f4a73bb8d8ce9/diff/klusterlet
/sysroot/ostree/deploy/rhcos/var/lib/containers/storage/overlay/88558b134f5dc58e0aeb42ba5385e697298fd41aeddfabee083683fb9456f705/diff/etc/klusterlet
/sysroot/ostree/deploy/rhcos/var/lib/containers/storage/overlay/6b132e23e27548bc29b84d9fde04c7c136e7c6ba2ce8ebdbc1538c8f16e50a08/diff/run/klusterlet
find: File system loop detected; ‘/sysroot/ostree/deploy/rhcos/deploy/a1d1e224755dc6e7f95ff68b66b807f33cf08a3528f9e8e18d9625d58abc14d4.0’ is part of the same file system loop as ‘/’.
/var/lib/containers/storage/overlay/e50303f798c337e80e83e84ebcbc533bff192269f021531de59d790a1e9a9e93/diff/run/klusterlet
/var/lib/containers/storage/overlay/e50303f798c337e80e83e84ebcbc533bff192269f021531de59d790a1e9a9e93/merged/run/klusterlet
/var/lib/containers/storage/overlay/e50303f798c337e80e83e84ebcbc533bff192269f021531de59d790a1e9a9e93/merged/klusterlet
/var/lib/containers/storage/overlay/3509f5aa97e884edb292bf102d74c378c5cc7f16ac37e72927f2d14348995be4/diff/run/klusterlet
/var/lib/containers/storage/overlay/3509f5aa97e884edb292bf102d74c378c5cc7f16ac37e72927f2d14348995be4/merged/run/klusterlet
/var/lib/containers/storage/overlay/f2e0cbc182b69c80dba6c8a6846211fab824da7d7966991d109f4a73bb8d8ce9/diff/klusterlet
/var/lib/containers/storage/overlay/88558b134f5dc58e0aeb42ba5385e697298fd41aeddfabee083683fb9456f705/diff/etc/klusterlet
/var/lib/containers/storage/overlay/88558b134f5dc58e0aeb42ba5385e697298fd41aeddfabee083683fb9456f705/merged/etc/klusterlet
/var/lib/containers/storage/overlay/6b132e23e27548bc29b84d9fde04c7c136e7c6ba2ce8ebdbc1538c8f16e50a08/diff/run/klusterlet
/var/lib/containers/storage/overlay/6b132e23e27548bc29b84d9fde04c7c136e7c6ba2ce8ebdbc1538c8f16e50a08/merged/run/klusterlet
[root@worker1 ~]#
[root@worker1 ~]# cat /etc/group
root:x:0:
adm:x:4:core
wheel:x:10:core
sudo:x:16:core
systemd-journal:x:190:core
core:x:1000:
[root@worker1 ~]#
[root@worker1 ~]# groups core
core : core adm wheel sudo systemd-journal
```

```sh
补充：`sudo -i` 也能达到同样的效果。
```

深入理解 sudo 与 su 之间的区别 https://linux.cn/article-8404-1.html
- > **`su -`**
  * > 那么，`su` 命令与 `su -` 命令之间有什么区别呢？***前者在切换到 root 用户之后仍然保持旧的（或者说原始用户的）环境，而后者则是创建一个新的环境***（由 root 用户 `~/.bashrc` 文件所设置的环境），相当于使用 root 用户正常登录（从登录屏幕登录）。
- > **`sudo su`**
  * > 大概是因为使用 `su` 命令或直接以 root 用户身份登录有风险，所以，一些 Linux 发行版（如 Ubuntu）默认禁用 root 用户帐户。鼓励用户在需要 root 权限时使用 `sudo` 命令。
  * > 然而，***您还是可以成功执行 `su` 命令，而不用输入 root 用户的密码***。运行以下命令：
    ```sh
    sudo su
    ```
    > 由于你使用 sudo 运行命令，你只需要输入当前用户的密码。所以，一旦完成操作，su 命令将会以 root 用户身份运行，这意味着它不会再要求输入任何密码。
  * > PS：如果你想在系统中启用 root 用户帐户（强烈反对，因为你可以使用 sudo 命令或 sudo su 命令），你必须手动设置 root 用户密码，可以使用以下命令：
    ```sh
    sudo passwd root
    ```

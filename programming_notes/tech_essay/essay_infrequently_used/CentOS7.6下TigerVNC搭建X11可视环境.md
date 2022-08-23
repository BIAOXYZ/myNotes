# 0. 参考链接

## 0.1 主参考链接

怎样在 CentOS 7.0 上安装和配置 VNC 服务器 https://linux.cn/article-5335-1.html 【1】 --> 主参考链接

## 0.2 其他参考链接

- CentOS7.2安装VNC，让Windows远程连接CentOS 7.2 图形化界面 https://blog.51cto.com/12217917/2060252 【2】 --> 次要参考链接
- CentOS 7 配置 VNC Server https://qizhanming.com/blog/2018/03/06/how-to-config-vnc-server-on-centos-7 【3】 --> 和【2】基本一样，没有图，但是内容比【2】多一丢丢。最关键的是，后面从Window上用VNC客户端连VNC服务器端的时候，【2】里的`IP:Port`的方法是不对的，【3】里的`IP:数字`才对（更具体点，【2】里使用的`IP:5901`不对，**直接用`IP:1`就好!!!**-->但是不知道有没有可能是因为不同的VNC客户端填法不一样的原因？反正不管了。。。）。
- VNC（虚拟网络计算） https://wiki.centos.org/zh/HowTos/VNC-Server 【4】--> 这个留着当参考了。
- `TigerVNC 1.9.0` Release https://github.com/TigerVNC/tigervnc/releases 【5】 --> 虽然也有人推荐RealVNC，但是想了想还是选择了客户端也用TigerVNC（实际名字叫`vncviewer`）。原因有二：第一，TigerVNC开源的，RealVNC是商业软件（[Comparison_of_remote_desktop_software](https://en.wikipedia.org/wiki/Comparison_of_remote_desktop_software)）；第二，服务器端既然用的TigerVNC，客户端也用TigerVNC吧。

***后来的参考链接***：
- How to Install and Configure VNC Server in CentOS 7 https://www.tecmint.com/install-and-configure-vnc-server-in-centos-7/ 【这个后面演示用的是RealVNC家的VNC Viewer去连接服务器端。】
- https://www.linuxtechi.com/install-configure-vnc-server-centos-7-rhel-7/ 【这个后面是用哪家的vncview演示给忘了。。。以前还下载下来过的说。】

## 0.3 问题

### 0.3.1 `vncserver@1.service`起不来

周六在家安好后，搞容器的debuger去了。我确定过程中`vncserver@1.service`已经start和enable了。但是周一来到单位后查了下`vncserver@1.service`的状态发现没起来。这就罢了，然后执行`systemctl start vncserver@1.service`都起不来。根据提示用`journalctl -xe`看了下日志，还没看完呢，网络闪断了一下，MobaXterm连接断开了。重连上以后，也不知道怎么想的，鬼使神差执行了一下`systemctl daemon-reload`，然后再查了下服务状态，好了。。。

```sh
[root@temptest ~]# systemctl status vncserver@1.service
● vncserver@1.service - Remote desktop service (VNC)
   Loaded: loaded (/usr/lib/systemd/system/vncserver@.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
[root@temptest ~]# systemctl start vncserver@1.service
Job for vncserver@1.service failed because the control process exited with error code. See "systemctl status vncserver@1.service" and "journalctl -xe" for details.
[root@temptest ~]# journalctl -xe
-- A new session with the ID 62 has been created for the user root.
--
-- The leading process of the session is 9114.
Jul 07 21:13:24 temptest.sl.cloud9.ibm.com systemd[1]: Started Session 62 of user root.
-- Subject: Unit session-62.scope has finished start-up
-- Defined-By: systemd
-- Support: http://lists.freedesktop.org/mailman/listinfo/systemd-devel
--
-- Unit session-62.scope has finished starting up.
--
-- The start-up result is done.
Jul 07 21:13:24 temptest.sl.cloud9.ibm.com sshd[9114]: pam_unix(sshd:session): session opened for user root by (uid=0)
Jul 07 21:15:12 temptest.sl.cloud9.ibm.com polkitd[2579]: Registered Authentication Agent for unix-process:9858:19779676 (syste
Jul 07 21:15:12 temptest.sl.cloud9.ibm.com systemd[1]: Starting Remote desktop service (VNC)...
-- Subject: Unit vncserver@1.service has begun start-up
-- Defined-By: systemd
-- Support: http://lists.freedesktop.org/mailman/listinfo/systemd-devel
--
-- Unit vncserver@1.service has begun starting up.
Jul 07 21:15:12 temptest.sl.cloud9.ibm.com runuser[9867]: runuser: user <USER> does not exist
Jul 07 21:15:12 temptest.sl.cloud9.ibm.com systemd[1]: vncserver@1.service: control process exited, code=exited status=1
Jul 07 21:15:12 temptest.sl.cloud9.ibm.com systemd[1]: Failed to start Remote desktop service (VNC).
-- Subject: Unit vncserver@1.service has failed
-- Defined-By: systemd
-- Support: http://lists.freedesktop.org/mailman/listinfo/systemd-devel
--
-- Unit vncserver@1.service has failed.
--
-- The result is failed.
Jul 07 21:15:12 temptest.sl.cloud9.ibm.com systemd[1]: Unit vncserver@1.service entered failed state.
Jul 07 21:15:12 temptest.sl.cloud9.ibm.com systemd[1]: vncserver@1.service failed.
Jul 07 21:15:12 temptest.sl.cloud9.ibm.com polkitd[2579]: Unregistered Authentication Agent for unix-process:9858:19779676 (sys
lines 1661-1692/1692 (END)
```

解决方法是执行了一下`systemctl daemon-reload`就好了（我看了几遍这个现象前后的过程，确定**上个`systemctl start vncserver@1.service`失败后没有再启动过这个服务**——也就是说，看现象是只`systemctl daemon-reload`一下就好了。不过这个也无所谓了，反正要是还是不行，就再启动一下服务。。。不行再daemon-reload再启）。
```sh
[root@temptest ~]# systemctl daemon-reload
[root@temptest ~]# systemctl status vncserver@:1.service
● vncserver@:1.service - Remote desktop service (VNC)
   Loaded: loaded (/etc/systemd/system/vncserver@:1.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2019-07-05 14:41:37 CDT; 2 days ago
 Main PID: 653 (Xvnc)
   CGroup: /system.slice/system-vncserver.slice/vncserver@:1.service
           ‣ 653 /usr/bin/Xvnc :1 -auth /root/.Xauthority -desktop temptest.sl.cloud9.ibm.com:1 (root) -fp catalogue:/etc/X1...

Jul 05 14:41:34 temptest.sl.cloud9.ibm.com systemd[1]: Starting Remote desktop service (VNC)...
Jul 05 14:41:37 temptest.sl.cloud9.ibm.com systemd[1]: Started Remote desktop service (VNC).

# 看了下防火墙一直没开过，所以肯定不是防火墙有啥影响。
[root@temptest ~]# systemctl status firewalld
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; disabled; vendor preset: enabled)
   Active: inactive (dead)
     Docs: man:firewalld(1)
```


## 0.4 TODO

我发现了，绝大部分（不过真的不是100%，和工作紧密相关的topic或者很感兴趣的topic还是会跟下去直到解决或部分解决）TODO都是没有往下继续跟踪的。对不起，TODO是不可能DO的，这辈子都不可能DO的:dog:。

# 1. 配置CentOS上的VNC server端

```sh
[root@temptest packages]# yum check-update
//省略输出
[root@temptest packages]# yum -y groupinstall "X Window System"
...
...
...
Transaction Summary
===========================================================================================================================================================
Install  11 Packages (+272 Dependent packages)
Upgrade              (   5 Dependent packages)

Total download size: 171 M
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/288): NetworkManager-wifi-1.12.0-10.el7_6.x86_64.rpm                                                                             | 187 kB  00:00:02     
(2/288): ModemManager-glib-1.6.10-1.el7.x86_64.rpm                                                                                  | 231 kB  00:00:03     
(3/288): GConf2-3.2.6-8.el7.x86_64.rpm                                                                                              | 1.0 MB  00:00:06 
...
...
...


[root@temptest packages]# yum -y install gnome-classic-session gnome-terminal nautilus-open-terminal control-center liberation-mono-fonts
...
...
...
Transaction Summary
===========================================================================================================================================================
Install  5 Packages (+137 Dependent packages)

Total download size: 75 M
Installed size: 303 M
Downloading packages:
(1/142): accountsservice-libs-0.6.50-4.el7.1.x86_64.rpm                                                                             |  80 kB  00:00:02     
(2/142): accountsservice-0.6.50-4.el7.1.x86_64.rpm                                                                                  |  98 kB  00:00:02     
(3/142): adwaita-gtk2-theme-3.28-2.el7.x86_64.rpm                                                                                   | 134 kB  00:00:02 
...
...
...


# /etc/systemd/system/default.target是个软链接，上面步骤执行完成后长这样：
## default.target -> /lib/systemd/system/multi-user.target
# 这两句的作用是删除掉原来的软链接（删软链接安全起见最好用unlink），再新建一个。新的软链接长这样：
## default.target -> /lib/systemd/system/graphical.target
[root@temptest packages]# unlink /etc/systemd/system/default.target
[root@temptest packages]# ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target
[root@temptest packages]#
[root@temptest packages]# reboot
连接断开
连接成功
Last login: Fri Jul  5 13:48:40 2019 from 9.200.45.42
[root@temptest ~]# 
[root@temptest ~]# yum install tigervnc-server -y
//省略输出
[root@temptest ~]# cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service
[root@temptest ~]# 


#// 新版本下`vi /etc/systemd/system/vncserver\@\:1.service`打开后，这个文件的内容和以前不一样了。
#// 从下面贴的内容看，<USER>只需要替换一处了（原来是改两处并且root和普通用户不一样）。但是要额外去改
#// 另外一个脚本：/usr/bin/vncserver_wrapper  
##// -->  后来我打开看了看感觉这个脚本没啥可改的啊，就没改。事实证明也确实如此。
##// 所以新版现在更简单了，只需要替换一处<USER>即可。
``
# Quick HowTo:
# 1. Copy this file to /etc/systemd/system/vncserver@.service
# 2. Replace <USER> with the actual user name and edit vncserver
#    parameters in the wrapper script located in /usr/bin/vncserver_wrapper
# 3. Run `systemctl daemon-reload`
# 4. Run `systemctl enable vncserver@:<display>.service`

# Clean any existing files in /tmp/.X11-unix environment
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/usr/bin/vncserver_wrapper <USER> %i
ExecStop=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
``
[root@temptest ~]# vi /etc/systemd/system/vncserver\@\:1.service
[root@temptest ~]#
[root@temptest ~]# systemctl daemon-reload
[root@temptest ~]# 


# 这里攻略里没提到，网上搜了搜感觉都是选n
## 后续补充：如果时间比较久，该密码不小心忘记了，只需完全按照下面的步骤重新设置vnc登陆密码即可。
## 也有攻略提到先删除 ~/.vnc/passwd 文件再重新设置。但是我的机器（root用户）直接重新设置就可以，不需要删除文件这个步骤。
[root@temptest ~]# vncpasswd
Password:
Verify:
Would you like to enter a view-only password (y/n)? n
A view-only password is not used

[root@temptest ~]# 
[root@temptest ~]# sudo systemctl enable vncserver@:1.service
Created symlink from /etc/systemd/system/multi-user.target.wants/vncserver@:1.service to /etc/systemd/system/vncserver@:1.service.
[root@temptest ~]# sudo systemctl start vncserver@:1.service

# 最后防火墙那步没配，因为看了下本机防火墙就是关的。
[root@temptest ~]# systemctl status firewalld
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; disabled; vendor preset: enabled)
   Active: inactive (dead)
     Docs: man:firewalld(1)
```

至此，VNC服务器端安装完成，此时再下个firefox就可以直接打开了（不过firefox能打开主要是X11 Window System装了的原因吧。。。）
```sh
yum install -y firefox
firefox
```

# 2. 配置VNC的客户端

## 2.1 配置Windows 10上的VNC客户端（用的依然是`TigerVNC家的vncviewer`，更具体点：`vncviewer64-1.9.0.exe`）

https://github.com/TigerVNC/tigervnc/releases 【千万不要再被那个[~~TightVNC~~](https://www.tightvnc.com/download.php)给坑了，它的客户端不好用。另外RealVNC家的VNC Viewer也就那样，连上之后会显示花屏。。。所以，还是窝老虎头VNC好用呀，不管客户端还是服务器端都是它。】
- https://github.com/TigerVNC/tigervnc/releases/tag/v1.9.0  -->  https://bintray.com/tigervnc/stable/download_file?file_path=vncviewer64-1.9.0.exe
- https://github.com/TigerVNC/tigervnc/releases/tag/v1.10.0  -->  https://bintray.com/tigervnc/stable/download_file?file_path=vncviewer64-1.10.0.exe

```console
客户端访问

- 下载 VNC Viewer
- 设置如下：
VNC Server: YOUR_SERVER_IP:1
Name: YOUR_Display_1

- 连接之后，输入 admin 的 vpnpasswd，既可看到界面了。
```
>> //notes：用老虎头VNC的viewer（RealVNC家的VNC Viewer也是一样的）好像都不用这些，就是双击打开，输入类似`9.46.89.76:1`，点击`Connect`然后输入之前`vncpasswd`命令设置的密码即可。

## 2.2 配置CentOS服务器本机上的VNC客户端（TODO）

```sh
[root@temptest packages]# wget https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-1.9.0.x86_64.tar.gz
[root@temptest packages]# tar zxvf download_file\?file_path\=tigervnc-1.9.0.x86_64.tar.gz
[root@temptest packages]# ll
total 9128
-rw-r--r--. 1 root root 9324157 Jul 16  2018 download_file?file_path=tigervnc-1.9.0.x86_64.tar.gz
drwxrwxr-x. 3 4011 4011    4096 Jul 16  2018 tigervnc-1.9.0.x86_64

[root@temptest packages]# cd tigervnc-1.9.0.x86_64/
[root@temptest tigervnc-1.9.0.x86_64]# ll
total 4
drwxrwxr-x. 6 4011 4011 4096 Jul 16  2018 usr

[root@temptest tigervnc-1.9.0.x86_64]# cd usr/
[root@temptest usr]# ll
total 16
drwxrwxr-x. 2 4011 4011 4096 Jul 16  2018 bin
drwxrwxr-x. 2 4011 4011 4096 Jul 16  2018 lib
drwxrwxr-x. 3 4011 4011 4096 Jul 16  2018 lib64
drwxrwxr-x. 8 4011 4011 4096 Jul 16  2018 share

[root@temptest usr]# cd bin/
[root@temptest bin]# ll
total 16948
-rwxr-xr-x. 1 4011 4011  215264 Jul 16  2018 vncconfig
-rwxr-xr-x. 1 4011 4011  115992 Jul 16  2018 vncpasswd
-rwxr-xr-x. 1 4011 4011   24695 Jul 16  2018 vncserver
-rwxr-xr-x. 1 4011 4011 5452672 Jul 16  2018 vncviewer
-rwxr-xr-x. 1 4011 4011 3849216 Jul 16  2018 x0vncserver
-rwxr-xr-x. 1 4011 4011 7644672 Jul 16  2018 Xvnc

[root@temptest bin]# ./vncviewer

TigerVNC Viewer 64-bit v1.9.0
Built on: 2018-07-16 14:16
Copyright (C) 1999-2018 TigerVNC Team and many others (see README.rst)
See http://www.tigervnc.org for information on TigerVNC.
Fontconfig error: "/etc/fonts/conf.d/10-scale-bitmap-fonts.conf", line 71: non-double matrix element
Fontconfig error: "/etc/fonts/conf.d/10-scale-bitmap-fonts.conf", line 71: non-double matrix element
Fontconfig warning: "/etc/fonts/conf.d/10-scale-bitmap-fonts.conf", line 79: saw unknown, expected number

```

# 3. 后续补充一些VNC操作（TigerVNC）

```sh
[root@temptest ~]# vncserver -h

usage: vncserver [:<number>] [-name <desktop-name>] [-depth <depth>]
                 [-geometry <width>x<height>]
                 [-pixelformat rgbNNN|bgrNNN]
                 [-fp <font-path>]
                 [-cc <visual>]
                 [-fg]
                 [-autokill]
                 [-noxstartup]
                 [-xstartup <file>]
                 <Xvnc-options>...

       vncserver -kill <X-display>

       vncserver -list

[root@temptest ~]#
[root@temptest ~]#
[root@temptest ~]# vncserver -list

TigerVNC server sessions:

X DISPLAY #     PROCESS ID
:1              3296
:3              18873
:2              15024
[root@temptest ~]#
[root@temptest ~]#
[root@temptest ~]# vncserver -kill :2
Killing Xvnc process ID 15024
[root@temptest ~]#
[root@temptest ~]#
[root@temptest ~]# vncserver -list

TigerVNC server sessions:

X DISPLAY #     PROCESS ID
:1              3296
:3              18873


// 完全可以直接跳过 :2 去创建 :4
[root@temptest ~]# vncserver :4

New 'temptest.sl.cloud9.ibm.com:4 (root)' desktop is temptest.sl.cloud9.ibm.com:4

Starting applications specified in /root/.vnc/xstartup
Log file is /root/.vnc/temptest.sl.cloud9.ibm.com:4.log

[root@temptest ~]#
[root@temptest ~]#
[root@temptest ~]# vncserver -list

TigerVNC server sessions:

X DISPLAY #     PROCESS ID
:1              3296
:4              17743
:3              18873


// 我只是想看看版本啊，结果却自己建了个vnc连接？
// 后面还试了--version等也不行。。。
[root@temptest init.d]# vncserver -v

New 'temptest.sl.cloud9.ibm.com:2 (root)' desktop is temptest.sl.cloud9.ibm.com:2

Starting applications specified in /root/.vnc/xstartup
Log file is /root/.vnc/temptest.sl.cloud9.ibm.com:2.log

[root@temptest init.d]#
[root@temptest init.d]# vncserver -list

TigerVNC server sessions:

X DISPLAY #     PROCESS ID
:1              3296
:4              17743
:3              18873
:2              19622

```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 第二部分：后来补充 `本地 Mac + 远程 Debian 9` 下的 VNC 环境配置
>> 【[:star:][`*`]】 //notes：总体来说就是按下面这个帖子一步一步来，帖子写得很完美，除了开始的 `apt install xxx` 命令没有加 `-y` 以外，其他的写得都很具体，和我实战遇到的各种情况（比如目录的位置，文件的名称之类的）都完全一致，***完全不需要我再记录实战过程了***。但是我并没有完全按这个文章来，因为之前在 CentOS 下的一些经验可以复用 + 远程虚拟机和过去的情况不太一样（主要就是公司的 SSH 要求和配置就是垃圾！），所以省略了一些步骤。
>>> 安装完远程服务器端的 `vncserver` 后，本地 Mac 参照 CentOS 部分，同样选择安装了 TigerVNC 家的客户端（客户端名字从过去的 `vncviewer` 改成 `TigerVNC Viewer` 了，把老虎也带到名字里了）。然后顺利连接～

【[:star:][`*`]】 How to Install and Configure VNC on Debian 9 https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-debian-9
- > **Step 1 — Installing the Desktop Environment and VNC Server**
- > **Step 2 — Configuring the VNC Server**
- > **Step 3 — Connecting the VNC Desktop Securely**
  >> //notes：这部分涉及用 SSH tunnel 做转发，~~目前还没有试~~。感觉公司的 SSH 弄的太傻叉了。~~不过回头也可以考虑试试~~。
  >>> 【[:star:][`*`]】 //notes：后来试了试，发现是可以的，SSH 这个软件确实是做得好啊。总体是这样的效果：
  ```sh
  # 1. 在 Mac 上执行完下面这句后，当前命令行窗口就会 hang 住，正常表现。
  # 2. 然后 vnc 客户端可以直接输入 `localhost:1` 去连接 vnc 服务端（当然，用 `<your_server_ip>:1` 照样还是可以的）。
  # --> 但是如果不执行下面这句，vnc 客户端想连接 vnc 服务端就只能用 `<your_server_ip>:1` 的形式。
  $ ssh -L 5901:127.0.0.1:5901 -C -N -l <your_user_name> <your_server_ip>
  $
  ```
- > **Step 4 — Running VNC as a System Service**
  >> //notes：这部分也没有试，感觉没有必要了。

## 其他工作

### 1.安装Chrome

How to Install Google Chrome Web Browser on Debian 9 https://linuxize.com/post/how-to-install-google-chrome-web-browser-on-debian-9/ || How to Install Google Chrome Web Browser on Ubuntu 20.04 https://linuxize.com/post/how-to-install-google-chrome-web-browser-on-ubuntu-20-04/
```sh
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
```

### 2.配置中文
>> 【[:star:][`*`]】 //notes：如果不配置的话，有可能会出现好多小方块（也就是显示错误呗），配置过程 ***主力参考了一个帖子，次要参考了两个帖子***：

Debian 9 stretch源设置，中文乱码解决 https://blog.csdn.net/gong_xucheng/article/details/81114122 || https://www.jianshu.com/p/128ea159b587
>> //notes：这个帖子里每个步骤都做了，除了最后安装包时，`ttf-arphic-uming` 安装不上。后来发现是改名了，改成了 `fonts-arphic-uming`。

debian9 配置中文环境支持 https://www.cnblogs.com/sealin/p/13490743.html
```console
apt-get install fonts-arphic-uming     （百度查都是ttf-arphic-uming ，但安装没有这个包，后来才发现改名了。）
```
>> //notes：这个帖子只用了这一句。

debian，dietpi，linux中文乱码解决方法 https://www.cnblogs.com/Dream998/p/9721212.html
```console
sudo apt-get install ttf-mscorefonts-installer 
sudo fc-cache -f -v  //更新字体缓存
```
>> //notes：这个帖子用了这两句。

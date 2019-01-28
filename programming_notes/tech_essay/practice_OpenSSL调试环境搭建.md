

# 零、OpenSSL调试环境搭建

## 环境信息

- VB CentOS 7.5.2
- 建了一个专门的用户ssluser

## 参考链接

- Openssl代码根目录下的`INSTALL`文件————这个文件可能未来会随着版本更新发生变化噢。  【1】
- OpenSSL Cookbook: Chapter 1. OpenSSL https://www.feistyduck.com/library/openssl-cookbook/online/ch-openssl.html  【2】
```
The next step is to configure OpenSSL before compilation. In most cases, you’ll be leaving the 
system-provided version alone and installing OpenSSL in a different location. For example:

$ ./config \
--prefix=/opt/openssl \
--openssldir=/opt/openssl \
enable-ec_nistp_64_gcc_128
```
- CentOS执行sudo提示xxx is not in the sudoers file https://juejin.im/post/5af3aceaf265da0ba0632ab2  【3】
```
CentOS默认创建的用户并没有sudo命令的执行权限，而且CentOS中也并不存在sudo用户组。
不同于CentOS，Ubuntu在安装后默认创建的用户属于sudo用户组，因此可以使用sudo命令。

可知有两种方法可让指定用户获取sudo权限。

直接给指定用户授权
将指定用户加入wheel用户组


notes: 因为第二种不行，所以最终用了第一种办法，即root用户用visudo编辑。
```
- 解决加载动态链接库时的问题（并没有完全按照这俩帖子里的命令来，而是参考了一些更全面的讲解linux下编译程序的帖子。但是这两个帖子代表了在编译openssl场景下的两种不同的解决方案）：
  * 解决openssl: error while loading shared libraries: libssl.so.1.1: cannot open shared object file: No such file or directory错误 http://www.cnblogs.com/xyb930826/p/6077348.html  【4-1】
  * OpenSSL下载安装 https://www.jianshu.com/p/12a1dc4ab7a0  【4-2】 
- 下面这些存一下吧，比较general但是有干货，这里不标号了。
  - linux找不到动态链接库 .so文件的解决方法 https://blog.csdn.net/gx19862005/article/details/48528235
  - 无root权限下解决编译时的依赖问题 https://www.jianshu.com/p/da92ca36a220
  - linux下静态/动态函数库的原理和编写 https://www.jianshu.com/p/695d16a8947f
    * Linux动态链接库.so文件的创建与使用 https://blog.csdn.net/ithomer/article/details/7346146
  - /etc/ld.so.conf详解 http://www.cnblogs.com/chris-cp/p/3591306.html	


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# 一、搭建过程

## 代码根目录INSTALL文件里的一些说明：

```
 Quick Start
 -----------

 If you want to just get on with it, do:

  on Unix (again, this includes Mac OS/X):

    $ ./config
    $ make
    $ make test
    $ make install
	

 This will build and install OpenSSL in the default location, which is:

  Unix:    normal installation directories under /usr/local
  OpenVMS: SYS$COMMON:[OPENSSL-'version'...], where 'version' is the
           OpenSSL version number with underscores instead of periods.
  Windows: C:\Program Files\OpenSSL or C:\Program Files (x86)\OpenSSL

 If you want to install it anywhere else, run config like this:

  On Unix:

    $ ./config --prefix=/opt/openssl --openssldir=/usr/local/ssl
	
```

```
 Configuration Options
 ---------------------

 There are several options to ./config (or ./Configure) to customize
 the build (note that for Windows, the defaults for --prefix and
 --openssldir depend in what configuration is used and what Windows
 implementation OpenSSL is built on.  More notes on this in NOTES.WIN):


  --debug
                   Build OpenSSL with debugging symbols and zero optimization
                   level.

  --libdir=DIR
                   The name of the directory under the top of the installation
                   directory tree (see the --prefix option) where libraries will
                   be installed. By default this is "lib". Note that on Windows
                   only ".lib" files will be stored in this location. dll files
                   will always be installed to the "bin" directory.

  --openssldir=DIR
                   Directory for OpenSSL configuration files, and also the
                   default certificate and key store.  Defaults are:

                   Unix:           /usr/local/ssl
                   Windows:        C:\Program Files\Common Files\SSL
                                or C:\Program Files (x86)\Common Files\SSL
                   OpenVMS:        SYS$COMMON:[OPENSSL-COMMON]

  --prefix=DIR
                   The top of the installation directory tree.  Defaults are:

                   Unix:           /usr/local
                   Windows:        C:\Program Files\OpenSSL
                                or C:\Program Files (x86)\OpenSSL
                   OpenVMS:        SYS$COMMON:[OPENSSL-'version']
  no-asm
                   Do not use assembler code. This should be viewed as
                   debugging/trouble-shooting option rather than production.
                   On some platforms a small amount of assembler code may
                   still be used even with this option.
 
```

## config-make-make install过程：

```
参考INSTALL文件里的信息，所以最终使用的配置语句是：
./config --prefix=/opt/newssl --openssldir=/opt/newssl --debug

make

[ssluser@localhost openssl]$ sudo make install
[sudo] ssluser 的密码：
ssluser 不在 sudoers 文件中。此事将被报告。

最后用【3】的方案解决了。至此安装完成。
```

## 看看两个版本的openssl有啥异同

```
安装前：
[ssluser@localhost openssl]$ which openssl
/usr/bin/openssl
[ssluser@localhost openssl]$ whereis openssl
openssl: /usr/bin/openssl /usr/lib64/openssl /usr/share/man/man1/openssl.1ssl.gz


安装后：
[ssluser@localhost openssl]$ which openssl
/usr/bin/openssl
[ssluser@localhost openssl]$ whereis openssl
openssl: /usr/bin/openssl /usr/lib64/openssl /opt/newssl/bin/openssl /usr/share/man/man1/openssl.1ssl.gz

所以这里体现出了which和whereis的差距。
```

```
系统自带的openssl：
[ssluser@localhost bin]$ openssl version
OpenSSL 1.0.2k-fips  26 Jan 2017

新安装的openssl：
[ssluser@localhost bin]$ pwd
/opt/newssl/bin
[ssluser@localhost bin]$ ./openssl version
./openssl: error while loading shared libraries: libssl.so.3: cannot open shared object file: No such file or directory
```

## 出现了找不到动态库的问题

```
接着解决动态库加载问题，首先看看哪些动态库加载时找不到：
[ssluser@localhost bin]$ pwd
/opt/newssl/bin
[ssluser@localhost bin]$ ldd openssl
        linux-vdso.so.1 =>  (0x00007ffda9f94000)
        libssl.so.3 => not found
        libcrypto.so.3 => not found
        libdl.so.2 => /lib64/libdl.so.2 (0x00007f58782c1000)
        libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f58780a5000)
        libc.so.6 => /lib64/libc.so.6 (0x00007f5877cd8000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f58784c5000)


看来是`libssl.so.3`和`libcrypto.so.3`找不到。不妨再看看系统已有的openssl是啥情况：
[root@localhost bin]# pwd
/usr/bin
[root@localhost bin]# ldd openssl
        linux-vdso.so.1 =>  (0x00007ffc1a709000)
        libssl.so.10 => /lib64/libssl.so.10 (0x00007f1d87c7f000)
        libgssapi_krb5.so.2 => /lib64/libgssapi_krb5.so.2 (0x00007f1d87a32000)
        libkrb5.so.3 => /lib64/libkrb5.so.3 (0x00007f1d8774a000)
        libcom_err.so.2 => /lib64/libcom_err.so.2 (0x00007f1d87546000)
        libk5crypto.so.3 => /lib64/libk5crypto.so.3 (0x00007f1d87313000)
        libcrypto.so.10 => /lib64/libcrypto.so.10 (0x00007f1d86eb2000)
        libdl.so.2 => /lib64/libdl.so.2 (0x00007f1d86cae000)
        libz.so.1 => /lib64/libz.so.1 (0x00007f1d86a98000)
        libc.so.6 => /lib64/libc.so.6 (0x00007f1d866cb000)
        libkrb5support.so.0 => /lib64/libkrb5support.so.0 (0x00007f1d864bd000)
        libkeyutils.so.1 => /lib64/libkeyutils.so.1 (0x00007f1d862b9000)
        libresolv.so.2 => /lib64/libresolv.so.2 (0x00007f1d860a0000)
        libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f1d85e84000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f1d87ef1000)
        libselinux.so.1 => /lib64/libselinux.so.1 (0x00007f1d85c5d000)
        libpcre.so.1 => /lib64/libpcre.so.1 (0x00007f1d859fb000)

		
看来这个openssl依赖的动态库都在`/lib64`目录下。去这个目录看看，把`libs`开头的都列一下：

lrwxrwxrwx.  1 root root      16 10月 19 10:10 libssh2.so.1 -> libssh2.so.1.0.1
-rwxr-xr-x.  1 root root  174088 3月  10 2016 libssh2.so.1.0.1
-rwxr-xr-x.  1 root root  340976 9月  27 02:37 libssl3.so
-rwxr-xr-x.  1 root root  340832 3月   9 2016 libssl.so.0.9.8e
lrwxrwxrwx.  1 root root      16 10月 19 10:10 libssl.so.10 -> libssl.so.1.0.2k
-rwxr-xr-x.  1 root root  470360 4月  11 2018 libssl.so.1.0.2k
lrwxrwxrwx.  1 root root      16 10月 19 10:11 libssl.so.6 -> libssl.so.0.9.8e
lrwxrwxrwx.  1 root root      12 10月 19 10:10 libss.so.2 -> libss.so.2.0
-rwxr-xr-x.  1 root root   28440 4月  11 2018 libss.so.2.0
```

## 解决找不到动态库的问题

```
//先用第一种方法，建软链接。思想参照了【4-1】，但是语句不一样，过程如下：

[ssluser@localhost lib]$ ln -s /opt/newssl/lib/libssl.so.3 /lib64/libssl.so.3
ln: 无法创建符号链接"/lib64/libssl.so.3": 权限不够

权限不够就换root执行：
[root@localhost etc]# ln -s /opt/newssl/lib/libssl.so.3 /lib64/libssl.so.3
[root@localhost etc]#

加完一个软链接后再去`/lib64`目录下看看（和上面对比，多了一条）：

lrwxrwxrwx.  1 root root      16 10月 19 10:10 libssh2.so.1 -> libssh2.so.1.0.1
-rwxr-xr-x.  1 root root  174088 3月  10 2016 libssh2.so.1.0.1
-rwxr-xr-x.  1 root root  340976 9月  27 02:37 libssl3.so
-rwxr-xr-x.  1 root root  340832 3月   9 2016 libssl.so.0.9.8e
lrwxrwxrwx.  1 root root      16 10月 19 10:10 libssl.so.10 -> libssl.so.1.0.2k
-rwxr-xr-x.  1 root root  470360 4月  11 2018 libssl.so.1.0.2k
lrwxrwxrwx.  1 root root      27 1月  28 13:38 libssl.so.3 -> /opt/newssl/lib/libssl.so.3     //对，多的一条就是它！
lrwxrwxrwx.  1 root root      16 10月 19 10:11 libssl.so.6 -> libssl.so.0.9.8e
lrwxrwxrwx.  1 root root      12 10月 19 10:10 libss.so.2 -> libss.so.2.0
-rwxr-xr-x.  1 root root   28440 4月  11 2018 libss.so.2.0

再试试新安装的openssl，发现不再缺`libssl.so.3`，只缺`libcrypto.so.3`了：
[ssluser@localhost bin]$ ./openssl version
./openssl: error while loading shared libraries: libcrypto.so.3: cannot open shared object file: No such file or directory

把`libcrypto.so.3`的软链接也建一下：
[root@localhost etc]# ln -s /opt/newssl/lib/libcrypto.so.3 /lib64/libcrypto.so.3
[root@localhost etc]#

那个目录下动态链接库文件太多了，就用这种方式看下吧：
[ssluser@localhost lib64]$ ls -ltr
...
...
...
lrwxrwxrwx.  1 root root      27 1月  28 13:38 libssl.so.3 -> /opt/newssl/lib/libssl.so.3
lrwxrwxrwx.  1 root root      30 1月  28 13:48 libcrypto.so.3 -> /opt/newssl/lib/libcrypto.so.3

再试一下，成功：
[ssluser@localhost bin]$ ./openssl version
OpenSSL 3.0.0-dev xx XXX xxxx


--------------------------------------------------


//接着是第二种方法，更新`/etc/ld.so.conf`文件，把需要的动态链接库的路径加到里面。思想参照了【4-2】，语句不一样：

[ssluser@localhost bin]$ ./openssl version
./openssl: error while loading shared libraries: libssl.so.3: cannot open shared object file: No such file or directory

[root@localhost etc]# pwd
/etc
[root@localhost etc]# vi ld.so.conf

ld.so.conf修改前内容：
include ld.so.conf.d/*.conf

ld.so.conf修改后内容：
include ld.so.conf.d/*.conf
"/opt/newssl/lib"

[ssluser@localhost bin]$ ./openssl version
OpenSSL 3.0.0-dev xx XXX xxxx

//不过我发现一个问题，一旦添加后，再次去掉这个路径并更新该文件也不管用了，`/opt/newssl/lib`仍然属于动态加载时会去查找的路径。


--------------------------------------------------


实际上还有第三种方法，用环境变量`LD_LIBRARY_PATH`，但是之前工作中用过，而且比较简单，就不再赘述了。

```

## 调试

不知道为什么，cgdb可以看见代码单步调试，但是gdb不行。。。神了这情况- -下面两个帖子其实没参考，就只是为了处理`cgdb能调试但gdb不行`这个问题时搜了下，权且记一下吧。我自己编译安装到调试整个过程和下面两个帖子的不同点在于：
1. 我config时候并没有用到他们提的`-d`，`-g`或`-g3`选项，我觉得当前我用的最新版的openssl，INSTALL文件里的`--debug`应该已经包含这些了。
2. 目前还没有另写一个程序，通过那个程序调用openssl来调试。我只是用openssl命令的方式来调用，或许跟这个也有一定关系？

- Debugging OpenSSL code using gdb https://medium.com/@amit.kulkarni/debugging-openssl-code-using-gdb-55451efe9428
- Linux gdb 调试 openssl https://blog.csdn.net/xiangguiwang/article/details/52711103


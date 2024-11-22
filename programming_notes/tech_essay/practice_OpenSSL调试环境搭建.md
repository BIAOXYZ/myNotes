
:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 零、OpenSSL调试环境搭建

## 快速安装语句总结

```sh
yum install -y git gcc make zlib perl perl-IPC-Cmd perl-Data-Dumper

# 其实后面经常直接在root下进行，这个建用户就没必要了。
useradd -m ssluser -d /home/ssluser
echo 'ssluser:test2018' | chpasswd

mkdir openssldir
cd openssldir/
git clone https://github.com/openssl/openssl.git

cd openssl/
./config --prefix=/opt/newssl --openssldir=/opt/newssl --debug
make -sj8
sudo make install
```

## 环境信息

- VB CentOS 7.5.2
- 建了一个专门的用户ssluser（这个不像pg，应该不是必须的）
```sh
useradd -m ssluser -d /home/ssluser
printf test2018 | passwd --stdin ssluser

#// 若出现如下报错："passwd: Have exhausted maximum number of retries for service"
#// 可以用下面这句：
echo 'ssluser:test2018' | chpasswd

#// 或者也可以修改 /etc/pam.d/common-password  --  但是没必要，因为麻烦。
```

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

### 新问题 

```sh
# 需要安装 perl-IPC-Cmd

#// 首先是第一次碰到这个问题：
[root@croupous1 openssl]# ./config --prefix=/opt/newssl --openssldir=/opt/newssl --debug
Can't locate IPC/Cmd.pm in @INC (@INC contains: /root/openssldir/openssl/util/perl /usr/local/lib64/perl5 /usr/local/share/perl5 /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl /usr/lib64/perl5 /usr/share/perl5 . /root/openssldir/openssl/external/perl/Text-Template-1.56/lib) at /root/openssldir/openssl/util/perl/OpenSSL/config.pm line 18.
BEGIN failed--compilation aborted at /root/openssldir/openssl/util/perl/OpenSSL/config.pm line 18.
Compilation failed in require at /root/openssldir/openssl/Configure line 23.
BEGIN failed--compilation aborted at /root/openssldir/openssl/Configure line 23.
[root@croupous1 openssl]#

#// 然后本来以为perl没装，但看了看其实是装了的。
[root@croupous1 openssl]# yum install -y perl
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirrors.inet.vn
 * extras: mirrors.inet.vn
 * updates: mirrors.vhost.vn
Package 4:perl-5.16.3-297.el7.x86_64 already installed and latest version
Nothing to do
[root@croupous1 openssl]#

#// 然后网上搜也没有解决方案，但是偶然搜到了这个地址：
#// https://centos.pkgs.org/7/centos-x86_64/perl-IPC-Cmd-0.80-4.el7.noarch.rpm.html
#// 于是看名字猜测应该是用yum直接装，或者下载rpm再装一下这个 “perl-IPC-Cmd” 就好。
[root@croupous1 openssl]# yum -y install perl-IPC-Cmd
// 此处省略输出内容，并且后面把这个package直接加到初始需要安装的语句里。

[root@croupous1 openssl]# ./config --prefix=/opt/newssl --openssldir=/opt/newssl --debug
Configuring OpenSSL version 3.0.0-alpha9-dev for target linux-x86_64
Using os-specific seed configuration
Creating configdata.pm
Running configdata.pm
Creating Makefile

**********************************************************************
***                                                                ***
***   OpenSSL has been successfully configured                     ***
***                                                                ***
***   If you encounter a problem while building, please open an    ***
***   issue on GitHub <https://github.com/openssl/openssl/issues>  ***
***   and include the output from the following command:           ***
***                                                                ***
***       perl configdata.pm --dump                                ***
***                                                                ***
***   (If you are new to OpenSSL, you might want to consult the    ***
***   'Troubleshooting' section in the INSTALL.md file first)      ***
***                                                                ***
**********************************************************************
[root@croupous1 openssl]#
```

```sh
#// 后面有次安装，config过了，但是make时候报这个库缺失：
[root@marksmen1 openssl]# make -sj8
Can't locate Data/Dumper.pm in @INC (@INC contains: /root/openssldir/openssl/util/perl . providers/common/der /usr/local/lib64/perl5 /usr/local/share/perl5 /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl /usr/lib64/perl5 /usr/share/perl5 /root/openssldir/openssl/external/perl/Text-Template-1.56/lib) at providers/common/der/oids_to_c.pm line 26.
BEGIN failed--compilation aborted at providers/common/der/oids_to_c.pm line 26.
Compilation failed in require.
BEGIN failed--compilation aborted.
make[1]: *** [providers/common/include/prov/der_rsa.h] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [build_sw] Error 2
[root@marksmen1 openssl]# 

#// 于是参考这个链接，找到了库名：
#// perl-Data-Dumper missing from CentOS dependencies https://github.com/jimsalterjrs/sanoid/issues/224
[root@marksmen1 openssl]# yum install -y perl-Data-Dumper
// 此处省略输出内容，并且后面把这个package直接加到初始需要安装的语句里。

#// 另外需要注意的是，即使yum安装完这个包，接着直接make还是会报错。
#// 正确做法是再次用原来的config语句去config一下，然后再make，就可以成功了。
```

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
sudo make install     // 但是这句碰到了问题

[ssluser@localhost openssl]$ sudo make install
[sudo] ssluser 的密码：
ssluser 不在 sudoers 文件中。此事将被报告。

普通用户权限不够当然就加sudo，但是发现这个提示。最后用【3】中的"直接给指定用户授权"的方法
解决了该问题（貌似是CentOS默认没有sudo组的原因造成的），也就是在`/etc/sudoers`加了一行内容，变成如下：
## Allow root to run any commands anywhere
root    ALL=(ALL)       ALL
ssluser ALL=(ALL)       ALL

至此安装完成。
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

- ld.so.conf修改前内容：
``
include ld.so.conf.d/*.conf
``

- ld.so.conf修改后内容：
``
include ld.so.conf.d/*.conf
"/opt/newssl/lib"
``

- 修改完成后执行一下 ldconfig 更新下共享库的缓存，然后就可以查到版本信息了。


//// 注意，曾经在其他简化版系统里碰到过，添加类似上面的带引号的路径报错的问题：
``
[root@5c07e71abd5f etc]# ldconfig -v
ldconfig: Can't stat "/opt/newssl/lib": No such file or directory
ldconfig: Can't stat /libx32: No such file or directory
``
//// 解决办法就是上面往 ld.so.conf 文件里新添加的那行路径不要带引号了。。。


[ssluser@localhost bin]$ ./openssl version
OpenSSL 3.0.0-dev xx XXX xxxx

//不过我发现一个问题，一旦添加后，再次去掉这个路径并更新该文件也不管用了，`/opt/newssl/lib`仍然属于动态加载时会去查找的路径。


--------------------------------------------------


实际上还有第三种方法，用环境变量`LD_LIBRARY_PATH`，但是之前工作中用过，而且比较简单，就不再赘述了。 --> 还是补一下了：
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/newssl/lib
```

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# 二、调试

总体上讲，我认为有两类（或者说三类）调试方法。

## 1.直接从gdb/cgdb内部启动openssl命令行工具进行调试

```
第一种是直接通过gdb/cgdb内部启动openssl命令进行调试。比如，openssl命令行工具通过如下命令生成RSA密钥：

openssl genrsa

那么就可以利用gdb/cgdb的set args来操作。
```

```
整个debug的具体过程如下：

[ssluser@localhost bin]$ pwd
/opt/newssl/bin
[ssluser@localhost bin]$ cgdb ./openssl

source ~/bps.cfg

set args genrsa

r
```

```
这里断点文件bps.cfg也贴一下好了：

break main
break genrsa_main
break RSA_new_method
break RSA_generate_multi_prime_key
break PEM_write_bio_RSAPrivateKey
```

不过不知道什么原因，cgdb可以看见代码单步调试，但是gdb不行。。。神了这情况- -下面两个帖子其实没参考，就只是为了处理`cgdb能调试但gdb不行`这个问题时搜了下，权且记一下吧。我自己编译安装到调试整个过程和下面两个帖子的不同点在于：
1. 我config时候并没有用到他们提的`-d`，`-g`或`-g3`选项，我觉得当前我用的最新版的openssl，INSTALL文件里的`--debug`应该已经包含这些了。
2. 目前还没有另写一个程序，通过那个程序调用openssl来调试。我只是用调式工具内启动openssl命令的方式来调用，或许跟这个也有一定关系？

- Debugging OpenSSL code using gdb https://medium.com/@amit.kulkarni/debugging-openssl-code-using-gdb-55451efe9428
- Linux gdb 调试 openssl https://blog.csdn.net/xiangguiwang/article/details/52711103

## 2.用外部程序调用openssl函数进行调试

想了想还是把这种方式也实践一下吧，毕竟想是一回事，做又是另一回事。。。

### 主要参考了如下例子：
- openssl动态库生成以及交叉编译 https://blog.csdn.net/andylauren/article/details/53456340   【5】

### 但是对makefile文件有三处修改：
```c
## debug flag
DBG_ENABLE = 0     //这里要变为1

## used headers  file path
INCLUDE_PATH := /home/linux/opt/openssl/include/     //这里换实际的路径

## used include librarys file path
LIBRARY_PATH := /home/linux/opt/openssl/lib/        //这里换实际的路径 
```

### 具体的代码文件内容为：

> **cryptotest.h**
```c
#ifndef _CRYPTOTEST_H_
#define _CRYPTOTEST_H_


typedef enum {
        GENERAL = 0,
        ECB,
        CBC,
        CFB,
        OFB,
        TRIPLE_ECB,
        TRIPLE_CBC
}CRYPTO_MODE;

//string DES_Encrypt(const string cleartext, const string key, CRYPTO_MODE mode);
//string DES_Decrypt(const string ciphertext, const string key, CRYPTO_MODE mode);

char * RC4_Encrypt(const char *cleartext, const char * key, int cleartextlen, int keylen);
char * RC4_Decrypt(const char * ciphertext, const char * key, int cleartextlen, int keylen);

#endif //_CRYPTOTEST_H_
```

> **openssltest.c**
```c
#include "cryptotest.h"
#include <string.h>
#include <stdio.h>

int main()
{
        char cleartext[] = "中国北京12345$abcde%ABCDE@！！！";
        char *ciphertext;
        char key[] = "beijingchina1234567890ABCDEFGH!!!";

        ciphertext = RC4_Encrypt(cleartext, key, strlen(cleartext), strlen(key));
        char * decrypt = RC4_Decrypt(ciphertext, key, strlen(cleartext), strlen(key));

        printf("cleartext:%s\n", cleartext);
        printf("genarate ciphertext:%s\n", ciphertext);
        printf("src ciphertext:%s\n", ciphertext);
        printf("genarate ciphertext:%s\n", decrypt);

        if (strcmp(cleartext, decrypt) == 0)
                printf("RC4 crypto ok!!!\n");
        else
                printf("RC4 crypto error!!!\n");
        return 0;
}
```

> **rc4test.c**
```c
#include <stdlib.h>
#include <openssl/rc4.h>
#include <string.h>
#include "cryptotest.h"

char * RC4_Encrypt(const char *cleartext, const char * key, int cleartextlen, int keylen)
{
        RC4_KEY rc4key;
        char* tmp = malloc(cleartextlen + 1);
        memset(tmp, 0, cleartextlen + 1);

        RC4_set_key(&rc4key, keylen, (const unsigned char*)key);
        RC4(&rc4key, cleartextlen, (const unsigned char*)cleartext, tmp);

        return tmp;
}

char * RC4_Decrypt(const char * ciphertext, const char * key, int cleartextlen, int keylen)
{
        RC4_KEY rc4key;
        unsigned char* tmp = malloc(cleartextlen + 1);
        memset(tmp, 0, cleartextlen + 1);

        RC4_set_key(&rc4key, keylen, (const unsigned char*)key);
        RC4(&rc4key, cleartextlen, (const unsigned char*)ciphertext, tmp);

        return tmp;
}
```

> **makefile**
```makefile
#####################################################################
## file        : test makefile for build current dir .c   ##
## author      : jernymy                                  ##
## date-time   : 05/06/2010                               ##
#####################################################################

CC      = gcc
CPP     = g++
RM      = rm -rf

## debug flag
DBG_ENABLE   = 1

## source file path
SRC_PATH   := .

## target exec file name
TARGET     := openssltest

## get all source files
SRCS         += $(wildcard $(SRC_PATH)/*.c)

## all .o based on all .c
OBJS        := $(SRCS:.c=.o)


## need libs, add at here
LIBS := ssl crypto

## used headers  file path
INCLUDE_PATH := /opt/newssl/include/

## used include librarys file path
LIBRARY_PATH := /opt/newssl/lib/

## debug for debug info, when use gdb to debug
ifeq (1, ${DBG_ENABLE})
        CFLAGS += -D_DEBUG -O0 -g -DDEBUG=1
endif

## get all include path
CFLAGS  += $(foreach dir, $(INCLUDE_PATH), -I$(dir))

## get all library path
LDFLAGS += $(foreach lib, $(LIBRARY_PATH), -L$(lib))

## get all librarys
LDFLAGS += $(foreach lib, $(LIBS), -l$(lib))


all: clean build

build:
        $(CC) -c $(CFLAGS) $(SRCS)
        $(CC) $(CFLAGS) -o $(TARGET) $(OBJS) $(LDFLAGS)
        $(RM) $(OBJS)

clean:
        $(RM) $(OBJS) $(TARGET)	
```

>> 注：写完之后我又重新把这篇已经贴出来的内容再粘回去试了一下，从而保证没错。结果前三个文件都没问题，但是makefile文件因为只能用tab，所以粘贴回去后可能会报错：
```
[ssluser@localhost 123]$ make
makefile:54: *** 遗漏分隔符  (您的意思是用 TAB 代替 8 个空格？)。 停止。
```
>> 此时进去把相应行前的空格全都删掉，然后输一个tab保存即可。我是一共改了四处（build:下面三行；clean:下面一行）吧，反正问题不大。

### 整个的代码文件结构和编译运行过程为：
```
随便找个地方建立一个名为gdbopenssltest的新目录，例如我是在如下路径：
/home/ssluser/tmp/gdbopenssltest
这个目录名字也可以随便改，目录位置基本随意。这就是C的好处啊，go就哭了。。。

make前文件目录结构：

├── gdbopenssltest
│   ├── cryptotest.h
│   ├── makefile
│   ├── openssltest.c
│   └── rc4test.c

make后文件目录结构（生成了名为openssltest的可执行文件）：

├── gdbopenssltest
│   ├── cryptotest.h
│   ├── makefile
│   ├── openssltest
│   ├── openssltest.c
│   └── rc4test.c

运行openssltest：

[ssluser@localhost gdbopenssltest]$ ./openssltest
cleartext:中国北京12345$abcde%ABCDE@！！！
genarate ciphertext:Zu▒)▒0Xv▒ݏ▒▒▒▒▒
src ciphertext:Zu▒)▒0Xv▒ݏ▒▒▒▒▒
genarate ciphertext:中国北京12345$abcde%ABCDE@！！！
RC4 crypto ok!!!
```

### 调试就很简单了

这种方式我这边环境上gdb和cgdb都可以————其实本来就该这样啊，只是上一种方式出的问题比较怪，或者环境原因吧。
```
[ssluser@localhost gdbopenssltest]$ gdb ./openssltest
或
[ssluser@localhost gdbopenssltest]$ cgdb ./openssltest

b main

r
```

## 3.启动openssl命令行工具，并挂载该工具进行调试

***注***：目前这种方式已被废弃！！！详情参见这个PR：https://github.com/openssl/openssl/pull/12023
>> //notes：我真他妹的服了这帮人了。。。用得少又不是没人用！！！

这种调试方法类似postgres常用的调试方法：
- 先开个窗口输入`/opt/newssl/bin/openssl`或者跑到相应目录下输`./openssl`，并且不带任何参数。从而启动openssl命令行工具（此时命令行变成了`OpenSSL>`）。
- 然后再开一个新窗口`ps ufx`查一下其`$PID_value`，并在这个窗口`gdb attach $PID_value`挂上openssl命令行工具的进程。当然也可以直接**gdb/cgdb attach `pgrep openssl`**
- 回到前面窗口输个命令之类的，然后回到gdb所在的窗口进行调试。

具体过程如下：
```
第一个窗口：
[ssluser@localhost gdbopenssltest]$ cd /opt/newssl/bin/
[ssluser@localhost bin]$ pwd
/opt/newssl/bin
[ssluser@localhost bin]$ ./openssl
OpenSSL>


第二个窗口：
[ssluser@localhost ~]$ ps ufx
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
ssluser   1744  0.0  0.2 158808  2336 ?        S    17:30   0:00 sshd: ssluser@notty
ssluser   1745  0.0  0.2  72180  2864 ?        Ss   17:30   0:00  \_ /usr/libexec/openssh/sftp-server
ssluser   1731  0.0  0.2 158808  2332 ?        S    17:30   0:00 sshd: ssluser@notty
ssluser   1732  0.0  0.2  72180  2864 ?        Ss   17:30   0:00  \_ /usr/libexec/openssh/sftp-server
ssluser   1709  0.0  0.2 159132  2644 ?        S    17:30   0:00 sshd: ssluser@pts/2
ssluser   1710  0.0  0.2 115436  2116 pts/2    Ss   17:30   0:00  \_ -bash
ssluser   1956  0.0  0.1 155320  1852 pts/2    R+   18:07   0:00      \_ ps ufx
ssluser   1685  0.0  0.2 159132  2644 ?        S    17:30   0:00 sshd: ssluser@pts/1
ssluser   1686  0.0  0.2 115436  2100 pts/1    Ss   17:30   0:00  \_ -bash
ssluser   1951  0.0  0.2  17380  2276 pts/1    S+   18:06   0:00      \_ ./openssl
[ssluser@localhost ~]$
[ssluser@localhost ~]$ gdb attach 1951
(gdb) break genrsa_main
Breakpoint 1 at 0x430885: file apps/genrsa.c, line 60.
(gdb) c
Continuing.


第一个窗口：
OpenSSL> genrsa


第二个窗口：
Breakpoint 1, genrsa_main (argc=1, argv=0x1cb0560) at apps/genrsa.c:60
60          BN_GENCB *cb = BN_GENCB_new();

CTRL+X+A            //cgdb当然就不用了，可以直接开始调试

然后正式开始调试...
```

## 其他调试类攻略

下载、编译、安装、使用、调试openssl最新版 https://cloud.tencent.com/developer/article/1468839

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# docker方式搭建openssl调试环境（ ubuntu22.04 + openssl1.1.1 ）

参考链接：
- https://github.com/openssl/openssl/blob/openssl-3.4/INSTALL.md

```sh
# 宿主机
mkdir -p ~/githubs
cd ~/githubs
git clone https://github.com/openssl/openssl.git
cd openssl/
git checkout -b openssl-3.4 origin/openssl-3.4
docker run --name openssldebug -v ~/githubs/openssl:/root/openssl -it --privileged ubuntu:22.04 bash

# 容器内
mkdir openssldir
cd openssldir/
cp -r /root/openssl/ .
cd openssl/
apt update && apt install -y git build-essential libssl-dev

# 之前用 ./config --prefix=/opt/newssl --openssldir=/opt/newssl --debug，装完有 lib 找不到的问题，
#       不管是改 LD_LIBRARY_PATH 还是 ldconfig 新增一个配置文件都不行。
# 最终还是选择先 make uninstall 卸载，然后 make clean 清理（这步不能少！）一下，
#       接着用下面的 config 语句就可以了。主要是后面 no-shared 参数的原因，相当于直接用静态库了。
# ./config --prefix=/opt/newssl --openssldir=/opt/newssl -Wl,-rpath=/opt/newssl/lib --debug no-shared
#
# 补充：后来发现其实是因为用动态库的话，装出来的 lib 是在 /opt/newssl/lib64 下，而不是原以为的 /opt/newssl/lib 下。
#      所以之前 export LD_LIBRARY_PATH=/opt/newssl/lib:$LD_LIBRARY_PATH 是不行的。。。而是应该用：
#               export LD_LIBRARY_PATH=/opt/newssl/lib64:$LD_LIBRARY_PATH
./config --prefix=/opt/newssl --openssldir=/opt/newssl --debug
make -j8
make install

export LD_LIBRARY_PATH=/opt/newssl/lib64:$LD_LIBRARY_PATH
```

```sh
root@83b34a21e2fc:/openssldir/openssl# /usr/bin/openssl version
OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.0.2 15 Mar 2022)
root@83b34a21e2fc:/openssldir/openssl#
root@83b34a21e2fc:/openssldir/openssl# /opt/newssl/bin/openssl version
/opt/newssl/bin/openssl: /lib/x86_64-linux-gnu/libssl.so.3: version `OPENSSL_3.4.0' not found (required by /opt/newssl/bin/openssl)
/opt/newssl/bin/openssl: /lib/x86_64-linux-gnu/libssl.so.3: version `OPENSSL_3.2.0' not found (required by /opt/newssl/bin/openssl)
/opt/newssl/bin/openssl: /lib/x86_64-linux-gnu/libcrypto.so.3: version `OPENSSL_3.0.9' not found (required by /opt/newssl/bin/openssl)
/opt/newssl/bin/openssl: /lib/x86_64-linux-gnu/libcrypto.so.3: version `OPENSSL_3.3.0' not found (required by /opt/newssl/bin/openssl)
/opt/newssl/bin/openssl: /lib/x86_64-linux-gnu/libcrypto.so.3: version `OPENSSL_3.4.0' not found (required by /opt/newssl/bin/openssl)
/opt/newssl/bin/openssl: /lib/x86_64-linux-gnu/libcrypto.so.3: version `OPENSSL_3.2.0' not found (required by /opt/newssl/bin/openssl)
root@83b34a21e2fc:/openssldir/openssl#
root@83b34a21e2fc:/openssldir/openssl# ldd /usr/bin/openssl
	linux-vdso.so.1 (0x00007fff20ff4000)
	libssl.so.3 => /lib/x86_64-linux-gnu/libssl.so.3 (0x00007fd3d0599000)
	libcrypto.so.3 => /lib/x86_64-linux-gnu/libcrypto.so.3 (0x00007fd3d0155000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fd3cff2c000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fd3d0739000)
root@83b34a21e2fc:/openssldir/openssl#
root@83b34a21e2fc:/openssldir/openssl# ldd /opt/newssl/bin/openssl
/opt/newssl/bin/openssl: /lib/x86_64-linux-gnu/libssl.so.3: version `OPENSSL_3.4.0' not found (required by /opt/newssl/bin/openssl)
/opt/newssl/bin/openssl: /lib/x86_64-linux-gnu/libssl.so.3: version `OPENSSL_3.2.0' not found (required by /opt/newssl/bin/openssl)
/opt/newssl/bin/openssl: /lib/x86_64-linux-gnu/libcrypto.so.3: version `OPENSSL_3.0.9' not found (required by /opt/newssl/bin/openssl)
/opt/newssl/bin/openssl: /lib/x86_64-linux-gnu/libcrypto.so.3: version `OPENSSL_3.3.0' not found (required by /opt/newssl/bin/openssl)
/opt/newssl/bin/openssl: /lib/x86_64-linux-gnu/libcrypto.so.3: version `OPENSSL_3.4.0' not found (required by /opt/newssl/bin/openssl)
/opt/newssl/bin/openssl: /lib/x86_64-linux-gnu/libcrypto.so.3: version `OPENSSL_3.2.0' not found (required by /opt/newssl/bin/openssl)
	linux-vdso.so.1 (0x00007ffd151e7000)
	libssl.so.3 => /lib/x86_64-linux-gnu/libssl.so.3 (0x00007f08f50d1000)
	libcrypto.so.3 => /lib/x86_64-linux-gnu/libcrypto.so.3 (0x00007f08f4c8d000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f08f4a64000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f08f52bb000)
root@83b34a21e2fc:/openssldir/openssl#


root@83b34a21e2fc:/openssldir/openssl# export LD_LIBRARY_PATH=/opt/newssl/lib64:$LD_LIBRARY_PATH
root@83b34a21e2fc:/openssldir/openssl#
root@83b34a21e2fc:/openssldir/openssl# /usr/bin/openssl version
OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.4.0-beta1-dev )
root@83b34a21e2fc:/openssldir/openssl#
root@83b34a21e2fc:/openssldir/openssl# /opt/newssl/bin/openssl version
OpenSSL 3.4.0-beta1-dev  (Library: OpenSSL 3.4.0-beta1-dev )
root@83b34a21e2fc:/openssldir/openssl#
root@83b34a21e2fc:/openssldir/openssl# ldd /usr/bin/openssl
	linux-vdso.so.1 (0x00007ffef58ff000)
	libssl.so.3 => /opt/newssl/lib64/libssl.so.3 (0x00007f2190d57000)
	libcrypto.so.3 => /opt/newssl/lib64/libcrypto.so.3 (0x00007f21906fc000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f21904d0000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f2190fae000)
root@83b34a21e2fc:/openssldir/openssl#
root@83b34a21e2fc:/openssldir/openssl# ldd /opt/newssl/bin/openssl
	linux-vdso.so.1 (0x00007ffeeafe1000)
	libssl.so.3 => /opt/newssl/lib64/libssl.so.3 (0x00007f98775e4000)
	libcrypto.so.3 => /opt/newssl/lib64/libcrypto.so.3 (0x00007f9876f89000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f9876d5d000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f9877885000)
root@83b34a21e2fc:/openssldir/openssl#
```

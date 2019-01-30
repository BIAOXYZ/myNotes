

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


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


# 二、调试

总体上讲，我认为有两类调试方法。

## 1.用openssl命令行工具调试

```
第一种是直接通过openssl命令调试，比如，openssl命令行工具通过如下命令生成RSA密钥：

openssl genrsa
```

```
那么类似的就可以利用这类命令进行debug，具体过程如下：

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
2. 目前还没有另写一个程序，通过那个程序调用openssl来调试。我只是用openssl命令的方式来调用，或许跟这个也有一定关系？

- Debugging OpenSSL code using gdb https://medium.com/@amit.kulkarni/debugging-openssl-code-using-gdb-55451efe9428
- Linux gdb 调试 openssl https://blog.csdn.net/xiangguiwang/article/details/52711103

## 2.用外部程序调用openssl函数进行调试

想了想还是把这种方式也实践一下吧，毕竟想是一回事，做又是另一回事。。。

### 主要参考了如下例子：
- openssl动态库生成以及交叉编译 https://blog.csdn.net/andylauren/article/details/53456340 

但是对makefile文件有三处修改：
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

这种调试方法类似postgres常用的调试方法：
- 先开个窗口输入`openssl`不带任何参数，从而启动openssl命令行工具（）。
- 然后再开一个新窗口`ps ufx`查一下其`$PID_value`，并在这个窗口`gdb attach $PID_value`挂上openssl命令行工具的进程。
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


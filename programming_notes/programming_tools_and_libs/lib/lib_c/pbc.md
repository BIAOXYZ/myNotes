
# 1.官方

B. Lynn. "On the implementation of pairing-based cryptosystems". PhD thesis, Stanford University, November 2008. https://crypto.stanford.edu/pbc/thesis.pdf

https://github.com/blynn/pbc
- `"q 8780710799663312522437781984754049815806883199414208211028653399266475630880222957078625179422662221423155858769582317459277713367317481324925129998224791\n"` https://github.com/blynn/pbc/blob/master/pbc/pbc.c#L736

PBC Library -- The Pairing-Based Cryptography Library https://crypto.stanford.edu/pbc/
- https://crypto.stanford.edu/pbc/chunked/ch01.html
- https://crypto.stanford.edu/pbc/manual/ch01s03.html
  * > and linked against the PBC library and the GMP library, e.g. `$ gcc program.c -L. -lpbc -lgmp`
- Chapter 5. Param functions https://crypto.stanford.edu/pbc/manual/ch05.html
- Type A internals https://crypto.stanford.edu/pbc/manual/ch08s03.html

GMP -- The GNU Multiple Precision Arithmetic Library https://gmplib.org/
- https://gmplib.org/manual/Installing-GMP#Installing-GMP

# 2.其他

## 2.1 主参考链接

Linux环境PBC库配置 https://www.cnblogs.com/burymyname/p/12061212.html 【1】
```sh
# 管理库路径
cd /etc/ld.so.conf.d

cat << EOF > libpbc.conf
/usr/local/lib
EOF

sudo ldconfig
```

PBC library 学习笔记（一） https://blog.csdn.net/u013983667/article/details/54582126 【2】
- > ldconfig命令 https://man.linuxde.net/ldconfig

PBC库安装 https://blog.csdn.net/tbbetter/article/details/103587977 【3】

## 2.2 后续链接

[可搜索加密]PBC Library/PBC库的用法简介 https://jeza-chen.com/2020/06/04/PBC-Library/

双线性映射在密码学中的使用 - Holden Wu的文章 - 知乎 https://zhuanlan.zhihu.com/p/90716648

https://godoc.org/github.com/Nik-U/pbc

http://www.adminzero.cn/AZgeek/PBClearn/

关于密码学中PBC库的一些新的体会--安装（一） https://blog.csdn.net/m0_37719047/article/details/87621242

### 2.2.1 为验证一些参数的意义

https://paste.ubuntu.com/p/Pg5mZmTHdC/
```sh
[root@insisted1 pbc]# ./pbc
g:=rnd(G1);
g;
[2256839820158903331515428966370188979733278981273971103154436181517216200383923554238228223675607716809567282643353804230759107138384918007620330303058434, 7690513067087038094345603870602983480391275650372644393453785472004468046544180178446412099254774485223458321533834568093660171776474214304533070378792828]

q:=8780710799663312522437781984754049815806883199414208211028653399266475630880222957078625179422662221423155858769582317459277713367317481324925129998224791;
p:=q+1;

q;
8780710799663312522437781984754049815806883199414208211028653399266475630880222957078625179422662221423155858769582317459277713367317481324925129998224791
p;
8780710799663312522437781984754049815806883199414208211028653399266475630880222957078625179422662221423155858769582317459277713367317481324925129998224792

pairing(g,g);
[3608264746486809159193374223096861359169630651408129135372407568290618158081014341995767816241156920888891949624492549016633113795010598837601992976715560, 6128871634017304319802139765508085203130439324363686038377754165390802754671581931572334956954206871743200204426990384361127575853333215197385626561068601]

pairing(g,g)^q;
[3608264746486809159193374223096861359169630651408129135372407568290618158081014341995767816241156920888891949624492549016633113795010598837601992976715560, 2651839165646008202635642219245964612676443875050522172650899233875672876208641025506290222468455349679955654342591933098150137513984266127539503437156190]

pairing(g,g)^p;
[1, 0]

pairing(g,g)^(p+1);
[3608264746486809159193374223096861359169630651408129135372407568290618158081014341995767816241156920888891949624492549016633113795010598837601992976715560, 6128871634017304319802139765508085203130439324363686038377754165390802754671581931572334956954206871743200204426990384361127575853333215197385626561068601]
pairing(g,g)^(p+p+1);
[3608264746486809159193374223096861359169630651408129135372407568290618158081014341995767816241156920888891949624492549016633113795010598837601992976715560, 6128871634017304319802139765508085203130439324363686038377754165390802754671581931572334956954206871743200204426990384361127575853333215197385626561068601]

pairing(g,g)^5;
[1713454567024387959087223595120726397444205035759408425285448025517863288611099929030999857602871927853004156134983065111641812075971384756386146918208689, 6668094679476472791159473654592103013958415251591261710653963874146040095239704370583011512415630510566856566477222707479065786383978963229602185097078210]
pairing(g,g)^(5+p);
[1713454567024387959087223595120726397444205035759408425285448025517863288611099929030999857602871927853004156134983065111641812075971384756386146918208689, 6668094679476472791159473654592103013958415251591261710653963874146040095239704370583011512415630510566856566477222707479065786383978963229602185097078210]
pairing(g,g)^(5+6*p);
[1713454567024387959087223595120726397444205035759408425285448025517863288611099929030999857602871927853004156134983065111641812075971384756386146918208689, 6668094679476472791159473654592103013958415251591261710653963874146040095239704370583011512415630510566856566477222707479065786383978963229602185097078210]
```

PBC library 学习笔记（三） https://blog.csdn.net/u013983667/article/details/60478831 || https://www.shangmayuan.com/a/0f8f968014a8408aaa231846.html

https://blog.csdn.net/weixin_42314534/article/details/88380929

https://blog.csdn.net/qq_27855219/article/details/70194754

# 3.实战过程

## 3.1 编译安装

```sh
# apt install -y flex bison m4 g++

yum install -y flex bison m4 gcc

mkdir testlib
cd testlib/

wget https://gmplib.org/download/gmp/gmp-6.2.0.tar.xz
tar xvf gmp-6.2.0.tar.xz
cd gmp-6.2.0/
./configure
make
make check
make install

cd ..
wget https://crypto.stanford.edu/pbc/files/pbc-0.5.14.tar.gz --no-check-certificate
tar xvf pbc-0.5.14.tar.gz
cd pbc-0.5.14/
./configure
make
make install

echo "install End"
```

### 3.1.1 错误处理

```sh
[root@insisted1 testlib]# wget https://crypto.stanford.edu/pbc/files/pbc-0.5.14.tar.gz
--2020-10-31 21:36:52--  https://crypto.stanford.edu/pbc/files/pbc-0.5.14.tar.gz
Resolving crypto.stanford.edu (crypto.stanford.edu)... 171.64.78.27
Connecting to crypto.stanford.edu (crypto.stanford.edu)|171.64.78.27|:443... connected.
ERROR: cannot verify crypto.stanford.edu's certificate, issued by ‘/C=US/ST=MI/L=Ann Arbor/O=Internet2/OU=InCommon/CN=InCommon RSA Server CA’:
  Issued certificate has expired.
To connect to crypto.stanford.edu insecurely, use `--no-check-certificate'.
[root@insisted1 testlib]# tar xvf pbc-0.5.14.tar.gz
tar: pbc-0.5.14.tar.gz: Cannot open: No such file or directory
tar: Error is not recoverable: exiting now
[root@insisted1 testlib]#
```

### 3.1.2 库安装位置

```sh
# 第一次 (GMP的) make install

[root@insisted1 gmp-6.2.0]# make install
make  install-recursive
make[1]: Entering directory `/root/testlib/gmp-6.2.0'
Making install in tests
make[2]: Entering directory `/root/testlib/gmp-6.2.0/tests'
Making install in .
make[3]: Entering directory `/root/testlib/gmp-6.2.0/tests'
make[4]: Entering directory `/root/testlib/gmp-6.2.0/tests'
make[4]: Nothing to be done for `install-exec-am'.
make[4]: Nothing to be done for `install-data-am'.
make[4]: Leaving directory `/root/testlib/gmp-6.2.0/tests'
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/tests'
Making install in devel
make[3]: Entering directory `/root/testlib/gmp-6.2.0/tests/devel'
make[4]: Entering directory `/root/testlib/gmp-6.2.0/tests/devel'
make[4]: Nothing to be done for `install-exec-am'.
make[4]: Nothing to be done for `install-data-am'.
make[4]: Leaving directory `/root/testlib/gmp-6.2.0/tests/devel'
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/tests/devel'
Making install in mpn
make[3]: Entering directory `/root/testlib/gmp-6.2.0/tests/mpn'
make[4]: Entering directory `/root/testlib/gmp-6.2.0/tests/mpn'
make[4]: Nothing to be done for `install-exec-am'.
make[4]: Nothing to be done for `install-data-am'.
make[4]: Leaving directory `/root/testlib/gmp-6.2.0/tests/mpn'
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/tests/mpn'
Making install in mpz
make[3]: Entering directory `/root/testlib/gmp-6.2.0/tests/mpz'
make[4]: Entering directory `/root/testlib/gmp-6.2.0/tests/mpz'
make[4]: Nothing to be done for `install-exec-am'.
make[4]: Nothing to be done for `install-data-am'.
make[4]: Leaving directory `/root/testlib/gmp-6.2.0/tests/mpz'
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/tests/mpz'
Making install in mpq
make[3]: Entering directory `/root/testlib/gmp-6.2.0/tests/mpq'
make[4]: Entering directory `/root/testlib/gmp-6.2.0/tests/mpq'
make[4]: Nothing to be done for `install-exec-am'.
make[4]: Nothing to be done for `install-data-am'.
make[4]: Leaving directory `/root/testlib/gmp-6.2.0/tests/mpq'
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/tests/mpq'
Making install in mpf
make[3]: Entering directory `/root/testlib/gmp-6.2.0/tests/mpf'
make[4]: Entering directory `/root/testlib/gmp-6.2.0/tests/mpf'
make[4]: Nothing to be done for `install-exec-am'.
make[4]: Nothing to be done for `install-data-am'.
make[4]: Leaving directory `/root/testlib/gmp-6.2.0/tests/mpf'
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/tests/mpf'
Making install in rand
make[3]: Entering directory `/root/testlib/gmp-6.2.0/tests/rand'
make[4]: Entering directory `/root/testlib/gmp-6.2.0/tests/rand'
make[4]: Nothing to be done for `install-exec-am'.
make[4]: Nothing to be done for `install-data-am'.
make[4]: Leaving directory `/root/testlib/gmp-6.2.0/tests/rand'
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/tests/rand'
Making install in misc
make[3]: Entering directory `/root/testlib/gmp-6.2.0/tests/misc'
make[4]: Entering directory `/root/testlib/gmp-6.2.0/tests/misc'
make[4]: Nothing to be done for `install-exec-am'.
make[4]: Nothing to be done for `install-data-am'.
make[4]: Leaving directory `/root/testlib/gmp-6.2.0/tests/misc'
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/tests/misc'
Making install in cxx
make[3]: Entering directory `/root/testlib/gmp-6.2.0/tests/cxx'
make[4]: Entering directory `/root/testlib/gmp-6.2.0/tests/cxx'
make[4]: Nothing to be done for `install-exec-am'.
make[4]: Nothing to be done for `install-data-am'.
make[4]: Leaving directory `/root/testlib/gmp-6.2.0/tests/cxx'
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/tests/cxx'
make[2]: Leaving directory `/root/testlib/gmp-6.2.0/tests'
Making install in mpn
make[2]: Entering directory `/root/testlib/gmp-6.2.0/mpn'
make[3]: Entering directory `/root/testlib/gmp-6.2.0/mpn'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/mpn'
make[2]: Leaving directory `/root/testlib/gmp-6.2.0/mpn'
Making install in mpz
make[2]: Entering directory `/root/testlib/gmp-6.2.0/mpz'
make[3]: Entering directory `/root/testlib/gmp-6.2.0/mpz'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/mpz'
make[2]: Leaving directory `/root/testlib/gmp-6.2.0/mpz'
Making install in mpq
make[2]: Entering directory `/root/testlib/gmp-6.2.0/mpq'
make[3]: Entering directory `/root/testlib/gmp-6.2.0/mpq'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/mpq'
make[2]: Leaving directory `/root/testlib/gmp-6.2.0/mpq'
Making install in mpf
make[2]: Entering directory `/root/testlib/gmp-6.2.0/mpf'
make[3]: Entering directory `/root/testlib/gmp-6.2.0/mpf'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/mpf'
make[2]: Leaving directory `/root/testlib/gmp-6.2.0/mpf'
Making install in printf
make[2]: Entering directory `/root/testlib/gmp-6.2.0/printf'
make[3]: Entering directory `/root/testlib/gmp-6.2.0/printf'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/printf'
make[2]: Leaving directory `/root/testlib/gmp-6.2.0/printf'
Making install in scanf
make[2]: Entering directory `/root/testlib/gmp-6.2.0/scanf'
make[3]: Entering directory `/root/testlib/gmp-6.2.0/scanf'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/scanf'
make[2]: Leaving directory `/root/testlib/gmp-6.2.0/scanf'
Making install in rand
make[2]: Entering directory `/root/testlib/gmp-6.2.0/rand'
make[3]: Entering directory `/root/testlib/gmp-6.2.0/rand'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/rand'
make[2]: Leaving directory `/root/testlib/gmp-6.2.0/rand'
Making install in cxx
make[2]: Entering directory `/root/testlib/gmp-6.2.0/cxx'
make[3]: Entering directory `/root/testlib/gmp-6.2.0/cxx'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/cxx'
make[2]: Leaving directory `/root/testlib/gmp-6.2.0/cxx'
Making install in demos
make[2]: Entering directory `/root/testlib/gmp-6.2.0/demos'
Making install in calc
make[3]: Entering directory `/root/testlib/gmp-6.2.0/demos/calc'
make  install-am
make[4]: Entering directory `/root/testlib/gmp-6.2.0/demos/calc'
make[5]: Entering directory `/root/testlib/gmp-6.2.0/demos/calc'
make[5]: Nothing to be done for `install-exec-am'.
make[5]: Nothing to be done for `install-data-am'.
make[5]: Leaving directory `/root/testlib/gmp-6.2.0/demos/calc'
make[4]: Leaving directory `/root/testlib/gmp-6.2.0/demos/calc'
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/demos/calc'
Making install in expr
make[3]: Entering directory `/root/testlib/gmp-6.2.0/demos/expr'
make[4]: Entering directory `/root/testlib/gmp-6.2.0/demos/expr'
make[4]: Nothing to be done for `install-exec-am'.
make[4]: Nothing to be done for `install-data-am'.
make[4]: Leaving directory `/root/testlib/gmp-6.2.0/demos/expr'
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/demos/expr'
make[3]: Entering directory `/root/testlib/gmp-6.2.0/demos'
make[4]: Entering directory `/root/testlib/gmp-6.2.0/demos'
make[4]: Nothing to be done for `install-exec-am'.
make[4]: Nothing to be done for `install-data-am'.
make[4]: Leaving directory `/root/testlib/gmp-6.2.0/demos'
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/demos'
make[2]: Leaving directory `/root/testlib/gmp-6.2.0/demos'
Making install in tune
make[2]: Entering directory `/root/testlib/gmp-6.2.0/tune'
make[3]: Entering directory `/root/testlib/gmp-6.2.0/tune'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/tune'
make[2]: Leaving directory `/root/testlib/gmp-6.2.0/tune'
Making install in doc
make[2]: Entering directory `/root/testlib/gmp-6.2.0/doc'
make[3]: Entering directory `/root/testlib/gmp-6.2.0/doc'
make[3]: Nothing to be done for `install-exec-am'.
 /usr/bin/mkdir -p '/usr/local/share/info'
 /usr/bin/install -c -m 644 ./gmp.info ./gmp.info-1 ./gmp.info-2 '/usr/local/share/info'
 install-info --info-dir='/usr/local/share/info' '/usr/local/share/info/gmp.info'
make[3]: Leaving directory `/root/testlib/gmp-6.2.0/doc'
make[2]: Leaving directory `/root/testlib/gmp-6.2.0/doc'
make[2]: Entering directory `/root/testlib/gmp-6.2.0'
make[3]: Entering directory `/root/testlib/gmp-6.2.0'
 /usr/bin/mkdir -p '/usr/local/lib'
 /bin/sh ./libtool   --mode=install /usr/bin/install -c   libgmp.la '/usr/local/lib'
libtool: install: /usr/bin/install -c .libs/libgmp.so.10.4.0 /usr/local/lib/libgmp.so.10.4.0
libtool: install: (cd /usr/local/lib && { ln -s -f libgmp.so.10.4.0 libgmp.so.10 || { rm -f libgmp.so.10 && ln -s libgmp.so.10.4.0 libgmp.so.10; }; })
libtool: install: (cd /usr/local/lib && { ln -s -f libgmp.so.10.4.0 libgmp.so || { rm -f libgmp.so && ln -s libgmp.so.10.4.0 libgmp.so; }; })
libtool: install: /usr/bin/install -c .libs/libgmp.lai /usr/local/lib/libgmp.la
libtool: install: /usr/bin/install -c .libs/libgmp.a /usr/local/lib/libgmp.a
libtool: install: chmod 644 /usr/local/lib/libgmp.a
libtool: install: ranlib /usr/local/lib/libgmp.a
libtool: finish: PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin:/sbin" ldconfig -n /usr/local/lib
----------------------------------------------------------------------
Libraries have been installed in:
   /usr/local/lib

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the '-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the 'LD_LIBRARY_PATH' environment variable
     during execution
   - add LIBDIR to the 'LD_RUN_PATH' environment variable
     during linking
   - use the '-Wl,-rpath -Wl,LIBDIR' linker flag
   - have your system administrator add LIBDIR to '/etc/ld.so.conf'

See any operating system documentation about shared libraries for
more information, such as the ld(1) and ld.so(8) manual pages.
----------------------------------------------------------------------
 /usr/bin/mkdir -p '/usr/local/include'
 /usr/bin/install -c -m 644 gmp.h '/usr/local/include'
 /usr/bin/mkdir -p '/usr/local/lib/pkgconfig'
 /usr/bin/install -c -m 644 gmp.pc '/usr/local/lib/pkgconfig'
make  install-data-hook
make[4]: Entering directory `/root/testlib/gmp-6.2.0'

+-------------------------------------------------------------+
| CAUTION:                                                    |
|                                                             |
| If you have not already run "make check", then we strongly  |
| recommend you do so.                                        |
|                                                             |
| GMP has been carefully tested by its authors, but compilers |
| are all too often released with serious bugs.  GMP tends to |
| explore interesting corners in compilers and has hit bugs   |
| on quite a few occasions.                                   |
|                                                             |
+-------------------------------------------------------------+

make[4]: Leaving directory `/root/testlib/gmp-6.2.0'
make[3]: Leaving directory `/root/testlib/gmp-6.2.0'
make[2]: Leaving directory `/root/testlib/gmp-6.2.0'
make[1]: Leaving directory `/root/testlib/gmp-6.2.0'
[root@insisted1 gmp-6.2.0]#
```

```sh
# 第二次 (PBC的) make install

[root@insisted1 pbc-0.5.14]# make install
Making install in .
make[1]: Entering directory `/root/testlib/pbc-0.5.14'
make[2]: Entering directory `/root/testlib/pbc-0.5.14'
test -z "/usr/local/lib" || /usr/bin/mkdir -p "/usr/local/lib"
 /bin/sh ./libtool   --mode=install /usr/bin/install -c   libpbc.la '/usr/local/lib'
libtool: install: /usr/bin/install -c .libs/libpbc.so.1.0.0 /usr/local/lib/libpbc.so.1.0.0
libtool: install: (cd /usr/local/lib && { ln -s -f libpbc.so.1.0.0 libpbc.so.1 || { rm -f libpbc.so.1 && ln -s libpbc.so.1.0.0 libpbc.so.1; }; })
libtool: install: (cd /usr/local/lib && { ln -s -f libpbc.so.1.0.0 libpbc.so || { rm -f libpbc.so && ln -s libpbc.so.1.0.0 libpbc.so; }; })
libtool: install: /usr/bin/install -c .libs/libpbc.lai /usr/local/lib/libpbc.la
libtool: install: /usr/bin/install -c .libs/libpbc.a /usr/local/lib/libpbc.a
libtool: install: chmod 644 /usr/local/lib/libpbc.a
libtool: install: ranlib /usr/local/lib/libpbc.a
libtool: finish: PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin:/sbin" ldconfig -n /usr/local/lib
----------------------------------------------------------------------
Libraries have been installed in:
   /usr/local/lib

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the `-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the `LD_LIBRARY_PATH' environment variable
     during execution
   - add LIBDIR to the `LD_RUN_PATH' environment variable
     during linking
   - use the `-Wl,-rpath -Wl,LIBDIR' linker flag
   - have your system administrator add LIBDIR to `/etc/ld.so.conf'

See any operating system documentation about shared libraries for
more information, such as the ld(1) and ld.so(8) manual pages.
----------------------------------------------------------------------
test -z "/usr/local/include/pbc" || /usr/bin/mkdir -p "/usr/local/include/pbc"
 /usr/bin/install -c -m 644 include/pbc_a1_param.h include/pbc_a_param.h include/pbc_curve.h include/pbc_d_param.h include/pbc_e_param.h include/pbc_field.h include/pbc_multiz.h include/pbc_z.h include/pbc_fieldquadratic.h include/pbc_f_param.h include/pbc_g_param.h include/pbc_i_param.h include/pbc_fp.h include/pbc_ternary_extension_field.h include/pbc.h include/pbc_hilbert.h include/pbc_memory.h include/pbc_mnt.h include/pbc_pairing.h include/pbc_param.h include/pbc_poly.h include/pbc_random.h include/pbc_singular.h include/pbc_test.h include/pbc_utils.h '/usr/local/include/pbc'
make[2]: Leaving directory `/root/testlib/pbc-0.5.14'
make[1]: Leaving directory `/root/testlib/pbc-0.5.14'
Making install in example
make[1]: Entering directory `/root/testlib/pbc-0.5.14/example'
make[2]: Entering directory `/root/testlib/pbc-0.5.14/example'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/root/testlib/pbc-0.5.14/example'
make[1]: Leaving directory `/root/testlib/pbc-0.5.14/example'
Making install in gen
make[1]: Entering directory `/root/testlib/pbc-0.5.14/gen'
make[2]: Entering directory `/root/testlib/pbc-0.5.14/gen'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/root/testlib/pbc-0.5.14/gen'
make[1]: Leaving directory `/root/testlib/pbc-0.5.14/gen'
[root@insisted1 pbc-0.5.14]#
```

## 3.2 运行自带的、已经编译好的例子

### 3.2.1 运行自带的已经编译好的pbc例子

```sh
[root@insisted1 pbc]# ./pbc
g:=rnd(G1);
g;
[6588481775387743989592206776352143546456942324675824226547958468738896023343438195147465045734282857507737870497839353766585560188861898363343065445012459, 7829211344542542511640377706019903072567497830199451358114297386396862863162297616846456756001161874051111730599575157730058809739439829355285635895141044]

h:=rnd(G2);
h;
[6982960566907013906385185400627622211889857852923743177418298316410628122136975109898962971844800482174781061438065713755944449978650278959410256063795475, 6510486075631759452927543772726264015106629093470872114418476651213594997879373689699672737837603350154874985724061635695629149302522986897498864305284191]

pairing(g,h);
[6244906978712782616177610556730442196144321574170839037521832322049474262450851103903746759787764671425003835553697299405730027368118977509571632729297763, 6562415749618133777573265483740618577639453795123159762902420806721946589843891657859607254487238102400572386419259024787983930742921547436382312944284044]

a:=rnd(Zr);
b:=rnd(Zr);
pairing(g^a,h^b);
[309629711771428637803808347856915208863559740732757003832574246947134870786006546900544449885318415155586890496445425398863819340073375643076049580928873, 7477881932438500681804427563924500792727151882946169715493388126468844280399354617548726331773880422324073553944101920941317439873599364691743819215110268]
pairing(g,h)^(a*b);
[309629711771428637803808347856915208863559740732757003832574246947134870786006546900544449885318415155586890496445425398863819340073375643076049580928873, 7477881932438500681804427563924500792727151882946169715493388126468844280399354617548726331773880422324073553944101920941317439873599364691743819215110268]

```

### 3.2.2 运行自带的已经编译好的bls例子

```sh
[root@insisted1 example]# ./bls < ~/testlib/pbc-0.5.14/param/a.param
Short signature test
system parameter g = [6036870989251050438679734903133033944334477882176375994891253181198374533307142453558438521649652407685852577037726058502286048902523622150385426788893532, 8652871942799016245564679495347445131719554019083075684398975225332142455877739108745747859646205827763807046738817334561963661778407442459132328988502881]
private key = 521670951517365494855537289593832219182900200429
public key = [6455904532684764096839740207821792300296395750716516270445424347306211470989915814319315589850651940708682175314051333310498130698369961084733337838478518, 2130075255311123178179348661030491581923055369013767849002930344288964013389834554270538527918012276030763436264005867450107247453962987622754607354815380]
message hash = [6308075677352336790906281263294986729661631769387019691257778630720589301975659247632280684514057571723764287112653870734826839929986584710989244826273472, 6142454701008503581188871307879701426487817074338647796416651458053866219368265234706270304034263890451990757541502223250918907047682554979511124774751109]
signature = [7184550543756954689899227723339379805359726215284160295268610438566331704169077951126970576416310807197148726254424747993557487754435386587829153680061129, 326968677056440473565755604884689122424760310042305781680814056604259003454193264657536155210374259192481815048744306005315981550788338780085484811362767]
compressed = 892D59FE6C50116190C207004CE0713047108DC232550F57C57E8A6EC6911B68463EC4424F067CB2AC2FA049B23B3C5B606AA373743A2CB81E93D584AE5FF2C901
decompressed = [7184550543756954689899227723339379805359726215284160295268610438566331704169077951126970576416310807197148726254424747993557487754435386587829153680061129, 326968677056440473565755604884689122424760310042305781680814056604259003454193264657536155210374259192481815048744306005315981550788338780085484811362767]
f(sig, g) = [4644259473973637219299336074334561353802492809494848031652303951167675444369791705940511193659405624474759718906204031648287892902249201886857241712115129, 2108850240257086645726192123476200671361525561944274037413522524179454263567393850963379785216028513193391341473106269247214833956658673184967930526156198]
f(message hash, public_key) = [4644259473973637219299336074334561353802492809494848031652303951167675444369791705940511193659405624474759718906204031648287892902249201886857241712115129, 2108850240257086645726192123476200671361525561944274037413522524179454263567393850963379785216028513193391341473106269247214833956658673184967930526156198]
signature verifies
x-coord = 892D59FE6C50116190C207004CE0713047108DC232550F57C57E8A6EC6911B68463EC4424F067CB2AC2FA049B23B3C5B606AA373743A2CB81E93D584AE5FF2C9
de-x-ed = [7184550543756954689899227723339379805359726215284160295268610438566331704169077951126970576416310807197148726254424747993557487754435386587829153680061129, 8453742122606872048872026379869360693382122889371902429347839342662216627426029692421089024212287962230674043720838011453961731816529142544839645186862024]
signature verifies on second guess
random signature doesn't verify
[root@insisted1 example]#
```

## 3.3 自己编译下bls，加上一句print

```sh
# 试着（用最基本的参数）编译一下
[root@insisted1 example]# cp bls.c bls2.c
[root@insisted1 example]# gcc bls2.c -o blstest
bls2.c:6:17: fatal error: pbc.h: No such file or directory
 #include <pbc.h>
                 ^
compilation terminated.
[root@insisted1 example]#
[root@insisted1 example]#


# 那么首先编译的时候要把头文件地址改对：
[root@insisted1 example]# vi bls2.c
[root@insisted1 example]#
[root@insisted1 example]# gcc bls2.c -o blstest
/tmp/cc2WEpNo.o: In function `element_pow_zn':
bls2.c:(.text+0x126): undefined reference to `__gmpz_init'
bls2.c:(.text+0x15c): undefined reference to `__gmpz_clear'
/tmp/cc2WEpNo.o: In function `pbc_demo_pairing_init':
bls2.c:(.text+0x430): undefined reference to `pbc_die'
bls2.c:(.text+0x46a): undefined reference to `pbc_die'
bls2.c:(.text+0x493): undefined reference to `pairing_init_set_buf'
bls2.c:(.text+0x4a6): undefined reference to `pbc_die'
/tmp/cc2WEpNo.o: In function `main':
bls2.c:(.text+0x5d8): undefined reference to `element_printf'
bls2.c:(.text+0x600): undefined reference to `element_printf'
bls2.c:(.text+0x639): undefined reference to `element_printf'
bls2.c:(.text+0x66b): undefined reference to `element_printf'
bls2.c:(.text+0x6a4): undefined reference to `element_printf'
bls2.c:(.text+0x6bd): undefined reference to `pbc_malloc'
bls2.c:(.text+0x6e2): undefined reference to `element_to_bytes_compressed'
bls2.c:(.text+0x74a): undefined reference to `element_from_bytes_compressed'
bls2.c:(.text+0x763): undefined reference to `element_printf'
bls2.c:(.text+0x76a): undefined reference to `pbc_free'
bls2.c:(.text+0x7ac): undefined reference to `element_printf'
bls2.c:(.text+0x7e5): undefined reference to `element_printf'
bls2.c:(.text+0x831): undefined reference to `pbc_malloc'
bls2.c:(.text+0x856): undefined reference to `element_to_bytes_x_only'
bls2.c:(.text+0x8be): undefined reference to `element_from_bytes_x_only'
bls2.c:(.text+0x8d7): undefined reference to `element_printf'
bls2.c:(.text+0x973): undefined reference to `pbc_free'
bls2.c:(.text+0xa56): undefined reference to `pairing_clear'
collect2: error: ld returned 1 exit status
[root@insisted1 example]#


# 这个错误是编译时没有链接pbc和gmp库导致的，我们链接一下就可以编过了。
[root@insisted1 example]# gcc bls2.c -o blstest -L. -lpbc -lgmp
[root@insisted1 example]# ll
total 208
-rwxr-xr-x 1 root root  7629 Oct 31 21:42 bls
-rw-r--r-- 1 root root  3567 Nov  1 00:58 bls2.c
-rw-rw-r-- 1 fyre fyre  3437 Jun 14  2013 bls.c
-rw-r--r-- 1 root root  6640 Oct 31 21:42 bls.o
-rwxr-xr-x 1 root root 14280 Nov  1 00:59 blstest
...
...
...
```

```sh
# 即使编译好，也要注意动态链接库的问题。
[root@insisted1 example]# ./blstest < ~/testlib/pbc-0.5.14/param/a.param
./blstest: error while loading shared libraries: libpbc.so.1: cannot open shared object file: No such file or directory
[root@insisted1 example]#
[root@insisted1 example]#
[root@insisted1 example]# export LD_LIBRARY_PATH=/usr/local/lib
[root@insisted1 example]#
[root@insisted1 example]#
[root@insisted1 example]# ./blstest < ~/testlib/pbc-0.5.14/param/a.param
********************Program start********************
Short signature test
system parameter g = [5237562995796839394677036337636342818891275064954262584870014319319110759779029362585842925804127777698627253915837642308814215513303928181545321957962960, 5207231378389170839880248172269041129885327305213431732712397671492819844508571534429933453025773583723652596508808611385897826897377836201244540917402635]
private key = 270802737110250182443322052531388168590169569009
public key = [4031950651809934983018429766749191311869151150338516672699519736193679013603541833850140734719025418827881624682454989507849153809015842387098912320438887, 3289488901283424339436579512899359176820617958554120183232592518220685339496401565397035755053161064939219402611743051567158667838889797492850058659371719]
message hash = [6308075677352336790906281263294986729661631769387019691257778630720589301975659247632280684514057571723764287112653870734826839929986584710989244826273472, 6142454701008503581188871307879701426487817074338647796416651458053866219368265234706270304034263890451990757541502223250918907047682554979511124774751109]
signature = [6061769482833450731491151459827025854429509605932609305776464774628368872583807644302767777322843858076647451629014896122581175253067651673978374194374820, 7313621517493427619879195388792824409142825380535789816501256200295760095825281602044123710454724033061260245850697428429261878741464502228087882548310309]
compressed = 73BD4FE15B3EB54B98078446213C9CEE2E11B921ADD62A81E3B8843B08D69232413D1A254A0291E5A6FB0523DFD0A99355B25A8AA0AC311CA13C98489052A8A401
decompressed = [6061769482833450731491151459827025854429509605932609305776464774628368872583807644302767777322843858076647451629014896122581175253067651673978374194374820, 7313621517493427619879195388792824409142825380535789816501256200295760095825281602044123710454724033061260245850697428429261878741464502228087882548310309]
f(sig, g) = [3546671103546590435652443789095173767262600806157560371126302966064642675718879946691268172562531012332069902160519989297895811880341078915153269769319426, 4375741383697759471256942705989125373484718079465037767658416397273517981733124996890681592278381287716518834743836020970365944089494293952432915158402447]
f(message hash, public_key) = [3546671103546590435652443789095173767262600806157560371126302966064642675718879946691268172562531012332069902160519989297895811880341078915153269769319426, 4375741383697759471256942705989125373484718079465037767658416397273517981733124996890681592278381287716518834743836020970365944089494293952432915158402447]
signature verifies
x-coord = 73BD4FE15B3EB54B98078446213C9CEE2E11B921ADD62A81E3B8843B08D69232413D1A254A0291E5A6FB0523DFD0A99355B25A8AA0AC311CA13C98489052A8A4
de-x-ed = [6061769482833450731491151459827025854429509605932609305776464774628368872583807644302767777322843858076647451629014896122581175253067651673978374194374820, 1467089282169884902558586595961225406664057818878418394527397198970715535054941355034501468967938188361895612918884889030015834625852979096837247449914482]
signature verifies on second guess
random signature doesn't verify
[root@insisted1 example]#


# 或者直接改ldconfig的文件（但是前面那个貌似是不需要再运行下ldconfig的，这个改完必须运行下）然后再运行程序即可。
cd /etc/ld.so.conf.d
cat << EOF > libpbc.conf
/usr/local/lib
EOF
ldconfig -v

# 这里加-v（verbose）参数主要是为了能看清确实把pbc和gmp对应的库路径（/usr/local/lib）加到搜索路径里了。
[root@insisted1 ld.so.conf.d]# ldconfig -v
ldconfig: Can't stat /libx32: No such file or directory
ldconfig: Path `/usr/lib' given more than once
ldconfig: Path `/usr/lib64' given more than once
ldconfig: Can't stat /usr/libx32: No such file or directory
/usr/local/lib:
        libpbc.so.1 -> libpbc.so.1.0.0
        libgmp.so.10 -> libgmp.so.10.4.0
/usr/lib64/mysql:
        libmysqlclient.so.18 -> libmysqlclient.so.18.0.0
/lib:
/lib64:
        libevent_openssl-2.0.so.5 -> libevent_openssl-2.0.so.5.1.9
        libevent_extra-2.0.so.5 -> libevent_extra-2.0.so.5.1.9
        libmpc.so.3 -> libmpc.so.3.0.0
        libevent_core-2.0.so.5 -> libevent_core-2.0.so.5.1.9
...
...
...
```

# 4. 后来在Ubuntu又搞了一次，有了一些小改进，再记一下。

环境地址： https://www.katacoda.com/courses/ubuntu/playground

```sh
apt update
apt install -y g++ flex bison m4

mkdir packages && cd packages/

wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.xz
tar xvJf gmp-6.1.2.tar.xz
cd gmp-6.1.2/
./configure
make
make check
sudo make install

cd ..
wget https://crypto.stanford.edu/pbc/files/pbc-0.5.14.tar.gz
tar -xzvf pbc-0.5.14.tar.gz
cd pbc-0.5.14/
./configure
make
sudo make install

# 执行命令，验证安装成功。但是就算安装成功，离自己能编译自己的程序还差些步骤。
$ cd pbc/
$ ./pbc
g:=rnd(G1);
g;
[1537856473291356396691886261132155183792678611630435500440380859287863968689924343696586326959531962300549688140837035067971255277621329474680494241465908, 2720323835684916315562676117157510050963420553457708825205339835427463792306867315124218215967372026110959843537274118769519344644219016613823312537312733]

```

```sh
# 这里基本沿用了第 3 部分编译自己例子的过程，可以参照着对比着看。

cd example/
cp bls.c bls2.c

$ gcc bls2.c -o blstest
bls2.c:6:17: fatal error: pbc.h: No such file or directory
compilation terminated.

# 对于上面这个头文件的问题，过去的做法是改源码，
# 把类似 #include <pbc.h> 改成 #include "/usr/local/include/pbc/pbc.h"
# 但其实可以用不入侵源文件的方式，也就是每次用 -I 参数加上头文件的路径

# 先看看 /usr/local/include/ 里都有啥：
$ ll /usr/local/include/
total 96
drwxr-xr-x  3 root root  4096 Sep  1 07:39 ./
drwxr-xr-x 11 root root  4096 Nov 10  2020 ../
-rw-r--r--  1 root root 83706 Sep  1 07:35 gmp.h
drwxr-xr-x  2 root root  4096 Sep  1 07:39 pbc/
$ 
$ gcc bls2.c -o blstest -I/usr/local/include -I/usr/local/include/pbc
/tmp/ccFngvax.o: In function `element_pow_zn':
bls2.c:(.text+0x13b): undefined reference to `__gmpz_init'
bls2.c:(.text+0x171): undefined reference to `__gmpz_clear'
/tmp/ccFngvax.o: In function `pbc_demo_pairing_init':
bls2.c:(.text+0x479): undefined reference to `pbc_die'
bls2.c:(.text+0x4bc): undefined reference to `pbc_die'
bls2.c:(.text+0x4eb): undefined reference to `pairing_init_set_buf'
bls2.c:(.text+0x4fe): undefined reference to `pbc_die'
/tmp/ccFngvax.o: In function `main':
bls2.c:(.text+0x63b): undefined reference to `element_printf'
bls2.c:(.text+0x663): undefined reference to `element_printf'
bls2.c:(.text+0x69c): undefined reference to `element_printf'
bls2.c:(.text+0x6ce): undefined reference to `element_printf'
bls2.c:(.text+0x707): undefined reference to `element_printf'
bls2.c:(.text+0x723): undefined reference to `pbc_malloc'
bls2.c:(.text+0x751): undefined reference to `element_to_bytes_compressed'
bls2.c:(.text+0x7ce): undefined reference to `element_from_bytes_compressed'
bls2.c:(.text+0x7e7): undefined reference to `element_printf'
bls2.c:(.text+0x7ee): undefined reference to `pbc_free'
bls2.c:(.text+0x833): undefined reference to `element_printf'
bls2.c:(.text+0x86c): undefined reference to `element_printf'
bls2.c:(.text+0x8bb): undefined reference to `pbc_malloc'
bls2.c:(.text+0x8e9): undefined reference to `element_to_bytes_x_only'
bls2.c:(.text+0x966): undefined reference to `element_from_bytes_x_only'
bls2.c:(.text+0x97f): undefined reference to `element_printf'
bls2.c:(.text+0xa1b): undefined reference to `pbc_free'
bls2.c:(.text+0xb01): undefined reference to `pairing_clear'
collect2: error: ld returned 1 exit status
$ 

# 通过 -I 解决头文件问题后，上面那个错误属于常见的没有链接pbc和gmp库的问题，链接一下即可。整体命令为：
$ gcc bls2.c -o blstest -I/usr/local/include -I/usr/local/include/pbc -L. -lpbc -lgmp

# 至此，编译成功。但是要正确运行，还没有完。
```

```sh
$ ./blstest < ~/packages/pbc-0.5.14/param/a.param
./blstest: error while loading shared libraries: libpbc.so.1: cannot open shared object file: No such file or directory
$ 

# 解决这个问题当然也可以用 ldconfig 的办法，比如（其实前面也有，但是前面的还得 cd 换目录，这里直接原地搞定）：
cat << EOF > /etc/ld.so.conf.d/libpbc.conf
/usr/local/lib
EOF
ldconfig -v

$ export LD_LIBRARY_PATH=/usr/local/lib
$ 
$ ./blstest < ~/packages/pbc-0.5.14/param/a.param
Short signature test
system parameter g = [8316938319765830625610521523283891940505678515821507264843333223951492834745286642706534481852831825454661104692161268489390777994031361045361168401481553, 2021474071655016554823291566784698377935071177306698280028306977465387700081303427644806151268530673435770903348656362957695929759745795518411708804342407]
private key = 591600964708407764427505880775719998123999244613
public key = [8004255011220451009289168502068648183690181314411790255226518880148872489640967593562238700104880860843300613993841767119097540401107462744061147629966960, 2791721289239541138536787002915993287245261947036871010523604209153832098353489660698587838337930694890442859213945914850534906637833163977857207408001451]
message hash = [6308075677352336790906281263294986729661631769387019691257778630720589301975659247632280684514057571723764287112653870734826839929986584710989244826273472, 6142454701008503581188871307879701426487817074338647796416651458053866219368265234706270304034263890451990757541502223250918907047682554979511124774751109]
signature = [2897072360542627551927607215168507268404902145856131872955216576965373955552239190311194851536553657772498043526360696064440750548254012308788169484013606, 8316539344678070387537797645424972600361076336802102096121478499299309505890104416092564577195306977601819054465957034875343904614298382581369908809097827]
compressed = 3750983FC534B377C8B15C6B8287B04E2E02505DCB0D2CEED1BC370718A3C7EB0A67E010F3CF26668C6A309399FADAF380EBC56D1CABF760FEB17FAD5060102601
decompressed = [2897072360542627551927607215168507268404902145856131872955216576965373955552239190311194851536553657772498043526360696064440750548254012308788169484013606, 8316539344678070387537797645424972600361076336802102096121478499299309505890104416092564577195306977601819054465957034875343904614298382581369908809097827]
f(sig, g) = [4251372865246710552330356679403151818198731406559559550440711333885532633189280827149506845785681490012937938523789501264315370894688974063424897792347262, 7284701590076124819017033963387669984039777286177610138318427721821851899460485862122793870193368270972518452123047099892779696944879241275144241731063211]
f(message hash, public_key) = [4251372865246710552330356679403151818198731406559559550440711333885532633189280827149506845785681490012937938523789501264315370894688974063424897792347262, 7284701590076124819017033963387669984039777286177610138318427721821851899460485862122793870193368270972518452123047099892779696944879241275144241731063211]
signature verifies
x-coord = 3750983FC534B377C8B15C6B8287B04E2E02505DCB0D2CEED1BC370718A3C7EB0A67E010F3CF26668C6A309399FADAF380EBC56D1CABF760FEB17FAD50601026
de-x-ed = [2897072360542627551927607215168507268404902145856131872955216576965373955552239190311194851536553657772498043526360696064440750548254012308788169484013606, 464171454985242134899984339329077215445806862612106114907174899967166124990118540986060602227355243821336804303625282583933808753019098743555221189126964]
signature verifies on second guess
random signature doesn't verify
$ 
```



# 零、 VirtualBox CentOS 7.5.2下PostgreSQL调试环境的搭建

# 一、 PostgreSQL的安装过程

## 其他环境条件说明

1. 新建了一个系统用户`pguser`及其HOME目录。
```sh
useradd -m pguser -d /home/pguser
echo test2018 | passwd --stdin pguser 
# ubuntu下的passwd命令没有--stdin参数，此时要么就老老实实用最基本的交互式的passwd pguser
# 要么就参考我在passwd命令里的总结，用chpasswd
```
2. 在`/home/pguser/pg/postgrescode/`下存放pg源码，不过这个位置是啥叫啥没影响。
```sh
su - pguser
mkdir -p ~/pg/postgrescode
```

## 参考链接

- 第 16 章  从源代码安装 -- 16.4. 安装过程 http://www.postgres.cn/docs/10/install-procedure.html **【0】**
  > 卸载：要撤销安装可以使用命令make uninstall。不过这样不会删除任何创建出来的目录。
  >
  > 清理：在安装完成以后，你可以通过在源码树里面用命令make clean删除编译文件。 这样会保留configure程序生成的文件，这样以后你就可以用make命令重新编译所有东西。 要把源码树恢复为发布时的状态，可用make distclean命令。 如果你想从同一棵源码树上为多个不同平台制作，你就一定要运行这条命令并且为每个编译重新配置（另外一种方法是在每种平台上使用一套独立的编译树，这样源代码树就可以保留不被更改）。
  >
  > 如果你执行了一次制作，然后发现你的configure选项是错误的， 或者你修改了任何configure所探测的东西（例如，升级了软件）， 那么在重新配置和编译之前运行一下make distclean是个好习惯。如果不这样做， 你修改的配置选项可能无法传播到所有需要变化的地方。
- 安装postgreSQL出现configure:error:readline library not found解决方法及pg安装全过程 https://blog.csdn.net/wypblog/article/details/6863342 **【1】**
  > yum -y install readline-devel
- 安装postgreSQL出现configure: error: zlib library not found解决方法 https://www.cnblogs.com/shuaixf/archive/2011/11/29/2268298.html **【2】**
  > yum -y install zlib-devel
- linux下调试postgreSQL https://binresist.github.io/%E5%B7%A5%E5%85%B7%E5%AD%A6%E4%B9%A0/2017/05/17/linux%E4%B8%8B%E8%B0%83%E8%AF%95postgreSQL.html **【3】**
  > ./configure --prefix=/home/postgre/pgsql --exec-prefix=/home/postgre/eprefix --datadir=/home/postgre/datarootdir --docdir=/home/postgre/docdir --enable-nls=zh_CN.UTF-8 --enable-debug CFLAGS="-O0" --enable-profiling --enable-cassert --with-python --with-libxml

--------------------------------------------------

## 安装过程（源码安装PostgreSQL）

- 在`/home/pguser/pg/`目录执行:
  > `git clone git@github.com:postgres/postgres.git` || 或者不想配密钥的话： `git clone https://github.com/postgres/postgres.git`
  >> 执行完成后多了`/home/pguser/pg/postgres/`。我为了好区分也顺便试试（git仓库克隆下来后改名还行不行），就把路径最后的postgres改成了postgrescode。下次就没必要再这么画蛇添足了。
  >>> 下次直接只建到`/home/pguser/pg/`这层目录就行了，postgrescode没必要再涉及。此外，请参考**文章最后那个katacoda上提炼的最快速安装版本**。
 
- 源码下载完成后基本就是Linux下最常见的`config-make-makeinstall`三部曲，这中间会有些问题，一一解决就好。
  * 首先可以在代码主目录执行下`./configure`。其目的是看看缺啥依赖，先把这些依赖搞定。如果直接不报错一次过或者依赖都搞定以后，再执行下`make distclean`把刚才执行configure步骤产生的可能影响接下来的正确安装的东西都清理掉————`make distclean`、`make clean`、`make uninstall`等命令的作用不要忽视了（参见参考链接`【0】`）。
  * 在configure过程中可能会碰到提示readline库找不到的错误，但是明明readline库是有的。原因也不想深究了，解决办法就是执行下`yum -y install readline-devel`安装一下readline-devel库就好。此外，zlib库也有类似问题，解决方法也是一样的（参见参考链接`【1，2】`）。————我们当然可以在configure的时候使用`--without-readline`（这个会导致psql连接上数据库后SQL输入没那么方便）和`--without-zlib`（这个似乎影响不大）来bypass这类error，但是还是建议安装上相应库比较好。

--------------------------------------------------

- 配置-编译-安装数据库：
  * 安装使用的命令参考了参考链接`【3】`，更具体的是：
    ```
    ./configure --prefix=/home/pguser/pg/pgsql --enable-debug CFLAGS="-O0" --enable-profiling --enable-cassert
    make
    make install
    ```
    为了源码调试，`--enable-debug CFLAGS="-O0"`必不可少。
  * 进入到initdb可执行程序所在目录执行：
    > ./initdb -D /home/pguser/pg/pgdata

--------------------------------------------------

- 至此数据库安装彻底成功，可以用如下命令启动数据库（关闭的话start换stop即可，后面路径不可少）：
  > ./pg_ctl start -D /home/pguser/pg/pgdata

- 最后连接上数据库就可以开始调试了：
  > ./psql -d postgres

--------------------------------------------------

- 至此调试是没问题了，但是为了方便，还是添加两个环境变量吧：
  ```
  export PGHOME=/home/pguser/pg/pgsql
  export PGDATA=/home/pguser/pg/pgdata
  export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${PGHOME}/lib
  export PATH=$PATH:${PGHOME}/bin
  ```

- 此后可以直接执行下述命令，比上面的方便多了：
  ```
  pg_ctl start -D $PGDATA
  pg_ctl stop -D $PGDATA
  psql -d postgres
  ```

***不过以后还是脚本安装吧，方便快速。。。***

--------------------------------------------------

# 二、 cgdb的安装

## 其他环境条件说明

这里用了root用户安装，不用root应该也是可以的，记得在之前单位里是用普通用户装的。

## 参考链接

CGDB的安装与使用 https://blog.csdn.net/ran337287/article/details/72794585 **【4】**
``` 
yum -y install gcc-c++ gdb
wget http://cgdb.me/files/cgdb-0.7.0.tar.gz
tar -zvxf cgdb-0.7.0.tar.gz
cd cgdb-0.7.0
./configure --prefix=/usr/local
make && sudo make install

安装时在我系统下出现了如下错误： 
错误1： 
configure: error: Please install flex before installing 
解决： 
sudo apt-get install flex 
错误2： 
configure: error: Please install makeinfo before installing 
解决： 
sudo apt-get install texinfo || yum install -y texinfo
```

## 安装过程

记得之前安装就是从官网下的稳定版压缩包，然后从window拷到服务器上（毕竟某500强的服务器一般不给上外网），然后三部曲搞定。所以这次打算从cgdb官网（ https://cgdb.github.io/ ）下载源码安装。结果configure还是make的时候好几个错，还是算了，继续用稳定版吧。毕竟这种工具用熟练就好，人哪有那么多时间各种探究。不过这次能联外网了，所以用wget下载了。中间出了个错，提示信息挺二的。。。整体过程很简单，和参考链接**【4】**基本没什么区别。

- wget http://cgdb.me/files/cgdb-0.7.0.tar.gz
- tar -zxvf cgdb-0.7.0.tar.gz
- ./configure --prefix=/usr/local
  * configure: error: Please install makeinfo before installing
    > yum -y install texinfo //擦，提示明明是makeinfo啊。。。害我一直用yum -y install makeinfo
- make
- make install //这一步不是root用户的话应该是要加sudo的，我原来的笔记里是用了sudo的。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# katacoda的Centos环境再走一遍pg12的安装，主要就是步骤比较集中列出来，方便快速复制。

> 环境： https://www.katacoda.com/courses/centos/playground

```sh
#// 一、极简步骤版：上来就确定把依赖做齐，然后直接一次装好。
yum -y install readline-devel zlib-devel bison flex git gcc make
yum install epel-release -y 
yum install -y cgdb

useradd pguser
echo 123456 | passwd --stdin pguser
su - pguser

mkdir ~/pgdir
cd pgdir/
git clone https://github.com/postgres/postgres.git
cd postgres/
git checkout -b REL_12_STABLE origin/REL_12_STABLE

./configure --prefix=/home/pguser/pgdir/pgsql --enable-debug CFLAGS="-O0" --enable-profiling --enable-cassert
make -sj8
make install

cd /home/pguser/pgdir/pgsql/bin/
./initdb -D /home/pguser/pgdir/pgdata
./pg_ctl start -D /home/pguser/pgdir/pgdata/
./psql -d postgres
```

```sh
#// 二、详细步骤版：上面的极简步骤版的源泉。

yum -y install readline-devel zlib-devel 
# 呃，Katacoda的Centos环境连gcc都没。。。
yum -y install gcc
# 此外也可以考虑把bison和flex直接再这儿就装了！
# yum install -y bison flex

# root是无法run数据库的，所以开始就新建用户并切换吧。
#   [root@0f40b629bc50 bin]# ./initdb -D /pgdata
#   initdb: error: cannot be run as root
#   Please log in (using, e.g., "su") as the (unprivileged) user that will own the server process.
useradd pguser
echo 123456 | passwd --stdin pguser
su - pguser

mkdir ~/pgdir
cd pgdir/
git clone https://github.com/postgres/postgres.git
cd postgres/
git checkout -b REL_12_STABLE origin/REL_12_STABLE

# 惯例的安装前先试探，就是这步试探出了缺gcc
./configure
make distclean

# 不指定--prefix的话，默认是在/usr/local/目录下新建pgsql目录，普通用户有可能没有权限：
#   /bin/mkdir: cannot create directory ‘/usr/local/pgsql’: Permission denied
# prefix里指定的这个/home/pguser/pgdir/pgsql目录不用提前创建
./configure --prefix=/home/pguser/pgdir/pgsql --enable-debug CFLAGS="-O0" --enable-profiling --enable-cassert
make
# 然后提示缺bison，为了后面省事，连flex一起来一遍
# 一般情况下这个安装又得回到root用户，所以建议后面这里的依赖安装也可以直接挪最前面去
yum -y install bison flex

make
# 确定安装完了bison（以及后面的flex）再次make但还是一样的错，原因是必须再执行下configure
# https://stackoverflow.com/questions/3827938/ubuntu-how-to-install-flex-to-make-postgres/3827974#3827974
#   『You need to run ./configure again so that the make files are "aware" of flex.』
./configure --prefix=/home/pguser/pgdir/pgsql --enable-debug CFLAGS="-O0" --enable-profiling --enable-cassert

make
# 省略大段输出，最后是这句：All of PostgreSQL successfully made. Ready to install.
# make完成后，psql等二进制都还没装到机器里，所以此时上面那个 /home/pguser/pgdir/pgsql/ 目录系统还不会创建；
#   并且which下psql也是找不到的。这些都是最后install的时候做。
make install
# 省略大段输出，最后是这句：PostgreSQL installation complete.

cd /home/pguser/pgdir/pgsql/bin/
./initdb -D /home/pguser/pgdir/pgdata
# initdb完成后的输出：
#   Success. You can now start the database server using:  
#   ./pg_ctl -D /home/pguser/pgdir/pgdata -l logfile start
# 所以 /home/pguser/pgdir/pgdata/ 这个目录也是不用提前创建的。

./pg_ctl start -D /home/pguser/pgdir/pgdata/

pguser   24153  0.2  1.6 286792 24820 ?        Ss   05:56   0:00 /home/pguser/pgdir/pgsql/bin/postgres -D /home/pguser/pgdir/pgdata
pguser   24155  0.0  0.8 286792 12300 ?        Ss   05:56   0:00  \_ postgres: checkpointer
pguser   24156  0.0  0.8 286792 12528 ?        Ss   05:56   0:00  \_ postgres: background writer
pguser   24157  0.0  1.0 286792 16496 ?        Ss   05:56   0:00  \_ postgres: walwriter
pguser   24158  0.0  0.8 287340 13428 ?        Ss   05:56   0:00  \_ postgres: autovacuum launcher
pguser   24159  0.0  0.7 141212 12208 ?        Ss   05:56   0:00  \_ postgres: stats collector
pguser   24160  0.0  0.8 287344 12976 ?        Ss   05:56   0:00  \_ postgres: logical replication launcher

./psql -d postgres

# 一个可选步骤：将pgsql下的bin目录加进$PATH。因为这种指定prefix的安装，pgsql下的那些二进制大概率都不在$PATH下。
export PGHOME=/home/pguser/pgdir/pgsql
export PGDATA=/home/pguser/pgdir/pgdata
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${PGHOME}/lib
export PATH=${PATH}:${PGHOME}/bin

# 加入环境变量后就可以更简单的启动、停止、连接数据库了：
#  pg_ctl start -D $PGDATA
#  pg_ctl stop -D $PGDATA
#  psql -d postgres

# 意外地发现现在cgdb都可以一键装了，太幸福了简直。再看看之前的记录，当年装个cgdb都麻烦- -
yum install -y cgdb
# pgrep的 -n 参数是表示显示pid最大的那个。一般情况下psql起的连接要比本身的几个pg进程的pid大
# 那几个进程被杀过又起来的话例外，当我没说。。。反正最笨的办法还是去ps ufx看一下再attach
cgdb attach `pgrep -n postgres`
b exec_simple_query

# 发现ddd也可以一键装，回头试试ddd调试吧
yum install -y ddd
```

# Ubuntu安装 pg8.4.1（这是《PostgreSQL数据库内核分析》书里用的版本）

```sh
# docker run --name pgdebug -it centos:7 bash

apt install -y libreadline6 libreadline6-dev zlib1g zlib1g-dev bison flex git gcc make cgdb

useradd -m -d /home/pguser pguser
echo "pguser:123456" | chpasswd
su - pguser

mkdir ~/pgdir
cd pgdir/
git clone https://github.com/postgres/postgres.git
cd postgres/
#git checkout -b REL8_4_1 origin/REL8_4_1
git checkout -b REL8_4_STABLE origin/REL8_4_STABLE

./configure --prefix=/home/pguser/pgdir/pgsql --enable-debug CFLAGS="-O0" --enable-profiling --enable-cassert
make -sj8
make install

cd /home/pguser/pgdir/pgsql/bin/
./initdb -D /home/pguser/pgdir/pgdata
./pg_ctl start -D /home/pguser/pgdir/pgdata/

./psql -d postgres
```

这次碰到了一个新的问题，症状是用pguser用户attach进程后没有代码（其实就没有attach成功），提示信息大概是这样的：
```console
Could not attach to process （pid）. If your uid matches the uid of the target
process, check the setting of /proc/sys/kernel/yama/ptrace_scope, or try
again as the root user. For more details, see /etc/sysctl.d/10-ptrace.conf
```
本质是pguser权限不够，用root就可以attach上（但是pg必须在非root下才能运行，所以过去都是pguser起连接，再开个窗口用pguser挂上调试）。解决方法如下：

after upgrade gdb won't attach to process https://askubuntu.com/questions/41629/after-upgrade-gdb-wont-attach-to-process
- https://askubuntu.com/questions/41629/after-upgrade-gdb-wont-attach-to-process/41656#41656
  * > You can temporarily disable this restriction (and revert to the old behaviour allowing your user to ptrace (gdb) any of their other processes) by doing:
    ```sh
    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    ```
  * > To permanently allow it edit `/etc/sysctl.d/10-ptrace.conf` and change the line:
    ```conf
    kernel.yama.ptrace_scope = 1
    ```
    > To:
    ```conf
    kernel.yama.ptrace_scope = 0
    ```

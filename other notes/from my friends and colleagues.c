
## mingjie 


http://blog.csdn.net/u014539401/article/details/70992923
http://mutex73.github.io/

=======================================================================================
[pgenv.sh]
if [ ${#} -ne 1 ]; then
echo "${0} ver"
else

export LC_ALL="en_US.UTF-8"

export PGDATA=${HOME}/bin/data/pg_root${1}
export LANG=en_US.utf8
export PGHOME=${HOME}/bin/pgsql${1}
#export LD_LIBRARY_PATH=${PGHOME}/lib:${LD_LIBRARY_PATH}
export DATE=`date +"%Y%m%d%H%M"`
export PATH=${PGHOME}/bin:${HOME}/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/lib64/jvm/jre/bin:/usr/lib/mit/bin:/usr/lib/mit/sbin:.:.
#export MANPATH=${PGHOME}/share/man:${MANPATH}
export PGHOST=127.0.0.1
export PGUSER=${USER}
export PGPASSWORD=gaussdb@123
export PGDATABASE=postgres

export GAUSSDATA=${PGDATA}
export GAUSSHOME=${PGHOME}
fi
=======================================================================================
[193环境记录]
./configure --prefix=/home/liuliang3/app/pgsql00 --without-zlib --enable-debug --enable-cassert --enable-thread-safety CFLAGS='-O0' --with-pgport=6900 --enable-depend --without-readline

./configure --prefix=/home/liuliang3/app/pgsql01 --without-zlib --enable-debug --enable-cassert --enable-thread-safety CFLAGS='-O0' --with-pgport=6901 --enable-depend;make -sj8;make install


/*  
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/libreadline5-5.2-147.9.13.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/readline-devel-5.2-147.9.13.x86_64.rpm

-- 上面两个有问题的话用数字网址

rpm -ivh http://10.93.135.120/suse/SLES/11sp1/x86_64/libreadline5-5.2-147.9.13.x86_64.rpm
rpm -ivh http://10.93.135.120/suse/SLES/11sp1/x86_64/readline-devel-5.2-147.9.13.x86_64.rpm
*/

/* 给你发点常用的
SVN
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/libapr1-1.3.3-11.16.1.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/libapr-util1-1.3.4-12.20.2.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/neon-0.28.3-2.12.1.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/libneon27-0.28.3-2.12.1.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/subversion-1.5.7-0.1.1.x86_64.rpm


openssl
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/openCryptoki-2.3.0-0.7.21.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/zlib-1.2.3-106.34.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/zlib-devel-1.2.3-106.34.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/libopenssl0_9_8-0.9.8h-30.27.11.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/libopenssl-devel-0.9.8h-30.27.11.x86_64.rpm
odbc
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/unixODBC-2.2.12-198.17.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/unixODBC-devel-2.2.12-198.17.x86_64.rpm

libxml

rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/openldap2-2.4.20-0.4.29.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/cyrus-sasl-devel-2.1.22-182.20.1.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/cmake-2.6.2-3.20.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/libxml2-2.7.6-0.1.37.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/libxml2-devel-2.7.6-0.1.37.x86_64.rpm
高铭杰(g00367294) 2017-05-23 09:53 
python-devel

rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/libpython2_6-1_0-2.6.0-8.9.20.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/python-2.6.0-8.9.28.x86_64.rpm
rpm -ivh http://rnd-mirrors.huawei.com/suse/SLES/11sp1/x86_64/python-devel-2.6.0-8.9.20.x86_64.rpm
 */


./configure --prefix=/home/liuliang/app/pgsql01 --without-zlib --enable-debug --enable-cassert --enable-thread-safety CFLAGS='-O0' --with-pgport=6901 --enable-depend


00 PG9.5	PORT:6900
01 PG9.5	PORT:6901

./configure --prefix=/home/liuliang/bin/pgsql02 --without-zlib --enable-debug --enable-cassert --enable-thread-safety CFLAGS='-O0' --with-pgport=6902 --enable-depend

02 PG9.5   PORT:6902

gmake -sj8  /*8线程并发*/

gmake install

echo $PATH
切换 pgenv 02 (pp 02)

initdb

pg_ctl start/stop/restart


./configure --prefix=/home/liuliang/bin/pgsql03 --without-zlib --enable-debug --enable-cassert --enable-thread-safety CFLAGS='-O0' --with-pgport=6903 --enable-depend
/*后续就只是改数字了，但是要注意要在configure文件所在的目录下执行*/


[173环境记录]



=======================================================================================
[主备配置]


主库配置：
wal_level = hot_standby  //后面新版本变成了logical
max_wal_senders = 10 
listen_addresses = '*'

生成基础备份：
pg_basebackup -Fp -P -x -R -D ~/bin/app/pg_root01 -l backup20160826

( pg_basebackup -Fp -P -x -R -D ~/app/data/pg_root01 -l backup20160826 )
[ pg_basebackup -Fp -P -X fetch -R -D ~/app/data/pg_root11 -l backup20170523 ] // PG10以后改成了-x参数不管用了

启动standby：
hot_standby = on
启动数据库

主库查询状态：
select * from pg_stat_replication;

=======================================================================================

创建新用户

root
Gauss_234

高铭杰(g00367294) 2016-09-23 11:52
su - root
useradd -d /home/gmj -m gmj
passwd gmj
su - gmj

=======================================================================================
find . -name postgresql.conf
grep -n max_replication_slots ./app/data/pg_root01/postgresql.conf 
grep -n wal_level ./app/data/pg_root01/postgresql.conf
=======================================================================================
okr
1) 结合GaussKernel设计实现，给出CBO的理论分析及设计方案(移植PG)
2) 结合性能目标与PG优化器实现，在优化算法上有所突破，提升系统整体性能
3) 参考Oracle中安全竞争力特性，给出落地GaussKernel的设计方案

=======================================================================================
git add *
git commit -m "xxxx"
git push --all
=======================================================================================
=======================================================================================
=======================================================================================
=======================================================================================
查看有没有设置core
[liuliangap@LFG1000810262 ~]$ ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 127854
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1000000
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 4096
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited

没有的话root执行下述语句设置
echo "kernel.core_pattern = core-%e-%p-%t" >> /etc/sysctl.conf 
/sbin/sysctl -w kernel.core_pattern=core-%e-%p-%t
echo "* soft core unlimited" >> /etc/security/limits.conf
echo "* hard core unlimited" >> /etc/security/limits.conf




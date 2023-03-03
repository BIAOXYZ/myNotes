
# swap内存管理

【[:star:][`*`]】 Create a Linux Swap File https://linuxize.com/post/create-a-linux-swap-file/ || https://linuxize.com/post/how-to-add-swap-space-on-debian-9/
- > **涉及的命令**
  * > free：查看内存状态命令，可以显示memory、swap、buffer/cache等的大小及使用状况;
  * > dd：读取，转换并输出数据命令；
  * > mkswap：设置交换区
  * > swapon：启用交换区，相当于mount
  * > swapoff：关闭交换区，相当于umount

***个人文章实战***：
```sh
$ sudo swapon --show
$ free -m
              total        used        free      shared  buff/cache   available
Mem:          15393       10113        3084         189        2195        4779
Swap:             0           0           0

$ cd diskswapfile/
# 创建swap需要的分区文件
$ dd if=/dev/zero of=~/tmpfiles/diskswapfile/swapfile bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 1.79627 s, 598 MB/s
$ ll
total 1048588
drwxr-xr-x  2 biaoxyz biaoxyz       4096 Mar  3 18:19 .
drwxr-xr-x 12 biaoxyz biaoxyz       4096 Mar  3 18:18 ..
-rw-r--r--  1 biaoxyz biaoxyz 1073741824 Mar  3 18:19 swapfile

# 格式化swap分区文件
$ mkswap swapfile
-bash: mkswap: command not found
# 感觉这点是这个 mkswap 最二的地方，需要 root 或者 sudo 权限来运行没问题，但是提示偏偏是 command not found。
# 于是我用 sudo apt install -y util-linux 去装，结果提示已经装了。。。
# 后来在这个帖子里才发现端倪：https://www.linuxquestions.org/questions/red-hat-31/mkswap-gives-command-not-found-error-690156/
$ sudo mkswap swapfile
mkswap: swapfile: insecure permissions 0644, 0600 suggested.
mkswap: swapfile: insecure file owner 1001, 0 (root) suggested.
Setting up swapspace version 1, size = 1024 MiB (1073737728 bytes)
no label, UUID=f5331fdb-85f2-4798-86b4-1febb53c0841

# 启用swap分区文件
$ sudo swapon swapfile
swapon: /data00/home/biaoxyz/tmpfiles/diskswapfile/swapfile: insecure permissions 0644, 0600 suggested.
swapon: /data00/home/biaoxyz/tmpfiles/diskswapfile/swapfile: insecure file owner 1001, 0 (root) suggested.

# 添加开机启动
$ sudo vim /etc/fstab
$ cat /etc/fstab
# /etc/fstab: static file system information.
proc       /proc    proc  nodev,noexec,nosuid                 0  0
/dev/sda1  /        ext4  defaults,discard,errors=remount-ro  0  1
/dev/sdb   /data00  ext4  defaults,discard                    0  0
/home/biaoxyz/tmpfiles/diskswapfile/swapfile swap swap defaults 0 0

# 最后再次查询
$ sudo swapon --show
NAME                                                       TYPE  SIZE USED PRIO
/data00/home/biaoxyz/tmpfiles/diskswapfile/swapfile file 1024M   0B   -2
$ free -m
              total        used        free      shared  buff/cache   available
Mem:          15393       10175        2247         197        2969        4775
Swap:          1023           0        1023
```

How To Add Swap Space on Debian 9 https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-debian-9

linux增加swap空间的方法小结 https://www.cnblogs.com/tocy/p/linux-swap-cmd-summary.html || https://blog.csdn.net/xianjuke008/article/details/113461655

linux 增加swap 分区大小 https://www.jianshu.com/p/30cd53ed056c
- > **swap分区大小说明**
  * > 一般来说可以按照如下规则设置swap大小：
    ```console
    4G以内的物理内存，SWAP 设置为内存的2倍。
    4-8G的物理内存，SWAP 等于内存大小。
    8-64G 的物理内存，SWAP 设置为8G。
    64-256G物理内存，SWAP 设置为16G。
    ```
  * > 实际上，系统中交换分区的大小并不取决于物理内存的量，而是取决于系统中内存的负荷，所以在安装系统时要根据具体的业务来设置SWAP的值。
  * > 一般Linux桌面系统的SWAP设置的会相对大一点，而Linux服务器，特别是生产环境，SWAP可能只有一点点，1-2G，很多甚至都没有SWAP。
- > **添加swap交换分区空间**
- > **附：删除swap交换分区**

How to configure swappiness in Linux Memory Management? https://unix.stackexchange.com/questions/265713/how-to-configure-swappiness-in-linux-memory-management

Linux下设置swappiness参数来配置内存使用到多少才开始使用swap分区（转） https://www.cnblogs.com/EasonJim/p/7777904.html

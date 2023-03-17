
# 源头

how to tell which disk is sda and which is sdb disk? https://unix.stackexchange.com/questions/438570/how-to-tell-which-disk-is-sda-and-which-is-sdb-disk

# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

lsblk https://wangchujiang.com/linux-command/c/lsblk.html
- > lsblk命令默认情况下将以树状列出所有块设备。打开终端，并输入以下命令：
  ```sh
  lsblk

  NAME   MAJ:MIN rm   SIZE RO type mountpoint
  sda      8:0    0 232.9G  0 disk 
  ├─sda1   8:1    0  46.6G  0 part /
  ├─sda2   8:2    0     1K  0 part 
  ├─sda5   8:5    0   190M  0 part /boot
  ├─sda6   8:6    0   3.7G  0 part [SWAP]
  ├─sda7   8:7    0  93.1G  0 part /data
  └─sda8   8:8    0  89.2G  0 part /personal
  sr0     11:0    1  1024M  0 rom
  ```
- > 7个栏目名称如下：
  ```console
  NAME ：这是块设备名。
  MAJ:MIN ：本栏显示主要和次要设备号。
  RM ：本栏显示设备是否可移动设备。注意，在本例中设备sdb和sr0的RM值等于1，这说明他们是可移动设备。
  SIZE ：本栏列出设备的容量大小信息。例如298.1G表明该设备大小为298.1GB，而1K表明该设备大小为1KB。
  RO ：该项表明设备是否为只读。在本案例中，所有设备的RO值为0，表明他们不是只读的。
  TYPE ：本栏显示块设备是否是磁盘或磁盘上的一个分区。在本例中，sda和sdb是磁盘，而sr0是只读存储（rom）。
  MOUNTPOINT ：本栏指出设备挂载的挂载点。
  ```

# 个人实战

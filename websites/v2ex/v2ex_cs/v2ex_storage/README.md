
Linux 下，大存储(84Tb)选什么文件系统好？ https://www.v2ex.com/t/865940
- > 盘多的话 zfs ，盘少随意
- > openzfs
- > 一般的话 ext4 xfs 都行，zfs 的话需要大内存 ECC 内存条，要求高些。
  >> 12 个 16T 的机械硬盘做的 raid10 用 H710min 卡做的 <br> 内存有很多。几百个 G 都有。
  >>> zfs 属于软 raid ，一般用 hba 卡。如果硬 raid 就没必要用这个文件系统了，ext4 xfs 都可以
- > xfs 正解
- > 别用 ext4 ，没 xfs 稳定
- > min.io 最好了解一下，万一要扩呢。

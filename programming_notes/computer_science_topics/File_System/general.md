
文件系统 https://zh.wikipedia.org/wiki/%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F || File system https://en.wikipedia.org/wiki/File_system

阿里天池第一届PolarDB数据库性能大赛补遗（一）－谈文件系统对快存储IO性能的影响 - Jin MJ的文章 - 知乎 https://zhuanlan.zhihu.com/p/59212416

分布式文件系统架构对比 https://mp.weixin.qq.com/s/yYAgmQZe4CsXZlwtNamjcA

Linux 下用哪个文件系统格式最好？ EXT4 VS Btrfs VS XFS https://www.v2ex.com/t/837770

你管这叫文件系统？ https://www.ithome.com/0/643/446.htm || https://mp.weixin.qq.com/s/bYUGs-KBBzPafvZ7EbZJ1Q  【from `低并发编程`】

一口气搞懂「文件系统」，就靠这 25 张图了 - 小林coding的文章 - 知乎 https://zhuanlan.zhihu.com/p/183238194

# NFS

NFS (简体中文) https://wiki.archlinux.org/index.php/NFS_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

Linux NFS服务器的安装与配置 https://www.cnblogs.com/mchina/archive/2013/01/03/2840040.html

NFS的使用 · Linux 学习笔记 https://www.huweihuang.com/linux-notes/tools/nfs-usage.html

Linux下NFS服务器的搭建与配置 https://www.cnblogs.com/liuyisai/p/5992511.html

# Ceph

Ceph is a distributed object, block, and file storage platform https://github.com/ceph/ceph

Ceph相关论文：
- [译] [论文] Ceph: A Scalable, High-Performance Distributed File System (OSDI 2006) http://arthurchiao.art/blog/ceph-osdi-zh/
- 分布式存储 Ceph 的演进经验 · SOSP 2019 https://draveness.me/papers-ceph/

Red Hat Ceph存储—《深入理解Ceph架构》 http://ceph.org.cn/2018/06/29/red-hat-ceph%E5%AD%98%E5%82%A8-%E3%80%8A%E6%B7%B1%E5%85%A5%E7%90%86%E8%A7%A3ceph%E6%9E%B6%E6%9E%84%E3%80%8B/
- > 英文出处： Red Hat Ceph Storage 2 Architecture Guide https://access.redhat.com/documentation/en-US/Red_Hat_Ceph_Storage/2/pdf/Architecture_Guide/Red_Hat_Ceph_Storage-2-Architecture_Guide-en-US.pdf

Ceph介绍及原理架构分享 https://www.jianshu.com/p/cc3ece850433

# GFS

【MIT 6.824】学习笔记 3: GFS - 多颗糖的文章 - 知乎 https://zhuanlan.zhihu.com/p/354450124

# 其他

Facebook’s Tectonic Filesystem: Efficiency from Exascale - Lancer的文章 - 知乎 https://zhuanlan.zhihu.com/p/353383767

关于 Curve https://github.com/opencurve/curve/blob/master/README_cn.md
- > Curve 是网易主导自研的现代化存储系统, 目前支持文件存储(CurveFS)和块存储(CurveBS)。现作为沙箱项目托管于CNCF。
- > 对接 PolarDB | PG
  * > 作为存算分离形态分布式数据库 [PolarDB | PG](https://github.com/ApsaraDB/PolarDB-for-PostgreSQL) 底层存储底座, 为上层数据库应用提供数据一致性保证, 极致弹性, 高性能HTAP。部署详见[PolarDB | PG 进阶部署(CurveBS)](https://apsaradb.github.io/PolarDB-for-PostgreSQL/zh/deploying/storage-curvebs.html)。

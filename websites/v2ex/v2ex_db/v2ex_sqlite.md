
有没有人在生产用过 sqlite+nas 分布式存储的？ https://www.v2ex.com/t/1069791
- > 题外话，sqlite 不适合独立出来做数据服务器，适合嵌入在程序中， 这种就算用 sqlite 需要魔改，当然市面上已经有了这种魔改 sqlite 作为数据库引擎的高性能分布式数据库 (bloomberg 出的 `comdb2`) https://github.com/bloomberg/comdb2
- > 考虑 https://github.com/rqlite/rqlite 么？
- > SQLite 不适合分布式写入。要有高的写并发，就得利用 WAL ，尽可能缓冲多点事务，再落盘写入。而官方说，WAL 模式要求所有进程在同一主机上，不能在网络文件系统上工作：`All processes using a database must be on the same host computer; WAL does not work over a network filesystem. This is because WAL requires all processes to share a small amount of memory and processes on separate host machines obviously cannot share memory with each other.`
- > SQLite 的锁是基于文件系统的，所以官方也不建议你把数据库文件扔 NFS 里，主要是有些 NFS 文件系统实现的时候锁的机制做的不好，多线程或多进程访问的时候有可能损坏你的数据库文件。 <br> 但有些文件系统的实现是明确说过支持全部的锁机制，没记错的话 AWS 的 EBS 就可以。这种情况下你把 SQLite 文件放上去共享也没问题。

c++对大量图片进行序列化和反序列化 https://www.v2ex.com/t/1031297
```console
工作中开发的软件有这样一个需求：
程序用了某种算法对大量图片（约有 9 千多张，每张约 4M ）进行了处理。我该怎么将这所有的图片以数组的形式序列化为一个文件夹，当从硬盘将这些图片读回内存时可以随机访问图片，以便用户第二次打开。
```
- > 感谢大家的回复。我没有表达清楚问题的意思，我是希望将所有的图片能够序列化到一个文件中（不是文件夹），我保存的不单单只有图片，还有与图片相关的一系列的数据，编号等，因此我想请教有没有这样一种第三方库：能够以将图片，数据，编号，日期作为一个对象进行序列化，我起初使用的是 protobuf ，但是该库不能序列化太大的文件 。如果采用的是读取图片的名称，用户一旦修改了图片名，那么读取图片就会出错了。非常感谢大家的建议。
- > `9k * 4M` ，36 个 G 存入一个文件，还想瞬间读写？建议存缩略图进 sqlite
- > 换个思路，直接把文件打包成一个不带压缩的 zip 文件。zip 文件是支持随机读取的。
- > zip 文件可以，但是大小有一定限制，有 zip64 的变种，可以支持 4G 以上的大文件。
- > 记录 offset ，fseek 即可
- > 数据库中存索引和 meta info ，图片文件一律改名成 ID ，完毕。IO 不够就把文件丢进分布式文件系统里从网络读
- > 我怀疑你是微信上找我的那个人 内存映射即可解决
- > 那就存 SQLite 数据库呗。。
  ```console
  优点：
  - 单文件
  - 可随机读写
  - 依赖库只有几百 KB
  - 有原生 C/C++ 接口
  - 可存一系列数据（编号、日期、数据、图片文件本身、……），单个数据最大 2GB

  写了 10GB 共 2500 条数据（每条包含 4MB 图片及数据），
  再测试下，随机读取图片速度（测试前，已用 RamMap 清空系统文件缓存）：
  - 机械盘：27 条数据/秒（ 150 MB/s 顺序读取，0.65 MB/s 随机 4K 读取）
  - 内存盘：323 条数据/秒（ 6754 MB/s 顺序读取，310 MB/s 随机 4K 读取，感觉明显没吃满 IO ）
  ```

跑 SQLite 查询不及时使用 sqlite3_finalize() 的严重后果，望周知。 https://www.v2ex.com/t/996370

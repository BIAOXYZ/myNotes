
# 官方

Timescale https://www.timescale.com/  -->  TigerData https://www.tigerdata.com/

TimescaleDB https://github.com/timescale/timescaledb
- > TimescaleDB is a PostgreSQL extension for high-performance real-time analytics on time-series and event data

# 文章

聊一聊时序数据库与TimescaleDB - xiongcc的文章 - 知乎 https://zhuanlan.zhihu.com/p/672345360
- > TimescaleDB简介
  * > TimescaleDB包含以下特性：
  * > 除此之外，有一点必须要提一下：TimescaleDB 还支持了 `Index skip scan`，加速 `distinct`。
  * > 另外关于 TimescaleDB 的压缩，也有"列存"的概念，不过并非 CK 这类的原生列存，其本质上就是利用数组存储多值，多条记录，给定一批数据（约 1,000 行），每列数据都会聚合到一个数组中，每个数组元素对应于原始行之一的值，比如原来的数据是
  * > 即使在应用压缩算法之前，这种格式也可以通过大大减少 Timescale 的内部每一行的存储开销来节省存储空间 (Tupleheader至少23个字节)。
- > 架构
  * > TimescaleDB 中的表叫做`超表`——`Hypertable`，每个分片叫做一个"chunk"，超表可以理解成一个虚拟层、代理层，一个视图，***实际是一个`分区表`***，各个 chunk 是通过继承实现的分区表，这些对于用户是完全透明的，使用超表和使用普通的表无异，***不过既然是分区表，那么`唯一索引`必须包含`分区列`这个限制还是存在的***。

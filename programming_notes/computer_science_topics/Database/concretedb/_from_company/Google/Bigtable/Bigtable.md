
# 官方

Cloud Bigtable https://cloud.google.com/bigtable?hl=zh-cn

Bigtable https://zh.wikipedia.org/wiki/Bigtable
- > BigTable不是传统的关系型数据库，不支持JOIN这样的SQL语法，BigTable更像今日的NoSQL的Table-oriented，优势在于扩展性和性能。BigTable的Table数据结构包括row key、col key和timestamp，其中row key用于存储倒转的URL，例如www.google.com必须改成com.google.www。BigTable使用大量的Table，在Table之下还有Tablet。每一个Tablets大概有100-200MB，每台机器有100个左右的Tablets。所谓的Table是属于immutable的SSTables，也就是存储方式不可修改。另外Table还必须进行压缩，其压缩又分成table的压缩或系统的压缩。客户端有一指向META0的Tablets的指针，META0 tablets保储所有的META1的tablets的资料记录。

# 论文

Bigtable: A Distributed Storage System for Structured Data https://static.googleusercontent.com/media/research.google.com/en//archive/bigtable-osdi06.pdf

Bigtable 论文详述 - 呆呆的文章 - 知乎 https://zhuanlan.zhihu.com/p/35687103

# 其他

浅析 Bigtable 和 LevelDB 的实现 https://draveness.me/bigtable-leveldb/

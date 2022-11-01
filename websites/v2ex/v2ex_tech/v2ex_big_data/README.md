
基于内存数据库做大数据运算是否靠谱？ https://www.v2ex.com/t/891636
- > spark 临时表
- > flink 试一试
- > SAP HANA 可以尝试一下，不过成本非常高
- > trino 或者 presto 试一试
- > 1.整个过程不要求实时计算,那么直接原始数据入 mpp 库,整个 dag 在 mpp 里执行.就是数仓那一套. <br> 2.整体要实时计算,可以试试 flink,最后把结果写入 mpp,供后续使用. 至于中间结果,可以就一整套 flink sql(这种中间状态会变大,不可控),或者中间结果打入 redis,flink 实时异步关联
- > spark-redis 了解下。
- > 如果是简单 etl, 建议实时就 flink sql +udf, 离线就 hive/spark, 想方便就还继续 mpp 数据库吧, 毕竟一把梭
- > 内存数据库的方案我玩过，先说结论，玩好了效果很好 <br> 用的是 Hive Transform + Python 脚本 + Python 内置的 SQLite 模块做内存数据库。只要控制好每个节点数据量（比如根据某个 id hash 到不同 reducer ，这样就能承载很大的总数据量），效果就非常好，比我那个项目以前的方案强很多。当时这个方案由于效果太好还在公司内有些反响
- > 除了 spark 和 flink ，补充一个 Apache Ignite （这个才是和 redis 一类的真内存数据库，支持内存数据表 session 持久化，支持 acid ） <br> https://stackoverflow.com/questions/36036910/apache-spark-vs-apache-ignite <br> 不过所有内存的东西不落盘都不靠谱，即便你能用上持久化内存也一样，所以你得切分清楚哪些东西是进了内存库后往里读 /往外写了一半全丢了也不要紧
- > ramdisk 可以试试

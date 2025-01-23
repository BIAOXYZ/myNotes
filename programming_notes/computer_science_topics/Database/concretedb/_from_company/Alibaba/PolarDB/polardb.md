
# 官方

JOIN优化和执行 https://doc.polardbx.com/sql-tunning/topics/join-optimizing.html
- > **JOIN顺序**
  * > 在多表连接的场景中，优化器的一个很重要的任务是决定各个表之间的连接顺序，因为不同的连接顺序会影响中间结果集的大小，进而影响到计划整体的执行代价。
  * > 例如，对于`4张表`JOIN（暂不考虑下推的情形），JOIN Tree可以有如下`3种`形式，同时表的排列又有`4! = 24种`，一共有`72种`可能的JOIN顺序。 <br> ![](https://doc.polardbx.com/sql-tunning/images/p334721.png)

# 课程

数据库内核从入门到精通 https://developer.aliyun.com/learning/topic/database

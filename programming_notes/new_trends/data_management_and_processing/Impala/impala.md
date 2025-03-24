
# 官方

Welcome to Impala https://github.com/apache/impala

Apache Impala https://impala.apache.org/

# 文章

Impala与Spark SQL的兼容性分析及处理 - 温正湖的文章 - 知乎 https://zhuanlan.zhihu.com/p/718382054
- > 本文基于`Impala 4.1`和`Spark 3.1/3.3`版本进行了SQL兼容性分析，并提供改写建议。由于对spark了解比较有限，里面的分析和改写建议供参考，发现错误或有补充还望各位大佬指正
- > **不兼容语法**
  ```console
  spark 3.3 不支持 offset
  spark as 别名需要使用 ``，impala as 别名可以使用 ’‘
  spark 不支持 cast as timestamp format 'yyyy-MM-dd' 这样的使用，举例 select cast('01-01-2000' as timestamp format 'MM-dd-yyyy')
  spark 不支持 RIGHT ANTI JOIN 和 RIGHT SEMI JOIN， 除此之外 calcite 不支持在 SqlJoin 中放 LEFT ANTI JOIN 类型
  spark 和 impala 在跑 select t.* from tbl inner join tbl t using(col) 时 impala 结果集会多一列（应该算不兼容但是语义应该是一样的）。
  union 和 limit 的优先级不同，举例 select * from call_center union select * from call_center limit 10
  spark 不支持 where NULL，举例 select * from call_center WHERE NULL
  spark 不支持 tablesample，举例 select * from call_center t tablesample system(100) repeatable(20)
  spark 3.1 insert 的 query source 部分不能是直接的 with 语句，需要移到 insert 之外
  ```

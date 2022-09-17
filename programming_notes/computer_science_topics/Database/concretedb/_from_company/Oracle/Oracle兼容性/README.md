
21 Oracle兼容性 https://github.com/digoal/blog/blob/master/class/21.md
- PostgreSQL , EDB EPAS PPAS(兼容Oracle) , Oracle 对比（兼容性、特性优劣势） - 企业去O,去IOE https://github.com/digoal/blog/blob/master/201903/20190301_01.md

漫谈数据库的 Oracle 兼容 - 唐僧的文章 - 知乎 https://zhuanlan.zhihu.com/p/69347701
- > 原文链接：https://zedware.github.io/ORACLE-COMPATIBILITY/

Oracle Package的使用 https://cloud.tencent.com/developer/article/1470444
- > 我们在Oracle的数据库里面在逻辑处理的时候可能会写大量的存储过程，由于数据多了以后，找起来比较麻烦，用package不仅能把存储过程分门别类，而且在package里可以定义公共的变量/类型，既方便了编程，又减少了服务器的编译开销。还有一点，不同的package的存储过程可以重名。
- > 我们在程序或是PL/SQL里执行存储过程时，直接就输入存储过程名就可以了，如果把存储过程都加入到package里面后，调用时需要先输入**`包名.存储过程名`**。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# DB2兼容Oracle

Oracle 的兼容性功能 https://www.ibm.com/docs/zh/ias?topic=compatibility-features-oracle

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# PG兼容Oracle

## 1
- 这个库的文档：https://www.ivorysql.org/docs/Compatibillity_Features/parameter_settings
- 匿名块实现：https://github.com/IvorySQL/IvorySQL/commit/832d23781ba1827bbd3a82cce3480208099f081d
- 不用CALL就能调用函数：https://github.com/IvorySQL/IvorySQL/commit/eb035aac4afb34cfbcdd77468f520f9cefff54ed

Group By https://www.ivorysql.org/zh-CN/docs/Compatibillity_Features/groupby
- > 当 `compatible_mode` 为 `oracle` 时，即使group by子句中有主键列，目标列也必须存在于group by子句中。
  ```sql
  set compatible_mode to oracle;

  create table students(student_id varchar(20) primary key ,
  student_name varchar(40),
  student_pid int);

  select student_id,student_name from students group by student_id;
  ERROR:  column "students.student_name" must appear in the GROUP BY clause or be used in an aggregate function
  ```

## 其他

https://www.jianshu.com/u/aaa5eddef78e
- Postgres兼容Oracle语法研究-extension https://www.jianshu.com/p/cdb84a9f49a1
- Postgres兼容Oracle语法研究-extension（续） https://www.jianshu.com/p/a6164ed189ef
- Postgres兼容Oracle研究——orafce调研 https://www.jianshu.com/p/3b8e1c47fecf
  * > orafce源码：https://github.com/orafce/orafce

What's the equivalent to Oracle Packages in PostgreSQL https://stackoverflow.com/questions/35043957/whats-the-equivalent-to-oracle-packages-in-postgresql

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# GP兼容Oracle

Oracle兼容性函数 https://gp-docs-cn.github.io/docs/utility_guide/orafce_ref.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# openGauss兼容Oracle

对于Oracle的SQL方言，openGauss的兼容性如何？ https://www.sohu.com/a/435329449_411876

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# PolarDB兼容Oracle

Oracle兼容性说明 https://help.aliyun.com/document_detail/116365.html || https://www.alibabacloud.com/help/zh/polardb-for-oracle/latest/oracle-compatibility

DTCC 2020 | 阿里云赵殿奎：PolarDB的Oracle平滑迁移之路 https://segmentfault.com/a/1190000038887221

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# OceanBase兼容Oracle

OceanBase 2.2 体验：ORACLE兼容性测试 https://blog.51cto.com/u_13929755/5287876

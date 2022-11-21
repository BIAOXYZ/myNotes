
SQL优化——IN和EXISTS谁的效率更高 https://cloud.tencent.com/developer/article/1868851
- > **总结**
  * > 1、IN查询在内部表和外部表上都可以使用到索引；
  * > 2、EXISTS查询仅内部表上可以使用到索引，外表会全表扫描；当子查询结果集很大，而外部表较小的时候，EXISTS的Block Nested Loop(Block 嵌套循环)的作用开始显现，查询效率会优于IN；
  * > 3、当子查询结果集较小，而外部表很大的时候，EXISTS的Block嵌套循环优化效果不明显，IN 的外表索引优势占主要作用，此时IN的查询效率会优于EXISTS。
  * > 子查询结果集越大用EXISTS，子查询结果集越小用IN。
- > 墨天轮原文链接：https://www.modb.pro/db/95929

SQL优化 - 避免使用 IN 和 NOT IN https://blog.csdn.net/fly910905/article/details/78288685
- > HOW？
  * > 1、用 EXISTS 或 NOT EXISTS 代替
  * > 2、用JOIN 代替
- > PS：那我们死活都不能用 IN 和 NOT IN 了么？并没有，一位大神曾经说过，***如果是确定且有限的集合时，可以使用。如 IN （0，1，2）***。


# 文章

基于antlr4实现hiveSQL的解析[表血缘和字段血缘] http://ganjiacheng.cn/article/2020/article_14_%E5%9F%BA%E4%BA%8Eantlr4%E5%AE%9E%E7%8E%B0HQL%E7%9A%84%E8%A7%A3%E6%9E%90-%E8%A1%A8%E8%A1%80%E7%BC%98%E5%92%8C%E5%AD%97%E6%AE%B5%E8%A1%80%E7%BC%98/

分类 SQL解析与数据血缘 下的文章 https://makeyourchoice.cn/category/sql_parse_lineage/
- 从事SQL血缘解析一年后，谈谈我对它的理解 https://makeyourchoice.cn/archives/568/

SQL血缘解析原理 https://blog.csdn.net/shy_snow/article/details/133373567
- > 3.访问AST抽象语法树根据语法结构推测出数据的流向。
  * > 语法树中包含了sql的全部信息， 可以从中获取到所需信息。***但是，访问代码并不好写，因为语法树中封装的对象类型很多，不同的类型需要不同的访问方式***，一般使用visitor访问者模式进行访问。大部分的业务代码就在这里访问sql解析后的AST语法树（Abstract Syntax Tree），然后获取源表和目标表之间的对应关系，即所谓血缘关系。

# 非SQL血缘直接相关

漫谈数据血缘系统 https://izualzhy.cn/sql-lineage

Spark App 血缘解析方案 https://tech.youzan.com/spark-app-xie-yuan-jie-xi-fang-an/

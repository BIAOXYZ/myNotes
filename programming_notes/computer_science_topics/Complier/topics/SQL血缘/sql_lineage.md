
# 文章

基于antlr4实现hiveSQL的解析[表血缘和字段血缘] http://ganjiacheng.cn/article/2020/article_14_%E5%9F%BA%E4%BA%8Eantlr4%E5%AE%9E%E7%8E%B0HQL%E7%9A%84%E8%A7%A3%E6%9E%90-%E8%A1%A8%E8%A1%80%E7%BC%98%E5%92%8C%E5%AD%97%E6%AE%B5%E8%A1%80%E7%BC%98/
- > **前言**
  * > 代码实现参考：https://github.com/webgjc/sql-parser/

分类 SQL解析与数据血缘 下的文章 https://makeyourchoice.cn/category/sql_parse_lineage/
- 基于Antlr对PostgreSql血缘解析（表、列），并存入Atlas https://makeyourchoice.cn/archives/523/
  * > 注意：ANTLR的运行库提供了两种遍历树的机制：监听器机制与访问器机制。***与访问器不同的是，监听器的方法会被ANTLR提供的遍历器对象（比如ParseTreeWalker）自动调用，而在访问器的方法中，必须显示调用visit方法来访问子节点。如果没有调用visit方法就会导致对应的子树不被访问***。而且监听器方法是没有返回值的（即返回类型是void）。
- 从事SQL血缘解析一年后，谈谈我对它的理解 https://makeyourchoice.cn/archives/568/

SQL血缘解析原理 https://blog.csdn.net/shy_snow/article/details/133373567
- > 3.访问AST抽象语法树根据语法结构推测出数据的流向。
  * > 语法树中包含了sql的全部信息， 可以从中获取到所需信息。***但是，访问代码并不好写，因为语法树中封装的对象类型很多，不同的类型需要不同的访问方式***，一般使用visitor访问者模式进行访问。大部分的业务代码就在这里访问sql解析后的AST语法树（Abstract Syntax Tree），然后获取源表和目标表之间的对应关系，即所谓血缘关系。

# 非SQL血缘直接相关

漫谈数据血缘系统 https://izualzhy.cn/sql-lineage

Spark App 血缘解析方案 https://tech.youzan.com/spark-app-xie-yuan-jie-xi-fang-an/

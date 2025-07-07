
# 文章

基于antlr4实现hiveSQL的解析[表血缘和字段血缘] http://ganjiacheng.cn/article/2020/article_14_%E5%9F%BA%E4%BA%8Eantlr4%E5%AE%9E%E7%8E%B0HQL%E7%9A%84%E8%A7%A3%E6%9E%90-%E8%A1%A8%E8%A1%80%E7%BC%98%E5%92%8C%E5%AD%97%E6%AE%B5%E8%A1%80%E7%BC%98/
- > **前言**
  * > 代码实现参考：https://github.com/webgjc/sql-parser/

分类 SQL解析与数据血缘 下的文章 https://makeyourchoice.cn/category/sql_parse_lineage/
- 基于Antlr对PostgreSql血缘解析（表、列），并存入Atlas https://makeyourchoice.cn/archives/523/
  * > 注意：ANTLR的运行库提供了两种遍历树的机制：监听器机制与访问器机制。***与访问器不同的是，监听器的方法会被ANTLR提供的遍历器对象（比如ParseTreeWalker）自动调用，而在访问器的方法中，必须显示调用visit方法来访问子节点。如果没有调用visit方法就会导致对应的子树不被访问***。而且监听器方法是没有返回值的（即返回类型是void）。
- 从事SQL血缘解析一年后，谈谈我对它的理解 https://makeyourchoice.cn/archives/568/

从事SQL血缘解析一年后，谈谈我对它的理解 https://makeyourchoice.cn/archives/568/
- 回复：
  * > 有没有什么开源的的代码可以解析呀
    >> calcite 里 RelMetadataQuery 有一个方法是 getExpressionLineage 可以获得带来源信息的 RexCall，你可以通过这个来提取血缘信息。单纯的SQL解析框架有很多，可以参考 Trino 的 parser 模块
  * > 怎么提取 列血缘关系呀, 我用antlr 能解析出 select语句的信息了,包括嵌套子查询等. 怎么样的逻辑提取列血缘并用什么结构存储呢?
    >> antlr解析出来的是SQL1:1抽象语法树，血缘解析属于是语义分析了（作用域分析），需要再设计一套AST，这套AST具备血缘分析能力；这句话的理解你可以类比Calcite里的 SqlNode -> 校验 -> RelNode（***SqlNode类似于Antlr生成的那一层AST***）
  * > 能否请教下，有什么高效的方法解析sql statement的类型（可以支持各种方言sql的）？
    >> 文章里还没写，我最近会更新。解析sql的话就使用一些解析器，antlr或calcite，antlr有相应的词法文件`g4`，也比较容易扩展；calcite内部用`parse.jj`，扩展能力比antlr差点，但是速度比antlr快；如果你考虑易扩展且高效解析，可以混合使用两种解析器
    >>> 请教下，怎么混合两种解析器呢？
    >>>> 你项目里同时引 calcite 和 antlr ，可以先用 calcite 做解析，calcite 解析失败了再使用 antlr 解析， antlr 做兜底
    >>>>> 非常感谢，但是我不仅仅需要解析，还需要做关系的映射，这种情况下，是不是把antlr抽象出类似于Calcite中的SqlNode，以统一结果
    >>>>>> 可以的，sql --> calcite --> sqlNode，sql --> antlr --> parseTree，两者结果都是一个抽象语法树 ast，你可以把 antlr 解析后的 parseTree 再遍历转换成 sqlNode，统一抽象语法树，方便做后续处理，你可以参考我另一篇文章`Calcite使用Antlr解析并扩展其他方言`，是个demo，就是做这个

SQL血缘解析原理 https://blog.csdn.net/shy_snow/article/details/133373567
- > 3.访问AST抽象语法树根据语法结构推测出数据的流向。
  * > 语法树中包含了sql的全部信息， 可以从中获取到所需信息。***但是，访问代码并不好写，因为语法树中封装的对象类型很多，不同的类型需要不同的访问方式***，一般使用visitor访问者模式进行访问。大部分的业务代码就在这里访问sql解析后的AST语法树（Abstract Syntax Tree），然后获取源表和目标表之间的对应关系，即所谓血缘关系。

基于Calcite解析Flink SQL列级数据血缘 https://blog.csdn.net/nazeniwaresakini/article/details/121652104

FlinkSQL的字段血缘解决方案 https://mp.weixin.qq.com/s/aBPbITpUDCWgWvOLLcscqg || https://www.sohu.com/a/674488599_121124371 || FlinkSQL的字段血缘解决方案 - DataFunTalk的文章 - 知乎 https://zhuanlan.zhihu.com/p/628376451
- > **01 Apache Calcite 简介**
  * > ![](https://mmbiz.qpic.cn/sz_mmbiz_png/EBaibcQicPxgxShNO0S5sMbD4EpVRsz8czUEIsrZPiaz2YiaTwFXSH4llhd9cbVGwhyjemKICb9Gxbxs4BmdyuZRgQ/640)

深度好文！FlinkSQL字段血缘解决方案及源码 https://mp.weixin.qq.com/s/ub3_so6q-0N78Sri9CVUew
- 回复：
  * > up主，有完整的源码吗？想照着实践一下
    >> https://github.com/HamaWhiteGG/flink-sql-lineage

深度探究 Apache Calcite SQL 校验器实现原理 https://strongduanmu.com/blog/in-depth-exploration-of-implementation-principle-of-apache-calcite-sql-validator.html
- > 完成校验后，返回的 outermostNode 结构如下，可以看到 SqlNode 的 Identifier 都进行了全限定名展开，根据 names 属性可以很快速地获取到列对象所属的表，以及表对象所属的 Schema。***使用 SqlValidator#getFieldOrigins 方法可以获取列的原始类型，该类型中包含 catalog, schema, table, column，可以用来实现 SQL 血缘分析等需求***。函数对象则会查找到 Calcite 内置的函数，或者用户在元数据中定义的函数，这些校验后的对象将在后续 SqlNode 转换 RelNode 过程中发挥重要作用。

# 非SQL血缘直接相关

漫谈数据血缘系统 https://izualzhy.cn/sql-lineage

Spark App 血缘解析方案 https://tech.youzan.com/spark-app-xie-yuan-jie-xi-fang-an/

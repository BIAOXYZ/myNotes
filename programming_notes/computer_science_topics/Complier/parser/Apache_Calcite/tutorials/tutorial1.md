
# 1

Tutorial https://calcite.apache.org/docs/tutorial.html || 教程 https://strongduanmu.com/wiki/calcite/tutorial.html
- https://github.com/apache/calcite/tree/main/example/csv
  * https://github.com/apache/calcite/blob/main/example/csv/src/test/resources/smart.json

Calcite官方教程避坑 https://blog.csdn.net/weixin_44112790/article/details/114284434  【生草，就没见过这么坑爹的官方教程】

# 2

Apache Calcite 学习文档 https://github.com/quxiucheng/apache-calcite-tutorial/tree/master

# 3

Calcite tutorial at BOSS 2021 https://www.youtube.com/watch?v=meI0W12f_nw&t=532s
- calcite-tutorial https://github.com/zabetak/calcite-tutorial

# 4

Apache Calcite原理与实践 https://liebing.org.cn/collections/calcite/
- Apache Calcite整体架构及处理流程 https://liebing.org.cn/apache-calcite-overview.html
- Apache Calcite SQL解析及语法扩展 https://liebing.org.cn/apache-calcite-sql-parser.html

Apache Calcite整体架构及处理流程 https://liebing.org.cn/apache-calcite-overview.html
- > Apache Calcite是一个动态的数据管理框架, 它可以实现SQL的`解析`, `验证`, `优化`和`执行`. ***称之为”动态”是因为Calcite是模块化和插件式的, 上述任何一个步骤在Calcite中都对应着一个相对独立的模块. 用户可以选择使用其中的一个或多个模块, 也可以对任意模块进行定制化的扩展***. 正是这种灵活性使得Calcite可以在现有的存储或计算系统上方便地构建SQL访问层, 甚至在已有SQL能力的系统中也可引入Calcite中的某个模块实现相应的功能, ***比如`Apche Hive`就仅使用了Calcite进行优化, 但却有自己的SQL解析器***. Calcite的这种特性使其在大数据系统中得到了广泛的运用, 比如`Apache Flink`, `Apache Drill`等都大量使用了Calcite, 因此理解Calcite的原理已经成为理解大数据系统中SQL访问层实现原理的必备条件.
- > **Calcite整体架构**
  * > Calcite的整体架构如下图(图片来自[Calcite论文](https://dl.acm.org/doi/pdf/10.1145/3183713.3190662))所示, 它包含以下组成部分:
  * > ![](https://liebing.org.cn/apache-calcite-overview/arch.png)
- > **Calcite处理流程**
  * > 为了更加深入地理解上述步骤, 笔者设计了一个小而全的案例, 通过Calcite实现使用SQL访问CSV文件. 后文我们将依据Calcite处理的5个阶段, 逐步分析每个阶段所做的工作和输出结果. 为方便阅读本文只给出了核心代码, 完整的可执行代码可参考[这里](https://github.com/LB-Yu/data_systems_learning/tree/master/sql-recognition-learning/calcite-learning/calcite-parser/src/main/java/org/apache/calcite/example/overall)。
    >> 【[ :star: ][`*`]】 //notes：文件位置有变，所以自己fork了一个： https://github.com/BIAOXYZ/forked--data-systems-learning/tree/master/sql/calcite-learning/calcite-parser/src/main/java/org/apache/calcite/example/overall
- > **SQL解析**
  * > SQL语句处理的第一步便是通过词法分析和语法分析将SQL字符串转化为AST. 在Calcite中, 借助[`JavaCC`](https://javacc.github.io/javacc/)实现了SQL的解析, 并转化为SqlNode表示. JavaCC是一种解析器生成器工具, 可以根据用户提供的语法规则文件自动生成解析器, 如果对如何使用JavaCC生成抽象语法树感兴趣可阅读笔者之前的博文[编译原理实践 - JavaCC解析表达式并生成抽象语法树](https://liebing.org.cn/javacc-expression-ast.html).
  * > 在Calcite中, SqlNode是AST节点的抽象基类, 不同类型的节点有对应的实现类. 比如上述SQL语句便会生成SqlSelect和SqlOrderBy两个主要的节点. 在Calcite中, 我们可以简单地使用如下代码将SQL字符串转化为SqlNode.
    ```java
    String sql = "SELECT u.id, name, age, sum(price) " +
        "FROM users AS u join orders AS o ON u.id = o.user_id " +
        "WHERE age >= 20 AND age <= 30 " +
        "GROUP BY u.id, name, age " +
        "ORDER BY u.id";
    // 创建SqlParser, 用于解析SQL字符串
    SqlParser parser = SqlParser.create(sql, SqlParser.Config.DEFAULT);
    // 解析SQL字符串, 生成SqlNode树
    SqlNode sqlNode = parser.parseStmt();
    ```
  * > 上述代码中的sqlNode是AST的根节点, 下图是将其展开后的结果. 可以看到sqlNode其实是SqlOrderBy类型, 它的query字段是一个SqlSelect类型, 即代表原始的SQL语句去掉ORDER BY部分. 图中红色矩形框内的其实都是SqlNode类型.
- > **SQL验证**
  * > SQL解析阶段只是简单地将SQL字符串转化为SqlNode树, 并没有对SQL语句进行语义上的检查, 比如SQL中指定的表是否存在于数据库中, 字段是否存在于表中等. Calcite中的SQL验证阶段一方面会借助元数据信息执行上述验证, 另一方面会对SqlNode树进行一些改写, 以转化为统一的格式, 方便下一步处理.
  * > 在Calcite中可通过以下代码进行SQL验证.
    ```java
    // 创建Schema, 一个Schema中包含多个表. Calcite中的Schema类似于RDBMS中的Database
    SimpleTable userTable = SimpleTable.newBuilder("users")
        .addField("id", SqlTypeName.VARCHAR)
        .addField("name", SqlTypeName.VARCHAR)
        .addField("age", SqlTypeName.INTEGER)
        .withFilePath("/path/to/user.csv")
        .withRowCount(10)
        .build();
    SimpleTable orderTable = SimpleTable.newBuilder("orders")
        .addField("id", SqlTypeName.VARCHAR)
        .addField("user_id", SqlTypeName.VARCHAR)
        .addField("goods", SqlTypeName.VARCHAR)
        .addField("price", SqlTypeName.DECIMAL)
        .withFilePath("/path/to/order.csv")
        .withRowCount(10)
        .build();
    SimpleSchema schema = SimpleSchema.newBuilder("s")
        .addTable(userTable)
        .addTable(orderTable)
        .build();    
    CalciteSchema rootSchema = CalciteSchema.createRootSchema(false, false);
    rootSchema.add(schema.getSchemaName(), schema);

    RelDataTypeFactory typeFactory = new JavaTypeFactoryImpl();

    // 创建CatalogReader, 用于指示如何读取Schema信息
    Prepare.CatalogReader catalogReader = new CalciteCatalogReader(
        rootSchema,
        Collections.singletonList(schema.getSchemaName()),
        typeFactory,
        config);
    // 创建SqlValidator, 用于执行SQL验证
    SqlValidator.Config validatorConfig = SqlValidator.Config.DEFAULT
        .withLenientOperatorLookup(config.lenientOperatorLookup())
        .withSqlConformance(config.conformance())
        .withDefaultNullCollation(config.defaultNullCollation())
        .withIdentifierExpansion(true);
    SqlValidator validator = SqlValidatorUtil.newValidator(
        SqlStdOperatorTable.instance(), catalogReader, typeFactory, validatorConfig);
    // 执行SQL验证
    SqlNode validateSqlNode = validator.validate(node);
    ```
- > **参考**
  * > `[4]` Apache Calcite 处理流程详解（一） https://matt33.com/2019/03/07/apache-calcite-process-flow/
- 本文涉及链接：
  * ~~https://github.com/LB-Yu/data_systems_learning/tree/master/sql-recognition-learning/calcite-learning/calcite-parser/src/main/java/org/apache/calcite/example/overall~~  -->  https://github.com/BIAOXYZ/forked--data-systems-learning/tree/master/sql/calcite-learning/calcite-parser/src/main/java/org/apache/calcite/example/overall
  * JavaCC -- The most popular parser generator for use with Java applications. https://javacc.github.io/javacc/
  * 编译原理实践 - JavaCC解析表达式并生成抽象语法树 https://liebing.org.cn/javacc-expression-ast.html

# 5

Apache Calcite Code Reading Part 1 https://medium.com/@masayuki/calcite-code-reading-part-1-4ff7cdc56959

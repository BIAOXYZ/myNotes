
# antlr official

Grammars-v4 https://github.com/antlr/grammars-v4/tree/master
- > Grammars written for ANTLR v4; expectation that the grammars are free of actions.

`grammars-v4/sql/postgresql/PostgreSQLParser.g4` https://github.com/antlr/grammars-v4/blob/master/sql/postgresql/PostgreSQLParser.g4

# other project official

## Hive

【这个应该是 Hive 的存储过程语言】
- `hive/hplsql/src/main/antlr4/org/apache/hive/hplsql/Hplsql.g4` https://github.com/apache/hive/blob/master/hplsql/src/main/antlr4/org/apache/hive/hplsql/Hplsql.g4

Hive SQL语法规则（多个文件）
- `hive/parser/src/java/org/apache/hadoop/hive/ql/parse/HiveLexer.g` https://github.com/apache/hive/blob/branch-4.0/parser/src/java/org/apache/hadoop/hive/ql/parse/HiveLexer.g
- `hive/parser/src/java/org/apache/hadoop/hive/ql/parse/HiveLexerParent.g` https://github.com/apache/hive/blob/branch-4.0/parser/src/java/org/apache/hadoop/hive/ql/parse/HiveLexerParent.g
- `hive/parser/src/java/org/apache/hadoop/hive/ql/parse/HiveLexerStandard.g` https://github.com/apache/hive/blob/branch-4.0/parser/src/java/org/apache/hadoop/hive/ql/parse/HiveLexerStandard.g
- `hive/parser/src/java/org/apache/hadoop/hive/ql/parse/HiveParser.g` https://github.com/apache/hive/blob/branch-4.0/parser/src/java/org/apache/hadoop/hive/ql/parse/HiveParser.g
- `hive/parser/src/java/org/apache/hadoop/hive/ql/parse/FromClauseParser.g` https://github.com/apache/hive/blob/branch-4.0/parser/src/java/org/apache/hadoop/hive/ql/parse/FromClauseParser.g
- `hive/parser/src/java/org/apache/hadoop/hive/ql/parse/IdentifiersParser.g` https://github.com/apache/hive/blob/branch-4.0/parser/src/java/org/apache/hadoop/hive/ql/parse/IdentifiersParser.g
- ......

https://github.com/alan2lin/hive_ql_parser
- > **第四章 语法分析**
  * > **第一节 快速定位词法语法分析的位置的方法**
  * > **第二节 语法文件之间的关系**
    + > 熟悉antlr v3的朋友一般会奇怪，为什么这里的词法语法怎么不是在一个文件，或者词法语法结对出现呢？ 这里面用到了一种叫 `composite grammars` 的技术。 这种高级货是antlr v3.1开始引进的。 是为了解决把所有语法塞入到一个文件里导致编译出来的java文件过大和逻辑多了之后不容易阅读的问题。它允许在逻辑上把一个大语法划分成几大块，独立实现，然后合并在一起。
    + > `HiveParser.g` 有一行 `import SelectClauseParser, FromClauseParser, IdentifiersParser;` 类似于 c 中的 include SelectClauseParser.g, FromClauseParser.g, IdentifiersParser.g

## ClickHouse

`ClickHouse/utils/antlr/ClickHouseParser.g4` https://github.com/ClickHouse/ClickHouse/blob/master/utils/antlr/ClickHouseParser.g4

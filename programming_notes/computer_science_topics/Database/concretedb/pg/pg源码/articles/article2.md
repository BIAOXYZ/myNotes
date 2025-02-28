
# 1

https://cch1996.github.io/tags/#postgres
- postgres 查询处理流程分析 https://cch1996.github.io/2020/07/11/postgres-02/

postgres 查询处理流程分析 https://cch1996.github.io/2020/07/11/postgres-02/
- > 查询编译
  * > PostgreSQL 从客户端接收一用户的SQL查询之后，backend得到的是一串SQL字符串，会先调用由lex 和 yacc编写的查询编译模块，将SQL字符串解析成内部的数据结构——ParseTree构成的链表，这一步主要通过pg_parse_query函数完成，这一步主要检查的是SQL的语法，如果存在语法错误，就是在这一步报错。PG的语法定义，可以看gram.y的源文件。
- > 语义分析
  * > 得到ParseTree之后，需要对查询进行语义分析与查询重写，由pg_analyze_and_rewrite完成。语义分析的工作，就是检查SQL里是否由不符合语义规定的部分，比方说，它会去看用户要查询的表是否存在，要查询的列是否在表中存在，SQL里使用的函数是否存在定义等等情况。查询分析的输入，是查询编译产生的ParseTree构成的链表，输出则是Query链表。***查询分析会分根据查询的类别(`T_SelectStmt`, `T_UpdateStmt`, `T_InsertStmt`..等等)调用不同的函数进行语义分析。对SQL的每个子句，都会调用`transformXXStmt`来进行语义分析***，如对SQL的`From子句`，调用的就是`transformfromStmt`函数来，对目标属性的分析处理，则调用`transformTargetList`来进行，我们平常写的 `Select * from ..` 的星号，就是在这一步展开成表中所有的列名的。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:


# 1

## `grun` 个人实战

实战1：官方简单的例子（ https://github.com/antlr/antlr4/blob/master/doc/getting-started.md#a-first-example ）
```g4
// Define a grammar called Hello
grammar Hello;
r  : 'hello' ID ;         // match keyword hello followed by an identifier
ID : [a-z]+ ;             // match lower-case identifiers
WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines
```
```sh
# 必须先编译生成相应的 java class 才能 debug，哪怕你用其他语言的 binding 也一样。
$ cd 1-hello/
$ antlr4 Hello.g4
$ javac Hello*.java

$ grun Hello r -gui
hello bob
^D
# 弹出生成的图片

$ cd 1-hello/
$ grun Hello r -gui testhello.txt                    
# 弹出生成的图片
$
```

实战2：hive官方语法文件
```console
语法文件链接：
https://github.com/apache/hive/blob/master/hplsql/src/main/antlr4/org/apache/hive/hplsql/Hplsql.g4
```
```sh
$ mkdir test_hive_official_grammar
$ cd test_hive_official_grammar/
$ antlr4 Hplsql.g4 
$ javac Hplsql*.java

# 只输出 token
$ grun Hplsql block -tokens
select * from tb1;
^D
[@0,0:5='select',<T_SELECT>,1:0]
[@1,7:7='*',<'*'>,1:7]
[@2,9:12='from',<T_FROM>,1:9]
[@3,14:16='tb1',<L_ID>,1:14]
[@4,17:17=';',<';'>,1:17]
[@5,19:18='<EOF>',<EOF>,2:0]

# 输出 token 和 rule
$ grun Hplsql block -tokens -trace
select * from tb1;
^D
[@0,0:5='select',<T_SELECT>,1:0]
[@1,7:7='*',<'*'>,1:7]
[@2,9:12='from',<T_FROM>,1:9]
[@3,14:16='tb1',<L_ID>,1:14]
[@4,17:17=';',<';'>,1:17]
[@5,19:18='<EOF>',<EOF>,2:0]
enter   block, LT(1)=select
enter   stmt, LT(1)=select
enter   select_stmt, LT(1)=select
enter   fullselect_stmt, LT(1)=select
enter   fullselect_stmt_item, LT(1)=select
enter   subselect_stmt, LT(1)=select
consume [@0,0:5='select',<257>,1:0] rule subselect_stmt
enter   select_list, LT(1)=*
enter   select_list_item, LT(1)=*
enter   select_list_asterisk, LT(1)=*
consume [@1,7:7='*',<363>,1:7] rule select_list_asterisk
exit    select_list_asterisk, LT(1)=from
exit    select_list_item, LT(1)=from
exit    select_list, LT(1)=from
enter   from_clause, LT(1)=from
consume [@2,9:12='from',<119>,1:9] rule from_clause
enter   from_table_clause, LT(1)=tb1
enter   from_table_name_clause, LT(1)=tb1
enter   table_name, LT(1)=tb1
enter   qident, LT(1)=tb1
enter   ident, LT(1)=tb1
consume [@3,14:16='tb1',<372>,1:14] rule ident
exit    ident, LT(1)=;
exit    qident, LT(1)=;
exit    table_name, LT(1)=;
exit    from_table_name_clause, LT(1)=;
exit    from_table_clause, LT(1)=;
exit    from_clause, LT(1)=;
exit    subselect_stmt, LT(1)=;
exit    fullselect_stmt_item, LT(1)=;
exit    fullselect_stmt, LT(1)=;
exit    select_stmt, LT(1)=;
exit    stmt, LT(1)=;
enter   stmt, LT(1)=;
enter   semicolon_stmt, LT(1)=;
consume [@4,17:17=';',<370>,1:17] rule semicolon_stmt
exit    semicolon_stmt, LT(1)=<EOF>
exit    stmt, LT(1)=<EOF>
exit    block, LT(1)=<EOF>
$ 
$ grun Hplsql block -gui
select * from tb1;
^D
# 弹出生成的图片
$
```

## `antlr4-tools` 个人实战

```g4
grammar Expr;
prog:	expr EOF ;
expr:	expr ('*'|'/') expr
    |	expr ('+'|'-') expr
    |	INT
    |	'(' expr ')'
    ;
NEWLINE : [\r\n]+ -> skip;
INT     : [0-9]+ ;
```
```sh
$ mkdir test_Expr
$ cd test_Expr/
$ ls
Expr.g4

# 注意，antlr4-tools 这里接的是语法文件（带有 .g4 后缀的）；但是 grun 接的是语法名称（没有 .g4 后缀）
# 此外，antlr4-tools 明显没有去显示地编译出那些 java class（虽然我猜大概率后台编译了）
$ antlr4-parse Expr.g4 prog -tree
1+2*3-4
^D
(prog:1 (expr:2 (expr:2 (expr:3 1) + (expr:1 (expr:3 2) * (expr:3 3))) - (expr:3 4)) <EOF>)
$
$ antlr4-parse Expr.g4 prog -tokens -trace
1+2*3-4
^D
[@0,0:0='1',<INT>,1:0]
[@1,1:1='+',<'+'>,1:1]
[@2,2:2='2',<INT>,1:2]
[@3,3:3='*',<'*'>,1:3]
[@4,4:4='3',<INT>,1:4]
[@5,5:5='-',<'-'>,1:5]
[@6,6:6='4',<INT>,1:6]
[@7,8:7='<EOF>',<EOF>,2:0]
enter   prog, LT(1)=1
enter   expr, LT(1)=1
consume [@0,0:0='1',<8>,1:0] rule expr
enter   expr, LT(1)=+
consume [@1,1:1='+',<3>,1:1] rule expr
enter   expr, LT(1)=2
consume [@2,2:2='2',<8>,1:2] rule expr
enter   expr, LT(1)=*
consume [@3,3:3='*',<1>,1:3] rule expr
enter   expr, LT(1)=3
consume [@4,4:4='3',<8>,1:4] rule expr
exit    expr, LT(1)=-
exit    expr, LT(1)=-
enter   expr, LT(1)=-
consume [@5,5:5='-',<4>,1:5] rule expr
enter   expr, LT(1)=4
consume [@6,6:6='4',<8>,1:6] rule expr
exit    expr, LT(1)=<EOF>
exit    expr, LT(1)=<EOF>
consume [@7,8:7='<EOF>',<-1>,2:0] rule prog
exit    prog, LT(1)=<EOF>
$

# 也可以直接把输入放到文件里，这样不用每次输入 test case 和每次 ctrl + D，并且对比较长的输入肯定更方便。
$ echo "1+2*3-4" > test.txt
$ antlr4-parse Expr.g4 prog -tokens -trace test.txt
[@0,0:0='1',<INT>,1:0]
[@1,1:1='+',<'+'>,1:1]
[@2,2:2='2',<INT>,1:2]
[@3,3:3='*',<'*'>,1:3]
[@4,4:4='3',<INT>,1:4]
[@5,5:5='-',<'-'>,1:5]
[@6,6:6='4',<INT>,1:6]
[@7,8:7='<EOF>',<EOF>,2:0]
enter   prog, LT(1)=1
enter   expr, LT(1)=1
consume [@0,0:0='1',<8>,1:0] rule expr
enter   expr, LT(1)=+
consume [@1,1:1='+',<3>,1:1] rule expr
enter   expr, LT(1)=2
consume [@2,2:2='2',<8>,1:2] rule expr
enter   expr, LT(1)=*
consume [@3,3:3='*',<1>,1:3] rule expr
enter   expr, LT(1)=3
consume [@4,4:4='3',<8>,1:4] rule expr
exit    expr, LT(1)=-
exit    expr, LT(1)=-
enter   expr, LT(1)=-
consume [@5,5:5='-',<4>,1:5] rule expr
enter   expr, LT(1)=4
consume [@6,6:6='4',<8>,1:6] rule expr
exit    expr, LT(1)=<EOF>
exit    expr, LT(1)=<EOF>
consume [@7,8:7='<EOF>',<-1>,2:0] rule prog
exit    prog, LT(1)=<EOF>
$

# 因为是在 docker 容器里实战的，生成图的那个就不弄了，基本和前面是类似的
```

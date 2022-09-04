
# 第5章 查询编译

## 5.2 查询分析

### 5.2.1 Lex 和 Yacc 简介

**`example.l`**
```lex
%{
#include <stdlib.h>
%}

%%

[\n \t];
-?[0-9] {printf("num = %d\n", atoi(yytext));}
. ECHO;

%%

main() {
    yylex();
}
```
```sh
[pguser@fd0a862c7e6b 1]$ ls
example.l
[pguser@fd0a862c7e6b 1]$ lex example.l 
[pguser@fd0a862c7e6b 1]$ ls
example.l  lex.yy.c
# 装 pg 时肯定装了 flex，于是 lex 命令肯定有。但是下面这步要 -ll 链接 flex 库，可能需要再装下：
# yum install -y flex-devel
[pguser@fd0a862c7e6b 1]$ cc lex.yy.c -o first -ll
[pguser@fd0a862c7e6b 1]$ ls
example.l  first  lex.yy.c
[pguser@fd0a862c7e6b 1]$ 
[pguser@fd0a862c7e6b 1]$ ./first 
1234
num = 1
num = 2
num = 3
num = 4


aa

aa

789

num = 7
num = 8
num = 9
^C
[pguser@fd0a862c7e6b 1]$ 
```

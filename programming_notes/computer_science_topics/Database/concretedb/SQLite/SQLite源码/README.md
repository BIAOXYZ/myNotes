
# 官方

`cpython/Modules/_sqlite/` https://github.com/python/cpython/tree/main/Modules/_sqlite

# SQLite字节码与`Explain`

The SQLite Bytecode Engine https://www.sqlite.org/opcode.html || SQLite字节码引擎 https://www.sqlite.net.cn/opcode.html

第9章 SQLite内核 https://wizardforcel.gitbooks.io/the-definitive-guide-to-sqlite/content/11.html
- > VDBE是一个虚拟机，它的字节代码指令和汇编程序十分类似，每一条指令由操作码和三个操作数构成：`<opcode, P1, P2, P3>`。***Opcode为一定功能的操作码，为了理解，可以看成一个函数。p1是32位的有符号整数，p2是31位的无符号整数，它通常是跳转(jump)指令的目标地址(destination)，当然还有其它用途；p3为一个以null结尾的字符串或者其它结构体的指针***。目前SQLite中有`128`个操作码。***和C API不同的是，VDBE操作码经常变化，所以不应该用字节码编写自己的程序***。
- > 空注：有关VDBE的最详细参考在 `vbde.c` 中，也可以参考SQLite网站提供的文档 http://www.sqlite.org/opcode.html 。

SQLite入门与分析(三)---内核概述(1) https://www.cnblogs.com/hustcat/archive/2009/02/15/1390989.html

How can I analyse a Sqlite query execution? https://stackoverflow.com/questions/1454188/how-can-i-analyse-a-sqlite-query-execution

# 其他

SQlite源码分析 https://huili.github.io/ || The pages for github.com/huili sqlite 3.7 源代码阅读注释 https://github.com/HuiLi/huili.github.io

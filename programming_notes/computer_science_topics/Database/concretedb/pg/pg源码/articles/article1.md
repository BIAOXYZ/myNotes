
:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# flying-tiger

【[:star:][`*`]】 随笔分类 - postgresql https://www.cnblogs.com/flying-tiger/category/881004.html
- postgresql编译安装与调试（一） https://www.cnblogs.com/flying-tiger/p/5859393.html
- postgresql编译安装与调试（二） https://www.cnblogs.com/flying-tiger/p/5866660.html
- 跟我一起读postgresql源码(一)——psql命令 http://www.cnblogs.com/flying-tiger/p/6004314.html
- 跟我一起读postgresql源码(二)——Parser(查询分析模块) https://www.cnblogs.com/flying-tiger/p/6021107.html || http://blog.csdn.net/zdy0_2004/article/details/53106260
- 跟我一起读postgresql源码(六)——Executor(查询执行模块之——查询执行策略) https://www.cnblogs.com/flying-tiger/p/6100794.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

postgresql编译安装与调试（一） https://www.cnblogs.com/flying-tiger/p/5859393.html
- > 如果我们比较懒，不想每次登录手动启动psql，那么设置下psql开机启动。PostgreSQL的开机自启动脚本位于PostgreSQL源码目录的contrib/start-scripts路径下：

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

postgresql编译安装与调试（二）https://www.cnblogs.com/flying-tiger/p/5866660.html
- > 方法2.直接在进入postgresql后运行下面的查询语句：`select pg_backend_pid();`
- > #8#7 `postgres.c` 文件内：该文件定义了postgres后端的主要模块，相当于后端的main，并且负责后端进程的调度。
  * > line884：`exec_simple_query()` 函数入口。该函数做一些初始化工作，建立一个transaction command，做简单的语法规则判断，分析重写，并为该查询建立查询计划，并返回查询结果;
  * > line1104：进入函数 `PortalRun()`，进入pquery.c文件.
- > #6#5 `pquery.c` 文件内：
  * > line786：进入 `PortalRunSelect()` 函数，跳转至line888;
  * > line888：`PortalRunSelect()` 函数入口。该函数只能执行简单的 SELECT 查询操作;
  * > line942：进入 `ExecutorRun()` 函数，进入execMain.c文件.
- > #4#3#2 `execMain.c` 文件内：
- > #1 `execProcnode.c` 文件内：
- > #0 `nodeResult.c` 文件内：

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

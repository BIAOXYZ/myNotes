
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

# 健哥的数据花园

PostgreSQL内部结构与源代码研究索引页 https://www.cnblogs.com/gaojian/p/internalindex.html

tag: initdb https://www.cnblogs.com/gaojian/tag/initdb/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

PostgreSQL 内核源码分析 https://blog.csdn.net/zxwsbg/category_11618970.html
- 【[:star:][`*`]】 PostgreSQL 中 SELECT 的元组是如何出现的 https://blog.csdn.net/zxwsbg/article/details/119912014
- PostgreSQL 内核源码分析——lazy Vacuum https://blog.csdn.net/zxwsbg/article/details/122775015

PostgreSQL 中 SELECT 的元组是如何出现的 https://blog.csdn.net/zxwsbg/article/details/119912014
- > 当我们运行一句最简单的 SQL ：`SELECT * FROM t;` 时，查询结束后会将元组一下子打印到屏幕上。那么就会有一个问题，当元组数量非常多的时候，为什么 SELECT 语句卡一会后，会一下子打印出来？
- > **Server 端的执行**
  * > 当 Server 端接收到 SQL 语句后，会经过词法分析、语法分析、语义分析、生成执行计划，这时候执行器会执行生成的执行计划，得到最终的结果。 <br> 而 PostgreSQL 的执行器采用的是火山模型，这里不详细展开，我们只需要知道元组是扫描到一条就向上吐一条，然后再去扫描下一条。 <br> 为了便于理解，我们来分析下删减版的执行器的主要函数 `ExecutePlan`
    ```c
    static void
    ExecutePlan()
    {
    	TupleTableSlot *slot;

    	for (;;)
    	{
    		/* 调用下层函数获取一条元组，其结果就是一个 slot */
    		slot = ExecProcNode(planstate);
    		
    		/* 如果 slot 为空，说明所有元组都已经获取完了，跳出死循环 */
    		if (TupIsNull(slot))
    			break;
    			
    		/* 标记该元组要发出去，比如发给 psql 客户端 */
    		if (sendTuples)
    		{
    			/* 该函数指针会调用 printtup 函数，而 printtup 会把这个 slot 
    			   通过 libpq 发送给 psql 客户端
    			 */
    			if (!dest->receiveSlot(slot, dest))
    				break;
    		}
    	}
    }
    ```
  * > 如果在该函数运行中打上断点，我们会发现 `psql` 客户端无论等待多久，都不会将结果打印到屏幕。因此可以推出一个初步结论：**扫描到的元组并不会扫一部分显示一部分，而是等所有元组都扫描完后一下子显示出来**。
  * > 继续顺着函数走下去，当 Server 端执行器运行完毕，执行 `EndCommand` 函数时，会调用 `pq_putmessage('C',...)` 标记语句运行完成。然而这时候 `psql` 并没有显示出结果。
  * > 为了验证是否 `psql` 收到这个标记后就会直接显示结果，我们在 `gdb` 中 `call PqCommMethods->flush()` 函数，将这个 message 发过去，**但依然没有显示**。
  * > Server 端再走下去，到 `ReadyForQuery` 时，会发送一个 `‘Z’` 标记，标识这时候 Server 已经可以接受新的语句了，当 `psql` 收到这个标记后，**终于能显示查询结果了**。
  * > 下面这张图可以帮助大家更直观的理解 ![](https://img-blog.csdnimg.cn/2d567e52e8a9420ba0163014c17af30f.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_Q1NETiBA5oC75oOz546p5LiW5LiN5oGt,size_81,color_FFFFFF,t_70,g_se,x_16)
- > **psql 端的处理**
  * > 上一章我们主要讲述了 Server 端的执行流程，这一章将讲述客户端 `psql` 的对应处理过程。
  * > `psql` 的代码放在 `src/bin/psql` 文件夹下，其 `main` 函数位于 `startup.c` 中。当 Server 端发来元组时， `psql` 会进行对应的解析处理，并将它们全部存到内存中（这在最后一章会提到），这里我们不做详细讲解。可以理解为，**当收到结束标记时，所有的元组均被存到一个数组中**。
  * > 具体的打印函数调用堆栈如下图所示。可以看出，`print_aligned_text` 函数就是最终的打印函数。其上层函数为其增加方格线、列名称等。 ![](https://img-blog.csdnimg.cn/f16131ae4d8a4c1094660d1a8ee49424.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_Q1NETiBA5oC75oOz546p5LiW5LiN5oGt,size_43,color_FFFFFF,t_70,g_se,x_16)
  * > `gdb` 进入 `print_aligned_text` 函数，其代码逻辑告诉我们是一行一行打印出来的。当已经 `fpuc` 出一些字符后，我们手动调用 `call fflush(fout)` ，强制刷出缓冲区，其显示结果如下图所示。 ![](https://img-blog.csdnimg.cn/1c1d90540df1442bb34158fb7e027e2a.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_Q1NETiBA5oC75oOz546p5LiW5LiN5oGt,size_51,color_FFFFFF,t_70,g_se,x_16)
  * > 接下来我们再多打印一些元组，这时候左下角的 `:` 出现了，当前屏幕无法显示全部元组。因此疯狂按回车，直到显示不了为止。
- > **题外话**
  * > 上文提到 “当 Server 端发来元组时， `psql` 会进行对应的解析处理，并将它们全部存到内存中”。这时候就衍生出了一个问题——如果有一个内存为 `2G` 的机器，里面的 PG 里有一张表 `t` 存了 `3G` 的数据，那么运行 `SELECT * FROM t;` 会发生什么现象？
  * > 为了验证这个问题，我特地找了个 1 核 `2G` 的docker，在里面装上PG并插入了约 `3GB` 的数据。然后执行如下语句
    ```sql
    SELECT pg_size_pretty(pg_relation_size('table_name')); --查看表 t 的大小
    SELECT * FROM t;
    ```
  * > 运行后的结果如下图所示。然后发现 `psql` 进程直接被 Kill 掉了。 ![](https://img-blog.csdnimg.cn/8aa0e0a42e314b958d3204e18dda969e.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_Q1NETiBA5oC75oOz546p5LiW5LiN5oGt,size_30,color_FFFFFF,t_70,g_se,x_16)
- > **总结**
  * > 本文主要研究了 PostgreSQL 中运行 Select 语句后元组是如何出现的，也算是解决了困惑我很久的一个问题。当 psql 终端开始显示元组时，说明所有的元组都已经被扫描完毕存在内存里。这时候所要做的只是把它们打印到屏幕上，而由于 IO 缓冲区的存在，它们也是一段一段显示出来的，只不过显示的太快了肉眼分辨不出来而已。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:


当运行到协程 await 语句时，当前线程处于一种什么样的状态？ https://www.v2ex.com/t/942365
- > https://github.com/lightjiao/lightjiao.github.io/blob/master/Blogs/073.Await-in-deep.md
- > 可以学习 C++20 协程，比较底层，自己实现一下 task 这些类型就明白了。swift 这种是无栈协程，无栈协程就相当于同一个函数调用多次，但是执行的代码不一样了。一般 await 表示让出执行权，一般就是两种选择，把执行权交给调度器，让调度器去选择协程执行，或者是直接把执行权给另外一个协程。而让出执行权有两种方式，一种是函数返回，一种是函数调用。一般来说回到调度器是通过函数返回，而 await 另外一个协程是通过直接调用对应的协程函数实现的，await 的协程调用结束的时候又会把执行权交给原来的协程。 https://lewissbaker.github.io 可以看看这里的文章，讲的非常清晰


# `.join()`

C++ std::thread join()的理解 https://www.cnblogs.com/adorkable/p/12722209.html
- > 先贴一下关于join()函数的解释：`The function returns when the thread execution has completed.This synchronizes the moment this function returns with the completion of all the operations in the thread: This blocks the execution of the thread that calls this function until the function called on construction returns (if it hasn't yet).`
- > 总结理解一下就是两个关键点：
  * > **谁调用了这个函数**？ 调用了这个函数的线程对象，一定要等这个线程对象的方法（在构造时传入的方法）执行完毕后（***<ins>或者理解为这个线程的活干完了！</ins>***），这个 `join()` 函数才能得到返回。
  * > **在什么线程环境下调用了这个函数**？ 上面说了必须要等线程方法执行完毕后才能返回，那必然是阻塞调用线程的，也就是说如果一个线程对象在一个线程环境调用了这个函数，那么这个线程环境就会被阻塞，直到这个线程对象在构造时传入的方法执行完毕后，才能继续往下走，另外如果线程对象在调用 `join()` 函数之前，就已经做完了自己的事情（在构造时传入的方法执行完毕），那么这个函数不会阻塞线程环境，线程环境正常执行。

What does std::thread.join() do? https://stackoverflow.com/questions/15148057/what-does-stdthread-join-do

【[:star:][`*`]】 What does this thread join code mean? https://stackoverflow.com/questions/15956231/what-does-this-thread-join-code-mean
- https://stackoverflow.com/questions/15956231/what-does-this-thread-join-code-mean/15956304#15956304
  * > ***<ins>`join()` means waiting for a thread to complete</ins>***. This is a blocker method. ***Your main thread (the one that does the `join()`) will wait on the `t1.join()` line until t1 finishes its work, and then will do the same for `t2.join()`***.
- https://stackoverflow.com/questions/15956231/what-does-this-thread-join-code-mean/47468249#47468249
  * > A picture is worth a thousand words.
    ```console
        Main thread-->----->--->-->--block##########continue--->---->
                     \                 |               |
    sub thread start()\                | join()        |
                       \               |               |
                        ---sub thread----->--->--->--finish 
    ```
  * > Hope to useful, for more detail click [here](http://www.henryxi.com/java-thread-join-example)

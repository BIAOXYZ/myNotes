
# `.join()`

C++ std::thread join()的理解 https://www.cnblogs.com/adorkable/p/12722209.html
- > 先贴一下关于join()函数的解释：`The function returns when the thread execution has completed.This synchronizes the moment this function returns with the completion of all the operations in the thread: This blocks the execution of the thread that calls this function until the function called on construction returns (if it hasn't yet).`
- > 总结理解一下就是两个关键点：
  * > **谁调用了这个函数**？ 调用了这个函数的线程对象，一定要等这个线程对象的方法（在构造时传入的方法）执行完毕后（***<ins>或者理解为这个线程的活干完了！</ins>***），这个 `join()` 函数才能得到返回。
  * > **在什么线程环境下调用了这个函数**？ 上面说了必须要等线程方法执行完毕后才能返回，那必然是阻塞调用线程的，也就是说如果一个线程对象在一个线程环境调用了这个函数，那么这个线程环境就会被阻塞，直到这个线程对象在构造时传入的方法执行完毕后，才能继续往下走，另外如果线程对象在调用 `join()` 函数之前，就已经做完了自己的事情（在构造时传入的方法执行完毕），那么这个函数不会阻塞线程环境，线程环境正常执行。

What does std::thread.join() do? https://stackoverflow.com/questions/15148057/what-does-stdthread-join-do

【[:star:][`*`]】 What does this thread join code mean? https://stackoverflow.com/questions/15956231/what-does-this-thread-join-code-mean
- https://stackoverflow.com/questions/15956231/what-does-this-thread-join-code-mean/15956265#15956265
- https://stackoverflow.com/questions/15956231/what-does-this-thread-join-code-mean/15956321#15956321
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

## 个人实战
>> //notes：两个程序的唯一区别就是：第一次 time1 时间短于 time2；第二次 time1 时间长于 time2。于是说明：（主函数里）t2.join() 这一行虽然必须等到 t1 执行完返回后才能执行，但是 t2 本身不会被主线程或被 t1 影响。

```py
import time, threading
def func1(time1):
    print(f"I am [func1], I will sleep [{time1}s], this is my start")
    time.sleep(time1)
    print(f"I am [func1], I have finished sleep [{time1}s], this is my end")
def func2(time2):
    print(f"I am [func2], I will sleep [{time2}s], this is my start")
    time.sleep(time2)
    print(f"I am [func2], I have finished sleep [{time2}s], this is my end")

if __name__ == "__main__":
    print("Main() starts")
    time1 = 1
    time2 = 5
    t1 = threading.Thread(target=func1, args=(time1,))
    t1.start()
    t2 = threading.Thread(target=func2, args=(time2,))
    t2.start()

    print("*"*20)
    t1.join()
    print("Is the 1st print in Main() strictly before t2's print? No!")
    t2.join()
    print("Is the 2nd print in Main() strictly after t2's print? Yes!")
    print("*"*20)
    print("Main() ends")
```
```console
Main() starts
I am [func1], I will sleep [1s], this is my start
I am [func2], I will sleep [5s], this is my start
********************
I am [func1], I have finished sleep [1s], this is my end
Is the 1st print in Main() strictly before t2's print? No!
I am [func2], I have finished sleep [5s], this is my end
Is the 2nd print in Main() strictly after t2's print? Yes!
********************
Main() ends
```

```py
import time, threading
def func1(time1):
    print(f"I am [func1], I will sleep [{time1}s], this is my start")
    time.sleep(time1)
    print(f"I am [func1], I have finished sleep [{time1}s], this is my end")
def func2(time2):
    print(f"I am [func2], I will sleep [{time2}s], this is my start")
    time.sleep(time2)
    print(f"I am [func2], I have finished sleep [{time2}s], this is my end")

if __name__ == "__main__":
    print("Main() starts")
    time1 = 10
    time2 = 5
    t1 = threading.Thread(target=func1, args=(time1,))
    t1.start()
    t2 = threading.Thread(target=func2, args=(time2,))
    t2.start()

    print("*"*20)
    t1.join()
    print("Is the 1st print in Main() strictly before t2's print? No!")
    t2.join()
    print("Is the 2nd print in Main() strictly after t2's print? Yes!")
    print("*"*20)
    print("Main() ends")
```
```console
Main() starts
I am [func1], I will sleep [10s], this is my start
I am [func2], I will sleep [5s], this is my start
********************
I am [func2], I have finished sleep [5s], this is my end
I am [func1], I have finished sleep [10s], this is my end
Is the 1st print in Main() strictly before t2's print? No!
Is the 2nd print in Main() strictly after t2's print? Yes!
********************
Main() ends
```

>> //notes2：多个子线程的时候，每一个都先 start 起来，然后就互不影响了。如果 start 完一个就立刻 join 这个，那后面的得等待这个执行完，整体就变串行了。
```py
import time, threading
def func1(time1):
    print(f"I am [func1], I will sleep [{time1}s], this is my start")
    time.sleep(time1)
    print(f"I am [func1], I have finished sleep [{time1}s], this is my end")
def func2(time2):
    print(f"I am [func2], I will sleep [{time2}s], this is my start")
    time.sleep(time2)
    print(f"I am [func2], I have finished sleep [{time2}s], this is my end")

if __name__ == "__main__":
    print("Main() starts")
    time1 = 10
    time2 = 5
    t1 = threading.Thread(target=func1, args=(time1,))
    t2 = threading.Thread(target=func2, args=(time2,))
    t1.start()
    t1.join()
    print("Is the 1st print in Main() strictly before t2's print? yes!")
    t2.start()
    t2.join()
    print("Main() ends")
```
```console
Main() starts
I am [func1], I will sleep [10s], this is my start
I am [func1], I have finished sleep [10s], this is my end
Is the 1st print in Main() strictly before t2's print? yes!
I am [func2], I will sleep [5s], this is my start
I am [func2], I have finished sleep [5s], this is my end
Main() ends
```

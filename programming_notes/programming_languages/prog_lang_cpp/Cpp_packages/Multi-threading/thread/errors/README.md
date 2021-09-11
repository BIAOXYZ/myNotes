
# `error: invalid use of non-static member function`

invalid use of non-static member function https://blog.csdn.net/fengfengdiandia/article/details/82465987

C++ 多线程 报错invalid use of non-static member function https://blog.csdn.net/xysjj/article/details/103183737
- > vs编译器报错 不会计算为接受0个参数的函数，GCC编译器报的错看不懂，不写了； <br> 根据vs提示，似乎线程需要一个参数，可是我们的func没有参数？ <br> 我们看到没有对象，我查资料，说是需要对象指针作为参数；
  ```cpp
  std::thread(&test::func,t);
  ```
  > ok,运行成功；
- > 也可以根据GCC编译器的提示，将func设为静态成员函数；只是静态成员函数只能调用静态成员，如果程序复杂点，很麻烦，所以一般不是很推荐

invalid use of non-static member function [duplicate] https://stackoverflow.com/questions/29286863/invalid-use-of-non-static-member-function

使用C++实现线程池报错，std::thread https://segmentfault.com/q/1010000004413576

## 延伸

Start thread with member function https://stackoverflow.com/questions/10673585/start-thread-with-member-function

C++11 : Start thread by member function with arguments https://thispointer.com/c11-start-thread-by-member-function-with-arguments/

# `error: no type named ‘type’ in ‘class std::result_of`

c++ thread 带参数编译错误：/usr/include/c++/4.8/functional:1697:61: error: no type named ‘type’ in ‘class st https://blog.csdn.net/Jack_Zhao_/article/details/88820910
- c++: error: no type named ‘type’ in `‘class std::result_of<void (*(std::unordered_map` https://stackoverflow.com/questions/28950835/c-error-no-type-named-type-in-class-stdresult-ofvoid-stdunordered
- 使用C++实现线程池报错，std::thread https://segmentfault.com/q/1010000004413576

# `terminate called without an active exception`

C++ terminate called without an active exception https://newbedev.com/c-terminate-called-without-an-active-exception

std::thread “terminate called without an active exception” https://blog.csdn.net/github_20066005/article/details/79999530
- > 原因是主线程在任务线程还没有执行完成就退出了，销毁了一些资源，导致任务线程就异常了。要修复这个问题也很简单，就是调用join，等待子线程执行完成，代码如下：

C++ Thread: terminate called without an active exception https://stackoverflow.com/questions/37024545/c-thread-terminate-called-without-an-active-exception
- https://stackoverflow.com/questions/37024545/c-thread-terminate-called-without-an-active-exception/37026636#37026636
  * > Your code that creates the thread creates a stack variable that is immediately destroyed. You need to change this:
    ```cpp
    if(!isRepeatAllowed)
    {
        std::thread newThread(getUniqueInteger, arr, i, &newVal);
        threadArr.push_back( &newThread);
    }
    ```
    > to this:
    ```cpp
    if(!isRepeatAllowed)
    {
        std::thread* newThread = new std::thread(getUniqueInteger, arr, i, &newVal);
        threadArr.push_back( newThread);
    }
    ```
    > Then uncomment your delete line later on.

C++ terminate called without an active exception https://stackoverflow.com/questions/7381757/c-terminate-called-without-an-active-exception

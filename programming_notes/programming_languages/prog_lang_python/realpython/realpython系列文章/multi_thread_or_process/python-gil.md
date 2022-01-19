
What Is the Python Global Interpreter Lock (GIL)? https://realpython.com/python-gil/
- > The Python Global Interpreter Lock or [GIL](https://wiki.python.org/moin/GlobalInterpreterLock), in simple words, is a mutex (or a lock) that allows only one [thread](https://realpython.com/intro-to-python-threading/) to hold the control of the Python interpreter.
- > This means that ***only one thread can be in a state of execution at any point in time***. The impact of the GIL isn’t visible to developers who execute single-threaded programs, but it can be a performance bottleneck in CPU-bound and multi-threaded code.
- > Since ***the GIL allows only one thread to execute at a time even in a multi-threaded architecture with more than one CPU core***, the GIL has gained a reputation as an “infamous” feature of Python.
- > In this article you’ll learn how the GIL affects the performance of your Python programs, and how you can mitigate the impact it might have on your code.
- > **What Problem Did the GIL Solve for Python?**
  * > Python uses reference counting for [memory management](https://realpython.com/python-memory-management/). It means that objects created in Python have a reference count variable that keeps track of the number of references that point to the object. When this count reaches zero, the memory occupied by the object is released.
    >
    > Let’s take a look at a brief code example to demonstrate how reference counting works:
    ```py
    >>> import sys
    >>> a = []
    >>> b = a
    >>> sys.getrefcount(a)
    3
    ```
    > In the above example, the reference count for the empty list object `[]` was `3`. The list object was referenced by `a`, `b` and ***the argument passed to `sys.getrefcount()`***.
  * > Back to the GIL:
    + > The problem was that ***this `reference count variable` needed protection from `race conditions`*** where two threads increase or decrease its value simultaneously. If this happens, it can cause either leaked memory that is never released or, even worse, incorrectly release the memory while a reference to that object still exists. This can cause crashes or other “weird” bugs in your Python programs.
    + > This reference count variable can be kept safe by adding locks to all data structures that are shared across threads so that they are not modified inconsistently.
    + > But adding a lock to each object or groups of objects means multiple locks will exist which can cause another problem — `Deadlocks` (deadlocks can only happen if there is more than one lock). Another side effect would be decreased performance caused by the repeated acquisition and release of locks.
  * > The GIL, although ***used by interpreters for other languages like `Ruby`***, is not the only solution to this problem. ***Some languages avoid the requirement of a GIL for thread-safe memory management by using approaches other than `reference counting`, such as `garbage collection`***.
  * > On the other hand, this means that those languages often have to compensate for the loss of single threaded performance benefits of a GIL by adding other performance boosting features like `JIT compilers`.
- > **Why Was the GIL Chosen as the Solution?**
  * > Python has been around ***since the days when operating systems did not have a concept of threads***. Python was designed to be easy-to-use in order to make development quicker and more and more developers started using it.
  * > A lot of extensions were being written for the existing C libraries whose features were needed in Python. To prevent inconsistent changes, these C extensions required a thread-safe memory management which the GIL provided.
- > **The Impact on Multi-Threaded Python Programs**
  * > CPU-bound programs are those that are pushing the CPU to its limit. This includes programs that do mathematical computations like matrix multiplications, searching, image processing, etc.
  * > I/O-bound programs are the ones that spend time waiting for Input/Output which can come from a user, file, database, network, etc. I/O-bound programs sometimes have to wait for a significant amount of time till they get what they need from the source due to the fact that the source may need to do its own processing before the input/output is ready, for example, a user thinking about what to enter into an input prompt or a database query running in its own process.
  * > Let’s have a look at a simple CPU-bound program that performs a countdown:
    ```py
    # single_threaded.py
    import time
    from threading import Thread
    COUNT = 50000000
    
    def countdown(n):
        while n>0:
            n -= 1
    
    start = time.time()
    countdown(COUNT)
    end = time.time()
     
    print('Time taken in seconds -', end - start)
    ```
    > Running this code on my system with 4 cores gave the following output:
    ```sh
    $ python single_threaded.py
    Time taken in seconds - 6.20024037361145
    ```
  * > Now I modified the code a bit to do to the same countdown using two threads in parallel:
    ```py
    # multi_threaded.py
    import time
    from threading import Thread
    COUNT = 50000000
    
    def countdown(n):
        while n>0:
            n -= 1
    
    t1 = Thread(target=countdown, args=(COUNT//2,))
    t2 = Thread(target=countdown, args=(COUNT//2,))
    
    start = time.time()
    t1.start()
    t2.start()
    t1.join()
    t2.join()
    end = time.time()
    
    print('Time taken in seconds -', end - start)
    ```
    > And when I ran it again:
    ```sh
    $ python multi_threaded.py
    Time taken in seconds - 6.924342632293701
    ```
  * > As you can see, both versions take almost same amount of time to finish. In the multi-threaded version the GIL prevented the CPU-bound threads from executing in parellel.
  * > The ***GIL does not have much impact on the performance of I/O-bound multi-threaded programs*** as the lock is shared between threads while they are waiting for I/O.
  * > But a program whose threads are entirely CPU-bound, e.g., a program that processes an image in parts using threads, ***would not only become single threaded due to the lock but will also see an increase in execution time***, as seen in the above example, in comparison to a scenario where it was written to be entirely single-threaded.
    > 
    > ***This increase is the result of acquire and release overheads added by the lock***.
- > **Why Hasn’t the GIL Been Removed Yet?**

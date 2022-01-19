
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

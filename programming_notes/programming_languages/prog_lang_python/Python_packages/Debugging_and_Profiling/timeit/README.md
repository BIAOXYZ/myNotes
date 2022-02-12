
# 源头

deque.popleft() and list.pop(0). Is there performance difference? https://stackoverflow.com/questions/32543608/deque-popleft-and-list-pop0-is-there-performance-difference
- https://stackoverflow.com/questions/32543608/deque-popleft-and-list-pop0-is-there-performance-difference/32543932#32543932
  * > Using `%timeit`, the performance difference between `deque.popleft()` and `list.pop(0)` is about ***a factor of `4`*** when both the `deque` and the `list` have the same ***`52` elements*** and grows to over ***a factor of `1000` when their lengths are `10**8`***. Test results are given below.
    ```py
    import string
    from collections import deque
    
    %timeit d = deque(string.letters); d.popleft()
    1000000 loops, best of 3: 1.46 µs per loop
    
    %timeit d = deque(string.letters)
    1000000 loops, best of 3: 1.4 µs per loop
    
    %timeit l = list(string.letters); l.pop(0)
    1000000 loops, best of 3: 1.47 µs per loop
    
    %timeit l = list(string.letters);
    1000000 loops, best of 3: 1.22 µs per loop
    
    d = deque(range(100000000))
    
    %timeit d.popleft()
    10000000 loops, best of 3: 90.5 ns per loop
    
    l = range(100000000)
    
    %timeit l.pop(0)
    10 loops, best of 3: 93.4 ms per loop
    ```

# 官方

timeit --- 测量小代码片段的执行时间 https://docs.python.org/zh-cn/3/library/timeit.html

# 其他

What is `%timeit` in python? https://stackoverflow.com/questions/29280470/what-is-timeit-in-python
- https://stackoverflow.com/questions/29280470/what-is-timeit-in-python/29280612#29280612
  * > `%timeit` is an [ipython magic](https://ipython.org/ipython-doc/dev/interactive/magics.html#magic-timeit) function, which can be used to time a particular piece of code (A single execution statement, or a single method).
  * > From the docs:
    ```console
    %timeit
    
    Time execution of a Python statement or expression
    
    Usage, in line mode:
        %timeit [-n<N> -r<R> [-t|-c] -q -p<P> -o] statement
    ```
  * > To use it, for example if we want to find out whether using `xrange` is any faster than using `range`, you can simply do:
    ```py
    In [1]: %timeit for _ in range(1000): True
    10000 loops, best of 3: 37.8 µs per loop

    In [2]: %timeit for _ in xrange(1000): True
    10000 loops, best of 3: 29.6 µs per loop
    ```
    > And you will get the timings for them.
  * > The major advantage of `%timeit` are:
    + > that you **don't** have to import `timeit.timeit` from the standard library, and ***run the code multiple times*** to figure out which is the better approach.
    + > `%timeit` will ***automatically calculate number of runs required for your code based on a total of `2` seconds execution window***.
    + > You can also make use of current console variables without passing the whole code snippet as in case of `timeit.timeit` to built the variable that is built in an another environment that timeit works.

Timeit in Python with Examples https://www.geeksforgeeks.org/timeit-python-examples/

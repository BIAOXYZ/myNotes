
Python enumerate() https://www.programiz.com/python-programming/methods/built-in/enumerate
- > Syntax of `enumerate()`
  ```py
  enumerate(iterable, start=0)
  ```

# `enumerate()` 提前停止
>> //notes：我们知道 `enumerate()` 提供了一个 `start=` 参数从而可以选择开始的位置，但是没有对应的参数去处理默认的位置。。。

Easiest way to include a stop parameter in enumerate python? https://stackoverflow.com/questions/21690529/easiest-way-to-include-a-stop-parameter-in-enumerate-python
- https://stackoverflow.com/questions/21690529/easiest-way-to-include-a-stop-parameter-in-enumerate-python/21690559#21690559
  * > 
    ```py
    for i, row in enumerate(myiterable[2:], start=2):
       if i>= limit: break
       ...
    ```
  * > or        
    ```py
    for i,row in itertools.takewhile(lambda (i,val):i < limit,enumerate(myiterable[2:],2)):
    ```
  * > to rephrase the other suggestion (note that it will only work if your iterable is a sliceable object)
    ```py
    start,stop = 11,20
    my_items = range(100)
    for i,row in enumerate(my_items[start:stop],start):
          ....
    ```
    >> //notes：其实最简单的还是这种：直接去 enumerate 一个（有你想要的开始位置和停止位置的）切片。。。

Python enumerate list setting start index but without increasing end count https://stackoverflow.com/questions/29181284/python-enumerate-list-setting-start-index-but-without-increasing-end-count

How can I limit iterations of a loop in Python? https://stackoverflow.com/questions/36106712/how-can-i-limit-iterations-of-a-loop-in-python

Using enumerate in Python to iterate up to len(list) - 1 https://stackoverflow.com/questions/40349468/using-enumerate-in-python-to-iterate-up-to-lenlist-1


# 官方

`8. 错误和异常` https://docs.python.org/zh-cn/3/tutorial/errors.html
- > **8.1. `句法错误`**
  * > ***`句法错误`又称`解析错误`***，是学习 Python 时最常见的错误：
  * > 解析器会复现出现句法错误的代码行，并用小“箭头”指向行里检测到的第一个错误。错误是由箭头上方的 token 触发的（至少是在这里检测出的）：本例中，在 `print()` 函数中检测到错误，因为，在它前面缺少冒号（`':'`） 。错误信息还输出文件名与行号，在使用脚本文件时，就可以知道去哪里查错。
- > **8.2. `异常`**
  * > ***即使语句或表达式使用了正确的语法，执行时仍可能触发错误。<ins>执行时检测到的错误称为`异常`</ins>***，`异常`不一定导致严重的后果：很快我们就能学会如何处理 Python 的异常。大多数异常不会被程序处理，而是显示下列错误信息：
- > 【[:star:][`*`]】 **8.3. 异常的处理**
  * > [`try`](https://docs.python.org/zh-cn/3/reference/compound_stmts.html#try) 语句的工作原理如下：
    + > 首先，执行 `try` 子句 （`try` 和 [`except`](https://docs.python.org/zh-cn/3/reference/compound_stmts.html#except) 关键字之间的（多行）语句）。
    + > 如果没有触发异常，则跳过 `except` 子句，`try` 语句执行完毕。
    + > 如果在执行 `try` 子句时发生了异常，则跳过该子句中剩下的部分。 如果异常的类型与 `except` 关键字后指定的异常相匹配，则会执行 `except` 子句，***然后跳到 `try/except` 代码块之后继续执行***。
    + > 如果发生的异常与 `except` 子句 中指定的异常不匹配，则它会被传递到外部的 `try` 语句中；如果没有找到处理程序，则它是一个**未处理异常**且执行将终止并输出如上所示的消息。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

~~Python Exceptions: An Introduction https://realpython.com/python-exceptions/~~  -->  参加 realpython 部分的笔记吧。

https://www.cnblogs.com/IPrograming/p/Python_error_handler.html

Python 异常处理 http://www.runoob.com/python/python-exceptions.html

http://www.yiibai.com/python/python_exceptions.html

Python Exception Handling Using try, except and finally statement https://www.programiz.com/python-programming/exception-handling

python 一篇搞定所有的异常处理 https://www.cnblogs.com/wj-1314/p/8707804.html
- > **四：异常处理的用法**
  * > 1，如果错误发生的条件是可预知的，我们需要用if进行处理，在错误发生之前进行预防
  * > 2，如果错误发生的条件是不可预知的，则需要用到try..except：在错误发生之后进行处理

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 多重`exception`

raise 与 raise ... from 的区别 - weapon的文章 - 知乎 https://zhuanlan.zhihu.com/p/52091476
- > **禁止异常关联**
  * > `from` 还有个特别的用法：`raise ... from None` ，它通过设置 `__suppress_context__` 属性指定来明确禁止异常关联：

How to raise a ValueError in Python https://www.kite.com/python/answers/how-to-raise-a-valueerror-in-python
- > Use the syntax `raise exception` with `exception` as `ValueError(text)` to throw a `ValueError` exception with the error message `text`.
  ```py
  try:
      num = int("string")
  except ValueError:
      raise ValueError("ValueError exception thrown")
  ```
  ```console
  Traceback (most recent call last):
    File "main.py", line 2, in <module>
      num = int("string")
  ValueError: invalid literal for int() with base 10: 'string'
  
  During handling of the above exception, another exception occurred:
  
  Traceback (most recent call last):
    File "main.py", line 4, in <module>
      raise ValueError("ValueError exception thrown")
  ValueError: ValueError exception thrown
  ```
  >> //notes：但是呢其实这里这个例子不太好，因为会引起多重 `exception`。。。于是正好借机整理下。

【[:ok:][:star:][`*`]】 During handling of the above exception, another exception occurred是如何发生的？ https://www.pynote.net/archives/1856
- > 调试python代码，常常看到这样的提示，`During handling of the above exception, another exception occurred`。这是如何发生的？请看如下代码：
  ```py
  x = 2
  y = 0
  
  try:
      result = x / y
  except ZeroDivisionError:
      raise ValueError('raise in exception clause')
      print("=== division by zero!")
  else:
      print("result is", result)
  finally:
      raise ValueError('raise in finally clause')
      print("executing finally clause")
  ```
  > `ZeroDivisionError`必然发生，然后代码进入`except`分支，在这个分支中，遇到了一个`raise`，后面的`print`得不到执行。由于有`finally`分支，在`raise`之前，需要执行`finally`分支的代码，不幸的是，此时又遇到了`raise`，它后面的`print`也得不到执行。因此运行这段代码的效果，就是如下：
  ```py
  E:\py>python try.py
  Traceback (most recent call last):
    File "try.py", line 8, in 
      result = x / y
  ZeroDivisionError: division by zero
  
  During handling of the above exception, another exception occurred:
  
  Traceback (most recent call last):
    File "try.py", line 10, in 
      raise ValueError('raise in exception clause')
  ValueError: raise in exception clause
  
  During handling of the above exception, another exception occurred:
  
  Traceback (most recent call last):
    File "try.py", line 15, in 
      raise ValueError('raise in finally clause')
  ValueError: raise in finally clause
  ```
  > 这就是`During handling of the above exception, another exception occurred`的由来！在处理异常的`except`分支或离开`try`的`finally`分支有`raise`，就会出现这样的提示。
- > 到此，自然而然我们会想到另一个问题，在这种情况下，如果这段代码整体有try护着，抛出来的异常时哪个呢？请看下面的测试代码：
  ```py
  def testA():
      x = 2
      y = 0
      
      try:
          result = x / y
      except ZeroDivisionError:
          raise ValueError('raise in exception clause')
          print("=== division by zero!")
      else:
          print("result is", result)
      finally:
          raise ValueError('raise in finally clause')
          print("executing finally clause")
  
  try:
      testA()
  except Exception as e:
      print(repr(e))
  ```
  > 运行结果：
  ```console
  E:\py>python try.py
  ValueError('raise in finally clause')
  ```
  > 看出来了吧，抛出来的只有最后那一个`exception`！

During handling of the above exception, another exception occurred https://stackoverflow.com/questions/52725278/during-handling-of-the-above-exception-another-exception-occurred

Python: 捕获异常然后再抛出另一个异常的正确姿势 https://mozillazg.com/2016/08/python-the-right-way-to-catch-exception-then-reraise-another-exception.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## index不在range的时候不抛出异常

Python index of item in list without error? [duplicate] https://stackoverflow.com/questions/13160564/python-index-of-item-in-list-without-error/13160626
- https://stackoverflow.com/questions/13160564/python-index-of-item-in-list-without-error/13160631#13160631
  * > How about this?
    ```py
    a = [1]
    try:
        index_value = a.index(44)
    except ValueError:
        index_value = -1
    ```
- > https://stackoverflow.com/questions/13160564/python-index-of-item-in-list-without-error/13160632#13160632
  * > use exception-handling, `list.index` raises `ValueError` so you can catch that exception:
    ```py
    In [78]: lis=[1,2,3,4]
    In [79]: for i in range(-1,6):
        try:
            print lis.index(i)
        except ValueError:    
            print i,"not found"
    
    -1 not found
    0 not found
    0
    1
    2
    3
    5 not found
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

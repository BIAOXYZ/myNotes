
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
    + > 如果在执行 `try` 子句时发生了异常，则跳过该子句中剩下的部分。 如果异常的类型与 `except` 关键字后指定的异常相匹配，则会执行 `except` 子句，然后跳到 `try/except` 代码块之后继续执行。
    + > 如果发生的异常与 `except` 子句 中指定的异常不匹配，则它会被传递到外部的 `try` 语句中；如果没有找到处理程序，则它是一个**未处理异常**且执行将终止并输出如上所示的消息。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

https://www.cnblogs.com/IPrograming/p/Python_error_handler.html

Python 异常处理 http://www.runoob.com/python/python-exceptions.html

http://www.yiibai.com/python/python_exceptions.html

Python Exception Handling Using try, except and finally statement https://www.programiz.com/python-programming/exception-handling

How to raise a ValueError in Python https://www.kite.com/python/answers/how-to-raise-a-valueerror-in-python

During handling of the above exception, another exception occurred https://stackoverflow.com/questions/52725278/during-handling-of-the-above-exception-another-exception-occurred

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

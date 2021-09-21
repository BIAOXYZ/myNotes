
# python异常

## 官方

`8. 错误和异常` https://docs.python.org/zh-cn/3/tutorial/errors.html

## 其他

https://www.cnblogs.com/IPrograming/p/Python_error_handler.html

Python 异常处理 http://www.runoob.com/python/python-exceptions.html

http://www.yiibai.com/python/python_exceptions.html

Python Exception Handling Using try, except and finally statement https://www.programiz.com/python-programming/exception-handling

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# python错误处理

“Too many values to unpack” Exception https://stackoverflow.com/questions/1479776/too-many-values-to-unpack-exception

TypeError: 'NoneType' object is not iterable in Python https://stackoverflow.com/questions/3887381/typeerror-nonetype-object-is-not-iterable-in-python
> 【Python】python "TypeError: 'NoneType' object is not iterable"错误分析 http://blog.csdn.net/dataspark/article/details/9953225

## TypeError: Unicode-objects must be encoded before hashing
Python 用hashlib求中文字符串的MD5值 - CSDN博客 https://blog.csdn.net/haungrui/article/details/6959340
> 其实是在用pycrypto的哈希函数时碰到的这个错，我估计任何python（指python3版本，python2系列不清楚情况）里的哈希函数都是一样的。就是要对某个字符串求哈希，必须先把这个字符串从unicode形式encode成一个其他形式比如utf-8。

## UnicodeDecodeError: 'utf-8' codec can't decode byte 0xa4 in position 3: inval

- Python3解决UnicodeDecodeError: 'utf-8' codec can't decode byte问题终极解决方案 https://blog.csdn.net/wang7807564/article/details/78164855
- UnicodeDecodeError: 'utf8' codec can't decode byte 0xc9 in position 0: inval https://blog.csdn.net/a2011480169/article/details/68947804

***编码问题总结***：
- python编码总结(编码类型、格式、转码) http://www.jb51.net/article/87739.htm
- Python编码问题整理 https://www.cnblogs.com/fnng/p/5008884.html
- 字符编码笔记：ASCII，Unicode 和 UTF-8 http://www.ruanyifeng.com/blog/2007/10/ascii_unicode_and_utf-8.html
- Python 编码为什么那么蛋疼？ - 知乎 https://www.zhihu.com/question/31833164
- Unicode 和 UTF-8 有何区别？ - 于洋的回答 - 知乎 https://www.zhihu.com/question/23374078/answer/69732605
- Python 3中bytes/string的区别 https://www.cnblogs.com/abclife/p/7445222.html

python2 中 unicode 和 str 之间的转换及与python3 str 的区别 https://www.cnblogs.com/lowmanisbusy/p/9136347.html
- > 在python2中字符串分为 `unicode` 和 `str` 类型
  ```concole
  Str To Unicode 使用decode(), 解码
  Unicode To Str 使用encode(), 编码
  ```
- > 在python3中字符串分为 `str` 和 `bytes` 两种类型
  ```console
  Str To Bytes 使用 encode(), 编码
  Bytes To Str 使用 decode(), 解码
  ```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

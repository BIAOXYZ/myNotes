
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

python3 三种字符串（无前缀，前缀u，前缀b）与encode() https://blog.csdn.net/anlian523/article/details/80504699
- > 首先要明确，虽然有三种前缀（无前缀，前缀u，前缀b），但是字符串的类型只有两种（`str`，`bytes`），实验如下：
  * > 根据程序以及以上运行结果，发现**无前缀**，和**前缀u**，构造出来的字符串常量，是一样的。
  * > 其实，这里是因为，python3中，字符串的存储方式都是以Unicode字符来存储的，所以前缀带不带u，其实都一样。
  * > 结论：***字符串常量，前缀带不带u，都是一样的***。
- > 不管是utf-8，还是gbk，都可以理解为一种对应关系（若干个十六进制数<——>某个字符）：
  * > 所以可以发现任何str类型的字符串，在经过encode('utf-8')后，就是通过utf-8这种编码解码方式（两种方向），将Unicode字符转换为对应的以字节方式存储的若干十六进制数。
  * > 根据如上程序以及结果，可以发现，utf-8用三个字节（6个十六进制数）来表示一个中文字符，而gbk用两个字节（4个十六进制数）来表示一个中文字符。
  * > 结论：***`encode()` 函数根据括号内的编码方式，把str类型的字符串转换为bytes字符串，字符对应的若干十六进制数，根据编码方式决定***。
- > 既然知道了，str实际存储的是Unicode字符，那么也可以Unicode编码来存储str，形如`\u1234`：
  * > 发现`\u`后面跟四个十六进制数，就可以代表一个Unicode字符，同样的，前缀带不带u都一样。
  * > 结论：***str类型的字符串，每个字符用字符本身或者`\u1234`，来表示都可以，后者则是直接是Unicode编码。但打印时都是打印字符本身***。
- > bytes字符串的组成形式，必须是十六进制数，或者ASCII字符：
  * > 在打印bytes字符串时，某些正常字符和一些转义字符可以打印出来，比如：字母数字和`‘\n’`换行符。别的就只能以原来的方式存在。
  * > 还可以对bytes取索引，所以这里bytes也可以用for循环来迭代了，因为也是可迭代对象。
- > 代码：
```py
oath = '我爱妞'
print(type(oath))
print(len(oath))
oath1 = u'我爱妞'
print(type(oath1))
print(len(oath1))
print(oath==oath1)
print('*'*50)

utf8 = oath.encode('utf-8')
print(type(utf8))
print(len(utf8))
print(utf8)
gbk = oath.encode('gbk')
print(type(gbk))
print(len(gbk))
print(gbk)
print('*'*50)

test = u'\u5220\u9664'
print(len(test))
print(test)
test1 = test.encode('utf-8')
print(test1)
print(type(test1))
print('*'*50)

out = open('test.txt','w',encoding = 'utf-8')
out.write(test)
out.close()
```
```
$ python tmp.py 
<class 'str'>
3
<class 'str'>
3
True
**************************************************
<class 'bytes'>
9
b'\xe6\x88\x91\xe7\x88\xb1\xe5\xa6\x9e'
<class 'bytes'>
6
b'\xce\xd2\xb0\xae\xe6\xa4'
**************************************************
2
删除
b'\xe5\x88\xa0\xe9\x99\xa4'
<class 'bytes'>
**************************************************
$
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

### `bz2` 模块找不到
>> //notes：碰到这个问题的场景是机器自带的是 python2.7 和 python3.5，于是自己编译了一个 Python3.7。但是编译安装的时候机器上还没有安装 `bz2`。解决办法也很简单：`apt` 或者 `yum` 安装下 `bz2`，然后把自己编译的那个 python 再重新编译安装一下即可。

'bz2 is module not available' when installing Pandas with pip in python virtual environment https://stackoverflow.com/questions/22346269/bz2-is-module-not-available-when-installing-pandas-with-pip-in-python-virtual

missing python bz2 module https://stackoverflow.com/questions/12806122/missing-python-bz2-module

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

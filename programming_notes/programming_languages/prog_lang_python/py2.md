
# python DEBUG

<<用PDB库调试Python程序>> http://www.cnblogs.com/dkblog/archive/2010/12/07/1980682.html

Python 程序如何高效地调试？ - 知乎用户的回答 - 知乎 https://www.zhihu.com/question/21572891/answer/149974828

Python 代码调试技巧 https://www.ibm.com/developerworks/cn/linux/l-cn-pythondebugger/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Python 2.x 和 3.x 系列的差异

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## "/" 运算符

- python中的float除法和整除法 https://www.jianshu.com/p/9034aafb50aa
- 除法运算符/在Python2和Python3中的区别 https://www.pythontab.com/html/2017/pythonjichu_1227/1211.html

简单总结下就是：2.x里`int/int=int (7/10=0)`，但是3.X里`int/int=float (7/10=0.7)`。若想在3.x达到一样的效果，应该用两个/，即`int//int=int`。这个是有血泪教训的，参见LeetCode 002的代码：[000002_Add_Two_Numbers_algo1.py](https://github.com/BIAOXYZ/variousCodes/blob/master/_CodeTopics/LeetCode/000002_Add_Two_Numbers/000002_Add_Two_Numbers_algo1.py)

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# python命令行

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## python -m

Python 中 -m 的典型用法、原理解析与发展演变 https://mp.weixin.qq.com/s/ifMOoIH7yf4GbciPSeNDWA
- > 首先，让我们用“--help”来看看它的解释：
  ```sh
  -m  mod run library module as a script (terminates option list)
  ```
  > "mod"是“module”的缩写，即“-m”选项后面的内容是 module（模块），其作用是把模块当成脚本来运行。
  >
  > “terminates option list”意味着“-m”之后的其它选项不起作用，在这点上它跟“-c”是一样的，都是“终极选项”。官方把它们定义为“接口选项”（Interface options），需要区别于其它的普通选项或通用选项。
- > -m 选项的五个典型用法
  ```py
  在 Python3 中，只需一行命令就能实现一个简单的 HTTP 服务：

  python -m http.server 8000

  # 注:在 Python2 中是这样
  python -m SimpleHTTPServer 8000
  ```
  > 执行后，在本机打开“http://localhost:8000”，或者在局域网内的其它机器上打开“http://本机ip:8000”，就能访问到执行目录下的内容
- > -m 选项的两种原理解析
  >
  > 对于“python -m name”，一句话解释：Python 会检索sys.path ，查找名字为“name”的模块或者包（含命名空间包），并将其内容当成“__main__”模块来执行。 

代码跑得慢甩锅Python？手把手教你如何给代码提速30% https://mp.weixin.qq.com/s/bY3REj6qVw0M1NkhfQaj2g || https://zhuanlan.zhihu.com/p/102485080 || https://towardsdatascience.com/making-python-programs-blazingly-fast-c1cd79bd1b32
- > 在这里，我们使用cProfile模块和time参数运行测试脚本，以便按内部时间（cumtime）对行进行排序。这给了我们很多信息，你在上面看到的行大约是实际输出的10％。由此可见，exp函数是罪魁祸首，现在我们可以更详细地了解时序和性能分析。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# python 语法

Python学习--函数调用与声明问题 https://blog.csdn.net/no_superintendent/article/details/80245294
```py
def test1():   #这是定义函数test1()
    test()     #函数test1()中调用了test()，此时函数test()还没有定义，不过没关系，因为这里只是定义函数test1()，只要在调用test1()的地方之前定义了test()函数就可以！！！ 
 
def test():    #这是定义函数test()
    print('test')
 
test1()        #这里是调用函数test1()的语句，只要在这句之前定义了test()，程序就不会报错！！！
```

<<Python学习笔记-函数基础>> http://www.cnblogs.com/dukeidea/p/6396980.html
```py
#正常情况下，给函数传参数要按顺序，不想按顺序就可以用关键参数，只需指定参数名即可。关键字参数必须在位置参数之后。

def func(a,b,c):
    res = a * b *c
    print(res)

func(3,c= 5,b = 6)
#输出90

func(c= 5,b = 6,3)   #错误写法，报错
#SyntaxError: positional argument follows keyword argument
```

<<Python基础教程 --> Python 面向对象 --> Python内置类属性>> http://www.runoob.com/python/python-object.html
```py
__dict__ : 类的属性（包含一个字典，由类的数据属性组成）
__doc__ :类的文档字符串
__name__: 类名
__module__: 类定义所在的模块（类的全名是'__main__.className'，如果类位于一个导入模块mymod中，那么className.__module__ 等于 mymod）
__bases__ : 类的所有父类构成元素（包含了一个由所有父类组成的元组）
```

<<Python中的作用域及global用法>> http://www.cnblogs.com/summer-cool/p/3884595.html

python对象引用_一切都是对象 https://blog.csdn.net/qinyushuang/article/details/71412862

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## python文件前面的 `#!/usr/bin/env python` 或者 `#!/usr/bin/python`

- #!/usr/bin/env python与#!/usr/bin/python的区别 https://blog.csdn.net/wh_19910525/article/details/8040494
- Why do people write the #!/usr/bin/env python shebang on the first line of a Python script https://stackoverflow.com/questions/2429511/why-do-people-write-the-usr-bin-env-python-shebang-on-the-first-line-of-a-pyt

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## python文件前面（第二行一般）的 `# -*- coding: utf-8 -*-`

- [Python]编码声明：是coding:utf-8还是coding=utf-8呢 https://blog.csdn.net/orangleliu/article/details/8755461
- https://stackoverflow.com/questions/4872007/where-does-this-come-from-coding-utf-8
  * PEP 263 -- Defining Python Source Code Encodings https://www.python.org/dev/peps/pep-0263/
- https://stackoverflow.com/questions/41680533/is-coding-utf-8-also-a-comment-in-python/41680554

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## module

- `if __name__ == '__main__'` 如何正确理解? - 旷修的回答 - 知乎 https://www.zhihu.com/question/49136398/answer/114438004
> http://blog.konghy.cn/2017/04/24/python-entry-program/
- `if __name__ == '__main__'` 如何正确理解? - 秋雨mac的回答 - 知乎 https://www.zhihu.com/question/49136398/answer/208021240
> https://docs.python.org/3.6/library/__main__.html
```py
A module can discover whether or not it is running in the main scope by checking its own __name__, which 
allows a common idiom for conditionally executing code in a module when it is run as a script or with python -m 
but not when it is imported:

if __name__ == "__main__":
    # execute only if run as a script
    main()
```

### __init__.py 

python 在不同层级目录import 模块的方法
https://www.cnblogs.com/kex1n/p/5971590.html

https://stackoverflow.com/questions/279237/import-a-module-from-a-relative-path

### 'module' object is not callable

http://blog.csdn.net/kenkywu/article/details/6743520
```
原因分析：
Python导入模块的方法有两种：import module 和 from module import，区别是前者所有导入的东西使用时需加上模块名的限定，而后者不要。
正确的代码：
>>> import Person
>>> person = Person.Person('dnawo','man')
>>> print person.Name
或
>>> from Person import *
>>> person = Person('dnawo','man')
>>> print person.Name
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## string类型

<<Python基本数据类型之str>> https://www.cnblogs.com/whatisfantasy/p/5956747.html
```py
url = "www.google.com/login/ex"

a, b, c = url.split("/")
print(a, b, c)  #www.google.com login ex

x = url.split("/")
print(x)        #['www.google.com', 'login', 'ex']
p = url.split("/", -1)
print(p)        #['www.google.com', 'login', 'ex']

y = url.split("/")[-1]
print(y)        #ex

z = url.split("/", 1)
print(z)        #['www.google.com', 'login/ex']
```

<<Python中使用多个分隔符分隔字符串re.split>> http://blog.csdn.net/programmer_at/article/details/77409507

<Python正则表达式操作指南> http://wiki.ubuntu.org.cn/Python%E6%AD%A3%E5%88%99%E8%A1%A8%E8%BE%BE%E5%BC%8F%E6%93%8D%E4%BD%9C%E6%8C%87%E5%8D%97

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Lambda表达式

- 关于Python中的lambda，这可能是你见过的最完整的讲解 https://blog.csdn.net/zjuxsl/article/details/79437563
- Python学习笔记（十二）：lambda表达式与函数式编程 https://blog.csdn.net/mathboylinlin/article/details/9413551
> python by mathboylinlin的专栏 https://blog.csdn.net/mathboylinlin/article/category/1505225

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 静态方法

Python: classmethod类函数 & staticmethod静态函数 区别 http://blog.csdn.net/bytxl/article/details/46928837

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## python异常

https://www.cnblogs.com/IPrograming/p/Python_error_handler.html

http://www.runoob.com/python/python-exceptions.html

http://www.yiibai.com/python/python_exceptions.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## python错误处理

“Too many values to unpack” Exception
https://stackoverflow.com/questions/1479776/too-many-values-to-unpack-exception

TypeError: 'NoneType' object is not iterable in Python
https://stackoverflow.com/questions/3887381/typeerror-nonetype-object-is-not-iterable-in-python
> 【Python】python "TypeError: 'NoneType' object is not iterable"错误分析 http://blog.csdn.net/dataspark/article/details/9953225

### TypeError: Unicode-objects must be encoded before hashing
Python 用hashlib求中文字符串的MD5值 - CSDN博客 https://blog.csdn.net/haungrui/article/details/6959340
> 其实是在用pycrypto的哈希函数时碰到的这个错，我估计任何python（指python3版本，python2系列不清楚情况）里的哈希函数都是一样的。就是要对某个字符串求哈希，必须先把这个字符串从unicode形式encode成一个其他形式比如utf-8。

### UnicodeDecodeError: 'utf-8' codec can't decode byte 0xa4 in position 3: inval

- Python3解决UnicodeDecodeError: 'utf-8' codec can't decode byte问题终极解决方案 https://blog.csdn.net/wang7807564/article/details/78164855
- UnicodeDecodeError: 'utf8' codec can't decode byte 0xc9 in position 0: inval https://blog.csdn.net/a2011480169/article/details/68947804

- python编码总结(编码类型、格式、转码) http://www.jb51.net/article/87739.htm
- Python编码问题整理 https://www.cnblogs.com/fnng/p/5008884.html
- 字符编码笔记：ASCII，Unicode 和 UTF-8 http://www.ruanyifeng.com/blog/2007/10/ascii_unicode_and_utf-8.html
- Python 编码为什么那么蛋疼？ - 知乎 https://www.zhihu.com/question/31833164
- Unicode 和 UTF-8 有何区别？ - 于洋的回答 - 知乎 https://www.zhihu.com/question/23374078/answer/69732605

- Python2.x与3​​.x版本区别 http://www.runoob.com/python/python-2x-3x.html
- Python 3中bytes/string的区别 https://www.cnblogs.com/abclife/p/7445222.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

## 伯乐在线python

27 个机器学习、数学、Python 速查表
http://blog.jobbole.com/112009/
>http://datasciencefree.com/python.pdf
>https://www.datacamp.com/community/tutorials/python-data-science-cheat-sheet-basics
>http://www.wzchen.com/s/probability_cheatsheet.pdf
>https://minireference.com/static/tutorials/linear_algebra_in_4_pages.pdf
>http://web.mit.edu/~csvoss/Public/usabo/stats_handout.pdf

Python 资源大全
http://python.jobbole.com/84464/
>awesome-python-cn https://github.com/jobbole/awesome-python-cn

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

动态类型一时爽，代码重构火葬场？ https://blog.csdn.net/zV3e189oS5c0tSknrBCL/article/details/83829485
- > 以前定义一个函数可以接收任何类型的数据。程序运行前，不会有任何错误提示，虽然我们知道字符串和数字是不支持“+”操作的。
  ```python
  def greeting(name):
      return "Hello" + name
  
  greeting("bob")
  greeting(1)
  ```
- > 在 Python3.5 中，用 Type Hint 写法是这样的：
  ```py
  def greeting(name: str) -> str:
      return 'Hello ' + name
  ```
- > 上面就是静态类型的写法，多了 「: str」与 「-> str」，前者用来说明 name 的类型，后者指函数返回值的类型，我们在写代码的过程中IDE也能提示我们写得不对.
- > 除了 IDE 之外，我们还有更强大的静态类型检查工具，叫 mypy，这个工具也是由 Python 之父 Guido 亲自操刀实现的静态类型检查工具。


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

【[:star:][`*`]】【见realpython专门目录】 Absolute vs Relative Imports in Python https://realpython.com/absolute-vs-relative-python-imports/

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

## None 和 None类型

The None Object https://docs.python.org/3.7/c-api/none.html || The None Object https://docs.python.org/2.7/c-api/none.html

What is the None keyword in Python? https://www.educative.io/edpresso/what-is-the-none-keyword-in-python

深入理解Python中的None - 小包总的文章 - 知乎 https://zhuanlan.zhihu.com/p/65193194

What is a None value? https://stackoverflow.com/questions/19473185/what-is-a-none-value

What is the difference between “ is None ” and “ ==None ” https://stackoverflow.com/questions/3257919/what-is-the-difference-between-is-none-and-none

Python `if x is not None` or `if not x is None`? https://stackoverflow.com/questions/2710940/python-if-x-is-not-none-or-if-not-x-is-none

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 可变对象与不可变对象

python可变和不可变对象 https://www.jianshu.com/p/c5582e23b26c

python可变对象与不可变对象 - Dwzb的文章 - 知乎 https://zhuanlan.zhihu.com/p/34395671

Python中的可变与不可变对象 https://segmentfault.com/a/1190000015198945

Python中的不可变对象类型与可变对象类型 https://www.cnblogs.com/shiyublog/p/10809953.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 伯乐在线python

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


# general

Python官方教程
- <<Python 2.7.14 documentation>> https://docs.python.org/2/
- <<Python 3.7.1 documentation>> https://docs.python.org/3.7/

Python中文学习大本营 http://www.pythondoc.com/
- Python 入门指南 (Release:	3.6.3 Date:	Dec 10, 2017) http://www.pythondoc.com/pythontutorial3/index.html
- Python 入门指南 (Release:	2.7.14 Date:	Dec 10, 2017) http://www.pythondoc.com/pythontutorial27/index.html

Python 基础教程 by 菜鸟教程 http://www.runoob.com/python/python-tutorial.html
- Python 列表(List) http://www.runoob.com/python/python-lists.html
  * Python List list()方法 http://www.runoob.com/python/att-list-list.html
  > 描述：list() 方法用于将元组转换为列表。注：元组与列表是非常类似的，区别在于元组的元素值不能修改，元组是放在括号中，列表是放于方括号中。
- Python 内置函数 http://www.runoob.com/python/python-built-in-functions.html
  * Python enumerate() 函数 http://www.runoob.com/python/python-func-enumerate.html
  > 描述：enumerate() 函数用于将一个可遍历的数据对象(如列表、元组或字符串)组合为一个索引序列，同时列出数据和数据下标，一般用在 for 循环当中。Python 2.3. 以上版本可用，2.6 添加 start 参数。

Python Tutorials
https://gist.github.com/reorx/8aa83ad55591987dc286

- Python v2.7.8 文档
http://usyiyi.cn/translate/python_278/index.html
- Python 3.5.2文档
http://usyiyi.cn/translate/python_352/index.html

<<Python 2.7教程>>
https://www.liaoxuefeng.com/wiki/001374738125095c955c1e6d8bb493182103fac9270762a000

这些是 Python 官方推荐的最好书籍（推荐）
https://zhuanlan.zhihu.com/p/34378860
> https://pythonbooks.org/

http://www.jb51.net/article/89425.htm
>更多关于Python相关内容感兴趣的读者可查看本站专题：《Python字符串操作技巧汇总》、《Python编码操作技巧总结》、《Python图片操作技巧总结》、《Python数据结构与算法教程》、《Python Socket编程技巧总结》、《Python函数使用技巧总结》、《Python入门与进阶经典教程》及《Python文件与目录操作技巧汇总》

Python 的练手项目有哪些值得推荐？ - 刘志军的回答 - 知乎
https://www.zhihu.com/question/29372574/answer/192385626

如何系统地自学 Python？ - 彭猫的回答 - 知乎 https://www.zhihu.com/question/29138020/answer/72193349
> VISUALIZE CODE AND GET LIVE HELP http://www.pythontutor.com/
>> Philip Guo Assistant Professor of Cognitive Science UC San Diego http://pgbovine.net/

【循序渐进学Python】系列 http://www.cnblogs.com/IPrograming/category/476786.html
- 【循序渐进学Python】10.模块和包 http://www.cnblogs.com/IPrograming/archive/2013/11/24/Python_module_package.html

开源项目精选：python教程full-speed-python https://openingsource.org/1672/ 

Project Python http://projectpython.net/
- 这次拿下Python全靠它了！一个交互式的学习资源！ https://blog.csdn.net/dQCFKyQDXYm3F8rB0/article/details/82976127

Python - 100天从新手到大师 https://github.com/jackfrued/Python-100-Days

Python最佳实践指南中文版 https://github.com/Prodesire/Python-Guide-CN
- Python最佳实践指南！ https://pythonguidecn.readthedocs.io/zh/latest/

wtfpython的中文翻译/施工结束/ 能力有限，欢迎帮我改进翻译 https://github.com/leisurelicht/wtfpython-cn

:blue_book:《Python进阶》（Intermediate Python 中文版） https://github.com/eastlakeside/interpy-zh
> http://interpy.eastlakeside.com

《Python 3 源码剖析》 https://github.com/flaggo/python3-source-code-analysis
> https://flaggo.github.io/python3-source-code-analysis/

关于Python的面试题 https://github.com/taizilongxu/interview_python

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


## DEBUG

<<用PDB库调试Python程序>>
http://www.cnblogs.com/dkblog/archive/2010/12/07/1980682.html

Python 程序如何高效地调试？ - 知乎用户的回答 - 知乎
https://www.zhihu.com/question/21572891/answer/149974828

Python 代码调试技巧
https://www.ibm.com/developerworks/cn/linux/l-cn-pythondebugger/


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# Python 2.x 和 3.x 系列的差异

## "/" 运算符

- python中的float除法和整除法 https://www.jianshu.com/p/9034aafb50aa
- 除法运算符/在Python2和Python3中的区别 https://www.pythontab.com/html/2017/pythonjichu_1227/1211.html

简单总结下就是：2.x里`int/int=int (7/10=0)`，但是3.X里`int/int=float (7/10=0.7)`。若想在3.x达到一样的效果，应该用两个/，即`int//int=int`。这个是有血泪教训的，参见LeetCode 002的代码：[000002_Add_Two_Numbers_algo1.py](https://github.com/BIAOXYZ/variousCodes/blob/master/_CodeTopics/LeetCode/000002_Add_Two_Numbers/000002_Add_Two_Numbers_algo1.py)


# 语法

Python学习--函数调用与声明问题 https://blog.csdn.net/no_superintendent/article/details/80245294
```
def test1():   #这是定义函数test1()
    test()     #函数test1()中调用了test()，此时函数test()还没有定义，不过没关系，因为这里只是定义函数test1()，只要在调用test1()的地方之前定义了test()函数就可以！！！ 
 
def test():    #这是定义函数test()
    print('test')
 
test1()        #这里是调用函数test1()的语句，只要在这句之前定义了test()，程序就不会报错！！！
```

<<Python学习笔记-函数基础>> http://www.cnblogs.com/dukeidea/p/6396980.html
```
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
```
__dict__ : 类的属性（包含一个字典，由类的数据属性组成）
__doc__ :类的文档字符串
__name__: 类名
__module__: 类定义所在的模块（类的全名是'__main__.className'，如果类位于一个导入模块mymod中，那么className.__module__ 等于 mymod）
__bases__ : 类的所有父类构成元素（包含了一个由所有父类组成的元组）
```

<<Python中的作用域及global用法>>
http://www.cnblogs.com/summer-cool/p/3884595.html

python对象引用_一切都是对象 https://blog.csdn.net/qinyushuang/article/details/71412862

### python文件前面的 `#!/usr/bin/env python` 或者 `#!/usr/bin/python`

- #!/usr/bin/env python与#!/usr/bin/python的区别 https://blog.csdn.net/wh_19910525/article/details/8040494
- Why do people write the #!/usr/bin/env python shebang on the first line of a Python script https://stackoverflow.com/questions/2429511/why-do-people-write-the-usr-bin-env-python-shebang-on-the-first-line-of-a-pyt


### module

if __name__ == '__main__' 如何正确理解? - 旷修的回答 - 知乎
https://www.zhihu.com/question/49136398/answer/114438004
> http://blog.konghy.cn/2017/04/24/python-entry-program/

#### __init__.py 

python 在不同层级目录import 模块的方法
https://www.cnblogs.com/kex1n/p/5971590.html

https://stackoverflow.com/questions/279237/import-a-module-from-a-relative-path

#### 'module' object is not callable

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

### string类型

<<Python基本数据类型之str>>
https://www.cnblogs.com/whatisfantasy/p/5956747.html
```
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

<<Python中使用多个分隔符分隔字符串re.split>>
http://blog.csdn.net/programmer_at/article/details/77409507

<Python正则表达式操作指南>
http://wiki.ubuntu.org.cn/Python%E6%AD%A3%E5%88%99%E8%A1%A8%E8%BE%BE%E5%BC%8F%E6%93%8D%E4%BD%9C%E6%8C%87%E5%8D%97

### Lambda表达式

- 关于Python中的lambda，这可能是你见过的最完整的讲解 https://blog.csdn.net/zjuxsl/article/details/79437563
- Python学习笔记（十二）：lambda表达式与函数式编程 https://blog.csdn.net/mathboylinlin/article/details/9413551
> python by mathboylinlin的专栏 https://blog.csdn.net/mathboylinlin/article/category/1505225

--------------------------------------------------

### 静态方法

Python: classmethod类函数 & staticmethod静态函数 区别
http://blog.csdn.net/bytxl/article/details/46928837

### python异常

https://www.cnblogs.com/IPrograming/p/Python_error_handler.html

http://www.runoob.com/python/python-exceptions.html

http://www.yiibai.com/python/python_exceptions.html


### python错误处理

“Too many values to unpack” Exception
https://stackoverflow.com/questions/1479776/too-many-values-to-unpack-exception

TypeError: 'NoneType' object is not iterable in Python
https://stackoverflow.com/questions/3887381/typeerror-nonetype-object-is-not-iterable-in-python
> 【Python】python "TypeError: 'NoneType' object is not iterable"错误分析 http://blog.csdn.net/dataspark/article/details/9953225


#### TypeError: Unicode-objects must be encoded before hashing
Python 用hashlib求中文字符串的MD5值 - CSDN博客 https://blog.csdn.net/haungrui/article/details/6959340
> 其实是在用pycrypto的哈希函数时碰到的这个错，我估计任何python（指python3版本，python2系列不清楚情况）里的哈希函数都是一样的。就是要对某个字符串求哈希，必须先把这个字符串从unicode形式encode成一个其他形式比如utf-8。

#### UnicodeDecodeError: 'utf-8' codec can't decode byte 0xa4 in position 3: inval

- Python3解决UnicodeDecodeError: 'utf-8' codec can't decode byte问题终极解决方案 https://blog.csdn.net/wang7807564/article/details/78164855
- UnicodeDecodeError: 'utf8' codec can't decode byte 0xc9 in position 0: inval https://blog.csdn.net/a2011480169/article/details/68947804

- python编码总结(编码类型、格式、转码) http://www.jb51.net/article/87739.htm
- Python编码问题整理 https://www.cnblogs.com/fnng/p/5008884.html
- 字符编码笔记：ASCII，Unicode 和 UTF-8 http://www.ruanyifeng.com/blog/2007/10/ascii_unicode_and_utf-8.html
- Python 编码为什么那么蛋疼？ - 知乎 https://www.zhihu.com/question/31833164
- Unicode 和 UTF-8 有何区别？ - 于洋的回答 - 知乎 https://www.zhihu.com/question/23374078/answer/69732605

- Python2.x与3​​.x版本区别 http://www.runoob.com/python/python-2x-3x.html
- Python 3中bytes/string的区别 https://www.cnblogs.com/abclife/p/7445222.html


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

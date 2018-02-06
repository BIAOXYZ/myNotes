

# general

Python Tutorials
https://gist.github.com/reorx/8aa83ad55591987dc286

<<Python v2.7.8 文档>>
http://usyiyi.cn/translate/python_278/index.html

<<Python 2.7.14 documentation>>
https://docs.python.org/2/

<<Python 2.7教程>>
https://www.liaoxuefeng.com/wiki/001374738125095c955c1e6d8bb493182103fac9270762a000

http://www.jb51.net/article/89425.htm
>更多关于Python相关内容感兴趣的读者可查看本站专题：《Python字符串操作技巧汇总》、《Python编码操作技巧总结》、《Python图片操作技巧总结》、《Python数据结构与算法教程》、《Python Socket编程技巧总结》、《Python函数使用技巧总结》、《Python入门与进阶经典教程》及《Python文件与目录操作技巧汇总》


# IDE

## IDE pycharm

### pycharm日常

<<pycharm快捷键、常用设置、配置管理>>
http://blog.csdn.net/pipisorry/article/details/39909057
```
Ctrl + /    行注释/取消行注释
Ctrl + Shift + F  或者连续2次敲击shift   全局查找{可以在整个项目中查找某个字符串什么的，如查找某个函数名字符串看之前是怎么使用这个函数的}
Ctrl + Y 删除当前插入符所在的行
Ctrl + G    查看当前行号、字符号 (跳转到输入的指定行)
```

Pycharm下运行程序查看每个变量的值的方法（类似于Spyder和MATLAB）
https://www.cnblogs.com/tq007/p/7285239.html


### linux下安装pycharm有问题，目前还没时间看

https://stackoverflow.com/questions/27727826/problems-installing-pycharm


## IDE Anaconda

http://python.jobbole.com/tag/anaconda/
>Anaconda使用总结 http://python.jobbole.com/86236/
>致Python初学者：Anaconda入门使用指南 http://python.jobbole.com/87522/

<<Anaconda修改国内镜像源>>
https://jingyan.baidu.com/article/1876c8527be1c3890a137645.html

<<清华大学开源软件镜像站 - Anaconda>>
https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/

### Anaconda问题解决

- anaconda没有创建启动快捷方式的解决办法
http://blog.csdn.net/w371500241/article/details/78582403

- Python，Pycharm，Anaconda等的关系与安装过程~为初学者跳过各种坑
https://www.cnblogs.com/tq007/p/7281105.html


### 安装使用

<Pycharm，Anaconda的安装，集成开发环境，包安装>
https://www.jianshu.com/p/98b2fbb3a45c

<python 科学计算 发行版 Anaconda安装使用教程>
http://blog.csdn.net/bitcarmanlee/article/details/51917642

<最省心的Python版本和第三方库管理——初探Anaconda>
https://zhuanlan.zhihu.com/p/25198543

<python anaconda 怎么安装？>
https://www.zhihu.com/question/30123965

<Anaconda介绍、安装及使用教程>
https://zhuanlan.zhihu.com/p/32925500


## DEBUG

<<用PDB库调试Python程序>>
http://www.cnblogs.com/dkblog/archive/2010/12/07/1980682.html


# 语法

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
<<Python学习笔记-函数基础>>
http://www.cnblogs.com/dukeidea/p/6396980.html


```
__dict__ : 类的属性（包含一个字典，由类的数据属性组成）
__doc__ :类的文档字符串
__name__: 类名
__module__: 类定义所在的模块（类的全名是'__main__.className'，如果类位于一个导入模块mymod中，那么className.__module__ 等于 mymod）
__bases__ : 类的所有父类构成元素（包含了一个由所有父类组成的元组）
```
<<Python基础教程 --> Python 面向对象 --> Python内置类属性>>
http://www.runoob.com/python/python-object.html

<<Python中的作用域及global用法>>
http://www.cnblogs.com/summer-cool/p/3884595.html

### module

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



### 静态方法

Python: classmethod类函数 & staticmethod静态函数 区别
http://blog.csdn.net/bytxl/article/details/46928837

### python异常

https://www.cnblogs.com/IPrograming/p/Python_error_handler.html

http://www.runoob.com/python/python-exceptions.html

http://www.yiibai.com/python/python_exceptions.html


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



# general

## IDE pycharm

<<pycharm快捷键、常用设置、配置管理>>
http://blog.csdn.net/pipisorry/article/details/39909057
>
Ctrl + /    行注释/取消行注释
Ctrl + Shift + F  或者连续2次敲击shift   全局查找{可以在整个项目中查找某个字符串什么的，如查找某个函数名字符串看之前是怎么使用这个函数的}
Ctrl + Y 删除当前插入符所在的行
Ctrl + G    查看当前行号、字符号


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

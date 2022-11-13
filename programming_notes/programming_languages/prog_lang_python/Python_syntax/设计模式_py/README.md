
什么是工厂函数？Python 中工厂函数怎么理解？ - 石溪的回答 - 知乎 https://www.zhihu.com/question/20670869/answer/310595560

【[:star:][`*`]】 用Python实现设计模式——工厂模式 https://segmentfault.com/a/1190000013053013
- > 前言
  * > 工厂模式，顾名思义就是我们可以通过一个指定的“工厂”获得需要的“产品”，在设计模式中主要用于抽象对象的创建过程，让用户可以指定自己想要的对象而不必关心对象的实例化过程。这样做的好处是用户只需通过固定的接口而不是直接去调用类的实例化方法来获得一个对象的实例，隐藏了实例创建过程的复杂度，解耦了生产实例和使用实例的代码，降低了维护的复杂性。本文会用Python实现三种工厂模式的简单例子，所有代码都托管在Github上。
    >> https://github.com/shaqsnake/DesignPatternWithPython/tree/master/Factory
- > **简单工厂**
- > **工厂方法**
  * > 我们把工厂抽象出来用 `abc` 模块实现了一个抽象的基类AbstractFactory，这样就可以通过特定的工厂来获得特定的产品实例了：
- > **抽象工厂**

# 单例模式

Python中的单例模式的几种实现方式的及优化 https://www.cnblogs.com/huchong/p/8244279.html

Python实现单例模式的几种方式 https://juejin.cn/post/6993944421133713415

Python单例模式(Singleton)的N种实现 - Crossin的文章 - 知乎 https://zhuanlan.zhihu.com/p/37534850

Python 实现单例模式的五种写法 https://mp.weixin.qq.com/s/vaf79eXLgvDYNcSd5kd6Jg

# 访问者模式

访问者模式 https://zh.wikipedia.org/wiki/%E8%AE%BF%E9%97%AE%E8%80%85%E6%A8%A1%E5%BC%8F || Visitor pattern https://en.wikipedia.org/wiki/Visitor_pattern

访问者模式 https://www.runoob.com/design-pattern/visitor-pattern.html

# 其他Python编程技巧

## 减少 if-else 分支

Using a class dictionary to map to instance methods in Python https://stackoverflow.com/questions/12921857/using-a-class-dictionary-to-map-to-instance-methods-in-python
- 【[:star:][`*`]】 https://stackoverflow.com/questions/12921857/using-a-class-dictionary-to-map-to-instance-methods-in-python/12921884#12921884

Why store a function inside a python dictionary? https://softwareengineering.stackexchange.com/questions/182093/why-store-a-function-inside-a-python-dictionary

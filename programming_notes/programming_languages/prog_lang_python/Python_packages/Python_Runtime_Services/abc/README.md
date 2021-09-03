
# 官方

abc --- 抽象基类 https://docs.python.org/zh-cn/3/library/abc.html || abc — Abstract Base Classes https://docs.python.org/3/library/abc.html

# 其他

【进阶Python】第七讲：接口与抽象基类 - Jackpop的文章 - 知乎 https://zhuanlan.zhihu.com/p/89549054

Python抽象类（abc模块） https://www.cnblogs.com/Black-rainbow/p/9582826.html
- > 1、抽象类概念
  * > 抽象类是一个特殊的类，只能被继承，不能实例化
- > 2、为什么要有抽象类
  * > 其实在未接触抽象类概念时，我们可以构造香蕉、苹果、梨之类的类，然后让它们继承水果这个基类，水果的基类包含一个eat函数。 <br> 但是你有没有想过，我们可以将香蕉、苹果、梨实例化，去吃香蕉、苹果、梨。但是我们却不能将水果实例化，因为我们无法吃到叫水果的这个东西。 <br> 所以抽象类中只能有抽象方法（没有实现功能），该类不能被实例化，只能被继承，且子类必须实现抽象方法。
- > 3、抽象类的作用
  * > 在不同的模块中通过抽象基类来调用，可以用最精简的方式展示出代码之间的逻辑关系，让模块之间的依赖清晰简单。
  * > 抽象类的编程，让每个人可以关注当前抽象类的方法和描述，而不需要考虑过多的实现细节，这对协同开发有很大意义，也让代码可读性更高。

Python之abc模块 https://blog.csdn.net/haiyanggeng/article/details/81983627
- > **1.为什么使用 `abc`？**
  * > Abstract base classes由一组接口组成，检查比 `hasattr()` 更严格。通过定义一个抽象基类，可以为一组子类定义一个通用的API。这对于第三方为应用提供插件等非常有用，另外当您在一个大型的团队中工作或在一个大型的代码库中，同时将所有的类放在您的头脑中是困难或不可能的时，它也可以帮助您。
- > **2.`abc`怎么工作**
  * > `abc` 通过把基类中的方法标记为抽象方法，并且注册具体类为基类的实现的方式工作。

Python设计模式二：接口类和抽象类（Python接口设计） https://blog.csdn.net/weixin_42681866/article/details/113479049

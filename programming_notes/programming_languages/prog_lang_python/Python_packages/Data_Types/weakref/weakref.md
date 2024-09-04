
# 官方

weakref --- 弱引用 https://docs.python.org/zh-cn/3.12/library/weakref.html

# 其他

Python weakref (弱引用 ) 教程 https://www.cnblogs.com/marsggbo/p/14831456.html
- > 原文： https://blog.csdn.net/NeverLate_gogogo/article/details/107021695 本文有删改
- > **一、变量**
  * > 1.2  `==` 和 `is` 之间的比较
    + > `==` 运算符比较两个对象的值（对象中保存的数据），而 `is` 比较对象的标识。
    + > `is` 运算符比 `==` 速度快，因为它不能重载.接比较两个对象的 整数 ID。
    + > `a == b` 是语法糖，等同于 `a.__eq__(b)`。
    + > `__eq__` 方法继承自 `object`, 比较两个对象的 ID，结果与 `is` 一样。但是多数内置类型使用更有意义的方式覆盖了 `__eq__` 方法，会考虑对象属性的值。相等性测试可能涉及大量处理工作，例如，比较大型集合或嵌套层级深的结构时。

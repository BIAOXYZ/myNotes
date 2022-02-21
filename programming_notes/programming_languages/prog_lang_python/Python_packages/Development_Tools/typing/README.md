
# 官方

typing --- 类型提示支持 https://docs.python.org/zh-cn/3/library/typing.html || typing — Support for type hints https://docs.python.org/3/library/typing.html

## `typing.Callable`

# 其他

​Python 3 新特性：类型注解 - Crossin的文章 - 知乎 https://zhuanlan.zhihu.com/p/37239021
- > 于是 Python 3 提供了一个新的特性：**函数注解**，也就是文章开头的这个例子：
  ```py
  def add(x:int, y:int) -> int:
      return x + y
  ```
- > 在 Python 3.6 中，又引入了对变量类型进行注解的方法：
  ```py
  a: int = 123
  b: str = 'hello'
  ```
- > 更进一步，如果你需要指明一个全部由整数组成的列表：
  ```py
  from typing import List
  l: List[int] = [1, 2, 3]
  ```
- > 但同样，这些仅仅是“注解”，不会对代码产生任何影响。不过，你可以通过 `mypy` 库来检验最终代码是否符合注解。

## 类型提示时到底是用 `list` 还是 `List`？
>> //notes：看起来用 `typing` 库的好处是，列表里可以再具体的指定类型。。。

Difference between defining typing.Dict and dict? https://stackoverflow.com/questions/37087457/difference-between-defining-typing-dict-and-dict

Using List/Tuple/etc. from typing vs directly referring type as list/tuple/etc https://stackoverflow.com/questions/39458193/using-list-tuple-etc-from-typing-vs-directly-referring-type-as-list-tuple-etc

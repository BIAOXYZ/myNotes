
# 长行换行问题

`2. 打印输出和格式化` https://pythonhowto.readthedocs.io/zh_CN/latest/print.html || https://github.com/llinjupt/pyhowto/blob/master/print.rst
- > **2.5. 长行打印输出**
  * > 如果 `print()` 函数要打印很长的数据，则可使用右斜杠将一行的语句分为多行进行编辑，编译器在执行时， 将它们作为一行解释，注意右斜杠后不可有空格，且其后的行必须顶格，否则头部空格将被打印。
    ```py
    def print_long_line():
        print("The door bursts open. A MAN and WOMAN enter, drunk and giggling,\
    horny as hell.No sooner is the door shut than they're all over each other,\
    ripping at clothes,pawing at flesh, mouths locked together.")
    
    print_long_line()
    
    >>>
    The door bursts open. A MAN and WOMAN enter, drunk and giggling,horny as
    hell.No sooner is the door shut than they're all over each other, ripping
    at clothes,pawing at flesh, mouths locked together.
    ```
  * > 使用一对三引号和上述代码是等价的，以上写法每行字符必须顶格，否则对齐空格将作为字符串内容被打印，这影响了代码的美观。可以为每行添加引号来解决这个问题。
    ```py
    def print_long_line():
        print("""The door bursts open. A MAN and WOMAN enter, drunk and giggling,
    horny as hell.No sooner is the door shut than they're all over each other,
    ripping at clothes,pawing at flesh, mouths locked together.""")
    ```
    ```py
    def print_long_line():
        print("The door bursts open. A MAN and WOMAN enter, drunk and giggling,"
              "horny as hell.No sooner is the door shut than they're all over each other,"
              "ripping at clothes,pawing at flesh, mouths locked together.")
    
    print_long_line()
    
    >>>
    The door bursts open. A MAN and WOMAN enter, drunk and giggling,horny as
    hell.No sooner is the door shut than they're all over each other, ripping
    at clothes,pawing at flesh, mouths locked together.
    ```

# 带颜色打印

Python基础之控制台输出颜色 https://blog.csdn.net/qq_33567641/article/details/82769523
- > **基本属性**
  * > 控制台显示方式

    | 显示方式 | 显示效果 |
    |:--:|:--:|
    | 0	| 默认值 |
    | 1	| 高亮 |
    | 4	| 下划线 |
    | 5 |	闪烁 |
    | 7	| 反显 |
    | 8	| 不可见 | 

  * > 控制台颜色

    | 前景色 | 背景色 | 颜色说明 |
    |:--:|:--:|:--:|
    | 30 | 40 | 黑色 |
    | 31 | 41 | 红色 |
    | 32 | 42 | 绿色 |
    | 33 | 43 | 黄色 |
    | 34 | 44 | 蓝色 |
    | 35 | 45 | 紫红色 |
    | 36 | 46 | 青蓝色 |
    | 37 | 47 | 白色 |

- > **语法**
  ```console
  \033[显示方式; 前景色; 背景色m******\033[0m
  ```
  > 其中`******`表示被标记的内容。可以缺省书写，使用默认设定。
- > **实例演示**
  ```py
  print("\033[31m这是红色字体\033[0m")
  print("\033[32m这是绿色字体\033[0m")
  print("\033[33m这是黄色字体\033[0m")
  print("\033[34m这是蓝色字体\033[0m")
  print("\033[38m这是默认字体\033[0m")  # 大于37将显示默认字体
  ```
  ```py
  print("\033[0;31;42m这是默认红色字体背景绿色\033[0m")
  print("\033[1;32;43m这是高亮绿色字体背景黄色\033[0m")
  print("\033[4;33;45m这是下划线黄色字体背景紫红色\033[0m")
  print("\033[5;34;46m这是闪烁蓝色字体背景青蓝色\033[0m")
  ```
  ```py
  print("\033[4;35;43m平生不会相思，")
  print("才会相思，便害相思。")
  print("身似浮云，心如飞絮，")
  print("气若游丝。")
  print("空一缕馀香在此，")
  print("盼千金游子何之。")
  print("证候来时，正是何时？")
  print("灯半昏时，月半明时。\033[0m")
  ```
  >> //notes：本地亲测可行，但是试了两个在线的 IDE 都显示不出来颜色。怀疑是 Online IDE 的环境（一般都是容器）里缺少了一些显示颜色的库。。。不过无所谓了，本地试过可以就行。

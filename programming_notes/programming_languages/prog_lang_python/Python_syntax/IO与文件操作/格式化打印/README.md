
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

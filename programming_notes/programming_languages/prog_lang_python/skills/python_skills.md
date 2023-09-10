
# 类型转换

## 将字符串类型灵活转换为整型或浮点型

Convert string to int, float or leave it as string, depending on the best option https://stackoverflow.com/questions/63361635/convert-string-to-int-float-or-leave-it-as-string-depending-on-the-best-option
- > https://stackoverflow.com/questions/63361635/convert-string-to-int-float-or-leave-it-as-string-depending-on-the-best-option/63361892#63361892
  ```py
  def convert(string):
      possible = [str, int, float]
      for func in possible:
          try:
              result = func(string)
          except ValueError:
              continue
          if str(result) == string and type(result) is not str:
              return result
      return string

  strings = ['hello', '1', '1.0', '1.9']
  for string in strings:
     result = convert(string)
     print(type(result), result)
  ```
  ```console
  Output:
  <class 'str'> hello
  <class 'int'> 1
  <class 'float'> 1.0
  <class 'float'> 1.9
  ```
  * > 个人实战（注意小写的 "nan" 被认为是 `float` 类型）：
    ```py
    def convert(s):
        funcs = [str, int, float]
        for func in funcs:
            try:
                res = func(s)
            except ValueError:
                continue
            if str(res) == s and type(res) is not str:
                return res
        return s

    strings = ['hello', '1', '1.0', '1.9', "1.1.5", "nan", 'NaN', 'None']
    for string in strings:
       result = convert(string)
       print(type(result), result)
    ```
    ```console
    <class 'str'> hello
    <class 'int'> 1
    <class 'float'> 1.0
    <class 'float'> 1.9
    <class 'str'> 1.1.5
    <class 'float'> nan
    <class 'str'> NaN
    <class 'str'> None
    ```

Checking if a string can be converted to float in Python [duplicate] https://stackoverflow.com/questions/736043/checking-if-a-string-can-be-converted-to-float-in-python


# 类型转换

## 将字符串类型灵活转换为整型或浮点型

Convert string to int, float or leave it as string, depending on the best option https://stackoverflow.com/questions/63361635/convert-string-to-int-float-or-leave-it-as-string-depending-on-the-best-option
- > 
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


# 官方

https://docs.python.org/3.8/library/functions.html#int
- > If x is not a number or if base is given, then x must be a string, [bytes](), or [bytearray]() instance representing an [integer literal]() in radix base. 

# 个人实战

```py
>>> int('101', 2)
5
>>> int('101')
101
>>> int(101)
101
>>> int(101, 2)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: int() can't convert non-string with explicit base
>>>
```

```py
>>> bin(5)
'0b101'
>>> int(bin(5), 2)
5
>>> oct(9)
'0o11'
>>> int(oct(9), 8)
9
>>> hex(18)
'0x12'
>>> int(hex(18), 16)
18
>>> int(hex(18))
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ValueError: invalid literal for int() with base 10: '0x12'
>>> 
```

# 其他

可能是最优雅的任意进制转换（python实现） https://www.jianshu.com/p/10bf68378b10

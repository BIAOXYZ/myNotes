
# 官方

namedtuple() 命名元组的工厂函数 https://docs.python.org/zh-cn/3/library/collections.html#collections.namedtuple
- > 命名元组赋予每个位置一个含义，提供可读性和自文档性。它们可以用于任何普通元组，并添加了通过名字获取值的能力，通过索引值也是可以的。
- > `collections.namedtuple(typename, field_names, *, rename=False, defaults=None, module=None)`
  ```py
  >>> # Basic example
  >>> Point = namedtuple('Point', ['x', 'y'])
  >>> p = Point(11, y=22)     # instantiate with positional or keyword arguments
  >>> p[0] + p[1]             # indexable like the plain tuple (11, 22)
  33
  >>> x, y = p                # unpack like a regular tuple
  >>> x, y
  (11, 22)
  >>> p.x + p.y               # fields also accessible by name
  33
  >>> p                       # readable __repr__ with a name=value style
  Point(x=11, y=22)
  ```
- > **命名元组尤其有用于赋值 `csv` `sqlite3` 模块返回的元组**
  ```py
  EmployeeRecord = namedtuple('EmployeeRecord', 'name, age, title, department, paygrade')

  import csv
  for emp in map(EmployeeRecord._make, csv.reader(open("employees.csv", "rb"))):
      print(emp.name, emp.title)

  import sqlite3
  conn = sqlite3.connect('/companydata')
  cursor = conn.cursor()
  cursor.execute('SELECT name, age, title, department, paygrade FROM employees')
  for emp in map(EmployeeRecord._make, cursor.fetchall()):
      print(emp.name, emp.title)
  ```

# 其他

Write Pythonic and Clean Code With namedtuple https://realpython.com/python-namedtuple/

Namedtuple in Python https://www.geeksforgeeks.org/namedtuple-in-python/

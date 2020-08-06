
Python '!=' Is Not 'is not': Comparing Objects in Python https://realpython.com/python-is-identity-vs-equality/
- > **Conclusion**
  * > In this tutorial, you’ve learned that == and != **compare the value of two objects**, whereas the Python is and is not operators compare whether two variables **refer to the same object in memory**. If you keep this distinction in mind, then you should be able to prevent unexpected behavior in your code.

# 个人补充链接：

Is there a difference between “==” and “is”? https://stackoverflow.com/questions/132988/is-there-a-difference-between-and-is
- > `is` will return `True` if two variables point to the same object, `==` if the objects referred to by the variables are equal.
  ```py
  >>> a = [1, 2, 3]
  >>> b = a
  >>> b is a 
  True
  >>> b == a
  True

  # Make a new copy of list `a` via the slice operator, 
  # and assign it to variable `b`
  >>> b = a[:] 
  >>> b is a
  False
  >>> b == a
  True
  ```
- > In your case, the second test only works because Python caches small integer objects, which is an implementation detail. For larger integers, this does not work:

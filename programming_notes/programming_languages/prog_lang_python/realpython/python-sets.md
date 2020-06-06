
Sets in Python https://realpython.com/python-sets/
- > `x.remove(<elem>)` removes `<elem>` from `x`. Python raises an exception if `<elem>` is not in `x`:
  ```py
  >>> x = {'foo', 'bar', 'baz'}
  
  >>> x.remove('baz')
  >>> x
  {'bar', 'foo'}
  
  >>> x.remove('qux')
  Traceback (most recent call last):
    File "<pyshell#58>", line 1, in <module>
      x.remove('qux')
  KeyError: 'qux'
  ```
- > `x.discard(<elem>)` also removes `<elem>` from `x`. However, if `<elem>` is not in `x`, this method quietly does nothing instead of raising an exception:
  ```py
  >>> x = {'foo', 'bar', 'baz'}
  
  >>> x.discard('baz')
  >>> x
  {'bar', 'foo'}
  
  >>> x.discard('qux')
  >>> x
  {'bar', 'foo'}
  ```

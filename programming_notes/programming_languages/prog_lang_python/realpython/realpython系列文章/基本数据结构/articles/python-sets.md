
【[:star:][`*`]】 Sets in Python https://realpython.com/python-sets/
- > `x1.union(x2)` and `x1 | x2` both return the set of all elements in either `x1` or `x2`:
  ```py
  >>> x1 = {'foo', 'bar', 'baz'}
  >>> x2 = {'baz', 'qux', 'quux'}

  >>> x1.union(x2)
  {'foo', 'qux', 'quux', 'baz', 'bar'}

  >>> x1 | x2
  {'foo', 'qux', 'quux', 'baz', 'bar'}
  ```
- > `x1.intersection(x2)` and `x1 & x2` return the set of elements common to both `x1` and `x2`:
  ```py
  >>> x1 = {'foo', 'bar', 'baz'}
  >>> x2 = {'baz', 'qux', 'quux'}

  >>> x1.intersection(x2)
  {'baz'}

  >>> x1 & x2
  {'baz'}
  ```
- > `x1.difference(x2)` and `x1 - x2` return the set of all elements that are in `x1` but not in `x2`:
  ```py
  >>> x1 = {'foo', 'bar', 'baz'}
  >>> x2 = {'baz', 'qux', 'quux'}

  >>> x1.difference(x2)
  {'foo', 'bar'}

  >>> x1 - x2
  {'foo', 'bar'}
  ```
- > `x1.symmetric_difference(x2)` and `x1 ^ x2` return the set of all elements in either `x1` or `x2`, but not both:
  ```py
  >>> x1 = {'foo', 'bar', 'baz'}
  >>> x2 = {'baz', 'qux', 'quux'}

  >>> x1.symmetric_difference(x2)
  {'foo', 'qux', 'quux', 'bar'}

  >>> x1 ^ x2
  {'foo', 'qux', 'quux', 'bar'}
  ```
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

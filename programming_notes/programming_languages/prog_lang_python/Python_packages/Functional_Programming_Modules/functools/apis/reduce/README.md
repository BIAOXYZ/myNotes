
Python's reduce(): From Functional to Pythonic Style https://realpython.com/python-reduce-function/

Reduce function doesn't handle an empty list https://stackoverflow.com/questions/33945882/reduce-function-doesnt-handle-an-empty-list
- https://stackoverflow.com/questions/33945882/reduce-function-doesnt-handle-an-empty-list/33945933#33945933
  * > As it is written in the [documentation](https://docs.python.org/2/library/functions.html#reduce): `If the optional initializer is present, it is placed before the items of the iterable in the calculation, and serves as a default when the iterable is empty. If initializer is not given and iterable contains only one item, the first item is returned.`
  * > So if you want your code to work with an empty list, you should use an initializer:
    ```py
    >>> reduce(lambda x, y: x*y, [], 1)
    1
    ```


Python import: Advanced Techniques and Tips https://realpython.com/python-import/
- > **Basic Python `import`**
  * > In practice, a module usually corresponds to one `.py` file containing Python code.
  * > Note that you write `math.pi` and not just simply `pi`. In addition to being a module, ***`math` acts as a namespace*** that keeps all the attributes of the module together.
  * > You can list the contents of a namespace with `dir()`:
    ```py
    >>> import math
    >>> dir()
    ['__annotations__', '__builtins__', ..., 'math']
    >>> dir(math)
    ['__doc__', ..., 'nan', 'pi', 'pow', ...]
    ```
    > Using `dir()` without any argument shows ***what’s in the global namespace***. To see the contents of the `math` namespace, you use `dir(math)`.

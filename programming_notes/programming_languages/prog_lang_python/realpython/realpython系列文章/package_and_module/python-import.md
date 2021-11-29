
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
- > **Packages**
  * > You can use a package to further organize your modules. The Python.org glossary defines **package** as follows: A Python module which can contain submodules or recursively, subpackages. Technically, ***a package is a Python module with an `__path__` attribute***.
  * > In general, ***submodules and subpackages aren’t imported when you import a package. However, you can use `__init__.py` to include any or all submodules and subpackages if you want***. To show a few examples of this behavior, you’ll create a package for saying [Hello world【这个网站终结了我之前的 `full-stack_hello-world_software_engineer` 项目】](http://helloworldcollection.de/) in a few different languages. The package will consist of the following directories and files:
    ```sh
    world/
    │
    ├── africa/
    │   ├── __init__.py
    │   └── zimbabwe.py
    │
    ├── europe/
    │   ├── __init__.py
    │   ├── greece.py
    │   ├── norway.py
    │   └── spain.py
    │
    └── __init__.py
    ```
    > Each country file prints out a greeting, while the `__init__.py` files selectively import some of the subpackages and submodules. The exact contents of the files are as follows:
    ```py
    # world/africa/__init__.py  (Empty file)

    # world/africa/zimbabwe.py
    print("Shona: Mhoroyi vhanu vese")
    print("Ndebele: Sabona mhlaba")

    # world/europe/__init__.py
    from . import greece
    from . import norway

    # world/europe/greece.py
    print("Greek: Γειά σας Κόσμε")

    # world/europe/norway.py
    print("Norwegian: Hei verden")

    # world/europe/spain.py
    print("Castellano: Hola mundo")

    # world/__init__.py
    from . import africa
    ```
    > Note that `world/__init__.py` imports only `africa` and not `europe`. Similarly, `world/africa/__init__.py` doesn’t import anything, while `world/europe/__init__.py` imports `greece` and `norway` but not `spain`. Each country module will print a greeting when it’s imported.

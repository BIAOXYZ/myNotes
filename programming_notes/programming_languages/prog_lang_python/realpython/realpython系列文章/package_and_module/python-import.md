
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
- > **Modules**
  * The Python.org glossary defines ***`module`*** as follows: An object that serves as an organizational unit of Python code. ***Modules have a namespace containing arbitrary Python objects. Modules are loaded into Python by the process of importing***.
- > **Packages**
  * > You can use a package to further organize your modules. The Python.org glossary defines **package** as follows: A Python module which can contain submodules or recursively, subpackages. Technically, ***a `package` is a Python `module` with an `__path__` attribute***.
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
  * > Remember, ***importing a module both loads the contents and creates a namespace containing the contents***. The last few examples show that it’s possible for the same module to be part of different namespaces.
  * > **Technical Detail**: The module namespace is implemented as a [Python dictionary]() and is available at the `.__dict__` attribute:
    ```py
    >>> import math
    >>> math.__dict__["pi"]
    3.141592653589793
    ```
    > You rarely need to interact with `.__dict__` directly. <br> Similarly, Python’s global namespace is also a dictionary. You can access it through `globals()`.
  * > It’s fairly common ***to import subpackages and submodules in an `__init__.py` file*** to make them more readily available to your users. You can see [one example of this](https://github.com/psf/requests/blob/v2.23.0/requests/__init__.py#L112) in the popular requests package.
- > **Absolute and Relative Imports**
  * > The [PEP 8 style guide]() recommends using absolute imports in general. However, relative imports are an alternative for organizing package hierarchies. For more information, see [Absolute vs Relative Imports in Python](https://realpython.com/absolute-vs-relative-python-imports/).
- > **Python’s Import Path**
  * > How does Python find the modules and packages it imports? You’ll see more details about the mechanics of the Python import system [later](). For now, just know that ***Python looks for modules and packages in its [import path](https://docs.python.org/3/glossary.html#term-import-path)***. This is ***a list of locations*** that are searched for modules to import.
  * > **Note**: When you type import something, Python will look for something a few different places before searching the import path. <br> In particular, it’ll look in a module cache to see if something has already been imported, and it’ll search among the built-in modules. <br> You’ll learn more about the full Python import machinery in a [later section]().
  * > You can inspect Python’s import path by printing `sys.path`. Broadly speaking, this list will contain three different kinds of locations:
    + > 1. The directory of the current script (or the current directory if there’s no script, such as when Python is running interactively)
    + > 2. The contents of the `PYTHONPATH` environment variable
    + > 3. Other, installation-dependent directories

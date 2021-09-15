
Python Modules and Packages – An Introduction https://realpython.com/python-modules-packages/
- > **The Module Search Path**
  * > Continuing with the above example, let’s take a look at what happens when Python executes the statement:
    ```py
    import mod
    ```
    > When the interpreter executes the above import statement, it searches for `mod.py` in ***a list of directories*** assembled from the following sources:
  * > Once a module has been imported, you can determine the location where it was found with the module’s `__file__` attribute:
    ```py
    >>> import mod
    >>> mod.__file__
    'C:\\Users\\john\\mod.py'
    >>> import re
    >>> re.__file__
    'C:\\Python36\\lib\\re.py'
    ```
    > The directory portion of `__file__` should be one of the directories in `sys.path`.
- > **The import Statement**
  * > **Module** contents are made available to the caller with the import statement. The import statement takes many different forms, shown below.

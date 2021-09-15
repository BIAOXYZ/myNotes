
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
  * > **`import <module_name>`**
    + > The simplest form is the one already shown above:
      ```py
      import <module_name>
      ```
    + > Note that this does not make the module contents directly accessible to the caller. Each module has its own **private symbol table**, which serves as the global symbol table for all objects defined in the module. Thus, a module creates a separate **namespace**, as already noted.
    + > The statement `import <module_name>` ***only places `<module_name>` in the caller’s symbol table***. The objects that are defined in the module ***remain in the module’s private symbol table***.
  * > **`from <module_name> import <name(s)>`**
    + > Because this form of import ***places the object names directly into the caller’s symbol table***, any objects ***that already exist with the same name will be overwritten***:
      ```py
      >>> a = ['foo', 'bar', 'baz']
      >>> a
      ['foo', 'bar', 'baz']
      >>> from mod import a
      >>> a
      [100, 200, 300]
      ```
    + > It is even possible to indiscriminately import everything from a module at one fell swoop:
      ```py
      from <module_name> import *
      ```
      > This will place the names of all objects from `<module_name>` into the local symbol table, with the exception of any that ***begin with the underscore (`_`) character***.


# 官方

`create_function(name, narg, func, *, deterministic=False)` https://docs.python.org/zh-cn/3.10/library/sqlite3.html#sqlite3.Connection.create_function

# sqlean

User-Defined Functions in SQLite https://antonz.org/sqlean-define/
- > SQLite does not support user-defined functions by default. However, you can easily enable them using the `sqlean-define` extension.
- sqlean: The ultimate set of SQLite extensions https://github.com/nalgeon/sqlean/tree/main

# 其他

Python Create or Redefine SQLite Functions https://pynative.com/python-sqlite-create-or-redefine-sqlite-functions/
- > **Defining SQLite Functions using Python**
  * > **Note**: if `num_params` is `-1`, the function may take any number of arguments. `connection.create_function()` can return any of the types supported by SQLite for example, `bytes`, `str`, `int`, `float`, and `None`.
- Python Database Programming Exercise https://pynative.com/python-database-programming-exercise-with-solution/

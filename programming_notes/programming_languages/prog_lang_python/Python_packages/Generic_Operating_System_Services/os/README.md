
# 官方

os --- 多种操作系统接口 https://docs.python.org/zh-cn/3/library/os.html || os — Miscellaneous operating system interfaces https://docs.python.org/3/library/os.html

`cpython/Lib/os.py` https://github.com/python/cpython/blob/main/Lib/os.py

# `os.getenv()`

https://github.com/python/cpython/blob/3.10/Lib/os.py#L771
```py
def getenv(key, default=None):
    """Get an environment variable, return None if it doesn't exist.
    The optional second argument can specify an alternate default.
    key, default and the result are str."""
    return environ.get(key, default)
```
>> //notes：虽然环境变量这个 dict 的 key 和 value 都是 str，但是这里因为用了 get 方法，所以是和 None 比较来判断是否为空。

# 其他

Python OS 文件/目录方法 https://www.runoob.com/python/os-file-methods.html

How do I get the full path of the current file's directory? https://stackoverflow.com/questions/3430372/how-do-i-get-the-full-path-of-the-current-files-directory
- https://stackoverflow.com/questions/3430372/how-do-i-get-the-full-path-of-the-current-files-directory/3430395#3430395
  ```py
  import os
  os.path.abspath(os.getcwd())
  ```

python 获取当前目录，上级目录，上上级目录 https://blog.csdn.net/flyfish1986/article/details/109773747
```py
import os
print('当前目录')
print(os.getcwd())
print(os.path.abspath(os.path.dirname(__file__)))

print('上级目录')
print(os.path.abspath(os.path.dirname(os.getcwd())))
print(os.path.abspath(os.path.join(os.getcwd(), "..")))

print('上上级目录')
print(os.path.abspath(os.path.join(os.getcwd(), "../..")))
```

Python3获取文件路径，文件名，文件类型 https://blog.csdn.net/bryanwang_3099/article/details/115217013
```py
import os
file_path = "C:/Users/Public/yellow.jpg"

# 获取文件所在目录和完整文件名
dir_name, full_file_name = os.path.split(file_path)
print("文件所在目录: {}".format(dir_name))
print("完整文件名: {}".format(full_file_name ))

# 获取不带后缀的文件名和文件类型
file_name, file_ext = os.path.splittext(full_file_name)
print("不带后缀的文件名: {}".format(file_name))
print("文件类型（即文件后缀）: {}".format(file_ext))
```
```console
文件所在目录: C:/Users/Public
完整文件名: yellow.jpg
不带后缀的文件名: yellow
文件类型（即文件后缀）: .jpg
```

How to set the current working directory? [duplicate] https://stackoverflow.com/questions/1810743/how-to-set-the-current-working-directory/1810760
- https://stackoverflow.com/questions/1810743/how-to-set-the-current-working-directory/34971949#34971949
  * > To set the working directory:
    ```py
    import os
    print os.getcwd()  # Prints the current working directory
    os.chdir('c:\\Users\\uname\\desktop\\python')  # Provide the new path here
    ```
    >> //notes：其实一般合成一句 `os.chdir(os.getcwd())` 就可以了。

How do I find out my PYTHONPATH using Python? https://stackoverflow.com/questions/1489599/how-do-i-find-out-my-pythonpath-using-python
- https://stackoverflow.com/questions/1489599/how-do-i-find-out-my-pythonpath-using-python/1489625#1489625
  * > `sys.path` might include items that aren't specifically in your `PYTHONPATH` environment variable. To query the variable directly, use:
    ```py
    import os
    try:
        user_paths = os.environ['PYTHONPATH'].split(os.pathsep)
    except KeyError:
        user_paths = []
    ```

5.11 文件路径名的操作 https://python3-cookbook.readthedocs.io/zh_CN/latest/c05/p11_manipulating_pathnames.html
```py
>>> import os
>>> path = '/Users/beazley/Data/data.csv'

>>> # Get the last component of the path
>>> os.path.basename(path)
'data.csv'

>>> # Get the directory name
>>> os.path.dirname(path)
'/Users/beazley/Data'

>>> # Join path components together
>>> os.path.join('tmp', 'data', os.path.basename(path))
'tmp/data/data.csv'

>>> # Expand the user's home directory
>>> path = '~/Data/data.csv'
>>> os.path.expanduser(path)
'/Users/beazley/Data/data.csv'

>>> # Split the file extension
>>> os.path.splitext(path)
('~/Data/data', '.csv')
```

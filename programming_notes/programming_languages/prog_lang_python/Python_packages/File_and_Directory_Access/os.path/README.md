
# 官方

os.path --- 常用路径操作 https://docs.python.org/zh-cn/3/library/os.path.html

# 其他

Python | os.path.expanduser() method https://www.geeksforgeeks.org/python-os-path-expanduser-method/

# 个人实战

```sh
python -c "import os; print(os.path.expanduser('~/file.txt'))"
python -c "import os; print(os.path.abspath('~/file.txt'))"
python -c "import os; print(os.path.abspath('./file.txt'))"

$ mkdir test && cd test
$ pwd
/root/test
$ 
$ python -c "import os; print(os.path.expanduser('~/file.txt'))"
/root/file.txt
$ 
$ python -c "import os; print(os.path.abspath('~/file.txt'))"
/root/test/~/file.txt
$ 
$ python -c "import os; print(os.path.abspath('./file.txt'))"
/root/test/file.txt
$ 
```

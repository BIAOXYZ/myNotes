
Python File I/O https://www.programiz.com/python-programming/file-operation

Python文件操作，看这篇就足够 - jiangyx的文章 - 知乎 https://zhuanlan.zhihu.com/p/56909212
- > 在上述例子中，`open()` 打开用于读取或写入的文件并返回文件句柄(本例子中的 `f` )，该句柄提供了可用于读取或写入文件数据的方法。阅读 [Working With File I/O in Python]() 获取更多关于如何读写文件的信息。
  >> Working With File I/O in Python https://dbader.org/blog/python-file-io

Context Managers and the “with” Statement in Python https://dbader.org/blog/python-context-managers-and-with-statement

Python: read(), readline()和readlines()使用方法及性能比较 https://blog.csdn.net/quiet_girl/article/details/80113591

python读取、写入txt文本内容 https://www.jianshu.com/p/45b790a08d5b

# 从文件的指定位置读内容

Python seek()和tell()函数详解 http://c.biancheng.net/view/4780.html

# 已验证过

## 读取大文件
>> //notes：文件很大时，不要用 `readlines()` 或直接用 `read()`，因为还是一次全读进内存的。但是可以用 `readline()` 一次读一行，或者 `read()` 带上一个读取大小的参数

Python花式读取大文件(10g/50g/1t)遇到的性能问题（面试向） https://juejin.cn/post/6844904154037485576

python读取一个文件并判断结束 https://www.jianshu.com/p/413580acf55b

## 打开文件时，如果文件不存在则自动创建

- python3下读文件时如果文件不存在则创建文件 https://blog.csdn.net/Fantasy_Virgo/article/details/82315727  【这个虽然能创建，但是如果文件有多级路径，就不行了】
- python 判断目录和文件是否存在，若不存在即创建 https://blog.csdn.net/u013247765/article/details/79050947  【这个比上一个强一些】

这个的难点在于“***如果文件不存在则自动创建***”。我本以为这应该是一个Python库的接口就搞定了，但是目前还没来及详细试诸如 `pathlib` 之类的库，仅用 `os` 的话，目前看只能是按下面的逻辑走：
1. 先拿到输入文件的完整路径（用 `os.path.abspath()` 是为了把可能的 `./tmp/xxx` 中的点号代表的当前目录展开，如果是 `~/`，则要用 `os.path.expanduser()`）
2. 用 `os.path.dirname()` 获取多级目录前缀
3. 完整路径可能有多层目录，但是这些目录均可能存在或不存在，所以先用 `os.makedirs()` 把正确的目录创建好（用 `os.mkdir()` 对多级目录是不行的，类似Linux shell的 `mkdir -p` 可以创建多级目录，只有 `mkdir` 不行）。
4. 最后创建文件时也可以用别的接口，比如：`os.mknod()`，但是在Mac下有权限问题。。。

```py
import os
def create_file_if_not_exist(local_file_path):
    abs_path = os.path.abspath(local_file_path)
    prefix_dirs = os.path.dirname(abs_path)
    if not os.path.exists(abs_path):
        print("{} does not exist, will create automatically".format(abs_path))
        if not os.path.isdir(prefix_dirs):
            os.makedirs(prefix_dirs)
        os.system(r"touch {}".format(abs_path))
```

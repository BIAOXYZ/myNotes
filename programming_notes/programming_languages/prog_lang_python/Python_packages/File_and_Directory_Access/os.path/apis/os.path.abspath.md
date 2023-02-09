
# `os.path.abspath()`

Difference between os.path.dirname(os.path.abspath(__file__)) and os.path.dirname(__file__) https://stackoverflow.com/questions/38412495/difference-between-os-path-dirnameos-path-abspath-file-and-os-path-dirnam

# `os.path.abspath()` vs `os.path.realpath()`

os.path.abspath和os.path.realpath区别 https://blog.csdn.net/rainshine1190/article/details/85165059
- > 1.`os.path.abspath()` 
  * > 返回一个目录的绝对路径 Return an absolute path.
    ```py
    >>> os.path.abspath("/etc/sysconfig/selinux")
    '/etc/sysconfig/selinux'
    >>> os.getcwd()
    '/root'
    >>> os.path.abspath("python_modu")
    '/root/python_modu'
    ```
- > 2.`os.path.realpath()`
  * > ***返回指定文件的标准路径，而非软链接所在的路径*** Return the canonical path of the specified filename, eliminating any symbolic links encountered in the path.
    ```py
    >>> os.path.realpath("/etc/sysconfig/selinux")
    '/etc/selinux/config'
    >>> os.path.realpath("/usr/bin/python")
    '/usr/bin/python2.7'
    ```

os.path.abs()与os.path.realpath()的一点区别 https://www.cnblogs.com/my_captain/p/9271462.html

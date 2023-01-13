
# `os.remove()`

# `os.remove()` 相关技巧

## 巧用 try except 删除不存在的文件

Most pythonic way to delete a file which may not exist https://stackoverflow.com/questions/10840533/most-pythonic-way-to-delete-a-file-which-may-not-exist
- https://stackoverflow.com/questions/10840533/most-pythonic-way-to-delete-a-file-which-may-not-exist/10840586#10840586
  * > A more pythonic way would be:
    ```py
    try:
        os.remove(filename)
    except OSError:
        pass
    ```
  * > Although this takes even more lines and looks very ugly, it avoids the unnecessary call to os.path.exists() and follows the python convention of overusing exceptions.
  * > It may be worthwhile to write a function to do this for you:
    ```py
    import os, errno
    def silentremove(filename):
        try:
            os.remove(filename)
        except OSError as e: # this would be "except OSError, e:" before Python 2.6
            if e.errno != errno.ENOENT: # errno.ENOENT = no such file or directory
                raise # re-raise exception if a different error occurred
    ```

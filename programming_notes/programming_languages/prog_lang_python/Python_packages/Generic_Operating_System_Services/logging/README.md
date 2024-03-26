
# 官方

logging --- Python 的日志记录工具 https://docs.python.org/zh-cn/3/library/logging.html || logging — Logging facility for Python https://docs.python.org/3/library/logging.html

日志常用指引 https://docs.python.org/zh-cn/3/howto/logging.html || Logging HOWTO https://docs.python.org/3/howto/logging.html

# root logger

Python root logger 解密 https://www.jianshu.com/p/cad8a77762b3

# 问题

## 各种 import 一堆后，当前文件内的 logging 模块不打印了

Python logging not outputting anything https://stackoverflow.com/questions/7016056/python-logging-not-outputting-anything/51843943#51843943
- https://stackoverflow.com/questions/7016056/python-logging-not-outputting-anything/51843943#51843943
  * > Maybe try this? It seems the problem is solved after remove all the handlers in my case.
    ```py
    for handler in logging.root.handlers[:]:
        logging.root.removeHandler(handler)
    logging.basicConfig(filename='output.log', level=logging.INFO)
    ```

# 其他

Logging in Python https://realpython.com/python-logging/

Python Logging Module https://www.askpython.com/python-modules/python-logging-module
- > **Logging from multiple modules**
  * > Since the log-file object and the handlers ***<ins>provide the same context</ins> in multiple modules***, we can use them directly in other modules.

Python之日志处理（logging模块） https://www.cnblogs.com/yyds/p/6901864.html

Python + logging 输出到屏幕，将log日志写入文件 https://www.cnblogs.com/nancyzhu/p/8551506.html

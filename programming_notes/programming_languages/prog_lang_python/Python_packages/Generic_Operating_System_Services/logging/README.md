
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

Set logging levels https://stackoverflow.com/questions/38537905/set-logging-levels
- https://stackoverflow.com/questions/38537905/set-logging-levels/38537983#38537983
  * > What Python version? That works for me in 3.4. But note that [`basicConfig()`](https://docs.python.org/3.4/library/logging.html#logging.basicConfig) won't affect the root handler if it's already setup: `This function does nothing if the root logger already has handlers configured for it.`
  * > ***To set the level on root explicitly do `logging.getLogger().setLevel(logging.DEBUG)`. But ensure you've called `basicConfig()` before hand so the root logger initially has some setup***. I.e.:
    ```py
    import logging
    logging.basicConfig()
    logging.getLogger().setLevel(logging.DEBUG)
    logging.getLogger('foo').debug('bah')
    logging.getLogger().setLevel(logging.INFO)
    logging.getLogger('foo').debug('bah')
    ```
    >> 【[:star:][`*`]】 //notes：和上面的思路类似的其实，核心都是上层logger（大概率是 root logger）影响了我的打印和调试，我就干脆只在我的代码部分禁用掉/重置一下logger。这里其实一般只需要 `logging.getLogger().setLevel(logging.INFO)` 这句就可以了。
  * > ***Also note that "Loggers" and their "Handlers" both have distinct independent log levels. So if you've previously explicitly loaded some complex logger config in you Python script, and that has messed with the root logger's handler(s), then this can have an effect, and just changing the loggers log level with `logging.getLogger().setLevel(..)` may not work***. This is because the attached handler may have a log level set independently. This is unlikely to be the case and not something you'd normally have to worry about.

# 其他

Logging in Python https://realpython.com/python-logging/

Python Logging Module https://www.askpython.com/python-modules/python-logging-module
- > **Logging from multiple modules**
  * > Since the log-file object and the handlers ***<ins>provide the same context</ins> in multiple modules***, we can use them directly in other modules.

Python之日志处理（logging模块） https://www.cnblogs.com/yyds/p/6901864.html

Python + logging 输出到屏幕，将log日志写入文件 https://www.cnblogs.com/nancyzhu/p/8551506.html

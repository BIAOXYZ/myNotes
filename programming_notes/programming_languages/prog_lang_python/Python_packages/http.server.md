
# 官方

http.server --- HTTP 服务器 https://docs.python.org/zh-cn/3/library/http.server.html || http.server — HTTP servers https://docs.python.org/3/library/http.server.html

20.18. BaseHTTPServer — Basic HTTP server https://python.readthedocs.io/en/v2.7.2/library/basehttpserver.html
- > **Note**: The `BaseHTTPServer` module has been merged into `http.server` in Python 3.0. The `2to3` tool will automatically adapt imports when converting your sources to 3.0.
- > This module defines two classes for implementing HTTP servers (Web servers). Usually, this module isn’t used directly, but is used as a basis for building functioning Web servers. See the `SimpleHTTPServer` and `CGIHTTPServer` modules.

# 其他

Using Python HttpServer as a simple HTTP Server https://www.askpython.com/python-modules/python-httpserver
- > **Running our Http Server**
  * > If you simply want to share your files and directories to another user, you can directly run the server using Python.
  * > Go to whatever directory you wish to share, and run the server from there, using:
    ```py
    python -m http.server 9000
    ```
    >> //notes：有时候上面那句需要显式地指定为 `python3`，因为那个是在 Python3.x 版本下的命令。
    >>> 如果服务器端只有 Python2.x 版本，此时语句应为：`python -m SimpleHTTPServer 9000` 。
- > **Connecting to the Http Server**
  * > Now, to connect to the local server, you must do the following steps:
    1. Go to the server machine, and find out the server IP Address using `arp -a` on Windows or `ip -a | grep inet` on Linux.
    2. From the remote client, simply type `http://IP_ADDRESS:9000/` on your browser and see the magic!

使用python构建简单的http上传下载服务 https://www.jianshu.com/p/2147b7e7cf38
- > 程序地址 https://github.com/freelamb/simple_http_server

在SimpleHTTPServer中加入上传功能 https://sparkydogx.github.io/2019/02/03/python-simplehttpserverwithupload/

uploadserver https://github.com/Densaugeo/uploadserver || https://pypi.org/project/uploadserver/

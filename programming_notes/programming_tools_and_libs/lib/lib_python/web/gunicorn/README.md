
# 官方

Gunicorn https://gunicorn.org/ || https://github.com/benoitc/gunicorn

Gunicorn https://en.wikipedia.org/wiki/Gunicorn

# 其他

gunicorn 详解 https://www.jianshu.com/p/69e75fc3e08e

Gunicorn使用详解 https://www.cnblogs.com/shijingjing07/p/9110619.html
- > Gunicorn是一个`WSGI` HTTP服务器,python自带的有个web服务器，叫做`wsgiref`
- > Gunicorn的优势在于，它使用了pre-fork worker模式，gunicorn在启动时，会在主进程中预先fork出指定数量的worker进程来处理请求

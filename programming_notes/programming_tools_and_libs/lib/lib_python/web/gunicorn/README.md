
# 官方

Gunicorn https://gunicorn.org/ || https://github.com/benoitc/gunicorn

Gunicorn - WSGI server https://docs.gunicorn.org/en/stable/index.html

Gunicorn https://en.wikipedia.org/wiki/Gunicorn

# 其他

gunicorn 详解 https://www.jianshu.com/p/69e75fc3e08e

Gunicorn使用详解 https://www.cnblogs.com/shijingjing07/p/9110619.html
- > Gunicorn是一个`WSGI` HTTP服务器,python自带的有个web服务器，叫做`wsgiref`
- > Gunicorn的优势在于，它使用了pre-fork worker模式，gunicorn在启动时，会在主进程中预先fork出指定数量的worker进程来处理请求

# debug

How to debug gunicorn application? https://stackoverflow.com/questions/45123699/how-to-debug-gunicorn-application

How can I debug a Flask App using gunicorn https://stackoverflow.com/questions/63323318/how-can-i-debug-a-flask-app-using-gunicorn

Enabling the Flask Interactive Debugger in Development with gunicorn https://nickjanetakis.com/blog/enabling-the-flask-interactive-debugger-in-development-with-gunicorn#enabling-the-interactive-debugger-with-gunicorn
- > If you’re looking for a complete working example, you can find one in the open source version of my [Build a SAAS App with Flask course on GitHub](https://github.com/nickjj/build-a-saas-app-with-flask) which is updated for Flask 1.0.

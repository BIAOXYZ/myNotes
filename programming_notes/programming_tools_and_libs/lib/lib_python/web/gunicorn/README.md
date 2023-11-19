
# 官方

Gunicorn https://gunicorn.org/ || https://github.com/benoitc/gunicorn

Gunicorn - WSGI server https://docs.gunicorn.org/en/stable/index.html

Gunicorn https://en.wikipedia.org/wiki/Gunicorn

# 其他

gunicorn 详解 https://www.jianshu.com/p/69e75fc3e08e

Gunicorn使用详解 https://www.cnblogs.com/shijingjing07/p/9110619.html
- > Gunicorn是一个`WSGI` HTTP服务器,python自带的有个web服务器，叫做`wsgiref`
- > Gunicorn的优势在于，它使用了pre-fork worker模式，gunicorn在启动时，会在主进程中预先fork出指定数量的worker进程来处理请求

## 重启 gunicorn

A better way to restart/reload Gunicorn (via Upstart) after 'git pull'ing my Django projects https://stackoverflow.com/questions/9881819/a-better-way-to-restart-reload-gunicorn-via-upstart-after-git-pulling-my-dja
- https://stackoverflow.com/questions/9881819/a-better-way-to-restart-reload-gunicorn-via-upstart-after-git-pulling-my-dja/27890485#27890485
  * > For those not using supervisord: what Rob said, it works with ps as well,
    ```sh
    ps aux | grep gunicorn | grep projectname | awk '{ print $2 }' | xargs kill -HUP
    ```
    >> //notes：或者用 `kill -1`，因为 `-HUP` 对应的数字就是 `1`。

# debug flask in gunicorn

How to debug gunicorn application? https://stackoverflow.com/questions/45123699/how-to-debug-gunicorn-application

How can I debug a Flask App using gunicorn https://stackoverflow.com/questions/63323318/how-can-i-debug-a-flask-app-using-gunicorn

Enabling the Flask Interactive Debugger in Development with gunicorn https://nickjanetakis.com/blog/enabling-the-flask-interactive-debugger-in-development-with-gunicorn#enabling-the-interactive-debugger-with-gunicorn
- > If you’re looking for a complete working example, you can find one in the open source version of my [Build a SAAS App with Flask course on GitHub](https://github.com/nickjj/build-a-saas-app-with-flask) which is updated for Flask 1.0.

How does one use the VSCode debugger to debug a Gunicorn worker process? https://stackoverflow.com/questions/39842422/how-does-one-use-the-vscode-debugger-to-debug-a-gunicorn-worker-process

## 实战过的

PYTHON : Debugging a Flask app running in Gunicorn https://www.youtube.com/watch?v=0iF203dj1Ps
>> 【[:star:][`*`]】 //notes：***其实核心点就是手动 run 这个 Flask app，而不是用 Gunicorn 去启动***。本地在 vscode 里还真成功了，也没有设置什么特殊的 `launch.json`。此外，我确实有按照视频里的代码那样，加上了这句 `app.config['DEBUG'] = True`，不知道不加这句行不行——反正加了之后在用 vscode debug 模式启动，在 vscode 里就能单步调试 Flask 应用的代码了。

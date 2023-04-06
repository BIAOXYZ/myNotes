
Python Flask web 有哪些好用的插件？ https://www.v2ex.com/t/929731
```console
各位大佬们，小弟正在开发一个 Python web 项目，项目应该不大，主要就是提供一些 Restful 的 HTTP API ，然后就是一些数据库的 CRUD ，
目前团队里决定用的框架和技术栈就是 Flask + Gunicorn + PostgreSQL 。
由于本人之前是做 java web 的，对 python 的 web 技术栈不熟，想请教下各位大佬们 python web 有哪些高效率和开发框架和组件，以及比较坑的地方，
找了一个 git 仓库 https://github.com/humiaozuzu/awesome-flask 里面列了很多插件，挑花了眼，有没有大佬分享下经验？先行谢过
```
- > sqlalchemy + marshmallow 这两个东西一般是最常用的。说实话，开发快，并且有 MVC 经验的，还是建议 django 。个人感觉 flask 插件加来加去，就长的和 django 差不多了
- > 可以参考这个模板 https://github.com/karec/cookiecutter-flask-restful
- > flask 就是轻盈...要用什么自己加...可以先写功能, 简单的自己写...复杂的再找插件
- > Flask + Gunicorn + PostgreSQL + Peewee/SQLAlchemy + marshmallow
- > FastAPI
- > 看你需要哪些东西，`flask-sqlalchemy` 和 `marshmallow/pydantic` 肯定是要要的，然后还有 `flask-security-too` ，`flask-caching`, `flask-principal` 等

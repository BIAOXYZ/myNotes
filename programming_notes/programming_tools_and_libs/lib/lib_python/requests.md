
# requests官方

A simple, yet elegant HTTP library. https://github.com/psf/requests
> 注：下面是旧版仓库地址，会重定向到上面的新版地址。
>> Python HTTP Requests for Humans™ ✨🍰✨ https://github.com/kennethreitz/requests

Requests: HTTP for Humans™ https://requests.readthedocs.io/en/master

Requests: 让 HTTP 服务人类 https://2.python-requests.org/zh_CN/latest/index.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 官方文档

Requests: 让 HTTP 服务人类 http://docs.python-requests.org/zh_CN/latest/

快速上手 https://2.python-requests.org/zh_CN/latest/user/quickstart.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# requests语法

Python’s Requests Library (Guide) https://realpython.com/python-requests/

Python - requests https://www.cnblogs.com/Neeo/articles/11511087.html
- > **文件下载**
```py
# 那要是下载大文件，可就不能这么干了：

import requests
import webbrowser

url = 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568638318957&di=1d7f37e7caece1c39af05b624f42f0a7&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201501%2F17%2F20150117224236_vYFmL.jpeg'

response = requests.get(url=url, stream=True)
with open('a.jpeg', 'wb') as f:
    for chunk in response.iter_content(chunk_size=256):
        f.write(chunk)
webbrowser.open('a.jpeg')
```

requests https://www.liaoxuefeng.com/wiki/1016959663602400/1183249464292448

请教一个问题， requests 包请求 csdn 首页推荐文章一个接口，为什么相同代码在 windows 和 Linux 下不同结果？ https://www.v2ex.com/t/626740

Python从网页上下载文件的9种方法 - Python 学习者的文章 - 知乎 https://zhuanlan.zhihu.com/p/355066395

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# requests其他

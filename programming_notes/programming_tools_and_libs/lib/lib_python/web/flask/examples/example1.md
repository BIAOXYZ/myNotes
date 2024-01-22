
# 1

手把手教你用Python和Flask创建REST API - Python与数据挖掘的文章 - 知乎 https://zhuanlan.zhihu.com/p/566894430

## 个人实战

```sh
pip install flask
pip install flask-restful
```

`app.py`
```py
from flask import Flask
from flask_restful import Resource, Api

app = Flask(__name__)
api = Api(app)

class Helloworld(Resource):
    def __init__(self):
        pass
    def get(self):
        return {"Hello": "World"}
api.add_resource(Helloworld, '/')

if __name__ == '__main__':
    app.run(debug=True)
```

`client.py`
```py
import requests

url = "http://127.0.0.1:5000/"

response = requests.get(url=url)

print(response.text)
```

**过程**：
```py
# 终端1: 运行app.py
python3 app.py

# 终端2: 运行client.py
python3 client.py
## 输出
{
    "Hello": "World"
}

```

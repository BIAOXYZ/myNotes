
# 1

Python Socket 编程详细介绍 https://gist.github.com/kevinkindom/108ffd675cb9253f8f71

## 个人文章实战
>> //notes：这个文章是针对 python 2 的，实战中改成了 python 3。像 print 之类的都好改，主要是通信过程中发送只能发字节流（需要 encode 一下），收到后打印只能打印字符串（需要 decode 一下）。

**`server.py`**
```py
import socket

HOST = '127.0.0.1'
PORT = 8001
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen(5)

print('Server start at: %s:%s' % (HOST, PORT))
print('wait for connection...')

while True:
    conn, addr = s.accept()
    print('Connected by ', addr)

    while True:
        data = conn.recv(1024)
        decoded_data = data.decode('utf8')
        print(decoded_data)
        conn.send(f"server received you message: {decoded_data}".encode('utf8'))
        print("-----Server finish a loop!!!")

# conn.close()
```

**`client.py`**
```py
import socket

HOST = '127.0.0.1'
PORT = 8001
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((HOST, PORT))

while True:
    cmd = input("Please input msg:")
    encoded_cmd = cmd.encode('utf8')
    s.send(encoded_cmd)
    data = s.recv(1024)
    decoded_data = data.decode('utf8')
    print(decoded_data)
    print("-----Client finish a loop!!!")

    # s.close()
```

```sh
# 1.服务端先启动
$ python3 server.py 
Server start at: 127.0.0.1:8001
wait for connection...

#--------------------------------------------------

# 2.另起一个终端启动客户端
$ python3 client.py 
Please input msg:

## 2.服务端那边立即收到新连接
Server start at: 127.0.0.1:8001
wait for connection...
Connected by  ('127.0.0.1', 62768)

#--------------------------------------------------

# 3.客户端发送一条消息
Please input msg:123
server received you message: 123
-----Client finish a loop!!!
Please input msg:

## 3.服务端收到这条消息
Server start at: 127.0.0.1:8001
wait for connection...
Connected by  ('127.0.0.1', 62768)
123
-----Server finish a loop!!!

#--------------------------------------------------

# 4.客户端发送一条消息
Please input msg:123
server received you message: 123
-----Client finish a loop!!!
Please input msg:456
server received you message: 456
-----Client finish a loop!!!
Please input msg:

## 4.服务端收到这条消息
Server start at: 127.0.0.1:8001
wait for connection...
Connected by  ('127.0.0.1', 62768)
123
-----Server finish a loop!!!
456
-----Server finish a loop!!!
```

# 2

一文带你使用 Python 实现Socket编程 https://juejin.cn/post/7066050305711931406
- > **七层网络模型——OSI标准**
  * > 于这七层模型，有一个记忆口诀： `All People Seem To Need Data Processing`
  * > 翻译成英语是“似乎所有人都需要数据处理”。这一句话由七个英语单词组成，每一个的首字母正好是按第 7 层到第 1 层的首字母的顺序。

# 3

How to convert bytes data into a python pandas dataframe? https://stackoverflow.com/questions/47379476/how-to-convert-bytes-data-into-a-python-pandas-dataframe

**`server.py`**
```py
import socket
import pandas as pd
from io import BytesIO

# 创建一个 socket 对象
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# 监听端口
host = '127.0.0.1'
port = 8003
server_socket.bind((host, port))
server_socket.listen(1)

# 等待客户端连接
print('等待客户端连接...')
conn, addr = server_socket.accept()

print('连接成功，客户端地址：', addr)

# 接收数据
data = conn.recv(1024)
df = pd.read_csv(BytesIO(data))
print(df)

# 关闭连接
conn.close()
server_socket.close()
print('客户端连接断开...')
```

**`client.py`**
```py
import socket
import pandas as pd

# 创建一个 socket 对象
host = '127.0.0.1'
port = 8003
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# 连接服务端
client_socket.connect((host, port))

# 发送数据
df = pd.DataFrame({'name': ['Alice', 'Bob', 'Charlie'], 'age': [25, 30, 35]})
data = df.to_json().encode('utf8')
client_socket.sendall(data)

# 关闭连接
client_socket.close()
```

```sh
# 1.客户端
$ python3 server3.py 
等待客户端连接...

# 2.服务端
$ python3 client3.py

# 3.客户端
等待客户端连接...
连接成功，客户端地址： ('127.0.0.1', 41758)
Empty DataFrame
Columns: [{"name":{"0":"Alice", 1:"Bob", 2:"Charlie"}, age:{"0":25, 1:30, 2:35}}]
Index: []
客户端连接断开...
$
```

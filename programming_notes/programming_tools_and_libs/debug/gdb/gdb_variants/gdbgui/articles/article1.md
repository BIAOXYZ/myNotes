
# gdbgui远程容器调试实战

之前在 Mac 本地装了 `gdbgui`，因为 Mac 垃圾的 `gdb` 权限问题，导致没有走通；此外远端机器的 Linux 上倒是肯定能调试，但是没有图形界面。。。后来突发奇想：反正 `gdbgui` 也是基于浏览器的，并且支持远程模式，那干脆在远程把 `gdbgui` 跑起来，然后本地浏览器打开去调试。

关于“在远程把 `gdbgui` 跑起来”，有两种方式：一是在远端Linux机器上直接跑；二是在远端Linux机器上启动个容器，在容器里跑，只要注意把相应的端口暴露出去就行。

# 实战1：`gdbgui` 运行在远端Linux上的容器里，在笔记本（Mac）的浏览器里，单步调试同样在容器里的 C++ 程序

```sh
#// 1. 下面两句 docker 的命令是在远程 Linux 机器上执行的。
# 准备一个开发调试用的容器，因为要在容器里用 gdb，所以 --privileged 应该是不可省的；
# 此外 -p 5000:5000 是必须的，因为 gdbgui 的端口就是通过 5000 暴露的。
docker run -itd --privileged -p 5000:5000 --name remotegdbgui ubuntu:20.04 bash
docker exec -it remotegdbgui bash

#// 2. 下面这些语句一直到 gdbgui 启动，是在远程 Linux 的容器里执行的。
apt update
apt install -y build-essential autoconf g++ git gdb cgdb python3-dev python3-pip
python3 -m pip install gdbgui
python3 -m pip install werkzeug==2.0.0  # 这个大概率会遇到，所以提前回退一下版本得了。

cd /tmp/
touch test.cpp
g++ -g -o test test.cpp

# 或者直接 `gdbgui -r`
# 然后在浏览器里的 gdb 界面的命令行里输入 `file /tmp/test`。或者直接点击左上角 Load Binary 图标输入路径后加载 test。
gdbgui -r test

#// 3. 回到 Mac，打开 Chrome，输入 http://{your_linux_machine_ip}:5000/ 即可打开 gdbgui 的界面。甚至可以用小键盘方向键来调试～
```

```cpp
#include<bits/stdc++.h>
using namespace std;

struct rect{
    int x1, y1, x2, y2;
};

int adder(int x, int y) {
    cout << "start" << endl;
    int z = x + y;
    cout << "end" << endl;
    return z;
}

int main(){
    int n = 2;
    struct rect rect[n];
    int a = 16;
    int b = 32;
    int c = adder(a, b);
    for(int i=0; i< n; i++){
        rect[i].x1 = n + i;
        rect[i].y1 = n + i+ 1;
        rect[i].x2 = n + i+2;
        rect[i].y2 = n + i+3;
    }

    // int area;  -->  不初始化的话有问题
    int area = 0;
    int flag[101][101];
    memset(flag, false, sizeof(flag));  // --> 试试把这个也放开注释
    for(int i=0; i< n; i++){
        area += (rect[i].x2 - rect[i].x1) * (rect[i].y2 - rect[i].y1);
        for(int j=rect[i].x1; j<rect[i].x2; j++){
            for(int t=rect[i].y1; t<rect[i].y2; t++){
                if(flag[j][t] == 1){
                    area--;
                }
                else{
                    flag[j][t] = 1;
                }
            }
        }
    }
    cout << area <<endl;;
}
```

## 参考链接

Guides https://www.gdbgui.com/guides/
- > **Running Remotely**
  * > Because `gdbgui` is a server, it naturally allows you to debug programs running on other computers.
    + > ssh into the computer with the program that needs to be debugged.
    + > run `gdbgui -r` on the remote machine (this will serve publicly so beware of security here)
    + > on your local machine, open your browser and access the remote machine's ip and port
    + > debug the remote computer in your local browser
  + > Note that gnu also distrubutes a program called `gdbserver` which `gdbgui` is compatible with. See the relevant section in this doc.
  >> //notes：所以核心其实就是启动的时候多加个 `-r` 参数，说明是远程调试模式。

## 问题解决

按上面步骤安装完成后，运行 `gdbgui` 会报如下错误。搜索了一下后，按官方 issue 里有人给的方法，回退 `werkzeug` 库的版本后解决。
```sh
root@50a2b8039aec:/# gdbgui
Opening gdbgui with default browser at http://127.0.0.1:5000
View gdbgui dashboard at http://127.0.0.1:5000/dashboard
exit gdbgui by pressing CTRL+C
Traceback (most recent call last):
  File "/usr/local/bin/gdbgui", line 8, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.8/dist-packages/gdbgui/cli.py", line 249, in main
    run_server(
  File "/usr/local/lib/python3.8/dist-packages/gdbgui/server/server.py", line 95, in run_server
    socketio.run(
  File "/usr/local/lib/python3.8/dist-packages/flask_socketio/__init__.py", line 596, in run
    app.run(host=host, port=port, threaded=True,
  File "/usr/local/lib/python3.8/dist-packages/flask/app.py", line 920, in run
    run_simple(t.cast(str, host), port, self, **options)
  File "/usr/local/lib/python3.8/dist-packages/werkzeug/serving.py", line 1047, in run_simple
    fd = int(os.environ["WERKZEUG_SERVER_FD"])
  File "/usr/lib/python3.8/os.py", line 675, in __getitem__
    raise KeyError(key) from None
KeyError: 'WERKZEUG_SERVER_FD'
```

Fails to start with KeyError: WERKZEUG_SERVER_FD #425 https://github.com/cs01/gdbgui/issues/425
>> //notes：按照该issue的回答，`pip install werkzeug==2.0.0` 把 `werkzeug` 版本改为 `2.0.0` 后就可以了。

## 补1：`gdbgui` 调试PG！

这种方式的高峰是直接在 `Mac 上的浏览器里` 调试 `远程 Linux` 上的 `容器里的` 自己编译安装的 pg。有了上面的例子后，不再给出具体过程了，这里只说大的步骤：
- 1.先在容器里编译好能单步调试的 pg 版本，启动数据库后，`psql` 连接到数据库，建表和插入数据。
- 2.按照过去的步骤，此时就应该是 `cgdb/gdb attach PID`，打好断点；然后回到 `psql` 连接的窗口，执行待调试的 sql 语句。这里用 `gdbgui` 的话，只有 attach 那里不太一样：
  * 直接 `gdbgui -r` 启动。
  * 回到 Mac 上浏览器里打开 `gdbgui` 相应地址，然后页面左上角选择 `Attach to Process` 图标，输入进程号后回车 attach 上。
  * 后面的换回到 `psql` 那个窗口，执行sql之类的都一样。

总之，其实整个过程对比过去的区别就是：过去用 `cgdb/gdb` 去 attach，然后在 `cgdb/gdb` 的界面调试；现在用 `gdbgui` 去 attach，然后在浏览器里调试。

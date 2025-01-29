
# 1. 在 GitHub Codespaces 中用 vsc 调试 pg

## 1.1 主参考链接

VSCode调试PostgreSQL源码 https://blog.csdn.net/qq_39690706/article/details/121062011 || https://www.cxymm.net/article/qq_39690706/121062011
- > **2. PostgreSQL部分准备**
  * > 2.15 在psql终端输入语句得到backend的pid
    ```sql
    select pg_backend_pid();
    ```
- > **3. VSCode部分准备**
  * > 3.1 选择`[Run]->[Add Configuration]`，在`launch.json`中添加新的配置，`launch.json`各参数具体含义见 [VSCode Debugging](https://code.visualstudio.com/docs/editor/debugging#_launch-configurations)
    ```json
    {
        "version": "0.2.0",
        "configurations": [
            {
                "name": "postgres --help",
                "type": "cppdbg",
                "request": "launch",
                "program": "/usr/local/pgsql/bin/postgres",
                "args": [
                    "--help"
                ],
                "stopAtEntry": false,
                "cwd": "${fileDirname}",
                "environment": [],
                "externalConsole": false,
                "MIMode": "gdb",
                "setupCommands": [
                    {
                        "description": "Enable pretty-printing for gdb",
                        "text": "-enable-pretty-printing",
                        "ignoreFailures": true
                    }
                ]
            },
            {
                "name": "initdb",
                "type": "cppdbg",
                "request": "launch",
                "program": "/usr/local/pgsql/bin/initdb",
                "args": [
                    "-D",
                    "<datadir>"
                ],
                "stopAtEntry": false,
                "cwd": "${fileDirname}",
                "environment": [],
                "externalConsole": false,
                "MIMode": "gdb",
                "setupCommands": [
                    {
                        "description": "Enable pretty-printing for gdb",
                        "text": "-enable-pretty-printing",
                        "ignoreFailures": true
                    }
                ]
            },
            {
                "name": "postgres backend",
                "type": "cppdbg",
                "request": "attach",
                "program": "/usr/local/pgsql/bin/postgres",
                "processId": "${command:pickProcess}",
                "MIMode": "gdb",
                "setupCommands": [
                    {
                        "description": "Enable pretty-printing for gdb",
                        "text": "-enable-pretty-printing",
                        "ignoreFailures": true
                    }
                ]
            }
        ]
    }
    ```
    > 一共有三个例子，一个`postgres --help`，一个`initdb`，一个`postgres后端调试`。在`src/main/main.c`中的`main`函数打上断点可以调试`postgres --help`
    >> 【[:star:][`*`]】 //notes：时间原因，只试了在 `main` 函数打断点那个例子（也就是调试 `postgres --help`），发现是可以成功的，其他的还没来得及试。
    >>> 【[:star:][`*`]】 //notes：后来试了一下调试 `initdb`，也是可以成功单步调试的，但是有两点需要注意：一是需要把已经存在的数据库删除，如果配了环境变量的话直接 `rm -rf $PGDATA` 即可（注意文章中 vsc 的配置文件里那个 `<datadir>` 要配置成你的 `$PGDATA` 路径）。二是打断点的位置不一样了（这就是大型软件复杂之处的体现）：这里算是调试 pg 的一个工具，而不是 pg 本身了，所以上面那个断点就不行了，应该是打在 `src/bin/initdb/initdb.c` 的 `main` 函数里。
    >>>> 第三个例子（也就是最关键的调试 SQL 查询的例子）还没有成功，总是碰到报错 `Error getting authority: Error initializing authority: Could not connect: No such file or directory`。我怀疑还是容器环境的问题：因为就算我换成 `root` 去启动调试，vsc 还是会自动换成当前用户（`codespace`）。
    >>>>> 【[:star:][`*`]】 //notes：事实证明我猜的不错，确实是 Codespaces 容器环境的问题。我用 Mac 上的 VMware Fusion 虚拟机装了个 Ubuntu `20.04.3`（Codespaces 上是 `20.04.4`，但基本不可能是这个小版本引起的。。。），然后编译好了一个能调试的 pg。左边一个 `bash` 里用普通用户，连上数据库后用来发送 SQL 好触发断点，右边一个 bash 里切换成 `root` 然后执行 `code`，得到如下提示：
    ```sh
    root@ubuntu:~# code
    You are trying to start Visual Studio Code as a super user which isn't recommended. If this was intended, please specify an alternate user data directory using the `--user-data-dir` argument.
    ```
    >>>>> 虽然命令行里用 `root` 是[有办法](https://askubuntu.com/questions/803343/how-to-run-visual-studio-code-as-root)打开的，但我还是决定先换个路线。于是我想到用图形化界面打开 vscode（此时 Ubuntu 系统登陆的用户仍是普通用户，所以感觉还是在用普通用户打开 vsc 吧？）。打开后贴入了和下面实战部分里一样的 `launch.json` 配置，然后 F5 启动调试时在 vsc 里选最后一个配置 （`"name": "postgres backend"`） 去试图用 attach 的方式调试，先是弹出如下提示（这个 vsc 命令行里弹出的 ***文本*** 提示 Codespaces 环境里也会出现，只不过我输入 y 后就每次都是前面那个 `Error getting authority:` 的报错，然后就进行不下去了。。。）：
    ```console
    Superuser access is required to attach to a process. Attaching as superuser can potentially harm your computer. Do you want to continue? [y/N]
    ```
    >>>>> 输入 y 回车后，弹出了一个 ***图形界面的窗口*** 让我输密码（***我怀疑 Codespaces 环境不行就是因为没有这一步*** —— 但是它就算弹出来了，我也不知道密码啊- -），输入完成后，终于 attach 上了。然后试着回到左边窗口发送了一条 `select * from t1;`，真的在 vscode 里断住了。。。至此，***虽然后来换成了虚拟机里的 Ubutun，但总算是完全成功了***。
  * > 3.2 首先在`src/backend/optimizer/plan/plan.c`的planner中打上断点，在侧边栏Run and Debug中选择postgres backend，点击调试按钮或者按F5后，输入2.15得到的pid进行调试，可能需要使用superuser权限进行连接，选择y就好
  * > 3.3 在psql终端中输入`"select * from t1 where id = 1;"`，如果看到在VSCode中代码在`planner.c`处停止，说明成功了

## 1.2 其他链接

VSCode调试PostgreSQL配置 https://blog.csdn.net/weixin_39540651/article/details/120758819 || https://juejin.cn/post/7080795170890842126
- > GDB配置：
  ```json
  {
      "version": "0.2.0",
      "configurations": [
      {
          "name": "(gdb) 附加",
          "type": "cppdbg",
          "request": "attach",
          "program": "/home/postgres/test/bin/postgres",
          "processId": "${command:pickProcess}",
          "MIMode": "gdb",
          "setupCommands": [
              {
                  "description": "为 gdb 启用整齐打印",
                  "text": "-enable-pretty-printing",
                  "ignoreFailures": true
              }
          ]
      }
      ]
  }
  ```
  >> //notes：这个和上面那个基本一样，但是上面那个一共有三段配置，所以综合看还是用上吗那个了。

如何使用VSCode进行PostgreSQL开发及调试 http://www.postgres.cn/v2/news/viewone/1/459

使用vscode+docker开箱即用调试postgresql代码 https://blog.csdn.net/qq_40608763/article/details/120582333

postgresql源码学习（26）—— Windows vscode远程调试Linux上的postgresql https://blog.51cto.com/u_13631369/7939614

## 1.3 个人实战

1. 自己 clone 一个 pg 的官方仓库，比如：https://github.com/BIAOXYZ/postgres/tree/master ，然后从这个仓库的 web 页面启动 Codespaces。因为没改 devcontainer 配置，所以用的就是官方默认的配置（ https://github.com/microsoft/vscode-dev-containers/blob/dfba31dbee/containers/codespaces-linux/README.md ）
2. 进入到 Codespaces 环境后，自己手动搞好各种依赖，编译好能 debug 的版本。  -->  【我还在 Codespaces 容器环境里的 vsc 自带的命令行里试了试能像过去一样 `cgdb` 调试起来（因为 Codespaces 其实就是个容器，所以需要用 root 用户去 attach pg 进程）。当然，这个（在 vsc 的命令行里用 `cgdb` 调试一下）不是必须的，只要保证编译好的 debug 版本没问题就行。】
3. 启动数据库，`psql` 连接数据库后，配置 `launch.json` 文件，并 attach 进程开始调试（如果是调试 `postgres --help` 或 `initdb`，那就不用先启动数据库了，因为这俩都不是用 attach 模式来调试的），目前基于前面的文章修改后的json配置文件如下：
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "postgres --help",
            "type": "cppdbg",
            "request": "launch",
            "program": "/workspaces/pgdir/pgsql/bin/postgres",
            "args": [
                "--help"
            ],
            "stopAtEntry": false,
            "cwd": "${fileDirname}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ]
        },
        {
            "name": "initdb",
            "type": "cppdbg",
            "request": "launch",
            "program": "/workspaces/pgdir/pgsql/bin/initdb",
            "args": [
                "-D",
                "/workspaces/pgdir/pgdata"
            ],
            "stopAtEntry": false,
            "cwd": "${fileDirname}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ]
        },
        {
            "name": "postgres backend",
            "type": "cppdbg",
            "request": "attach",
            "program": "/workspaces/pgdir/pgsql/bin/postgres",
            "processId": "${command:pickProcess}",
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ]
        }
    ]
}
```
>> 【[:star:][`*`]】 //notes：经验证该配置文件完全有效，只是最后一个最关键的配置（也就是能调试 SQL 执行的配置）只在虚拟机里成功了，在 Codespaces 没有成功。

## 1.4 关于用 `root` 用户或 `root` 权限去 debug
>> //notes：参见 vsc_debug 部分的 [README](README.md#debug-with-root-or-root-privilege) 吧。

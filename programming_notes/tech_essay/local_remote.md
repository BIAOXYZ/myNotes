
结论：C/S模式不愧是计算机这门学科里最经典的，再叠加容器，真的是方便得很！总结一下目前在这种模式下好用的套路包括（打对勾✅的是已经试过的，没有打对勾的是估计基本没啥问题，只是还没尝试）：
- dbeaver
  * [ ] **`本地(Mac)`** dbeaver + **`本地(Mac)`** 数据库
  * [ ] **`本地(Mac)`** dbeaver + **`远端(Linux)`** 数据库
  * [x] **`本地(Mac)`** dbeaver + **`本地(Mac)容器里`** ClickHouse
  * [x] **`本地(Mac)`** dbeaver + **`远端(Linux)容器里`** ClickHouse、PostgreSQL
- docker（Docker Daemon）
  * [x] **`本地(Mac)`** 浏览器 + **`远端(Linux)`** 上的 Docker Daemon 开启 docker 的 http API（比如，通过编辑 `/lib/systemd/system/docker.service`）
    + https://github.com/BIAOXYZ/myNotes/blob/5d78e957bf/programming_notes/new_trends/Docker/docker_api/README.md
    >> //notes：过去在 CRL 的时候对 Harbor（更准确说是远端 Harbor 的 API） 就这么搞过，不过当时更飘似乎，好像不止一台远程 Linux 上有 Harbor，此外还用到了 TigerVNC。
- [Cockpit](https://cockpit-project.org/)
  * 半个TODO: 远端 Linux 安装成功了，但是可能是因为设置了 SSH 的 Kerberos 登陆策略导致虽然 Mac 上的 Firefox 浏览器里打开了登陆界面（Chrome安全策略什么的限制，甚至打不开界面，屁事多就），但是无法使用 `用户名密码` 的方式登陆。等于是试成了一半。。。但是既然在 Mac 端浏览器里都能打开登陆页面了，就已经说明可用了。
- code-server
  * [x] **`本地(Mac)`** 浏览器 + **`远端(Linux)`** coder-server + 远端机器代码目录
    >> 【[:star:][`*`]】 //notes：这种方式下，远端的 Python 代码，可以直接在本地浏览器里单步调试；我估计 C/C++ 或者其他语言的代码也是类似的，虽然并没有实际去调试。
  * [x] **`本地(Mac)`** 浏览器 + **`远端(Linux)容器里`** coder-server + 代码目录（docker的 `-v` 挂载远端机器上的 or 直接复制一份在 code-server 所在容器里）
- gdbgui
  * [ ] **`本地(Mac)`** 浏览器 + **`远端(Linux)`** gdbgui + 待调试C++程序
  * [x] **`本地(Mac)`** 浏览器 + **`远端(Linux)容器里`** gdbgui + 待调试C++程序
    >> 【[:star:][`*`]】 //notes：甚至可以在 Mac 上的浏览器里单步调试远程 Linux 机器上容器里自己编译的 pg，用 attach 模式就好。美滋滋～
- portainer
  * [x] **`本地(Mac)`** 浏览器 + **`远端(Linux)容器里`** portainer
- ~~spark~~
  * TODO: **`本地(Mac)`** 浏览器 + **`远端(Linux)容器里`** spark
- vscode
  * [x] **`本地(vscode)`** + **`远端(Linux)容器里`** + 代码目录（docker的 `-v` 挂载远端机器上的 or 直接复制一份在容器里的）
    + https://github.com/BIAOXYZ/myNotes/blob/5d78e957bf/programming_notes/programming_tools_and_libs/ide/vsc/vsc_docker/README.md
    + https://github.com/BIAOXYZ/myNotes/blob/5d78e957bf/programming_notes/new_trends/Docker/articles/article1.md
    >> //notes：至于那两种更基本的方式：本地vsc + 远程Linux、本地vsc + 本地容器，就更不用多说了。
- [Netdata](https://github.com/netdata/netdata)
  * [x] **`本地(Mac)`** 浏览器（等远端docker容器起来后）输入 `远端ip:19999` + **`远端(Linux)`** 直接用官方github里的语句启动容器。PS：感觉那个面板挺不错的。
- ray dashboard
  * [x] **`本地(Mac)`** 浏览器 + **`远端(Linux)`** 启动 ray 集群，需要在启动命令里指定一些控制面板相关的参数，如：`ray start --head --include-dashboard 1 --dashboard-host 0.0.0.0 --dashboard-port 8877`
- ~~GoAccess~~
  * GoAccess is a real-time web log analyzer and interactive viewer that runs in a terminal in *nix systems or through your browser. https://github.com/allinurl/goaccess || https://goaccess.io/
- Hadoop/HDFS
  * [x] **`本地(Mac)`** 浏览器 + **`远端(Linux)上多个容器`** 用 docker-compose 方式启动的 hadoop 集群。从而可以在本地的浏览器里访问 `http://远端ip:9870/` 看到面板。
- Hadoop/HDFS2
  * [x] **`本地(Mac)`** 浏览器 + **`远端(Linux)上单个容器`** 这个镜像（ https://hub.docker.com/r/dockerq/docker-hdfs/ ）只需要一个命令（并且不需要 docker-compose）就可以在远端Linux启动，本地的浏览器里访问 `http://远端ip:50070/` 就可以看到HDFS的面板。 <br> 但是如果想在远端的 Linux 宿主机上（而不是在远端容器里）访问，貌似只能用类似 `hdfs dfs -ls hdfs://localhost:9000/` 的命令？

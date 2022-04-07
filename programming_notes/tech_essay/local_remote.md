
结论：C/S模式不愧是计算机这门学科里最经典的，再叠加容器，真的是方便得很！总结一下目前在这种模式下好用的套路包括（打对勾✅的是已经试过的，没有打对勾的是估计基本没啥问题，只是还没尝试）：
- dbeaver
  * [ ] **`本地(Mac)`** dbeaver + **`本地(Mac)`** 数据库
  * [ ] **`本地(Mac)`** dbeaver + **`远端(Linux)`** 数据库
  * [x] **`本地(Mac)`** dbeaver + **`本地(Mac)容器里`** ClickHouse
  * [x] **`本地(Mac)`** dbeaver + **`远端(Linux)容器里`** ClickHouse、PostgreSQL
- docker（Docker Daemon）
  * [x] **`本地(Mac)`** 浏览器 + **`远端(Linux)`** 上的 Docker Daemon 开启 docker 的 http API（比如，通过编辑 `/lib/systemd/system/docker.service`）
- code-server
  * [x] **`本地(Mac)`** 浏览器 + **`远端(Linux)`** coder-server + 远端机器代码目录
    >> //notes：这种方式下，远端的 Python 代码，可以直接在本地浏览器里单步调试；我估计 C/C++ 或者其他语言的代码也是类似的，虽然并没有实际去调试。
  * [x] **`本地(Mac)`** 浏览器 + **`远端(Linux)容器里`** coder-server + 代码目录（docker的 `-v` 挂载远端机器上的 or 直接复制一份在 code-server 所在容器里）
- gdbgui
  * [ ] **`本地(Mac)`** 浏览器 + **`远端(Linux)`** gdbgui + 待调试C++程序
  * [x] **`本地(Mac)`** 浏览器 + **`远端(Linux)容器里`** gdbgui + 待调试C++程序
    >> 【[:star:][`*`]】 //notes：甚至可以在 Mac 上的浏览器里单步调试远程 Linux 机器上容器里自己编译的 pg，用 attach 模式就好。美滋滋～
- portainer
  * [x] **`本地(Mac)`** 浏览器 + **`远端(Linux)容器里`** portainer
- spark
  * TODO: **`本地(Mac)`** 浏览器 + **`远端(Linux)容器里`** spark

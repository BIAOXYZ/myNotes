
CTeX的MiKTeX出现No Data: Data: Get host by name failed in tcp_connect()错误解决 https://blog.csdn.net/bluehatihati/article/details/99744291
- > 原因是CTeX中自带的MiKTeX组件版本过低，无法连接服务器进行更新，手动更新会出现错误提示：
  ```console
  No Data:
  Data: Get host by name failed in tcp_connect().
  ```
- > 解决办法：需要安装更高版本的MiKTeX。从官网 https://miktex.org/download 下载最新版本的安装文件。安装路径可以不必在ctex中，需要安装的包可以直接在console中安装
- > 另外也可以在winedit10.3中编译过程中，通过弹出的窗口自动安装。

Manage your TeX installation with MiKTeX Console https://miktex.org/howto/miktex-console

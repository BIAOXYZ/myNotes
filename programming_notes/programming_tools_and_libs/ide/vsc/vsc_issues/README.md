
# vscode issues

## 当仓库里文件数量过多时（一般在远程连接时不小心打开了很大的目录时会出现），修改代码时无法被vscode “watch”和显示出来

"Visual Studio Code is unable to watch for file changes in this large workspace" (error ENOSPC) https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc
- > The limit can be increased to its maximum by editing `/etc/sysctl.conf` (except on Arch Linux, read below) and adding this line to the end of the file:
  ```console
  fs.inotify.max_user_watches=524288
  ```
- > Another option is to exclude specific workspace directories from the VS Code file watcher with the `files.watcherExclude` [setting](https://code.visualstudio.com/docs/getstarted/settings).

VSCode出现"Visual Studio Code is unable to watch for file changes in this large workspace"警告的解决方法 https://blog.csdn.net/davidhopper/article/details/79620425
- > 今天，在使用VSCode打开Apollo项目文件夹时，弹出一条警告信息：“`Visual Studio Code is unable to watch for file changes in this large workspace`”，如下图所示：
- > 上述内容的大意是指，目前文件监控的实际数目已超出当前设置值。可以通过修改配置文件的方式，增加文件监控数目，来避免出现警告信息。524288是可设置的最大文件监控数目，一般情况下不应当设置这么大的值，因为每监控一个文件大约会消耗540字节（32位机）或1kB（64位机）的内存，监控524288个文件则大约会消耗256MB（32位机）或512MB（64位机）的内存。
- > 下面将操作方法记录下来，以便今后备查。

inotify resources exhausted https://www.cnblogs.com/brookin/p/6139073.html
- > **inotify resources exhausted**
  ```sh
  tail -f /var/log/kubelet.log
  tail: inotify resources exhausted
  tail: inotify cannot be used, reverting to polling
  ```
- > **debug**
  ```sh
  cat /proc/sys/fs/inotify/max_user_watches
  8192
  ```
- > **resolved**
  * > Add the following line to either `/etc/sysctl.conf` file or ***a new `*.conf` file*** (e.g. idea.conf) under `/etc/sysctl.d/` directory:
    ```console
    fs.inotify.max_user_watches = 524288
    ```
  * > Then run this command to apply the change:
    ```sh
    sudo sysctl -p --system
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

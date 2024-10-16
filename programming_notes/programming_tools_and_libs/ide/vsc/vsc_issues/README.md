
# vscode issues

## 当仓库里文件数量过多时（一般在远程连接时不小心打开了很大的目录时会出现），修改代码时无法被vscode “watch”和显示出来

```sh
# 有时候用 sudo 都不行，于是就干脆切换成 root 来改。
$ sudo -i

root# cat /proc/sys/fs/inotify/max_user_watches
8192
root# echo 524288 > /proc/sys/fs/inotify/max_user_watches
root# sudo sysctl -p
root# cat /proc/sys/fs/inotify/max_user_watches
524288
```

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

## vscode Python IntelliSense 失效，卸载重装 Python 插件也不行（重启 vsc，甚至重启 Mac 后再卸载重装插件都不行）。
>> //notes：如果试图重启 language server，会有如下报错信息：`Command 'Python: Restart Language Server' resulted in an error (command 'python.analysis.restartLanguageServer' not found)`，后来在下面的 issue 里找到的答案：
>>> //notes2：注意，实际中有可能是 ***<ins>远程机器</ins>上的 vsc 的扩展出问题了***，此时应该去删除远程机器上这个目录（ `~/.vscode-server/extensions` ）里的 `ms-python.python*` 相关扩展。我开始去本地 Mac 上的 `~/.vscode/extensions` 里做删除了。。。我说怎么没效果- - 
```sh
$ cd ~/.vscode-server/extensions/
$ ls
alexcvzz.vscode-sqlite-0.14.1		       formulahendry.docker-extension-pack-0.0.1  ms-toolsai.jupyter-2022.9.1202862440	     ms-vscode.cpptools-1.12.4-linux-x64      twxs.cmake-0.0.17
batisteo.vscode-django-1.10.0		       kevinrose.vsc-python-indent-1.18.0	  ms-toolsai.jupyter-keymap-1.0.0	     ms-vscode.cpptools-extension-pack-1.3.0  visualstudioexptteam.intellicode-api-usage-examples-0.2.6
donjayamanne.python-environment-manager-1.0.4  ms-azuretools.vscode-docker-1.22.2	  ms-toolsai.jupyter-renderers-1.0.12	     ms-vscode.cpptools-themes-2.0.0	      visualstudioexptteam.vscodeintellicode-1.2.29
donjayamanne.python-extension-pack-1.7.0       ms-python.isort-2022.4.0			  ms-toolsai.vscode-jupyter-cell-tags-0.1.6  mtxr.sqltools-0.25.1		      wholroyd.jinja-0.0.8
eamodio.gitlens-13.0.4			       ms-python.python-2022.18.1		  ms-toolsai.vscode-jupyter-slideshow-0.1.5  mtxr.sqltools-driver-sqlite-0.4.0
formulahendry.docker-explorer-0.1.7	       ms-python.vscode-pylance-2022.11.10	  ms-vscode.cmake-tools-1.12.27		     njpwerner.autodocstring-0.6.1
```

https://github.com/microsoft/vscode-python/issues/13474#issuecomment-774264146
- > Try this and see if it helps. Some times it is just a bad install. Looks like you might have a bad update. Do the following to remove stale versions of the extension:
  1. Uninstall Python extension (if you have pylance uninstall it first).
  2. Close all instances of VS Code.
  3. Go to, `%USERPROFILE%/.vscode/extensions` (on windows) or `~/.vscode/extensions` on Linux/Mac.
  4. Delete any folder with the name starting with `ms-python.python*`
  5. Start VS Code, and install Python extension (also pylance if you uninstalled it in step 1).

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

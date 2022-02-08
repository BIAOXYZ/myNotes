
# vscode issues

## 当仓库里文件数量过多时（一般在远程连接时不小心打开了很大的目录时会出现），修改代码时无法被vscode “watch”和显示出来

"Visual Studio Code is unable to watch for file changes in this large workspace" (error ENOSPC) https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc
- > The limit can be increased to its maximum by editing `/etc/sysctl.conf` (except on Arch Linux, read below) and adding this line to the end of the file:
  ```console
  fs.inotify.max_user_watches=524288
  ```
- > Another option is to exclude specific workspace directories from the VS Code file watcher with the `files.watcherExclude` [setting](https://code.visualstudio.com/docs/getstarted/settings).

VSCode出现"Visual Studio Code is unable to watch for file changes in this large workspace"警告的解决方法 https://blog.csdn.net/davidhopper/article/details/79620425

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

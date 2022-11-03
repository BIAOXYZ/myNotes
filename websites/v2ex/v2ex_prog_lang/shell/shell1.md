
请问如何让 ls 命令显示的 “文件夹” 使用斜体？ https://www.v2ex.com/t/892232
- > 不知道怎么用斜体，但我知道`-F`这个选项会对你有帮助
  >> 谢谢，`-F` 确实会在目录结尾显示 `/` 字符 如果使用 `-F` 的话，确实不需要斜体了。
  >>> 可以考虑 `ls -alF` (同时也是 ubuntu 默认的 `ll` 命令)
- > 有意思，学着用了下 `LS_COLORS` ，下面命令在 Bash 里可以『加粗、下划线、斜体』显示目录
  ```shell
  LS_COLORS='di=1;3;4' ls
  ```

aa=$(echo a)， aa=`echo a` 有什么区别？ https://www.v2ex.com/t/799826
- > https://stackoverflow.com/questions/9449778/what-is-the-benefit-of-using-instead-of-backticks-in-shell-scripts
- > 我记得 shell check 里是推荐的用前一种代替后一种
- > 后者不能嵌套
- > 用 shellcheck 检查，会提示违背了哪种规范
- > 后者在某些环境上无法正常使用.
- > 不用管区别，只用前者

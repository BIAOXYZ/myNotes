
Linux 中为什么有些程序正常运行可以在标准输出中打印，用了重定向>或者管道|后，重定向文件及管道中无任何输入？ https://www.v2ex.com/t/899729
```console
有些程序直接运行 COMMAND ，就能在屏幕中打 log 。
但是如果在后面加上> 或者 | xargs 后，文件或管道中不能收到任何数据。
想请教一下各位 Bash 玩的比较六的大佬们，到底什么问题？
```
- > 因为程序可以选择查看自己的标准流是哪里并选择不同的行为。比如 git diff 在 stdout 接入 terminal 的时候默认使用转义序列显示彩色，但 stdout 接入文件时默认不用。
- > 还是让高手来回答你们 <br> 程序判断输出是 tty 的时候，按照行缓冲输出，有了新一行，就写 <br> 如果是 pipe 的话，就会攒着，到一大块的时候，再写 <br> 这种一般有参数控制，比如 grep ，就有一个参数控制

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

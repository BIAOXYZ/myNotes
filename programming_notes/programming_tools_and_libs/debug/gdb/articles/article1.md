
【[:star:][`*`]】 终端调试哪家强？ - 韦易笑的文章 - 知乎 http://zhuanlan.zhihu.com/p/32843449
- > 穿上外套的 GDB：`cgdb`
  * > 上面的代码窗口称为 `cgdb mode`, 下面的 gdb 窗口称为 `gdb mode`，调试就是不停的在两种模式间切换，***按键模仿 vim，按 `ESC` 切换回 cgdb 模式，按 `i` 切换到 gdb 模式***。
  * > 这看起来和 TUI gdb 差不多啊？除了语法高亮外它比 gdb tui 高效在哪里呢？答案是：***大部分操作皆可在 cgdb mode 下（即源代码窗口）用快捷键操作***。
  * > 方向键 或者 hjkl 移动光标，page-down/up 或 c-f / c-b 前后翻页，按 o键会列出当前可执行文件的源代码列表，可以切换查看其他相关代码文件，按 / 或者 ？ 可以进行文档搜索。
  * > 上面这些快捷键基本和 vim 对应，能让你方便的浏览源代码，同时在代码窗口可以用空格键来切换断点，还有其他一些快捷键：
    ```console
    F5 - Send a run command to GDB.
    F6 - Send a continue command to GDB.
    F7 - Send a finish command to GDB.
    F8 - Send a next command to GDB.
    F10 - Send a step command to GDB.
    ```
  * > 更多快捷键见【[这里](https://cgdb.github.io/docs/cgdb.html#CGDB-Mode)】，这下单步和断点比原来轻松多啦，你基本可以呆在源代码窗口里不出来，大部分时候不用再到 gdb 命令行里一条条 next/step 的输入了。
  * > 编辑一下 `~/.cgdb/cgdbrc` ，简单调教下使用更方便：
    ```conf
    set ignorecase
    set ts=4
    set wso=vertical
    set eld=shortarrow
    set hls
    map <F9> :until<cr>
    ```
  * > 这里大概设置了搜索大小写不敏感，tab 大小，分屏方式（默认改为左右分屏），搜索高亮，以及加了一个 `F9` 的快捷键，用于跳出循环（默认没有这个快捷键）：
- `gdbgui`
- `Emacs GDB`
- `.gdbinit` 上配置 `peda`

[C/C++] 小伙伴们用 C/C++开发超大型项目时，有什么比较好的查看调用栈的工具吗 https://www.v2ex.com/t/828043
- > 开发用 vs2019 。 线上调试用 `windbg`.
- > windows `windbg`，linux gdb <br> 开发阶段 vs ，codeblock 之类 ide 也不错
- > gdb 配 https://github.com/hugsy/gef <br> 大型项目根本没什么机会直接挂调试器……几乎都在看 core dump 了 <br> 建议提供点更详细的信息，平台、项目组织形式（比如你要调 lib 还是 executable ，有没有单测和 mock 等等）
  >> https://github.com/hugsy/gef


【[:star:][`*`]】 终端调试哪家强？ - 韦易笑的文章 - 知乎 http://zhuanlan.zhihu.com/p/32843449
- `gdbgui`
- `Emacs GDB`
- `.gdbinit` 上配置 `peda`

[C/C++] 小伙伴们用 C/C++开发超大型项目时，有什么比较好的查看调用栈的工具吗 https://www.v2ex.com/t/828043
- > 开发用 vs2019 。 线上调试用 `windbg`.
- > windows `windbg`，linux gdb <br> 开发阶段 vs ，codeblock 之类 ide 也不错
- > gdb 配 https://github.com/hugsy/gef <br> 大型项目根本没什么机会直接挂调试器……几乎都在看 core dump 了 <br> 建议提供点更详细的信息，平台、项目组织形式（比如你要调 lib 还是 executable ，有没有单测和 mock 等等）
  >> https://github.com/hugsy/gef

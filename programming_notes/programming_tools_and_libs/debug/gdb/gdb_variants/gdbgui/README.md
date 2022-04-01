
# gdbgui 官方

Getting Started https://www.gdbgui.com/gettingstarted/

Examples https://github.com/cs01/gdbgui/blob/master/docs/examples.md
- > Use Mozilla's [record and replay](https://rr-project.org/) (`rr`) debugging supplement to `gdb`. `rr` lets your record a program (***usually with a hard-to-reproduce bug in it***), then deterministically replay it as many times as you want. You can even step forwards and backwards.
  ```sh
  gdbgui --gdb-cmd "rr replay --"
  ```
  > Use recording other than the most recent one
  ```sh
  gdbgui --gdb-cmd "rr replay RECORDED_DIRECTORY --"
  ```

https://github.com/cs01/gdbgui/issues/411

# gdbgui 其他

终端调试哪家强？ - 韦易笑的文章 - 知乎 https://zhuanlan.zhihu.com/p/32843449
- gdbgui https://www.gdbgui.com/

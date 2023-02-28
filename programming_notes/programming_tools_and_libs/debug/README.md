
Linux下怎样判断一个binary是否可以debug https://blog.csdn.net/yasi_xi/article/details/45824149
- > 用下面的命令即可，如果可以debug，则会显示debug相关的一些信息，否则没有相关信息。
  * > `objdump --syms your-binary | grep debug`  或  `objdump -t your-binary | grep debug`
- > 示例：
  * > 检查一个可以debug的binary：
    ```sh
    [root@ampcommons02 test]# objdump -t t-debug | grep debug
    t-debug:     file format elf64-x86-64
    0000000000000000 l    d  .debug_aranges 0000000000000000              .debug_aranges
    0000000000000000 l    d  .debug_pubnames        0000000000000000              .debug_pubnames
    0000000000000000 l    d  .debug_info    0000000000000000              .debug_info
    0000000000000000 l    d  .debug_abbrev  0000000000000000              .debug_abbrev
    0000000000000000 l    d  .debug_line    0000000000000000              .debug_line
    0000000000000000 l    d  .debug_str     0000000000000000              .debug_str
    0000000000000000 l    d  .debug_pubtypes        0000000000000000              .debug_pubtypes
    0000000000000000 l    d  .debug_ranges  0000000000000000              .debug_ranges
    ```
  * > 检查一个不能debug的binary：
    ```sh
    [root@ampcommons02 test]# objdump -t t-release | grep debug
    ```

linux上如何分辨一个二进制可执行文件是debug还是release的 https://blog.csdn.net/kingofmyheart/article/details/116862624
- > 假设，我们可执行文件是a.out：
  * > `readelf -S a.out | grep debug`
- > 如果，该文件是debug的，则会打印出类似这样的信息：
  ```console
    [29] .debug_aranges    PROGBITS         0000000000000000  00003042
    [30] .debug_info       PROGBITS         0000000000000000  000030d2
    [31] .debug_abbrev     PROGBITS         0000000000000000  00005f41
    [32] .debug_line       PROGBITS         0000000000000000  00006635
    [33] .debug_str        PROGBITS         0000000000000000  00006b22
    [34] .debug_ranges     PROGBITS         0000000000000000  00008659
  ```
- > 如果，该文件是release的，一般将不会打印出任何信息。

# 方便debug的宏

C++ 中 `__FILE__`, `__LINE__`, `__FUNCTION__` 含义 https://blog.csdn.net/weixin_39681471/article/details/109612681

`__FILE__`, `__LINE__`, and `__FUNCTION__` usage in C++ https://stackoverflow.com/questions/597078/file-line-and-function-usage-in-c

`__FILE__`, `__LINE__`, `FUNCTION__` 实现代码跟踪调试（linux下c语言编程 ）(转自IT博客） https://www.cnblogs.com/nufangrensheng/archive/2012/11/16/2774046.html

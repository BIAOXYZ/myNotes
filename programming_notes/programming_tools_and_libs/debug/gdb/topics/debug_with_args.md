
# 带参数调试

GDB调试带参数的程序 https://www.jianshu.com/p/1948eab69fe7
```sh
$ gdb --args ./A V1 V2 V3

$ gdb ./A，进入gdb后 r V1 V2 V3

$ gdb ./A，进入gdb后 设置参数 set args V1 V2 V3 再直接 r。
```

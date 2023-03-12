
linux 程序被Killed，如何精准查看日志 https://blog.csdn.net/shuihupo/article/details/80905641

Linux dmesg命令介绍 https://www.jianshu.com/p/4a029091b705

讲一讲内存不足问题的定位与处理 https://blog.csdn.net/chen1415886044/article/details/108611513

# 个人实战

```sh
$ dmesg
# 输出内容太长，省略了。。。

$ dmesg | grep memory
[31202.221956] Out of memory: Kill process 478336 (python3) score 624 or sacrifice child
[266498.346113]  out_of_memory+0x10c/0x490
[266498.566408] Tasks state (memory values in pages):
[266499.202760] Out of memory: Kill process 3792679 (gunicorn) score 152 or sacrifice child
[350720.858565]  out_of_memory+0x10c/0x490
[350721.080000] Tasks state (memory values in pages):
[350721.788817] Out of memory: Kill process 745820 (python3) score 175 or sacrifice child
[358080.380168]  out_of_memory+0x10c/0x490
[358080.619015] Tasks state (memory values in pages):
[358081.617693] Out of memory: Kill process 745819 (python3) score 173 or sacrifice child
[358123.647078]  out_of_memory+0x10c/0x490
[358123.886197] Tasks state (memory values in pages):
[358124.633250] Out of memory: Kill process 845177 (python3) score 277 or sacrifice child
[358216.523442]  out_of_memory+0x10c/0x490
[358216.778951] Tasks state (memory values in pages):
[358217.528988] Out of memory: Kill process 848123 (python3) score 267 or sacrifice child
$
```

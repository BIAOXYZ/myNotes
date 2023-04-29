
# 源头

为什么 netcat 要比 scp 和 rsync 快这么多 https://www.v2ex.com/t/704575

# 相关命令

- `scp`
- `rsync`
- `rz`/`sz`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

用好你的瑞士军刀/netcat - 韦易笑的文章 - 知乎 https://zhuanlan.zhihu.com/p/83959309

NetCat 命令 https://www.cnblogs.com/liangjingfu/p/10437834.html

# 个人实战

## 使用 nc 传输文件

使用nc命令传输文件和文件夹 https://www.cnblogs.com/toSeek/p/6559734.html

nc用法2，使用nc传输文件和目录 https://blog.csdn.net/mtj66/article/details/74959287

使用nc命令通过网络传送文件 https://blog.csdn.net/qq_37858281/article/details/105348107

```sh
# 接收端
$ lsof -i:1234
$ nc -l 1234 > file_recv.txt
......
......

# 发送端
## （按理说我预期发送端发送完成后会自己结束的，结果并没有，还是我 Ctrl + C）
$ nc 172.17.0.5 1234 < file.txt
^C

# 接收端
$ cat file_recv.txt
abcd1234
```

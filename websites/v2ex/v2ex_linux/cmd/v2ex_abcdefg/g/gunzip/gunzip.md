
Ubuntu 下解压 gz 文件，如何限制速度？ https://www.v2ex.com/t/1040701
```console
客户上传的是 gz 压缩包，解压后是单个 log 文件，压缩包大小1G左右，解压后10G左右。
使用 gunzip 或者 gzip -d 解压文件，会跑满服务器硬盘速度 200M/s ，导致服务器上其他服务卡顿。
有什么限制解压速度的方法吗？
```
- > https://unix.stackexchange.com/questions/48138/how-to-throttle-per-process-i-o-to-a-max-limit
- > `gunzip -c log.gz | pv -L 102400 > log`
  >>  你这个命令可以

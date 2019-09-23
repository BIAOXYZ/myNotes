
# 相关命令

# 其他博客类链接

Linux 下开启缓存服务 NSCD https://www.hi-linux.com/posts/9461.html

DNS缓存服务 — NSCD https://www.jianshu.com/p/a0a81062cdb4
```sh
偶然发现，本站的阿里云服务器上运行着一个叫 nscd 的服务。搜索了一番，得知 nscd（Name Service Cache Daemon）
是一种能够缓存 passwd、group、hosts 的本地缓存服务，分别对应三个源 /etc/passwd、/etc/hosts、/etc/resolv.conf。
其最为明显的作用就是加快 DNS 解析速度，在接口调用频繁的内网环境建议开启。

- 安装
  $ yum install nscd
  安装后，nscd 的缓存文件路径为/var/db/nscd/。
- 配置
  nscd 的配置文件默认路径为/etc/nscd.conf。

nscd 服务默认是关闭的，通过service nscd start开启。

- 查看统计信息
  $ nscd -g
- 清除缓存
  # 当更改完域名指向后，清除dns缓存
  $ nscd -i hosts
- 关闭服务
  $ nscd -K

开启 nscd 的 hosts 缓存服务后，每次内部接口请求不会都发起 dns 解析请求，而是直接命中 nscd 
缓存散列表，从而获取对应服务器 ip 地址，这样可以在大量内部接口请求时减少接口的响应时间。  
```

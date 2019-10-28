
# curl

Using curl to automate HTTP jobs https://curl.haxx.se/docs/httpscripting.html

curl网站开发指南 http://www.ruanyifeng.com/blog/2011/09/curl.html

cURL 作者 Daniel Stenberg 宣布即将从 Mozilla 离职 https://www.cnbeta.com/articles/tech/789651.htm

Linux中使用curl命令访问https站点4种常见错误和解决方法 https://www.jb51.net/LINUXjishu/287588.html
> "解决办法是将签发该证书的私有CA公钥cacert.pem文件内容，追加到/etc/pki/tls/certs/ca-bundle.crt。"
```
[root@cloudsec2 bin]# curl https://9.186.102.71:2379/v3alpha/kv/range
curl: (60) Peer's Certificate issuer is not recognized.
More details here: http://curl.haxx.se/docs/sslcerts.html

试ETCD的时候碰到的问题。试了下把自己生成的ca.pem内容按帖子里说的追加到"/etc/pki/tls/certs/ca-bundle.crt"末尾了，
但是还是不行。猜测是因为我这边ETCD是双向SSL认证的原因，所以client端也得改点啥???回头再研究吧，反正目前重点不在ETCD。
```

记一次解决curl https证书问题 https://www.cnblogs.com/xuxinkun/p/5417836.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# [wget](https://www.gnu.org/software/wget/)

【:star:】 GNU Wget 1.20 Manual https://www.gnu.org/software/wget/manual/

17. wget 文件下载 https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/wget.html

linux 下载 命令 wget 和 curl https://blog.csdn.net/freeking101/article/details/53691481

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

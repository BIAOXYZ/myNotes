
问一个关于 https 和 www 的小白问题 https://www.v2ex.com/t/720726
```console
网站开了 https 以后直接用域名可以访问，https://www.域名 也可与访问，
但是 www.域名 和 http://www.域名 访问不了，这是为什么呢？

大佬们可以试一下
    2yuansvip.com
    https://2yuansvip.com
    https://www.2yuansvip.com
这三种都可以直接访问，甚至 http://2yuansvip.com 也可以直接访问

但是
    www.2yuansvip.com
    http://www.2yuansvip.com
会提示没有找到站点
```
- > 众所周知，http 和 https 是两个不同的网站，www.xxx.com 和 xxx.com 是两个不同的网站。所以，你要想让这四个网站一样，就需要在 Nginx 都绑定这几个域名。参考如下配置
- > 先看 80 端口开了没 再看做没做 301
- > 没看到配置 盲猜是没配置 请求 www 的 http 重定向到 https 的逻辑
- > 二级域名服务商可以做特定解析，然后服务器也可以做 301 重定向
- > 我是用 certbot-auto --nginx 自动生成的配置 你可以参考一下
  ```
  server {
   if ($host = www.xxx.com) {
   return 301 https://$host$request_uri;
   } 
  
   if ($host = xxx.com) {
   return 301 https://$host$request_uri;
   } 
  
   server_name www.xxx.com xxx.com;
   listen 80;
   return 404; 
  }
  ```
  >> 感谢大佬！用了你的配置可以了！！！祝早日暴富！

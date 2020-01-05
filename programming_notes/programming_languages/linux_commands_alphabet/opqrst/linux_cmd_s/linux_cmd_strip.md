
# 相关命令

- `file`
- `nm`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

strip (Unix) https://en.wikipedia.org/wiki/Strip_(Unix)

strip(1) - Linux man page https://linux.die.net/man/1/strip

# 其他博客类链接

linux中的strip命令简介------给文件脱衣服 ~~https://blog.csdn.net/stpeace/article/details/47090255~~ || https://www.cnblogs.com/diegodu/p/6824895.html
>> notes：后面那个是转载链接，比原链接格式更好一点，然后开头部分比原链接多了两句话。其他都一样。
```sh
1、去掉-g，等于程序做了--strip-debug
2、strip程序，等于程序做了--strip-debug和--strip-symbol 
```
```sh
// 正文笔记：

通过ls -l 命令可知， a.out的大小是4673个字节；
通过file命令可知， a.out是可执行文件， 且是not stripped, 也就是说没有脱衣服。
通过nm命令， 可以读出a.out中的符号信息。

现在， 我把a.out的衣服strip掉， 得到的结果为：

通过ls -l 命令可知， a.out的大小是2980个字节， 大大减小；
通过file命令可知， a.out是可执行文件， 且是stripped, 也就是说衣服被脱了；
通过nm命令， 发现a.out中的符号没有了。
```

# 个人实战

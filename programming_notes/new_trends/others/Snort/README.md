
# 各种 snort 小猪～

```console
,,_  
o"  )~
''''
____________________

o")~
```

# 官方

Snort (software) https://en.wikipedia.org/wiki/Snort_(software) || Snort https://zh.wikipedia.org/wiki/Snort

Snort 3 is available! https://www.snort.org/
- Snort.conf examples https://www.snort.org/documents/snort-conf-examples
- Resources https://www.snort.org/resources 【有一系列 Youtube 视频，既然是官方的视频，应该比较权威。但是主要是为了记录这里的 Docker 镜像】
  * Snort 3
    + Snort 3 - Installation and Config (with labs) https://www.youtube.com/watch?v=PYP0YH2PVuo
      - 【应该就是视频里 lab2 用到的 `MS 1710` pcap文件】 Microsoft Security Bulletin MS17-010 - Critical https://docs.microsoft.com/en-us/security-updates/securitybulletins/2017/ms17-010
    + Snort 3 - Rule Writing (with labs) https://www.youtube.com/watch?v=CystKHV2gnI
      - 关于 `command injection`：
        * Command Injection https://owasp.org/www-community/attacks/Command_Injection
        * Command Injection https://www.imperva.com/learn/application-security/command-injection/
        * Command Injection in Python: Examples and Prevention https://www.stackhawk.com/blog/command-injection-python/
    + Snort 3 - Logging (with labs) https://www.youtube.com/watch?v=x0YqJIV5RZk
    + 【[:star:][`*`]】 Snort 3 Docker Container https://hub.docker.com/r/ciscotalos/snort3
      ```sh
      docker pull ciscotalos/snort3
      # -h 是指定主机名。更直白说：不用 -h 就是@后面一个哈希值的前若干位 `snorty@7f9d2c4cfbd8`，用了 -h 就是 `snorty@snort3`。
      docker run --name snort3 -h snort3 -u snorty -w /home/snorty -d -it ciscotalos/snort3 bash
      docker exec -it snort3 bash
      docker kill snort3
      ```

Snort++ https://github.com/snort3/snort3
- DOCUMENTATION https://github.com/snort3/snort3#documentation

SNORT Users Manual 2.9.16 http://manual-snort-org.s3-website-us-east-1.amazonaws.com/snort_manual.html 【这个虽然有点过时了，但是好处是可以在线打开直接看，官方那些还得下载下来本地打开才能看】
- `3.Writing Snort Rules` http://manual-snort-org.s3-website-us-east-1.amazonaws.com/node27.html

# 已阅

【[:star:][`*`]】 Snort入侵检测系统简介 https://www.jianshu.com/p/113345bbf2f7

# from github

Snorter -- Snort + Barnyard2 + Pulledpork → The easy way! https://github.com/joanbono/Snorter || https://joanbono.github.io/Snorter/

# from zhihu

Snort应用 https://www.zhihu.com/column/c_1301896265999671296
- 通过Docker安装Snort 3 - 李晨光的文章 - 知乎 https://zhuanlan.zhihu.com/p/267313598

Snort在CentOS操作系统上搭建 - Jy Wang的文章 - 知乎 https://zhuanlan.zhihu.com/p/32315542

# from CSDN

https://blog.csdn.net/qq_43968080/category_9417149.html
- Snort的使用一：安装、嗅探与记录 https://blog.csdn.net/qq_43968080/article/details/103376873
- Snort的使用二：入侵检测与规则编写 https://blog.csdn.net/qq_43968080/article/details/103378952

snort https://blog.csdn.net/gggyl111/category_10731440.html
- Snort入门（一） https://blog.csdn.net/GGGYL111/article/details/112510623

Snort Rules & Scapy——疯狂踩坑的第一次尝试 https://blog.csdn.net/wu_tongtong/article/details/123610153
- snort2.9规则-学习笔记 https://blog.csdn.net/weixin_44813582/article/details/105918523

snort：预处理器开发HelloWorld https://blog.csdn.net/weixin_43249758/article/details/105524164

snort 日志 mysql_Snort日志输出插件详解 https://blog.csdn.net/weixin_42489917/article/details/114469840

snort的安装、配置和使用 https://blog.csdn.net/qq_37865996/article/details/85088090

# `snort.conf`

Where is the location of snort.conf https://serverfault.com/questions/158438/where-is-the-location-of-snort-conf

# 其他

Snort安装使用中文手册 https://www.wangan.com/docs/snortnet

Snort的安装以及使用实验 https://blog.51cto.com/u_15127588/2807708

snort原理、搭建与应用 https://www.jianshu.com/p/44424498c51c

开源IDS与IPS的搭建与使用: Snort - 可信研究院 https://www.istt.org.cn/NewsDetail/2045553.html

Linux下安装入侵检测系统—Snort https://www.lxlinux.net/6678.html
- > snort使用 ***数据采集器(daq)*** 监听防火墙数据包队列，所以按照daq。需预装的程序有：flex、bison、libcap。

使用Snort检测企业流量 https://green-m.me/2018/01/05/network-detection-with-snort-in-company/

Snort: 5 Steps to Install and Configure Snort on Linux https://www.thegeekstuff.com/2010/08/snort-tutorial/

Configure Snort IDS and Create Rules https://linuxhint.com/configure-snort-ids-create-rules/

# 问题处理

Linux Snort ERROR: Can‘t start DAQ (-1) - SIOCGIFHWADDR: No such device! https://blog.csdn.net/xcyja/article/details/110503124

Linux Snort ERROR: Active response: can‘t open ip! https://blog.csdn.net/xcyja/article/details/110498589
- > 参考：https://stackoverflow.com/questions/34380208/snort-error-active-response-cant-open-ip

## drop 或者 reject 后提示成功，但是实际好像还是响应了？

snort ips rule - reject work but drop and sdrop dont work https://stackoverflow.com/questions/22126452/snort-ips-rule-reject-work-but-drop-and-sdrop-dont-work

Snort not showing blocked/dropped packets https://stackoverflow.com/questions/21597318/snort-not-showing-blocked-dropped-packets
```console
I'm trying to detect ping flood attacks with Snort. I have included the rule in the Snort's ddos.rule file.
    (drop icmp any any -> any any (itype:8; threshold, track by_src, count 20, seconds; msg:"Ping flood attack detected"; sid:100121))
I'm attacking using the command
    hping3 -1 --fast
```
>> //notes：主要就是从这个的提问描述里发现应该可以用 `hping3` 来模拟 DDOS 攻击，简单查了下应该就是可以的：
>>> hping3 使用详解 https://blog.csdn.net/freeking101/article/details/72582964

Snort Website Block Rule https://stackoverflow.com/questions/40401313/snort-website-block-rule

Different types of options for blocking Packet Using Snort https://stackoverflow.com/questions/38562327/different-types-of-options-for-blocking-packet-using-snort

# from stackoverflow

https://stackoverflow.com/tags/snort/hot?filter=all

Snort Not Dropping ICMP Packets Even After Using Drop/Reject And Packet Loss Is Not 100% https://stackoverflow.com/questions/70374384/snort-not-dropping-icmp-packets-even-after-using-drop-reject-and-packet-loss-is

Snort Rule to prevent malicious file from downloading https://stackoverflow.com/questions/68252357/snort-rule-to-prevent-malicious-file-from-downloading

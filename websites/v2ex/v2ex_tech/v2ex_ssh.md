
ssh 一分钟被打 1000 次， fail2ban 有用吗？ https://www.v2ex.com/t/848484
- > f2b 当然有用了，就是为了防这种情况的。这一点并发问题不大，没必要自己写。
- > 随便抄了个 IPTables 规则，一小时内只能连接 5 次,超过则阻断。顺便一提 f2b 其实也差不多……
  ```sh
  iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --name sshuser --set
  iptables -A INPUT -m recent --update --name sshuser --seconds 3600 --hitcount 5 -j DROP
  ```
- > 复杂点用 iptables ，简单点 ufw limit ，外加改 ssh 端口，禁止密码登陆
- > 我的做法 <br> 1.禁用 root 登录，更改默认 22 端口 <br> 2.服务器防火墙开放 SSH ，云防火墙关闭 SSH <br> 3.安装 ZeroTier <br> 平时通过 Zerotier 连过去，要是连不上或连接缓慢，直接开放云防火墙，用完再关
- > 开个 cockpit 用算了，sshd 都不开
- > 修改以下设置减少 99%攻击
  ```console
  生成密钥
  ssh-keygen -t rsa -f ~/.ssh/id_rsa -N '' -q
  ```
  > 把密钥保存到本地
  ```
  #/etc/ssh/sshd_config
  Port 23456 #修改 SSH 端口
  PermitRootLogin prohibit-password #root 禁止密码和交互登录
  PasswordAuthentication no #禁止密码登录
  ```
  > 修改前记得开启防火墙端口. 重启 ssh 服务
- 个人补充链接：
  * Fail2Ban：
    + Fail2Ban https://github.com/fail2ban/fail2ban
    + 保护 EC2 实例的开源工具 – Fail2Ban https://aws.amazon.com/cn/blogs/china/open-source-tool-to-protect-ec2-instances-fail2ban/
  * Cockpit：
    + Cockpit https://cockpit-project.org/
  * UFW：
    + UFW Essentials: Common Firewall Rules and Commands https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands

请大家帮忙看看 ssh 远程命令如何避免被本地解析？ https://www.v2ex.com/t/720284

Linux 服务器 ssh publickey 入侵 https://www.v2ex.com/t/703889

最近 SSH 登录服务器系统发现有很多的失败登录 https://www.v2ex.com/t/703864
- > 改公钥一样有人扫，你需要的是 fail2ban

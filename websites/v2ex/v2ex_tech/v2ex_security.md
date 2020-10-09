
Aes 加密 CBC 模式的 Nopadding 填充在 GO 里怎么实现啊 https://www.v2ex.com/t/713404

小公司如何实施信息安全防护？ https://www.v2ex.com/t/713313

想弄个公平抽奖的程序，想问问有什么类似彩票这种不太容易操纵的随机数吗 https://www.v2ex.com/t/713011
- > Cloudflare 的 League of Entropy 了解一下，利用多个不同机构的随机源获取去中心化的随机数
- > https://www.random.org/
- > Intel DRNG
- > 比如说取开奖前几分钟的全国省会的天气的平均值，这个基本不可能人为控制，应该也可以进行回溯
- > 取天气温度 x 股票的尾数，能同时操控这两个数据也是神人了
- > 这个需求计算机科学家和统计学家们很早就碰到了呀，所以 https://www.random.org/ 解君愁： <br> `RANDOM.ORG offers true random numbers to anyone on the Internet. The randomness comes from atmospheric noise, which for many purposes is better than the pseudo-random number algorithms typically used in computer programs.` <br> 他们还提供了免费的 API

使用区块链给图片建立信任 https://www.v2ex.com/t/710244

数据库密码，审计要求，要定期更改，程序怎么可以适应？ https://www.v2ex.com/t/705848

关于 PHP 和 Java 的加密解密问题，困扰一天了 https://www.v2ex.com/t/705838

服务器安全请教 https://www.v2ex.com/t/705603

现在有没有能实现格密码加密的软件 https://www.v2ex.com/t/700746
- > https://github.com/open-quantum-safe/liboqs

数字人民币技术细节讨论 无网络支付 https://www.v2ex.com/t/699333
- > https://www.jianshu.com/p/005ad20f0f08 在没有网络的情况下，DCEP 如何实现双离线支付

请问一个 rsa 加密问题 https://www.v2ex.com/t/697859
- > php RSA 密钥是 PKCS7 填充 Java 是 PKCS8 。。。你需要用 openssl 将对面给的做个格式转换 <br> 至于怎么转 你看下 openssl 的命令吧
  * > LZ回复：我转换了但是加密不了这么长的，我在网上看 512bit 最多也只支持 53 位加密，不知道 java 怎么弄的
- > 加密的时候是分块的，不足位数时需要填充，有不同的填充方式，你需要看下 java 代码，看其使用的填充方式。openssl 使用的是 0 做填充的，至于 php，我不太了解。

五分钟理解什么是 OIDC（OpenID Connect） https://www.v2ex.com/t/686976

函数计算在身份认证云中的应用场景 https://www.v2ex.com/t/686967

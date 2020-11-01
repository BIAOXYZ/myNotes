
语言种类最全的权限管理系统—Casbin https://www.v2ex.com/t/720677
```console
Casbin 官方网址： https://casbin.org/
Github 地址： https://github.com/casbin/casbin
```

网易云音乐加密疑问，为什么要经过两次 aes 加密 https://www.v2ex.com/t/719718
```console
很久之前就爬过网易云音乐的数据，但当时没有认真分析，现在项目 api 请求加密突然想参考网易云音乐的加密的方式，加密如下

i = self.create16RandomBytes()
encText = self.AESEncrypt(input_text, self.nonce)
encText = self.AESEncrypt(encText, i)
encSecKey = self.RSAEncrypt(i, self.public_key, self.modulus)

上面的算法一看就知道模仿 https 的加密流程的，但是我想不明白为什么要经过两次 aes,意义何在，
我觉得随机生成 16 位的密钥通过 aes 加密，然后 rsa 加密密钥传给服务端就可以啦，求解答
```

oauth2.0 授权码登录后，是如何和应用进行交互的？ https://www.v2ex.com/t/714626
- > 你用 QQ 登录授权给 A 应用后，QQ 给 A 一个 code，A 拿着 code 去问 QQ 要你的信息，里边包含了一个 openid，就可以唯一代表你。
<br> A 一般会拿着你的 openid 去自己数据库查一查，是否有相关用户，如果有，就得到了你的 user_id，如果没有，就用 openid 去注册一个新用户，也会生成一个 user_id 。
<br> 最后你去发帖，帖子表保存了你的 user_id 。
- > 但是发帖的时候，A 应用如何知道是我发的贴，交互的时候是有 cookie 还是其他信息？还是要再向 A 应用申请一个 token ？
  >> #3 说的很清楚了，你在 A 应用发帖，用的是 A 应用的用户身份，鉴权从 OpenID 登录到 A 应用之后，就是 A 应用用自己的用户逻辑去处理了，你发帖肯定是 A 应用用自己系统的用户标示去匹配的你，至于是用的 cookie 还是用 A 应用自己的 url token，header 里面放 jwt 之类的，看具体实现。
- > 用户点击 QQ 登录 -> 进入 QQ 授权页面 -> 确认登录后回调跳转到你的网站 -> 你的网站拿到回调 code 参数，通过 QQ 接口获取用户唯一 openid，拿到 openid 后查询数据库有没有对应用户 -> 有就进行登录，没有就转到注册 
<br> 能拿到 openid 就说明用户授权登录了，相当于用户输入账户密码并验证通过了，接下来的登录步骤是一样的，就是写 cookie 什么的

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

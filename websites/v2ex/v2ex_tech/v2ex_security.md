
从技术上讲 https://url 访问除了服务器地址被看到，其他都完全加密的是吗？ https://www.v2ex.com/t/764867
- > SNI 了解一下，除了 IP 地址，主机名(域名)也可以看到，后面的文件路径和参数看不到 <br> 服务器名称指示（英语：Server Name Indication，缩写：SNI ）是 TLS 的一个扩展协议，在该协议下，在握手过程开始时客户端告诉它正在连接的服务器要连接的主机名称。这允许服务器在相同的 IP 地址和 TCP 端口号上呈现多个证书，并且因此允许在相同的 IP 地址上提供多个安全（ HTTPS ）网站（或其他任何基于 TLS 的服务），而不需要所有这些站点使用相同的证书。它与 HTTP/1.1 基于名称的虚拟主机的概念相同，但是用于 HTTPS 。所需的主机名未加密，因此窃听者可以查看请求的网站。

一个关于我的同事计算 md5 的问题！ https://www.v2ex.com/t/738468
- > Java 的是 hex 格式，ios 的是 base64 格式，但是谁能介绍下，安卓的是什么格式？ 32 进制？？
- > 安卓的可能是把 hmacmd5 当成 md5 用了
- > 先统一 tohex()把格式整一致了再说 如果还不一致就找个小文件做二进制的 bindiff
- > 安卓和 IOS 的应该好好查查文档，并且贴个 MD5 的正则验证： `^([a-z0-9]{32})$` 来自 https://regexlib.com/REDetails.aspx?regexp_id=698 <br> 说真的，看到 o 和 u 的时候，已经不知道是啥东西了。HEX 怎么能超过 F <br> 附赠：https://en.wikipedia.org/wiki/MD5
  >> @ReysC 补一下，正则限定范围应该是：`^[a-f0-9]{32}$` 仅限小写。
- > 我来唱个反调，Android 和 iOS 端提供的 md5 都真的是 md5，不过 Android 是 32 进制的，iOS 的是 base64 encode 过的 raw data 。
  >> 没用过 32 进制的 md5，顺道补充知识。日常看到 md5 就默认是 16 进制 HEX 。多谢大佬 @Elethom 说明
- > md5 结果大多时候都直接用 32 个 16 进制字符表示，java 那样是最常见形式。也有用 16 个字符的比较少见。安卓和 ios 还敢拿出来与你比较，明显水平不够，建议开除。<br> 安卓那个没看懂是什么算法，26 个字符，还有 u 、n 、g 、r……哪位高手给解释下？ios 的看起来像 base64，但我没解析出来，是不是把 md5 的 128bit 给 base64 了？
- > 一般说的 md5 指的是 hex(md5)，也就是 md5 产生 16 字节数据之后再 16 进制编码产生 32 位字符串，一般还要统一规定大小写，认识这一点就好办了。 <br> 然后空格大概率是 ios 的 base64 字符串出现加号+被后端框架自动解码成空格了，我这边规定加密算法时都会详细说明每一步，比如 hex(md5(aes(userId,md5(password))))，解释每一步并在每一步给个示例供其他端统一参考

微软说的 cross-platform...开发环境一言难尽 https://www.v2ex.com/t/728829

有人用过国密算法吗，它有哪些好处？ https://www.v2ex.com/t/720857
- > 我司在用啊 SM1 是不公开算法 SM2 SM3 是公开的算法，尤其 SM2 是基于 ECC，挺先进 <br> 稍微坑的两点：SM1 的加密芯片是国密自产自销的，非常昂贵，拖累终端成本 <br> 由于目前国密应用情况较少，相关软件不够稳定成熟 <br> 优点大家都知道比较多。
- > 好处就是能拿到某些资质、拿到某些部委的项目、骗到纳税人的血汗钱。打过两年交道国产操作系统（银河麒麟、中标麒麟。。）和龙芯、中芯、瑞芯等的路过。。
- > 记得是等保三级必须上国密
- > Blake2, ChaCha20Poly1305, Ed25519, X25519 <br> 如果信不过 NSA 和国密，就用上面的。我就这样……
- > 我司最近对接腾讯的支付业务(新的事业部)，用的是国密 sm4.腾讯用的是 java 我们用的是 py.py 的库好像没有 java 支持的算法多.感觉要等死了
- > 用过 SM4，好像有些政企项目对加密算法有要求
- > 百度：GMSSL
- > #6 确实理解错了，比如 SM1 就是不公开的，要用芯片调用接口 另外就算是 rsa，芯片里面有后门你是没办法的，也只能用
- > 目前从事国密算法行业，金融领域基本已完成了国密改造，其他行业也已开始，国家密码法颁布，会进一步推动国密的发展。
- > https://github.com/intel/isa-l_crypto/commit/374d57fe17ecc5ee745fe86d5ffdb35b1c2b4cc0 推荐下 isa-l_crypto avx512 版本的 SM3..16 个 lane，10+倍快乐 :)
- > 另外回答下 lz 的问题， <br> SM2 和 ECC 原理一样，椭圆曲线选取不一样。 <br> SM3 和 SHA256 一样的数据长度，IV 不一样，中间过程也很多不一样。 <br> 其他的系列忘了。优点：有些 benchmark 说 xx 场景更快,更安全。我不太认同。。。 <br>什么场景下必须用：需要 ZF 认证的项目。类似于合作项目，必须用国密。
- > 国标加密算法， 政府项目新项目都要求上，旧项目也会被要求上，只要还有人 /公司在维护。 问题是做加密的公司貌似还没有充分考虑到国内云的趋势，都在强推 SM1 的密码机，一个项目也被要求上密码机。

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

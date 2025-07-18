
对于>256 字节的文件，对全文和尾部 128 位字节分别进行 xxHash3-128 然后拼接得到 256bit 散列和 SHA256 一次得到的 256bit 哪个更抗碰撞？用于命名用户上传的文件，另外加盐用拼接还是 XOR 方式更好？ https://www.v2ex.com/t/1145673
- > 如果要性能，考虑 `HighwayHash` ，做 256 位输出，要安全性，考虑 Blake3 做 256 位，拼接其他东西没啥意义

敏感 API 需要加密请求体避免泄漏请求内容给 CDN，是否使用了 AES-256-GCM 这类带完整性验证的加密算法，就没有必要再签名一次了？或者有没有更简单的方案， HMAC 拼接签名客户嫌麻烦不太愿意对接 https://www.v2ex.com/t/1126288

与银行对接 sm4 国密算法 https://www.v2ex.com/t/1085268
- > RSA 也是一个大坑，之前对接的一个项目，接口用到私钥签名、公钥验签加上公钥加密、私钥解密。双方交换公钥。折腾了好久，发现 rsa 加密要分段加密。RSA 密钥长度 1024bit ，加密的时候 117 个字符加密一次，然后把所有的密文拼接成一个密文；解密的时候需要 128 个字符解密一下，然后拼接成数据。具体可以看看这篇文章 https://www.cnblogs.com/meetuj/p/14954533.html <br> 不同语言的加解密处理确实太麻烦了，尤其是对方一句话，我们用的是默认的加密方式。你们自己实现就好了。代码也不给，给一串加密前和加密后的参数。你自己慢慢去试。成功了就是精诚所至金石为开。

AES-256-GCM 和使用两个不同密钥进行两次 AES-128-GCM 加密，哪个更安全？ https://www.v2ex.com/t/1077579
- > 256 就像请一个专业保镖，简单可靠，而两次 128 则像是请两个保镖，但他们彼此可能还不合拍。最终，安全不一定翻倍，麻烦倒可能加倍
- > 我记得开发过程中有一个 ”铁律“：不要自己 ”发明“ 加密算法，包括但不限于 两次 md5 这种 将已知的加密算法连续使用多次，它们并不会提升安全性，如果需要更高的安全性，请直接使用加密等级更高的算法
- > AES-256-GCM. GCM 是 AEAD ，在密钥不对的情况下，它会告诉你密钥不对，而不是强行用错的密钥解出一堆错误的数据。即暴力试 2^128 次就能解开第一个密钥，再试 2^128 次解开第二个密钥。而 AES-256-GCM 需要 2^256 次。所以两次 AES-128-GCM 并不能提供 256 bits (2^128 * 2^128) 的安全，只能提供 129 bits (2^128 + 2^128)。
  >> #5 结论是对的，但论证有些问题。密钥错误的时候以压倒性的（ overwhelming ）概率报错，但不能排除解出乱七八糟结果而没有报错的情况，遍历所有密钥的时候遇到不报错的错误密钥的概率可能很高。解决方法就是多试几次。 <br> 另外楼主的问题里面，“加密两次”的含义不明确，因为基于 AES 的加密通常不需要隐藏 IV ，外层加密的时候内层 IV 设置为明文还是关联数据，会导致不同的攻击方法。攻击多层加密的一般方法是所谓的 meet in the middle ，尤其对于加密随机数公开的对称加密（常见的基于 AES 的加密，加密随机数就是 IV ，是公开的）。

各位 V 友大佬们下午好，请教个算法的小白问题，关于 SM2 算法。 https://www.v2ex.com/t/1077150
- > 国标和国际 SM2 的参数有点区别
- > 国密改造的吧？ sm2 对接有两个坑，一个是 sm2 有 c1c2c3 模式和 c1c3c2 模式，还有一个是加密后的字符串需不需要去除 04 前缀
- > 签名最后有两个 BigInteger r 和 s 这两个 有很多种编码规则 比如转成 byte 数组 32 位对齐，也有使用默认的 standarddsa 具体看双方要求 https://mp.weixin.qq.com/s/6kXOb92I-ZqpwR1mLaI3AQ

从原理上分析，把明文进行 100 轮 [SHA512->SHA256] 这样哈希计算，随机性会比直接 SHA256 更差吗？运算后结果可能性不都是 2^256 种吗？照这么说的话加 salt 也会影响随机性？ https://www.v2ex.com/t/1070316
- > 多轮 hash 不增加熵，所以只要输入固定就不影响"随机性"，影响的只是攻击者的成本 https://www.google.com/search?q=site%3Acrypto.stackexchange.com+KDF+entropy

基于 GPU 加密的时光机 https://www.v2ex.com/t/1061501
```console
发送者对消息加密后，任何人都无法立即解密，必须经过预定的时间才能解开，从而将消息发送到未来。

之前分享过一个[简易版](https://v2ex.com/t/1028842)，那个版本加密需要花费和解密同样的时间，因此几乎没有可玩性。

最近更新了下算法，加密过程支持多线程，并且支持 GPU 加速，从而可利用显卡的并行能力提速几十到几百倍。当然，解密过程仍然只能 CPU 单线程，确保解密不会被加速。具体原理可参考文档。
https://github.com/EtherDream/timelock/blob/main/README-zh.md

不过这个版本也有个缺陷，由于加密结果需要保存每个线程的种子信息，而 GPU 通常有几千个线程，导致结果会非常大。即使降低一些安全性用较短的种子，结果也有 10KB 甚至更长，导致通过 URL 分享很困难，至少在聊天软件无法分享，只能通过文章或论坛里的超链接分享。

另外出于兼容性目前仍使用 WebGL2 的 GPGPU 方案，之后再改成 WebGPU 。（不知 WebGPU 稳定性方面是否更高，目前 WebGL2 加密时进行频繁界面操作经常会崩溃）

如果算法和程序没问题的话，之后再约定时间点发一些拼 CPU 性能的活动，第一个解密成功的可以领取奖励，鼓励大家升级 CPU 硬件~
```

看大佬摸鱼研究出一个新的加密算法发期刊有感，/t/1055809 https://www.v2ex.com/t/1055935
```console
我之前也有个想法，也是来自 v2 的，不知道是不是已经有的算法或是有什么作用，分享到这里，理性讨论一下。
这个东西我叫他 “aabb 加密”，严格来讲不能算加密方法，他不创建加密算法，只是对称加密算法的应用。使用的场景(场景可能不太正确但是很形象的讲出来它的作用)：假如你要去约炮，而你的老婆要翻你聊天记录，你肯定不想这种顶级机密信息被发现。你就可以和 约炮的人发送使用“aabb 加密” 加密后的密文，约定使用“123456” 作为你们两个约炮交流消息的解密密码，而如果不幸被你的老婆发现，你就可以告诉你老婆，这个密码是 “456789”，你老婆解密出来的是你提前设置好的正常的消息内容，就可以降低被发现的概率。
```
- > 推荐搜索的关键字是 deniable encryption （可抵赖加密），我印象里最开始大家对它感兴趣是因为它可以用来构造适应性安全的 MPC ，是相当非平凡的问题，这种加密可以用程序混淆构造。 <br> 在知乎写过一个简单的科普 https://www.zhihu.com/question/576682585/answer/2933493982
- > Truecrypt 及其后继者 Veracrypt 有类似功能，用于对抗比老婆更可怕的东西。
- > plausible deniability ，vc 的隐藏卷就是其中一种，而且外界很难有办法知道这个加密卷里有隐藏卷

在 V2EX 摸鱼引出的密码学研究，论文终于出版了，感谢一下 @sillydaddy https://v2ex.com/t/1055809
```console
这些基础问题在 7 月 15 日完整解决，不过论文出版的问题一直难产（读作：一直被拒稿），直到 2024 年 6 月 3 日才被 IACR 最近新推出的期刊 Communications in Cryptology （密码学通讯）接受，并在 7 月 8 日出版。
```

偶然发现奇游加速器会在系统里植入根证书 https://www.v2ex.com/t/1036217

多节点间加密通信的安全问题 https://www.v2ex.com/t/995144

编码，加密，与密码哈希演进简史 https://www.v2ex.com/t/957713

以前感觉 HTTPS 很安全，现在有一点点改变看法了。 https://www.v2ex.com/t/922534
```console
HTTPS 安全是因为有 SSL 加密，网管直接抓包是看不到具体内容的。
但是，我发现 chrome 会把很安全的 SSL 密钥导出到明文，仅仅只需要设置一个系统环境变量(SSLKEYLOGFILE)，就能轻易做到！
这意味着，公司网管只要在我机器上简简单单配置一个环境变量，我电脑上 chrome 浏览的所有网站，用户密码，他都能直接看到。并且 chrome 浏览器毫无风险提示信息，让人非常没有安全感。
```
- > 这压根不是 HTTPS 的职责范围。你都突破物理隔离了，即便不用环境变量装个抓包证书就可以吧，或者替换个加了后门的魔改版浏览器也可以吧。 <br> HTTPS 有效的前提是你信任你的浏览器和操作系统。
- > 文不对题，不安全的明明是 Chrome 这个具体浏览器的密钥日志行为，又不是 HTTPS 本身。
- > 都能设置环境变量了，也就没什么隐私了把
- > 不来个 LD_PRELOAD 呢

哈希冲撞的可能性 https://www.v2ex.com/t/883524
- > 哈希冲突的相关信息可以看这里： https://en.wikipedia.org/wiki/Hash_collision <br> 这里有一些 SHA-256 的哈希冲突的例子： https://crypto.stackexchange.com/questions/52578/are-there-any-well-known-examples-of-sha-256-collisions <br> 同样地，MD5 会更简单： https://crypto.stackexchange.com/questions/1434/are-there-two-known-strings-which-have-the-same-md5-hash-value
  >> 【[:star:][`*`]】 //notes：这个哥们给的链接是不错，但是回答的容易误解。目前【`2022.09.28`】为止，SHA-256 还是没有找到任何一对碰撞。
- > https://www.mscs.dal.ca/~selinger/md5collision/

国密标准推行不太顺利的样子？ https://www.v2ex.com/t/848968
- > SM2 、SM3 、SM4 都是有在 IANA 注册的，由 RFC8998 定义，也就是说在特定系统上使用这些算法是没有障碍的。包括 TLS1.3 密码套件（ TLS_SM4_GCM_SM3 ，TLS_SM4_CCM_SM3 ），签名模式 sm2sig_sm3 ，群 curveSM2 。至少 openssl 支持这个是无压力的，实际上一些银行 U 盾也有用这个。
  * > 但民用市场得考虑软件兼容性，你没有靠谱的办法让 XP 上的 Schannel SSP （ Windows 上的默认 SSL/TLS 实现）支持 TLS1.3 和 SM 系列，要知道 TLS 可以自动协商用什么密码套件，但证书种类可没法协商，客户端不支持就直接终止连接了。这也是为啥现在那么多网站证书还用 RSA2048 而不是 ECC 一样。
  * > 考虑到 SM2 也是一种 ECC ，在兼容性差于 ECDSA P256/P384/P521 （换句话说就是既生瑜何生亮），曲线参数同样有来源不明的问题，就算要换代，EdDSA(Curve25519)是设计透明度、安全性、性能上更好的选择，SM2 都可以直接跳过了，如果不是政策要求都没必要特意折腾这个。
- > 国密要求双证书，签名和加密分开，所以国密浏览器只能定制化，就比较蛋疼。但国内企业网络里很多都是用国密去加密通信的，只是用户侧感知不到。
- > 搜到了个关于 SM2 的测评。 https://developer.aliyun.com/article/785339 <br> 看文章说法，问题蛮多的，SM4 速度打不过 AES ，SM2 打不过 EdDSA 。 <br> 而且以前国标还强推客户端证书和双证书体系，换句话说，除非你有脱裤子给上面看的需求，否则强行适应这种标准都是负收益的事，而且现在上面也不喜欢用这种方法了。
- > 不知道算不算后门，反正我不用 https://github.com/guanzhi/GmSSL/issues/446
- > 算法应该没啥问题；但是国密的认证体制要求加密私钥也放在 CA 侧，这算是明着的“后门”了
- > 怎么还有传 RSA 算法有后门的…… 是 「 RSA 公司」的「 BSafe 」软件使用的「 Dual_EC_DRBG 」伪随机数生成算法存在后门
- > S 盒当时 IBM 提交的文档里有设计原理，但是那一页被 NSA 撕了哈哈哈 <br> 但是根据之后的种种迹象，现在密码学业界更多地认为是当时 DES 的设计者已经发现了差分攻击这个技术，所以设计 S 盒的时候专门考虑了这一点（对于输入的任意改变将引起输出的至少 2bit 变化），但是 NSA 不想让差分攻击就这样公之于众，所以就删了。所以 80 年代末 shamir 他们发表差分攻击的时候，DES 那群人说我们 74 年就知道这个了。。。 <br> 可以参考下 DES 设计者的描述 https://en.wikipedia.org/wiki/Differential_cryptanalysis#:~:text=more%20susceptible.%5B1%5D-,In%201994,-%2C%20a%20member%20of <br> 另外 DES 其实 40 多年了并没有什么设计层面的漏洞，唯一的问题是密钥太短了（ 56bit ），所以 3DES 现在还在用（逆向过微信支付算法的应该懂）

如何保护配置文件中的敏感信息,比如数据库密码 https://www.v2ex.com/t/836944

chacha20ploy1305 和 aes128gcm 那种加密算法更安全 https://www.v2ex.com/t/795784

关于 RSA 算法的疑问 https://www.v2ex.com/t/793223
```console
关于 RSA 算法的疑问：网上很多 RSA 的证明都是基于欧拉定理
m ^y(n) = 1 mod n
m ^(ky(n) + 1) = 1 ^k • m mod n = m

这里,有个前提是 m 和 n 互质啊, 这里 n =p•q
现实中,我们需要加密的消息千奇百怪,很有可能 m = p 或者 p 的倍数。
这样就不满足欧拉定理条件？
在 m = k * p 的情况下,如何证明呢
```
```console
/***
p = 3 
q = 5
n =  15
y(n) = (3-1) * (5-1) = 8
e = 3  pulic key
d = 3  private key
e * d =  y(n) + 1 =  9 ;
***/

console.log('\tM \tEuler test \tRSA test ')
for (let msg = 0; msg < 15; msg++) {
  var z = msg;
  var z0 = msg;

   z = (z * z) % 15;
   z = (z * z) % 15;
   z = (z * z) % 15;
   var rsa = z * z0 % 15;
   console.log(`\t ${msg} \t${z}${z==1 ? '  ' : ' x'} \t${rsa} `)
}

结果

 M       欧拉测试(m^8==1)    Rsa 测试(m^9=m) 
         0      0 x     0 
         1      1       1 
         2      1       2 
         3      6 x     3 
         4      1       4 
         5      10 x    5 
         6      6 x     6 
         7      1       7 
         8      1       8 
         9      6 x     9 
         10     10 x    10 
         11     1       11 
         12     6 x     12 
         13     1       13 
         14     1       14 
竟然不支持表格

结果也是正常,消息 m 需要与 n 互质欧拉公式菜鸟成立,但是 RSA 确能正常加解密
```
- > 楼上的都在强答些什么啊，正解是，你任意搜索一篇关于 rsa 原理的文献，其中的证明部分都针对 m 与 n 互质和不互质的情况进行了分类讨论，其中互质情况的证明就是你贴出来的欧拉定理，而假如不互质，那么 m 一定整除 p 或者整除 q，由于轮换对称性，任取其中一种假设接着证明即可，最后可以证出即使 m 与 n 不互质，m^ed%n==m 仍然成立，所以加解密仍然可以工作
  >> 感谢，我之前看到的文章都是只证明了一半的，今天仔细搜了下，确实有，证明很有技巧。

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
- > 另外回答下 lz 的问题， <br> ***SM2 和 ECC 原理一样，椭圆曲线选取不一样***。 <br> SM3 和 SHA256 一样的数据长度，IV 不一样，中间过程也很多不一样。 <br> 其他的系列忘了。优点：有些 benchmark 说 xx 场景更快,更安全。我不太认同。。。 <br> 什么场景下必须用：需要 ZF 认证的项目。类似于合作项目，必须用国密。
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

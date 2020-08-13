
请问一个 rsa 加密问题 https://www.v2ex.com/t/697859
- > php RSA 密钥是 PKCS7 填充 Java 是 PKCS8 。。。你需要用 openssl 将对面给的做个格式转换 <br> 至于怎么转 你看下 openssl 的命令吧
  * > LZ回复：我转换了但是加密不了这么长的，我在网上看 512bit 最多也只支持 53 位加密，不知道 java 怎么弄的
- > 加密的时候是分块的，不足位数时需要填充，有不同的填充方式，你需要看下 java 代码，看其使用的填充方式。openssl 使用的是 0 做填充的，至于 php，我不太了解。

五分钟理解什么是 OIDC（OpenID Connect） https://www.v2ex.com/t/686976

函数计算在身份认证云中的应用场景 https://www.v2ex.com/t/686967

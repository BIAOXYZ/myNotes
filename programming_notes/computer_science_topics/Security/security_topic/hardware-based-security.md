
# 机密计算general

揭秘机密计算：弥补最后一个入侵 “漏洞” https://www.ithome.com/0/524/422.htm
- > 机密计算（Confidential Computing，也译作保密计算）是通过基于硬件的可信执行环境（TEE）对使用中的数据进行保护。TEE 被定义为提供一定级别的数据完整性、数据机密性和代码完整性保证的环境。
- > 基于硬件的飞地的示例包括可信平台模块（TPM），英特尔的 Secure Guard 扩展（SGX），ARM 的 Trustzone 和 AMD 的安全加密虚拟化（SEV）。但是，使用云的公司通常需要转向由其云提供商托管服务的不同 TEE。其中包括使用英特尔 SGX 的 Azure 机密计算和 Google Cloud 机密计算。

# 其他公司

发现并协助修复数十处机密计算框架漏洞，百度安全获谷歌、微软致谢 https://mp.weixin.qq.com/s/HQoFMvQ_FXW3Mg09xGM9hQ
- > 近期，微软与谷歌公司相继对其主导的机密计算开源项目Microsoft Open Enclave SDK (https://openenclave.io/sdk/) 和Google Asylo (https://asylo.dev/) 发布了版本更新。更新中修复了数十处百度安全研究人员上报的漏洞，同时对百度安全公开发表致谢。

# TEE

Trusted execution environment https://en.wikipedia.org/wiki/Trusted_execution_environment

可信计算之二——TPM、TEE、TrustedZone以及Intel SGX - 云舒的文章 - 知乎 https://zhuanlan.zhihu.com/p/20539508

# Intel SGX

Edgeless RT https://github.com/edgelesssys/edgelessrt
- https://www.edgeless.systems/
  * Edgeless DB -- THE NEXT-GEN ENCRYPTED DATABASE
  * Edgeless RT -- BUILD CONFIDENTIAL COMPUTING APPS WITH EASE

英特尔公布五项新技术进展，涉及机器编程、量子计算等 https://www.ithome.com/0/522/982.htm
- > 在软件重要性逐渐突显的今天，开发者依然继续把大量时间用于修复 Bug，而不是用于写代码。事实上，在IT行业每年花费的 1.25 万亿美元软件开发成本中，大约有 50% 是用于 Debug 代码。
- > 最后，英特尔还公布了在保密计算方面的研究。保密计算旨在保护使用中的数据，例如最新的英特尔软件保护扩展技术，它将保密性、完整性和认证功能整合在一起，像数据保险箱一样，确保使用中的数据安全；一种全新的加密系统——完全同态加密，它允许应用在不暴露数据的情况下，直接对加密数据执行计算操作。

SGX技术的分析和研究 http://www.jos.org.cn/html/2018/9/5594.htm

Intel SGX背景、其他可信计算技术和TEE技术（翻译自Intel SGX Explained） https://blog.csdn.net/clh14281055/article/details/107248252
- > 强烈推荐《Intel SGX Explained》 作者对Intel SGX进行了详细的教科书般的讲解 <br> Costan V, Devadas S. Intel SGX Explained[J]. IACR Cryptol. ePrint Arch., 2016, 2016(86): 1-118. http://css.csail.mit.edu/6.858/2020/readings/costan-sgx.pdf

CPU 有个禁区，内核权限也无法进入！ https://www.ithome.com/0/647/857.htm
- 回复里的：
  * > 问题好像在Win 11系统或者英特尔Alder Lake上，SGX支持被停用了。 <br> CyberLink：想看 4K 蓝光光碟，请不要使用英特尔 11/12 代酷睿处理器 https://www.ithome.com/0/598/773.htm
    >> //notes：这是官方打自己脸吗？- -    

英特尔修补大量 SGX 安全漏洞，请尽快更新补丁 https://www.ithome.com/0/673/952.htm
- > 目前 SGX 已进入它生命周期中的第八个年头，虽然一直“漏洞百出”，但实际上该工具已在第 11 代和第 12 代酷睿等消费级处理器中弃用。

## Occlum (蚂蚁金服)

Occlum is a memory-safe, multi-process library OS for Intel SGX https://github.com/occlum/occlum || https://occlum.io/

人人都可以“机密计算”：Occlum 使用入门和技术揭秘 https://cloud.tencent.com/developer/news/685498

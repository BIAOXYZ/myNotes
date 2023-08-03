
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

# TPM

Linus Torvalds 对 AMD 的 fTPM 失望，推荐禁用以解决卡顿问题 https://www.ithome.com/0/709/824.htm
```console
Torvalds 在邮件列表中评论 fTPM 为“crud”，并推荐最好的方法就是，完全禁用 fTPM。他还敦促其他 Linux 开发人员使用 CPU RDRAND 指令来执行相同的任务，不会导致出现和 fTPM 相同的问题。
Torvalds 在邮件列表中直言不讳地说：“disable the stupid fTPM HWRND thing”（禁用这个愚蠢的 fTPM HWRND），并认为现有的修复程序很大程度上无效的。
```
- > Windows11在AMD上卡顿应该微软背锅还是AMD
  > AMD吧
  >> 祖传负优化
- > so，AMD，fxxk you
- > 拔掉显卡提升性能
- > 这样不能怪wintel联盟故意给amd使绊子了
  >> 这可是AMD自己选的，tpm的实现规范是开放的，苹果 Intel 高通都做了自己的可信模块硬件，就AMD非要拿软件ftpm来模拟人家硬件实现的可信模块，那你不慢谁慢。
- > 没毛病，au和iu到手我直接就bios禁用tpm了
  >> 我的bios里面没有关闭强制开启。。。华硕
  >>> 华硕tpm的关法不太一样，我台式机iu也是华硕rog的主板，里面有个tpm选项关闭之后重启会自动打开，正确方法是Advanced-Trusted Computing，里面有个Security Device Support选项，把它设置为Disable就行，系统里面就会显示TPM已禁用
  >>>> 我没有关闭的tpm选项，就两个选项内置tpm和外置tpm
  >>>>> 你有硬件的tpm吗，有的话就选外置的吧
- > tpm一定要用硬件的
- > Linus：其实，我对AMD是有一些失望的。当初觉得你是和Intel齐名的X86供应商。我是希望你能够拼一把，快速成长起来的。到了Linux内核这个层级，不是把内核支持了就可以的。你需要有体系化思考的能力，还要有超强的性能。为什么是你来做，Intel不能做吗？你需要有自己的判断力。我不需要中规中矩的答卷，它是有一些差异化在里面的。后续，你要把你的思考沉淀到每次bug提交里，我希望看到你的思考，而不仅仅是修复了bug就结束了的。另外提醒一下，你的产出和intel比，是有些单薄的，马上要到年底了，加把劲儿。你看Intel去年可以一整年为了支持大小核，提交了很多次MR。成长，一定是伴随着痛苦的，当你最痛苦的时候其实才是你成长最快的时候。
- > 早早就关了，没什么用，还导致电脑用着用着死机三秒钟以上，排查起来还特别麻烦，后来关掉ftpm正常
- > 为什么不像Intel那样用实体硬件解决？也不费什么空间吧（移动端芯片这种安全隔区都成标配了）
  >> Intel也有自己的软件方案，叫PTT（Intel Platform Trust Technology），我这台电脑就是用的PTT来模拟的TPM
- > win11不是要这个才能用？
- > 我这7840hs在win11下常有卡顿几秒 声音也卡顿 鼠标移动卡顿 好像整个系统被放慢了 几秒之后又恢复正常了 是ftpm的问题吗
- > AMD的ftpm修了几年了？这效率倒闭算了。
  >> 是这个问题修复不了，不是修了几年，AMD只能缓解这个问题，不能修复。只能上独立TPM，禁用fTPM。
- > 買處理器認準Intel就對了，按摩店的bug太多了
- > 我真服了，还有一个高精度时钟的问题，我打CS最低就20帧。笔记本还关不掉，真的是气死了。
- > 看了下淘宝上各家主板tpm模块的评价，全是amd用户哈哈哈哈哈,果然最好的解决方式是直接上硬件tpm
- > Linus 做出了一番推理：“我可以很容易地猜出 BIOS fTPM 代码应该使用了一些可怕的全局 EFI 同步锁之类的东西，然后就会根据一些完全不相关的活动引发随机问题。举例来说，可能不是 fTPM hwrnd 代码本身决定从 SPI 读取某个随机数，而是它与 BIOS 参与的其他活动串行化。” <br> 同步锁下fTPM与PSP交互确实难顶 最近在调AMD PSP TEE环境(里面实现了fTPM后端)，OEM厂商自签名下的单个TA，只能往PSP专用的NVRAM(与x86侧UEFI用的NVRAM隔离)中写存储内容大概6K左右，打包在UEFI BIOS里的PSP固件是黑盒，AMD自己得去修复，不然社区还得花大力气去逆向分析PSP固件，再找BUG

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

技术门槛高？来看Intel机密计算技术在龙蜥社区的实践 |龙蜥技术 https://ost.51cto.com/posts/16645
- > 机密计算通过在基于硬件的可信执行环境（TEE）中执行计算的方式来保护使用中的数据。这些安全的、隔离的环境可防止对使用中的应用程序和数据进行未经授权的访问或篡改，从而提升相关组织在管理敏感数据和受监管数据方面的安全级别。TEE目前流行的技术有 Intel 的`SGX`、`TDX`，AMD 的 `SEV` 及 ARM 的 `TrustZone` 等等。

解构隐私计算技术路线与形态 https://www.infoq.cn/article/4w9iuclqe847yqb80ln9
- > **可信执行环境（TEE）的分类**
  * > 目前 TEE 环境总体分为私密性和非私密性：私密性的 TEE，比如 SGX，不仅能抗运行时攻击，也能抗物理攻击，任何离开寄存器的数据都会被自动、强制加密；非私密性的 TEE，比如 TrustZone，其依赖特权级的控制实现运行时保护(低优先级程序不能访问高优先级程序的资源)，但是其内存不做任何加解密控 制，可以被多种物理方式攻击。
  * > 基于隐私计算的场景诉求，非私密 TEE 是不可用的。目前可用的私密性 TEE 主要是 Intel 的 SGX 以及国产的`海光 SEV` 等产品，尤其以 Intel 的 SGX 为业界主流，其安全性和性能都得到了实践认证。  

## Occlum (蚂蚁金服)

Occlum is a memory-safe, multi-process library OS for Intel SGX https://github.com/occlum/occlum || https://occlum.io/

人人都可以“机密计算”：Occlum 使用入门和技术揭秘 https://cloud.tencent.com/developer/news/685498


# 综合

Privacy-Preserving-Machine-Learning-Resources https://github.com/Ye-D/PPML-Resource

一文剖析2022年“全球隐私计算开源现状” https://mp.weixin.qq.com/s/nwqmycUGUycAvmC4heFtgg
- > （2）面向学术研究的开源项目。这部分的开源项目最多，呈持续繁荣的态势。其中MP-SPDZ支持最为丰富和全面的各种MPC安全协议，同时对通信部分进行了并行优化，提升总体框架效率；MPC4j是面向Java的旨在为研究人员提供MPC相关协议的库, 可对许多主流协议进行公平的性能比较；FudanMPL是国内首个由高校主导的开源的基于安全多方计算的机器学习框架，支持丰富的机器学习模型和场景；EzPC 主要支持神经网络的安全推理，并针对性地进行优化；ABY、ABY3、Cheetah等开源项目主要是针对相关论文的协议实现，通常作为底层协议被集 成在工业应用的开源框架中。

# 抗量子密码学

IBM Cloud 声称量子安全密码学是首创 https://www.ithome.com/0/522/857.htm

# 同态加密

微软最新同态加密应用：在Microsoft Edge中保护密码 https://mp.weixin.qq.com/s/iAypTwJm5ESk5ypcq5oLuw

# 差分隐私

小米开启「模糊定位」功能内测：利用差分隐私技术，应用仅能获得用户大致位置 https://www.ithome.com/0/523/107.htm

Opacus -- Training PyTorch models with differential privacy https://github.com/pytorch/opacus

# 其他技术

PrivateStats: De-Identified Authenticated Logging at Scale https://research.fb.com/wp-content/uploads/2021/01/PrivateStats-De-Identified-Authenticated-Logging-at-Scale_final.pdf

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 公司

EzPC (Easy Secure Multi-party Computation) https://www.microsoft.com/en-us/research/project/ezpc-easy-secure-multi-party-computation/

## FB

CRYPTEN: 当安全多方计算邂逅机器学习 https://mp.weixin.qq.com/s/xRf3D3wMxDYRBPJ8jMflrw

CrypTen: A framework for Privacy Preserving Machine Learning https://github.com/facebookresearch/CrypTen

FBPCF (Facebook Private Computation Framework) https://github.com/facebookresearch/fbpcf
- 【[:star:][`*`]】 (CCSW '21) Privacy-Preserving Randomized Controlled Trials: A Protocol for Industry Scale Deployment https://dl.acm.org/doi/10.1145/3474123.3486764 || https://dl.acm.org/doi/pdf/10.1145/3474123.3486764
- Private Computation Framework 2.0 https://research.facebook.com/publications/private-computation-framework-2-0/

FBPCP (Facebook Private Computation Platform) https://github.com/facebookresearch/fbpcp/tree/main
- 【[:star:][`*`]】 https://github.com/facebookresearch/fbpcp/blob/main/docs/PrivateScaling.md
  * ![](https://github.com/facebookresearch/fbpcp/raw/main/docs/ShardingDesignFB.jpg)

案例丨Meta如何提高密码安全性并保护用户隐私 https://mp.weixin.qq.com/s/v66OmdIdWA1efRCywPIuLQ

Private Matching for Compute https://eprint.iacr.org/2020/599.pdf  【//notes：google也有一个类似的，但是只有 github 项目（下面有记录项目链接：https://github.com/Google/private-join-and-compute ），没有论文。此外，从功能上看谷歌的只能在不泄漏交集的情况下求和。】
- > We revisit the problem of two-party private set intersection for aggregate computation which we refer to as private matching for compute. In this problem, two parties want to perform various downstream computation on the intersection of their two datasets according to a previously agreed-upon identifier. We observe that prior solutions to this problem have important limitations. For example, any change or update to the records in either party’s dataset triggers a rerun of the private matching component; and it is not clear how to support a streaming arrival of one party’s set in small batches without revealing the match rate for each individual batch.
- > We introduce two new formulations of the private matching for compute problem meeting these requirements, called `private-ID and streaming private secret shared set intersection` (`PS3I`), and design new DDH-based constructions for both. Our implementation shows that when taking advantage of the inherent parallelizability of these solutions, we can execute the matching for datasets of size upto 100 million records within an hour.

Gloo https://github.com/facebookincubator/gloo
- > Gloo is a collective ***communications library***. It comes with a number of collective algorithms useful for machine learning applications. These include a barrier, broadcast, and allreduce.

`pytorch/third_party/gloo.BUILD` https://github.com/pytorch/pytorch/blob/aeac7f4203a9a80d21d27a385fbca8ecfe6ec6e0/third_party/gloo.BUILD

## Oasis Labs

https://www.oasislabs.com/

https://github.com/oasislabs

## Unbound Tech

blockchain-crypto-mpc https://github.com/unbound-tech/blockchain-crypto-mpc || https://www.unboundsecurity.com/digital-asset-and-blockchain-security/
- > Protecting cryptographic signing keys and seed secrets with Multi-Party Computation.

About the Researchers https://www.unboundsecurity.com/unbound-mpc-labs/

## Dropout Labs (Cape Privacy)

Cape Privacy https://capeprivacy.com/ || https://medium.com/dropoutlabs

### tf-encrypted

`tf-encrypted` (or `TF Encrypted`, `TF-Encrypted`)

A Framework for Encrypted Machine Learning in TensorFlow https://github.com/tf-encrypted/tf-encrypted

TF-Encrypted https://tf-encrypted.io/

TF-Encrypted MPC 多方计算代码阅读 - 哈利法的文章 - 知乎 https://zhuanlan.zhihu.com/p/368881623

在 TensorFlow 中使用安全计算实现隐私保护机器学习 - 六三的文章 - 知乎 https://zhuanlan.zhihu.com/p/396553029
- > 文章下载地址： Private Machine Learning in TensorFlow using Secure Computation https://arxiv.org/pdf/1810.08130v2.pdf

## Intel

HE Transformer for nGraph https://github.com/IntelAI/he-transformer

## Google

### Private Join and Compute

Helping organizations do more without collecting more data https://security.googleblog.com/2019/06/helping-organizations-do-more-without-collecting-more-data.html
- Private Join and Compute https://storage.googleapis.com/gweb-uniblog-publish-prod/documents/private_join_and_compute.pdf

(Euro S&P 2020) On Deploying Secure Computing: Private Intersection-Sum-with-Cardinality https://eprint.iacr.org/2019/723.pdf

Private Join and Compute https://github.com/Google/private-join-and-compute
- > This project contains an implementation of the "Private Join and Compute" functionality. This functionality allows two users, each holding an input file, to privately compute the sum of associated values for records that have common identifiers.
- > In more detail, suppose a Server has a file containing the following
identifiers:

  Identifiers |
  ----------- |
  Sam         |
  Ada         |
  Ruby        |
  Brendan     |

- > And a Client has a file containing the following identifiers, paired with
associated integer values:

  Identifiers | Associated Values
  ----------- | -----------------
  Ruby        | 10
  Ada         | 30
  Alexander   | 5
  Mika        | 35

- > Then the Private Join and Compute functionality would allow the Client to learn that the input files had *2* identifiers in common, and that the associated values summed to *40*. It does this *without* revealing which specific identifiers were in common (Ada and Ruby in the example above), or revealing anything additional about the other identifiers in the two parties' data set.
- > Private Join and Compute is a variant of the well-studied Private Set Intersection functionality. We sometimes also refer to `Private Join and Compute` as `Private Intersection-Sum`.

谷歌MPC应用：隐私交集求和PIS - PrimiHub原语科技的文章 - 知乎 https://zhuanlan.zhihu.com/p/366783162
- > 以下资料中有更详细的信息，有兴趣可以深入研究：
  * > 油管上的视频：https://www.youtube.com/watch?v=mPMLY6UzvsI&t=33s
  * > 论文：[On Deploying Secure Computing: Private Intersection-Sum-with-Cardinality](https://eprint.iacr.org/2019/723)
  * > 谷歌安全Blog：[Helping organizations do more without collecting more data](https://security.googleblog.com/2019/06/helping-organizations-do-more-without-collecting-more-data.html)

## 华控清交

PrivPy：实现规模化通用隐私保护机器学习 - 雪琪的文章 - 知乎 https://zhuanlan.zhihu.com/p/115574680

PrivPy: Enabling Scalable and General Privacy-Preserving Machine Learning https://arxiv.org/abs/1801.10117

PrivPy: Scalable and General Privacy-Preserving Data Mining http://people.iiis.tsinghua.edu.cn/~weixu/Krvdro9c/kdd19-li-slides.pdf

PrivPy: General and Scalable Privacy-Preserving Data Mining https://www.kdd.org/kdd2019/accepted-papers/view/privpy-general-and-scalable-privacy-preserving-data-mining

PrivPy: Enabling Scalable and General Privacy-Preserving Machine Learning https://cs.paperswithcode.com/paper/privpy-enabling-scalable-and-general-privacy

隐私保护机器学习实例1-PrivPy(Section 3, POs) - 六三的文章 - 知乎 https://zhuanlan.zhihu.com/p/356648580

## Sharemind

Sharemind MPC (Multi-Party Computation) https://sharemind.cyber.ee/sharemind-mpc/
- Sharemind® SDK 2020.12 Beta http://sharemind-sdk.github.io/

Sharemind: a framework for fast privacy-preserving computations https://eprint.iacr.org/2008/289.pdf

Sharemind SDK https://github.com/sharemind-sdk
- Sharemind SDK build repository https://github.com/sharemind-sdk/build-sdk

## OpenMined

OpenMined https://blog.openmined.org/
- PYSYFT https://blog.openmined.org/tag/pysyft/
  * INTRODUCTION TO FEDERATED LEARNING AND PRIVACY PRESERVATION USING PYSYFT AND PYTORCH -- Federated Learning and Additive Secret Sharing using the PySyft framework https://blog.openmined.org/federated-learning-additive-secret-sharing-pysyft/
- PRIVATE SET INTERSECTION WITH DIFFIE-HELLMAN https://blog.openmined.org/private-set-intersection-with-diffie-hellman/

PySyft https://github.com/OpenMined/PySyft

TenSEAL https://github.com/OpenMined/TenSEAL

## 矩阵元

JUGO：
- https://jugo.juzix.net/home
- https://jugo.juzix.net/apiDocument

实验室论文被密码学顶级会议PKC收录！ https://mp.weixin.qq.com/s/nv4a33aO-p6CEbGpkolgvQ
- > 近日，上海市数据隐私安全计算企业重点实验室谢翔博士联合香港大学学者共同合作的论文《Compact Zero-Knowledge Proofs for Threshold ECDSA with Trustless Setup》被公钥密码学领域国际顶级会议PKC 2021（the International Conference on Practice and Theory of Public Key Cryptography, PKC）录用，该会议将在北京时间2021年5月9日至13日于线上举行。

Rosetta https://github.com/LatticeX-Foundation/Rosetta
- https://github.com/LatticeX-Foundation/Rosetta/tree/v0.3.0 || https://github.com/LatticeX-Foundation/Rosetta/releases/tag/v0.3.0
  * https://github.com/LatticeX-Foundation/Rosetta/blob/9945f6a29a9df79fdab57e7ba57048d5c550ad0c/doc/TUTORIALS_CN.md
  * https://github.com/LatticeX-Foundation/Rosetta/blob/9945f6a29a9df79fdab57e7ba57048d5c550ad0c/doc/DEPLOYMENT_CN.md
  * backup & restore
    + https://github.com/LatticeX-Foundation/Rosetta/blob/9945f6a29a/python/latticex/rosetta/secure/ops/training/io_saver.py
      - https://github.com/tensorflow/tensorflow/blob/v1.15.0/tensorflow/python/training/saver.py#L606-L1338
    + `SecureSaveV2 = _secure_ops.secure_save_v2` https://github.com/LatticeX-Foundation/Rosetta/blob/9945f6a29a/python/latticex/rosetta/secure/decorator/secure_ml_ops_.py#L142:1
    + `REGISTER_OP("SecureSaveV2")` https://github.com/LatticeX-Foundation/Rosetta/blob/9945f6a29a/cc/tf/secureops/secure_model_ops.cc#L22
    + https://github.com/LatticeX-Foundation/Rosetta/blob/9945f6a29a/cc/tf/secureops/secure_model.cc
      - https://github.com/tensorflow/tensorflow/blob/r1.14/tensorflow/core/kernels/save_restore_v2_ops.cc
- https://github.com/LatticeX-Foundation/Rosetta/tree/v1.0.0
  * backup & restore
    + `test_op save_v2` https://github.com/LatticeX-Foundation/Rosetta/blob/master/python/latticex/rosetta/test/single-task/test-simple.sh#L49
      - `class Checkpoint(tracking.AutoTrackable):` https://github.com/tensorflow/tensorflow/blob/v2.6.0/tensorflow/python/training/tracking/util.py#L1844-L2347
      - https://github.com/tensorflow/tensorflow/blob/v2.6.0/tensorflow/python/training/saving/functional_saver.py
    * https://github.com/tensorflow/tensorflow/blob/r2.6/tensorflow/core/kernels/save_restore_v2_ops.cc
    * https://github.com/tensorflow/tensorflow/blob/r2.6/tensorflow/core/ops/io_ops.cc
- 隐私AI工程技术实践指南 https://www.infoq.cn/theme/82
  * 隐私 AI 工程技术实践指南：整体介绍 https://www.infoq.cn/article/iDHE7UyH91pALUZh9OaV
  * 面向隐私 AI 的 TensorFlow 深度定制化实践 https://www.infoq.cn/article/ywmvctisilcfikvwbwvt || https://cloud.tencent.com/developer/news/696681
  * 隐私 AI 框架中 MPC 协议的快速集成 https://www.infoq.cn/article/V3wm8NUGllvTEYsaw3Hj
  * 隐私 AI 框架中的数据流动与工程实现 https://www.infoq.cn/article/QO2LTgqDFr3AItJTBsp4

Rosetta-IO https://github.com/LatticeX-Foundation/Rosetta-IO/blob/main/README_CN.md
- > Rosetta-IO是Rosetta的一个基础组件，对Rosetta提供IO服务。Rosetta-IO中的通道一旦被建立，就能够发送数据给其它节点或者从其它节点接收数据。在Rosetta-IO，`节点`通过`节点ID`来区分，它是TCP连接的一端。每个节点都有全局的(`主机`, `端口`)元组，`主机`是`IP地址`或者`域名`，`端口`是`TCP监听端口`。

## Inpher

inpher https://inpher.io/
- XOR Platform https://inpher.io/xor-secret-computing/
- TFHE: Fastest, Fully Homomorphic Encryption Library https://inpher.io/tfhe-library/

XORBoost: Tree Boosting in the Multiparty Computation Setting https://eprint.iacr.org/2021/432.pdf

## 富数科技

- https://www.fudata.cn/fmpc

揭秘联邦学习黑马：富数科技FMPC安全计算平台 - hellompc的文章 - 知乎 https://zhuanlan.zhihu.com/p/127941761

## 阿里

DataTrust https://dp.alibaba.com/product/datatrust

mpc4j https://github.com/alibaba-edu/mpc4j
- > (ICDE 2022) Scape: Scalable Collaborative Analytics System on Private Database with Malicious Security https://ieeexplore.ieee.org/author/37086477025

### 双子座实验室

https://alibaba-gemini-lab.github.io/
- PVC Security: An Intermediary-free Solution to Safe Data Sharing Between Rational Parties https://alibaba-gemini-lab.github.io/docs/blog/pvc/

(USENIX Security 2022) Cheetah: Lean and Fast Secure Two-Party Deep Neural Network Inference (Full Version) https://eprint.iacr.org/2022/207.pdf
- 相关文章：
  * Cheetah: Lean and Fast Secure Two-Party Deep Neural Network Inference - 云中雨雾的文章 - 知乎 https://zhuanlan.zhihu.com/p/476525705
  * G.O.S.S.I.P 学术论文推荐 2022-03-16 Cheetah https://mp.weixin.qq.com/s/qYJvF34i0OId3hTef1sHow

全同态加密开源库Seal发布4.0版，增加阿里贡献的BGV模块 https://mp.weixin.qq.com/s/Klq1FKPIPQZkqM7T6BhdTA

### 阿里妈妈

广告营销场景下的隐私计算实践：阿里妈妈营销隐私计算平台SDH https://mp.weixin.qq.com/s/UYhgRzgRLD5XDcx2M4Vg5Q
- > **一、概览**
  * > 如何在营销场景下安全合规的使用数据，维护在线广告商业模型的核心运作，成为当下广告生态中各企业亟需解决的问题。阿里妈妈一直注重对于隐私数据的安全合规使用，最大限度地保护用户隐私和数据安全。本篇分享阿里妈妈在保护数据安全和用户隐私方向的Data Clean Room实践产品 ***营销隐私计算平台Secure Data Hub（以下简称“SDH”）***，欢迎阅读交流。
- > **1.1 产品介绍**
  * > 营销隐私计算平台SDH（Secure Data Hub）是由阿里妈妈提供的一套面向广告引擎、广告主、第三方检测公司在隐私安全环境下进行数据融合、隐私计算、联合建模的Data Clean Room解决方案。
  * > SDH基于多方安全计算（Secure Multi-Party Computation, MPC）、隐私保护机器学习（Privacy-Preserving Machine Learning, PPML）等隐私增强计算技术，立足于广告营销场景，贯穿广告投放的跟踪、采集、激活和衡量的全流程，实现对隐私数据的安全合规使用。在营销场景下的数据处理、人群洞察、投放优化、归因衡量、增效度量、触达监测等流程中严格保障多方数据的隐私安全和数据合规，为品牌提供跨域安全一致的数据决策能力。
  * > SDH已于2022年12月份通过了中国信通院第七批“可信隐私计算”评测，并获得多方安全计算（MPC）和联邦学习（Federated Learning, FL）的基础能力专项评测的两项评测证书。
- > **关于我们**
  * > 阿里妈妈SDS（Strategic Data Solutions）团队致力于用数据让商家和平台的增长战略更加科学有效。我们为阿里妈妈全线广告客户提供营销洞察、营销策略、价值量化、效果归因、隐私计算的技术服务。我们将持续在营销场景下的数据隐私安全和解决方案方向进行探索和落地，欢迎各业务方关注与合作。
  * > 阿里巴巴智能引擎算法平台团队负责为阿里巴巴的广告搜索推荐等核心商业提供AI工程平台和隐私增强计算服务。我们长期追踪各类广告营销以及搜索推荐场景所需的超大规模计算存储、稀疏及多模态深度学习、联邦学习及隐私增强计算等领域前沿，欢迎进行技术交流。

## 蚂蚁金服

攻坚安全可信技术，2024年蚂蚁集团16篇论文被顶会顶刊收录 https://mp.weixin.qq.com/s/LuLF4vLDITg1mzEK10-Wkg

探索安全可信技术前沿，2023年蚂蚁14篇论文被国际顶会顶刊收录 https://mp.weixin.qq.com/s/dqJjd583E_m6YJeEX4PBlQ
- > 2023年即将进入尾声，跟大家汇报一些今年我们在探索安全可信技术前沿方面的工作，涵盖了隐私计算、数据安全、网络安全、AI安全、系统安全等领域，Usenix Security、ACM CCS 、Usenix ATC等国际顶会顶刊，共收录了14篇相关论文研究成果。这些研究很多已在蚂蚁集团的应用场景中得到应用，相关技术开源项目正成为高校学术研究重要平台 。

Antchain-MPC https://github.com/alipay/Antchain-MPC
- MORSE STF快速开始 https://github.com/alipay/Antchain-MPC/wiki/MORSE-STF%E5%BF%AB%E9%80%9F%E5%BC%80%E5%A7%8B
- MORSE STF使用手册 https://github.com/alipay/Antchain-MPC/wiki/MORSE-STF%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C

蚂蚁隐私计算服务平台 > 多方安全分析 https://help.aliyun.com/document_detail/356683.html
- 产品简介 https://help.aliyun.com/document_detail/356689.html
- 用户指南 https://help.aliyun.com/document_detail/364171.html
  * 脚本文件管理 https://help.aliyun.com/document_detail/364175.htm

PSI based on ECDH https://datatracker.ietf.org/doc/draft-ecdh-psi/
- https://www.ietf.org/archive/id/draft-ecdh-psi-00.html
  ```console
                A(data_A,sk_A)                  B(data_B,sk_B)
  -----------------------------------------------------------------------
  Step 1:             |                               |
                      |                               |
              p_A=scalar_mul(sk_A,            p_B=scalar_mul(sk_B,
              hash_to_curve(data_A))          hash_to_curve(data_B))
                      |                               |
  Step 2:             |                               |
                      |                               |
                      |-------------p_A-------------->|
                      |<------------p_B---------------|
                      |                               |
  Step 3:             |                               |
                      |                               |
         p_AB=scalar_mul(sk_A,p_B)     p_BA = scalar_mul(sk_B,p_A)
                      |                               |
                      |                               |
                      |                               |
  Step 4:             |                               |
                      |                               |
                      |-------------p_AB------------->|
                      |<------------p_BA--------------|
                      |                               |
  Step 5:             |                               |
                      |                               |
           set_A=intersect(p_AB,p_BA)      set_B=intersect(p_BA,p_AB)
                      |                               |
                      |                               |
           output match(set_A,data_A)      output match(set_B,data_B)
  ```
  > Figure 1: A Simplified Protocol Flow of ECDH-PSI

## 百度

PrivC—A Framework for Efficient Secure Two-Party Computation https://link.springer.com/chapter/10.1007/978-3-030-37231-6_23

PaddleFL https://github.com/PaddlePaddle/PaddleFL
- https://github.com/PaddlePaddle/PaddleFL/blob/master/README_cn.md
  ```md
  #### A. 联邦学习策略
  - **纵向联邦学习**: 带privc的逻辑回归，带ABY3[11]的神经网络
  - **横向联邦学习**: 联邦平均 [2]，差分隐私 [6]，安全聚合
  
  #### B. 训练策略
  - **多任务学习** [7]
  - **迁移学习** [8]
  - **主动学习**
  
  PaddleFL 中主要提供两种解决方案：**Data Parallel** 以及 **Federated Learning with MPC (PFM)**。
  ```

## 腾讯

Angel PowerFL 安全联合计算 https://cloud.tencent.com/solution/powerfl
- > 算法丰富：支持 LR、XGBoost、PCA、用户自定义神经网络模型（如 MLP、CNN、RNN、Wide&Deep，DeepFM, DSSM 等）
- > 性能卓越：一个小时左右可以完成千万级数据的 XGBoost 模型训练，十分钟左右可以完成千万级数据的预测。
  
快速上手联邦学习——腾讯自研联邦学习平台PowerFL实战 https://cloud.tencent.com/developer/article/1729569

云安全隐私计算 https://cloud.tencent.com/product/tcspc

## 星云Clustar

关于我们 https://www.clustar.ai/about
- > 深圳致星科技有限公司（简称：星云Clustar) 成立于2018年1月，是全球领先的AI算力解决方案提供商 ，支持通用、密态AI计算，致力于将高性能网络、联邦学习等创新性技术应用到人工智能及大数据领域。星云Clustar核心团队来自香港科技大学SING Lab，其世界领先的学术成果为星云研发提供支撑，获得红杉资本、基石资本等顶级机构投资，在北京、深圳和香港都设有产品和研发中心，目前团队规模100余人，80%以上为产品研发团队。

同态加密技术及其在机器学习中的应用 https://www.infoq.cn/article/ihal9cagg9fy7algmpuy
- > 除了 Paillier 和 CKKS，未来我们将测试更多的同态加密算法效率，以便为同态加密的应用提供参考，欢迎查看 GitHub 项目主页： https://github.com/Di-Chai/he-benchmark

## 字节

iDASH 2023国际大赛 | 字节Jeddak Team获得优异成绩 https://mp.weixin.qq.com/s/R8MT3eTjlVY3BwYzLH_3rA

Jeddak亮相2022世界人工智能大会|隐私计算的实践与探索 https://mp.weixin.qq.com/s/gPShSYeOII6HcJcB0n-28w
- > `安全研究团队  字节跳动安全中心  2022-09-16 17:18 发表于北京`
- > **Jeddak-MPC在联合查询与统计场景的实战**
  * > 在面对需要利用多方数据进行联合查询时，Jeddak-MPC也有不俗实力。比如一方拥有人群的特征数据，另一方拥有购买标签数据，需要联合分析广告的投放效果。首先MPC的底层实现对用户是透明的，用户通过使用常规的SQL发起任务，Jeddak将SQL重写技术与MPC算子结合，从而实现在各方数据均不出域的情况下实现联合查询，***目前Jeddak-MPC已支持亿级的联合查询***。

安全计算，云厂商新必争之地 https://mp.weixin.qq.com/s/QZ4egckqcRISQHAW_MA1kg
- > “今年4月，我收到了IEEE Symposium on Security and Privacy大会组委会的邮件通知。”火山引擎副总裁张鑫没想到，十年前发表于信息安全领域顶会IEEE Security and Privacy的论文，现在又获得了评奖门槛极其严苛的IEEE“Test of Time”奖（时间沉淀奖）。
- > IEEE认定，在这个层面上，以张鑫为一作的《SCION: Scalalbility, Control, and Isolation on Next Generation Networks（2011）》（SCION：下一代网络上的可扩展性、控制和隔离）对互联网安全的意义，与论文《Unleashing Mayhem on Binary Code (2012)》（释放二进制代码上的混乱 ）对二进制范式的演进、《Click Trajectories: End-to-End Analysis of the Spam Value Chain》（点击轨迹：垃圾邮件价值链的端到端分析）对垃圾邮件的意义相似。
- > 张鑫当时的导师Adrian Perrig解释道，“SCION承诺，在分布式拒绝服务攻击的情况下，也能根除路由攻击并提供通信保证。”Adrian Perrig如今在苏黎世联邦理工学院工作。前段时间，该校专门发了新闻，庆贺Adrian Perrig之前指导的论文获得IEEE时间沉淀奖。
- > 时移世易，当初人们眼中的冷门研究，近些年已经成为互联网安全领域的热门，火山引擎也给出了自己的隐私计算解决方案——Jeddak。

## TikTok

~~DPCA-PSI Protocol for Privacy-Preserving Set Intersection and Compute https://github.com/tiktok-privacy-innnovation/DPCA-PSI~~  -->  PrivacyGo https://github.com/tiktok-privacy-innovation/PrivacyGo

PETAce https://github.com/tiktok-privacy-innovation/PETAce
- https://github.com/tiktok-privacy-innovation/PETAce-Solo
- https://github.com/tiktok-privacy-innovation/PETAce-Verse
- https://github.com/tiktok-privacy-innovation/PETAce-Duet
- https://github.com/tiktok-privacy-innovation/PETAce-SetOps
- https://github.com/tiktok-privacy-innovation/PETAce-Network

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他项目

## SecureML

SecureML: A System for Scalable Privacy-Preserving Machine Learning https://eprint.iacr.org/2017/396.pdf

Secure Machine Learning https://github.com/shreya-28/Secure-ML

（阅读笔记）SecureML: A System for Scalable Privacy-Preserving Machine Learning https://blog.csdn.net/qq_42328228/article/details/109697929

SecureML: A System for Scalable Privacy-Preserving Machine Learning - 铃铃铃铃屋什造啊的文章 - 知乎 https://zhuanlan.zhihu.com/p/483203938

论文阅读笔记：SecureML: A System for Scalable Privacy-Preserving Machine Learning - 风起的文章 - 知乎 https://zhuanlan.zhihu.com/p/474142624

## ABY<sup>3</sup>

ABY 3 and Applications https://github.com/ladnir/aby3
- ***Paper***:
  * (`CCS 2018`) ABY<sup>3</sup>: A Mixed Protocol Framework for Machine Learning https://eprint.iacr.org/2018/403.pdf || https://dl.acm.org/doi/10.1145/3243734.3243760
    + > `[46] Fast and Secure Three-party Computation: The Garbled Circuit Approach` https://dl.acm.org/doi/10.1145/2810103.2813705 || https://eprint.iacr.org/2015/931.pdf

ABY3: A Mixed Protocol Framework for Machine Learning - 酸菜鱼的文章 - 知乎 https://zhuanlan.zhihu.com/p/402420978

（阅读笔记）ABY3: A Mixed Protocol Framework for Machine Learning https://blog.csdn.net/qq_42328228/article/details/109563447

ABY3: A Mixed Protocol Framework for Machine Learning https://slideplayer.com/slide/15832833/

## ABY

ABY - A Framework for Efficient Mixed-protocol Secure Two-party Computation https://github.com/encryptogroup/ABY  【这个和ABY<sup>3</sup>貌似不是一个单位搞的】
- ***Paper***:
  * (`NDSS 2015`) ABY – A Framework for Efficient Mixed-Protocol Secure Two-Party Computation https://www.ndss-symposium.org/ndss2015/ndss-2015-programme/aby-framework-efficient-mixed-protocol-secure-two-party-computation/ || https://encrypto.de/papers/DSZ15.pdf

Efficient Circuit-based PSI via Cuckoo Hashing https://github.com/encryptogroup/2DCuckooHashing
- > The proof-of-concept implementation of our PSI-CAT protocol based on 2D Cuckoo hashing developed as part of our EUROCRYPT'18 paper [Efficient Circuit-based PSI via Cuckoo Hashing](https://encrypto.de/papers/PSWW18.pdf) is available as an example in the [ABY repository](https://github.com/encryptogroup/ABY/tree/public/src/examples/psi_2D_CH).

(阅读笔记)ABY: A Framework for Efficient Mixed-Protocol Secure Two-Party Computation https://blog.csdn.net/qq_42328228/article/details/124918275

安全多方计算——ABY框架 - Patronuss的文章 - 知乎 https://zhuanlan.zhihu.com/p/475610774

安全多方计算基础——ABY框架（Arithmetic部分） https://blog.csdn.net/qq_37963864/article/details/120169331

隐私计算框架之ABY开发指南(一) - 六三的文章 - 知乎 https://zhuanlan.zhihu.com/p/491626700

ABY开发指南(三) - 六三的文章 - 知乎 https://zhuanlan.zhihu.com/p/495374615

ABY-PPLP：面向位置保护的隐私距离计算与近邻检测 https://github.com/primihub/hackathon/blob/master/winning-project/ABY/README.md

## ABY2.0

(`USENIX Security 2021`) ABY2.0: Improved Mixed-Protocol Secure Two-Party Computation (Full Version) https://eprint.iacr.org/2020/1225.pdf || https://www.usenix.org/conference/usenixsecurity21/presentation/patra 【这个似乎又是另外一拨人。。。PS：`ABY` 和 `ABY2.0` 是有一位作者两篇都参与了的：`Thomas Schneider`；但是 `ABY3` 的作者和这两篇完全没有重叠；此外时间顺序上 `ABY3` 反而处于 `ABY` 和 `ABY2.0` 之间。】

ABY和ABY2.0 https://mp.weixin.qq.com/s/FC-OlJBgQEJw9iCtnl5sew

隐语小课｜两方安全计算 ABY2.0 高效的 2PC 协议 https://xie.infoq.cn/article/8fc83431b0b5458b03a7a8388

## MPyC

MPyC -- Secure Multiparty Computation in Python https://github.com/lschoe/mpyc
- > See the [MPyC homepage](https://www.win.tue.nl/~berry/mpyc/) for more info and background.
  * MPyC: Secure Multiparty Computation in Python https://www.win.tue.nl/~berry/mpyc/
    + > See [MPyC--Python Package for Secure Multiparty Computation (PDF Slides)]() for some background information.
      - MPyC – Python Package for Secure Multiparty Computation https://www.win.tue.nl/~berry/mpyc/TPMPC2018.pdf
- > See demos for usage examples and [MPyC docs]() for pydoc-based documentation.
  * mpyc (version 0.7) https://lschoe.github.io/mpyc/

(SECRYPT 2009) Multiparty Comparison - An Improved Multiparty Protocol for Comparison of Secret-shared Values https://www.scitepress.org/Papers/2009/22336/22336.pdf || https://www.semanticscholar.org/paper/Multiparty-Comparison-An-Improved-Multiparty-for-of-Reistad/eced2fa7cfd70e9a8c015eeacc1b1d610a77f5c5 || https://www.researchgate.net/publication/221436438_Multiparty_Comparison_-_An_Improved_Multiparty_Protocol_for_Comparison_of_Secret-shared_Values

## SecMML

复旦大学开源的隐私计算项目SecMML https://mp.weixin.qq.com/s/MRfwctyFpUbIRXihVZpjFw

SecMML https://github.com/FudanMPL/SecMML
- > SecMML是FudanMPL(Multi-Party Computation + Machine Learning)的一个分支，是用于训练机器学习模型的高效可扩展的安全多方计算（MPC）框架，基于BGW协议实现。此框架可以应用到三个及以上参与方联合训练的场景中。目前，SecMML能够支持几种当前流行的机器学习模型，包括线性回归模型，逻辑回归模型，BP神经网络和LSTM神经网络模型。

Garnet（石榴石） https://github.com/FudanMPL/Garnet
- > FudanMPL 2.0, a series of multi-party learning frameworks, with rich features, including secure and fast XGBoost, secure Fine-tuning for pre-trained models, and open source SecureML.

## 其他 paper 相关项目

Implementation of protocols in Falcon https://github.com/snwagh/falcon-public
- (PETS 2021) Falcon: Honest-Majority Maliciously Secure Framework for Private Deep Learning https://arxiv.org/pdf/2004.02229.pdf

BLAZE: Blazing Fast Privacy-Preserving Machine Learning https://www.ndss-symposium.org/ndss-paper/blaze-blazing-fast-privacy-preserving-machine-learning/
- > BLAZE achieves the stronger guarantee of `fairness` (all honest servers get the output whenever the corrupt server obtains the same).

MOTION - A Framework for Mixed-Protocol Multi-Party Computation https://github.com/encryptogroup/MOTION
- > Check out our [paper](https://ia.cr/2020/1137) (published at ACM TOPS'22) for details.

## Primihub

重磅 | 企业级开源隐私计算平台—Primihub正式开源 https://mp.weixin.qq.com/s/Y4-Qhwpwr4wPpPuxodkgXw
- > Primihub平台融合了MPC（多方安全计算）、FL（联邦学习）、HE（同态加密）、TEE（可信执行环境）等多种技术路线，提供多安全级别、多性能要求、多场景支持的解决方案，帮助企业用户保护数据隐私的同时，深度连接各个合作方，实现跨数据、跨行业的合作共赢。在提供开源版的同时，原语科技研发了企业版，支持更加丰富的功能。
- > Primihub开源官网：http://docs.primihub.com/
- > GitHub开源地址：https://github.com/primihub/primihub

PrimiHub快速上手：5分钟运行一个MPC应用 https://mp.weixin.qq.com/s/p9j7Aup297bFtuetXRX8mA

## 小型项目

GBDT_Simple_Tutorial（梯度提升树简易教程） https://github.com/Freemanzxp/GBDT_Simple_Tutorial
- > 算法原理以及公式推导请前往blog：[GBDT算法原理以及实例理解](https://blog.csdn.net/zpalyq110/article/details/79527653)

Privacy-Preserving XGBoost Inference https://github.com/awslabs/privacy-preserving-xgboost-inference
- > An extended abstract of this work ( https://arxiv.org/pdf/2011.04789.pdf ) appears in Privacy-preserving Machine Learning Workshop at NeurIPS 2020.

安全多方计算代码python版本 https://blog.csdn.net/zhuiyunzhugang/article/details/108983850

Concrete Numpy is an open-source set of tools which aims to simplify the use of fully homomorphic encryption (FHE) for data scientists. https://github.com/zama-ai/concrete-numpy

MPCFormer: fast, performant, and private transformer inference with MPC. https://github.com/MccRee177/MPCFormer

## MPC and DB

Conclave https://github.com/multiparty/conclave
- (EuroSys '19) Conclave: secure multi-party computation on big data https://dl.acm.org/doi/10.1145/3302424.3303982
- https://cs.paperswithcode.com/paper/conclave-secure-multi-party-computation-on

Senate 【又是 Raluca Ada Popa 组的数据库相关的。。。关键又没找到源码】
- (Usenix Security 2021) Senate: A Maliciously-Secure MPC Platform for Collaborative Analytics https://www.usenix.org/conference/usenixsecurity21/presentation/poddar
- https://crossminds.ai/video/usenix-security-21-senate-a-maliciously-secure-mpc-platform-for-collaborative-analytics-61a4fa1141c1645262b809a6/
- https://cs.paperswithcode.com/paper/senate-a-maliciously-secure-mpc-platform-for
- https://iacr.org/submit/files/slides/2021/rwc/rwc2021/33/slides.pdf

SMCQL : Secure Querying for Federated Databases https://github.com/smcql/smcql
- (VLDB 2017) smcql: Secure Querying for Federated Databases http://www.vldb.org/pvldb/vol10/p673-rogers.pdf
- SMCSQL：一种用于安全查询的联合数据库 https://www.cnblogs.com/neumy/p/14998594.html
- **ObliVM**:
  * ObliVM : A Programming Framework for Secure Computation (The compiler) https://github.com/oblivm/ObliVMLang
  * ObliVM - Djvu的文章 - 知乎 https://zhuanlan.zhihu.com/p/148300132

Secrecy: Secure collaborative analytics on secret-shared data https://arxiv.org/abs/2102.01048
- Secrecy: Secure collaborative analytics on secret-shared data #42 https://github.com/pentium3/sys_reading/issues/42

Cerebro: A Platform for Multi-Party Cryptographic Collaborative Learning https://www.usenix.org/conference/usenixsecurity21/presentation/zheng

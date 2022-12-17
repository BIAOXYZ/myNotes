
# 1

【[:star:][`*`]】 固态硬盘为啥这么快？带你了解固态硬盘的“秘密”…… https://mp.weixin.qq.com/s/Dr2VVYZeG7U-lINxyL20Sg  【from： `服务器及存储专题` https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MjM5MTQ0MTQ2Mg==&action=getalbum&album_id=2386342673747247107】
- > **1 机械硬盘的工作原理**
  * > 机械硬盘在工作的时候，磁头会悬浮于磁盘面上方几纳米的距离。磁盘面上有很多的小格子，小格子内有很多的小磁粒。
  * > 这些磁盘上的磁粒有一定的极性，**当磁粒极性朝下的时候记为0，磁粒极性朝上的时候记为1，这样磁头就可以通过识别磁盘磁粒的极性读取数据了**。 <br> ![](https://mmbiz.qpic.cn/mmbiz_png/GOHsECYibE4RcSN6Jicy1b3pyFQfFCvBEo5lRpbCr9G0tk8JY6hseAJZlhBibSicqiblIBZ21Np0pAxlPtia3IzMzYicA/640)
  * > 而磁头也可以利用其变化的磁场改变磁盘磁粒的极性，这样就做到写入和改写磁盘数据了。 <br> ![](https://mmbiz.qpic.cn/mmbiz_png/GOHsECYibE4RcSN6Jicy1b3pyFQfFCvBEoylbiaq5hHqD5hYr990ibZniceVFxBWDWMianVWmccaWMJjpRddhhLqhKsw/640)
  * > 为了能够精准定位数据所在磁盘面上的位置，磁盘本身又被划分了无数的扇区和磁道。
  * > 假设数据存放在磁盘的第五磁道的第七扇区上： <br> ![](https://mmbiz.qpic.cn/mmbiz_png/GOHsECYibE4RcSN6Jicy1b3pyFQfFCvBEo3ibYPvSY5Zgae6DPkWdTxzibzb6ibWSX8KpTOZd0AwInqqkbT3hHy1ypg/640)
  * > 那磁头就会先摆动到第五磁道上空，然后等待第七扇区转过来。当第七扇区转到磁头下面的时候，才可以读取数据。
  * > 而固态硬盘同机械硬盘的工作原理完全不同，***固态硬盘采用纯电子结构***。
- > **2 固态硬盘的工作原理**
  * > 固态硬盘存储数据的基本单元叫**浮栅晶体管**，基本结构有：**存储电子的浮栅层**，**控制极G**、**衬底P**、**源极D**与**漏极S**。 <br> ![](https://mmbiz.qpic.cn/mmbiz_png/GOHsECYibE4RcSN6Jicy1b3pyFQfFCvBEoRsg0r9dfrrgTQ79oHH777c8x82GJicIpSbo6Sr4yHUIagKjN6QoZRJQ/640)
  * > **我们将`浮栅层`中的<ins>电子数量`高于`一定值计为`0`，`低于`一定值计为`1`</ins>**。 <br> ![](https://mmbiz.qpic.cn/mmbiz_jpg/GOHsECYibE4RcSN6Jicy1b3pyFQfFCvBEogHRgiavJHs5EpP3yZVQA1SxuvWCnKA2NRRdpicQD1SfBElgfBLwsFSFw/640)
    >> //notes：TODO: 所以固态硬盘的每个比特位的初始值都是 `1` 吗？
- > **写入数据**
  * > 写入数据时，需要在控制极G施加一个高压，这样电子就可以穿过隧穿层，进入浮栅层，因为有绝缘层的存在，电子不能再向前移动了，就被囚禁在了浮栅层。 <br> ![](https://mmbiz.qpic.cn/mmbiz_png/GOHsECYibE4RcSN6Jicy1b3pyFQfFCvBEo8fqHIvCueaJOK1ube1rpSuLNzic0QLP176dTelLDukTLT8ZXJsBK4Xw/640)
  * > 而当我们把电压撤去，这些电子依然会被囚禁在浮栅层，因为隧穿层本质上也相当于绝缘体，所以电子们只能被关押着，这样一位数据就被存储进去了。
  * > **这些电子能被“囚禁”多长时间也就是固态硬盘能够存储数据的年限，一般一块新的固态硬盘能够保存数据的年限为`10年`**。因为随着时间的流逝，不断地有电子“越狱”成功。
  * > 等“越狱”的电子多到一定的数量，我们保存的数据就不见了。
- > **擦除数据**
  * > 我们擦除固态硬盘上的数据其实就是在释放这些可怜的电子，即在衬底上施加高压，这样电子被吸出来，信息也就被擦除了。 <br> ![](https://mmbiz.qpic.cn/mmbiz_png/GOHsECYibE4RcSN6Jicy1b3pyFQfFCvBEogkXyTPd0q3XJLxlj9xn18yxWeYXibCG79SBbLicXf19RT8iaStV6Et9xA/640)
- > **读取数据**
  * > 关于它读取数据的原理也非常简单。
  * > 当`浮栅层`中不存在电子时（***存储数据为`1`***），我们给`控制极`一个低压，由于电压低，电子只能被吸引到靠近`隧穿层`的位置，却无法穿过`隧穿层`，因而`源极``漏极`可以导通，形成电流。
  * > **如果检测到电流，那么说明它没有储存电子，则读取数据为`1`**。 <br> ![](https://mmbiz.qpic.cn/mmbiz_png/GOHsECYibE4RcSN6Jicy1b3pyFQfFCvBEoUt8CfmfUVRiaJ0LibnldQNq5aYdS6LHZ9RsVVut13FKMQ8coZh7SsyXg/640)
  * > 当`浮栅层`中存在电子时（***存储数据为`0`***），我们还给`控制极`一个低压，由于`浮栅层`里面的电子对这些电子有排斥作用，所以电子无法被吸引到靠近`隧穿层`的位置，`源极``漏极`不会导通，不会形成电流。
  * > **如果无法检测到电流，那么说明浮栅层储存一定量电子，则读取数据为`0`**。 <br> ![](https://mmbiz.qpic.cn/mmbiz_png/GOHsECYibE4RcSN6Jicy1b3pyFQfFCvBEob154kV42mCYA2tQ5Q1jOxW8belDj4t5jqd2uXusVwUuYafreicQiboIw/640)
  * > 无数的浮栅晶体管堆叠在一块就可以存储大量的0和1，它们就类似于图书馆当中的书架一样，存储着无限的0101数据。
  * > **相对于机械硬盘这种机械结构，固态硬盘这种纯电子结构在存取速度方面的优势就非常突出**。在机械硬盘在读取数据之前，需要先摆动磁头臂到对应的磁道上方，再等待对应的扇区转过来。尽管目前的机械硬盘大部分都是`7200转/分钟`或者`5400转/分钟`的，看起来已经很快了，但是这两个操作依然会导致大约`十几毫秒`的延迟。这种延迟对于人类来讲确实微不足道，但是对于计算机内存和CPU来讲，就确实会产生显著影响。
  * > **而固态硬盘全程都是电子交互，电子信号的速度要远超磁头臂和磁盘这种机械结构**。如果你的数据是随机分散在磁盘的各个角落，那机械硬盘需要经过多次的寻道和寻址，多次等待扇区转动到磁头底下，所以机械硬盘在读取分散性文件的时候，性能就显得非常弱，速度很慢，**即随机读写性能低下**。
- > 了解固态硬盘的原理之后，**想必你一定知道为什么固态硬盘有擦写次数限制**？（点击下方空白处查看答案）
  * > ***是因为在浮栅晶体管擦写的过程中，电子反复在隧穿层反复进出，导致隧穿层损坏，不能有效的阻拦电子，失去了隧穿层应有的作用***。
- > 最后考你一个小问题，据说只有聪明的小伙伴才能回答出来～欢迎在评论区作答：**同一型号的两块固态硬盘，分别是1TB容量和500GB容量，哪一个的使用寿命更长，为什么**？
- 回复里的：
  * > 当然是大容量的固态硬盘寿命更长。相同的闪存颗粒，有效写入的pe次数自然是一样的。硬盘拥有更大的存储空间时，在全局均衡磨损算法的帮助之下。相对应的单个存储单元写入次数会更少，从而达到更久的使用寿命。
  * > 1tb寿命更长吧。假设对1tb和500g的硬盘同时刷写1tb的“0”数据，1tb的硬盘只隧穿了一次，而500的隧穿了两次，肯定更容易坏啊。
  * > 固态听说固态长时间不通电……所有电子都会跑光光
  * > 1TB寿命长，因为晶体管数量多的多。假设每个晶体管的可擦写次数相当，那么晶体管越多寿命越长
  * > 1Tb 有更多的空间存放数据，平均被读写的频率小

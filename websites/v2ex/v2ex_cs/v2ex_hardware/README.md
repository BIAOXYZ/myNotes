
【[:star:][`*`]】 过来人建议各位前后端 [软件] 工程师，慎入硬件相关的工作 https://www.v2ex.com/t/906962
```console
前提
[硬件相关] 指的是做和硬件相关的 [软件] 开发，比如触摸类机器的界面，atm 或者售票机这种

坑 1：基本上，你必须接触硬件
一般我们开发网站或软件，就在办公室一座电脑一开就行了，但是硬件不行，硬件开发你必须去硬件所在地。这是软件开发者不会意识到的，这就导致什么呢？
  · 基本告别远程上班，硬件小还行，但是比如电冰箱触摸屏开发这种，你怎么把电冰箱拿回家
  · 设置硬件的地方，环境肯定不如一般办公室，有的甚至直接在工厂
  · 一些情况下，你必须去公司解决问题，遇到周末等你想想难受不

坑 2：测试和 debug 异常艰难
一般我们开发网站或软件，就看看 log ，点点鼠标，前后端联调一下，大部分 bug 和测试就搞定了。但是硬件想都不要想，你必须去实地模拟，链接硬件，这就使得什么呢？
  · 需要排查硬件，atm 放入现金但是显示不对，你要排查 log 以外的进钞口有没有堵塞或损坏等，平时前后端联调，现在还需要和工厂师傅联调。一个收银系统就涉及银行卡读卡机，点钞机，小票印刷机等，排查测试简直就是噩梦
  · 测试一个确认按钮，为了确保点击的同时，二维码读卡机不影响操作，你就需要亲自操作这些硬件来测试
  · 告别自动测试，你告诉我怎么自动放入现金

最后
希望各位在选择硬件相关时，三思而后行，看好开发的到底是什么硬件，不要走我的老路，说多了都是泪
这并不是说硬件相关的工作不好，只是想提醒各位，入坑之前需要考虑清楚
如果是希望进入硬件或没有太多选择的人，就仅作参考
```
- > 我就说一点，模拟电路数字电路这些科目在大学里挂科都是很高的，尤其是模电，开卷考都能挂成一坨屎 <br> 电路和电路之前不是 http 那么高级的协议，是要按照时序交互的，时序是最离谱的东西，明明仿真一切 ok 的东西上了板子直接飞到奶奶家 <br> 搞编程都吹各种大数据,AI ，机器学习，到了电路层面谁也不会想只知道用开发板吧
- > 跟公司里的硬件工程师配合过，跟楼主说的基本一致
- > 做过一段时间，基本符合楼主说的。还有一个地方就是，硬件相对来说不那么开放，有时候遇到问题无从下手，只能自己去调，不像互联网那些通用教程和文档比较多。
- > 同意，和硬件相关的调试真的太难受了
- > 真挺搞笑的，刚刚看到一个贴子，说自己是做嵌入式硬件的，身边都是 35+，没有 996 ，越老越吃香，过的有滋有味，回头这边就有劝退的，笑哭。多说一句，因为不能远程上班就放弃一个行业挺幼稚的。
  >> 首先，无法远程只是这个工作千万缺点中的一个。其次，这和入行时候的状态有关。刚入行或之前从事的和硬件有关，你就会认为开发就是这样，这样的心态肯定 ok 干的长。假如你是互联网从业呢？我上面说的问题互联网行业都没有，所以你入行后就会产生巨大的违和感和不适。再次，和公司以及薪水有关。如果给我极高的薪水，没有 996 ，越老越吃香，我也会发一个帖子赞美一番。如果没有呢？所以这并不矛盾
- > 我朋友是做前端路由器和交换机相关的，不止是页面，也跟硬件接触，要把一些前端的包上传到硬件里面去，后端就更别说多烂了，全部是买的台湾的，或者国外的一些软件包回来自己修修改改，而这些还都是大家常用的路由器，华为、海康、移动、联通等等，反正就跟硬件沾边，真的很水。
- > 从纯软件转到软硬件结合的，真的巨难受，我有段时间甚至有点重回刚入行时候的恐慌心态，有点害怕上班面对那一大堆毫无头绪的问题
- > 哎，看到这个帖子真是感慨万千，刚毕业的时候就去了一家公司做上位机，一开始还没什么，就是串口输入输出什么的，可以模拟。 <br> 到布置现场，调试就抓瞎了，采集设备的状态，nnd ，输出和协议文档怎么不一样的。你想搞个设备来试试？做梦呢？人家公司在用的，停机你负责啊？买一台？就这一个项目，德国进口设备 30w ，再说这个设备型号已经停产了，想买都买不到。这还只是整条链路上的一个设备。 <br> 后来过完年直接飞去出差，现场住了一个月，他们下班了，我就去调试，抓完 log ，白天改代码。 <br> 最火大的还是有个设备，只有每周二凌晨停机检查的 2 小时能调，一礼拜一次的机会，一次只有 2 小时..... <br> 回来就辞职了，后来每次找工作必问，能不能在公司调试，要不要去现场调设备
  >> 我懂老铁，说多了都是泪 <br> 但凡和硬件有那么一丁点联系的，我就直接 pass <br> 所谓的布置现场我也去过，我一到那先是解决网络问题，然后是物理搬运，在是各种物理调试，md 忙活半天才发现自己原来是开发
- > 我想说要是之前是做纯软件开发的，转到这行的确难受，而且做上位机软件开发的深度要深一些，举个简单例子，做纯软件 crud 的时候很少会接触到移位计算，但是这个在上位机中是很常见的，同时上位机开发也需要学习大量的算法去支撑开发工作。 <br> 本身就是做这一行的，这行只是个很正常的行业，没有那么恐怖，做硬件方面的开发避开非标其他的都不是问题，没有 OP 说的这么恐怖，他只是个很正常的行业，只不过没法 100%远程而已。 <br> 远程我再补充一下，跟硬件相关的开发是肯定无法远程的，但是上位机也存在大量跟硬件无关的纯软件开发，这部分是可以远程的。
  >> 像 OP 说的那么深入硬件调试的工作，我基本上可以断定你们公司为了省钱没招硬件工程师、电气工程师、结构工程师、下位机开发工程师等等，拿着三方的硬件做二次开发，企图让软件一个人完成所有的工作，理想情况下，上位机软件工程师其实完全不了解硬件也是可以进行开发工作的。
  >>> 你说的全中 <br> 我这就是拿着三方的硬件做二次开发，企图让软件一个人完成所有的工作 <br> 说实话我到今天才知道还有什么结构工程师、下位机开发工程师😂 <br> 谢谢你老哥，我今天才算是入行了
- > 小公司电工也来说两点：
  * > 1.做硬件相关设备的公司一般都是重资产的传统行业，这类公司大都以生产和销售为核心，技术氛围很差劲，精力耗费在跟其他部门的麻瓜们扯皮
  * > 2.从电路设计，打样焊接，linux 移植和驱动适配，终端人机界面，桌面上位机，生产导入，甚至还要出差跑现场。这些都要一人全干。不知道大公司是否也这样
  * > 3.硬件调试遇到比如，电磁干扰，接口老化等玄学问题时非常头疼，示波器，逻辑分析仪，万用表这些工具走哪背哪
  * > 4.联调非常麻烦，底层硬件，内核层，驱动层和应用层，单独一个还好，结合在一起就很难受
- > 我们开发地铁 PIS ，广州 18 号线的时候连续加班几个月，就是因为这个调试只能现场调试，在机房待了几个月，没椅子没桌子，坐地上盘腿放电脑。楼主说的很对
  >> 我之前给电网做开发也是这样，坐在地上，后来我申请买了个折叠桌和小马扎。另外你可以再申请买一个无线路由和一根长网线，这样就可以在离设备比较远的地方比如空调房里进行开发，嘿嘿嘿
- > 做过智能硬件相关，硬件出问题有时候真的叫天天不应叫地地不灵，你人不在现场根本不知道发生了什么错误，要怎么解决。
- > 看来 OP 还是接触的少，接触多了你就会发现，你所说的坑，就是纯软件也照样有。大点的，客户要求必读在客户现场开发，各种权限卡得你基本没法看调试日志，都是很常见的。小点的，一个客户一套代码一把梭，没测试环境，甚至连代码版本库环境都没有的，也很常见。
- > 不仅是出差，你碰到三班倒的工厂经常得 24 小时待命，还有各种离奇得问题，我碰到过最离谱的的是有台机器会时不时莫名停止工作报警，检查了几天都检查不出来，直到有一天发现有一根头发丝粗细的线掉在 PLC 两个信号点上，机器震动一大两个信号点就导通了导致机器报警。
- > 大学时期搞过嵌入式，浅度总结下偏硬件的嵌入式各类问题：
  * > 1.购买硬件费钱
  * > 2.调试 bug 困难，开发需要涉及到模电、数电知识，各种硬件问题从意想不到的地方出现，例如：cpu 引脚坏了导致部分指令正常部分错误。PCB 板子验证，有问题测出来又要返工找厂商制版。
  * > 3.资源没有软件开发多，部分资源比较封闭，天天就是翻硬件的技术手册
  * > 4.知识面又广又杂，什么都要涉及和学习
- > 基本赞同，搞硬件开发是比较苦，debug 很麻烦。我这里搞 ATM 开发的同事，他们的开发和测试设备是在地下停车场里围起来的一个玻璃屋子，想着就有点惨
- > 一样，我有一次去过山区的现场，那现场一天下来就像上世纪的工人一样。晚上我面对无言的大山，思考自己是哪根筋错了，自己在大学的寝室里学编程时，怎么也不会想到有今天

# software engineering "theory" related

《软件基础》中文版 https://Coq-zh.github.io/SF-zh/ || https://github.com/Coq-zh/SF-zh

Software design pattern https://en.wikipedia.org/wiki/Software_design_pattern || 设计模式 (计算机) https://zh.wikipedia.org/wiki/%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F_(%E8%AE%A1%E7%AE%97%E6%9C%BA)

SOLID (面向对象设计) https://zh.wikipedia.org/wiki/SOLID_(%E9%9D%A2%E5%90%91%E5%AF%B9%E8%B1%A1%E8%AE%BE%E8%AE%A1)
- > 在程序设计领域， SOLID（单一功能、开闭原则、里氏替换、接口隔离以及依赖反转）是由罗伯特·C·马丁在21世纪早期引入的记忆术首字母缩略字，指代了面向对象编程和面向对象设计的五个基本原则。当这些原则被一起应用时，它们使得一个程序员开发一个容易进行软件维护和扩展的系统变得更加可能。SOLID所包含的原则是通过引发编程者进行软件源代码的代码重构进行软件的代码异味清扫，从而使得软件清晰可读以及可扩展时可以应用的指南。SOLID被典型的应用在测试驱动开发上，并且是敏捷开发以及自适应软件开发的基本原则的重要组成部分。

# issue or bug tracking/agile project management

Jira (software) https://en.wikipedia.org/wiki/Jira_(software)

Bugzilla https://en.wikipedia.org/wiki/Bugzilla

# CICD (Continuous Integration Continuous Delivery)

## CI general

持续集成（CI）- 各种工具的资料总结
http://www.cnblogs.com/2018/archive/2011/06/17/2055064.html

GitHub 欢迎一切 CI 工具 https://www.linuxidc.com/Linux/2017-12/149865.htm
- Travis CI https://travis-ci.org/
- CircleCI https://circleci.com/
- Jenkins https://jenkins.io/

持续集成工具Travis CI和Jenkins https://blog.csdn.net/hebbely/article/details/79099398
> Travis有两个网址：`https://travis-ci.org/`，`https://travis-ci.com/`。由域名可知：org是非盈利的，为GitHub上Public的repository提供免费服务；com是盈利的，可以对Private的提供付费服务。com前100次build是免费的，此后按月收费。二者的账户是相互独立的，但都可以用GitHub账户注册、登录。

## CI specific tools

### Jenkins

CI工具一周课程Day 1：Jenkins
http://www.freebuf.com/sectool/88143.html

### JFrog

JFrog https://jfrog.com/

从零开始通过 Artifactory 搭建公网的 maven 仓库 https://juejin.im/post/595368f35188250d852faf1e

### SourceMonitor

代码度量工具——SourceMonitor的学习和使用
http://www.cnblogs.com/bangerlee/archive/2011/09/18/2178172.html

## 待整理

### 忘了在哪看到的一套推荐工具合集

*C:*
- CCT代码规模(行)
- PCLint静态检查
- JAVA静态检查
- SourceMonitor圈复杂度
- Simian代码重复度
- Coverity检查	
- Fortify检查	
- Metric	
- SAI值	
- CsecCheck	
- clang-tidy

*Python:*
- Pylint代码分析	
- OM代码注释率	
- Py Complexity圈复杂度检测	
- Simian代码重复度	
- LLT覆盖率检测

### 待分类


# 其他

### 一套简单的开发工具
- gerrit代码检视
- sanity 自验
- Jenkins 持续集成
- JIRA 问题单，记录任务

# terminologies of software engineering

### [Upstream (software development)](https://en.wikipedia.org/wiki/Upstream_(software_development))

上游 (软件开发) https://zh.wikipedia.org/wiki/%E4%B8%8A%E6%B8%B8_(%E8%BB%9F%E9%AB%94%E9%96%8B%E7%99%BC)
> "在软件开发中，上游通常是指拥有软件源代码的原作者或是维护者，他们通常也较容易发现程序错误及使用Patch程序来修复。举例来说，一个补丁被送到上游即为提供给软件的原作者或是维护者。如果被接受了，作者或维护者就会包含该部分的补丁到他们软件中，可能是立即发布或包含在未来的版本中。如果被拒绝了，提交补丁的人就不得不继续维护自他们自己的版本。"

### 关于看板/Kanban

我一直以为"看板"这个词是根据某个英文"xxx board"**意译**过来的，结果竟然他妹的是**音译**过来的。。。
- Kanban board https://en.wikipedia.org/wiki/Kanban_board
  * Jira (software) https://en.wikipedia.org/wiki/Jira_(software)
    - Bugzilla https://en.wikipedia.org/wiki/Bugzilla
- Kanban https://en.wikipedia.org/wiki/Kanban_(development)
  * Scrum (software development) https://en.wikipedia.org/wiki/Scrum_(software_development)

### GA (General Availability)

General Availability (GA) https://www.techopedia.com/definition/32284/general-availability-ga

#### 其他软件版本生命周期相关术语：

Software release life cycle https://en.wikipedia.org/wiki/Software_release_life_cycle  【[软件版本周期](https://zh.wikipedia.org/wiki/%E8%BB%9F%E4%BB%B6%E7%89%88%E6%9C%AC%E9%80%B1%E6%9C%9F)】

Alpha、Beta、RC、GA版本的区别 http://www.blogjava.net/RomulusW/archive/2008/05/04/197985.html
```
Alpha：是内部测试版,一般不向外部发布,会有很多Bug.一般只有测试人员使用。

Beta：也是测试版，这个阶段的版本会一直加入新的功能。在Alpha版之后推出。

RC：(Release　Candidate) 顾名思义么 ! 用在软件上就是候选版本。系统平台上就是发行候选版本。RC版不会再加入新的功能了，
主要着重于除错。

GA:General Availability,正式发布的版本，在国外都是用GA来说明release版本的。

RTM：(Release to Manufacture)是给工厂大量压片的版本，内容跟正式版是一样的，不过RTM版也有出限制、评估版的。但是和
正式版本的主要程序代码都是一样的。

OEM：是给计算机厂商随着计算机贩卖的，也就是随机版。只能随机器出货，不能零售。只能全新安装，不能从旧有操作系统升级。
包装不像零售版精美，通常只有一面CD和说明书(授权书)。 

RVL：号称是正式版，其实RVL根本不是版本的名称。它是中文版/英文版文档破解出来的。 

EVAL：而流通在网络上的EVAL版，与“评估版”类似，功能上和零售版没有区别。 

RTL：Retail(零售版)是真正的正式版，正式上架零售版。在安装盘的i386文件夹里有一个eula.txt，最后有一行EULAID，就是
你的版本。比如简体中文正式版是EULAID:WX.4_PRO_RTL_CN，繁体中文正式版是WX.4_PRO_RTL_TW。其中：如果是WX.开头是
正式版，WB.开头是测试版。_PRE，代表家庭版；_PRO，代表专业版。

α、β、λ常用来表示软件测试过程中的三个阶段，α是第一阶段，一般只供内部测试使用；β是第二个阶段，已经消除了软件中
大部分的不完善之处，但仍有可能还存在缺陷和漏洞，一般只提供给特定的用户群来测试使用；λ是第三个阶段，此时产品已经
相当成熟，只需在个别地方再做进一步的优化处理即可上市发行。
```

### PMC member

- 谈谈社区里的头衔 https://blog.csdn.net/Adali/article/details/6860252
  > "Apache (Apache Software Foundation, ASF) 在开源软件界大名鼎鼎， 它有个良好的制度保证其运行。社区成员分为几类：User, Developer, Committer, PMC member,  PMC Chair, ASF memeber.  权限由低到高， ASF member 就是核心圈成员，有董事会选举的投票权， 也可以参与董事会竞选。ASF member也有权利决定是否接受一个新项目。"
- 科普丨程序员Apache开源社区进击之路 - CLI1的文章 - 知乎 https://zhuanlan.zhihu.com/p/24487169
  > "成为有影响力的提交者后可以被选入项目管理委员会 (Project Management Committee, 简称PMC) ， 晋级为PMC成员 (PMC Member)！PMC 作为一个整体，独立监管一个或多个项目。除了PMC，就算是ASF的理事会 (Board) 也不能干涉项目社区内的具体事宜。"

### Waterfall, Agile/SCRUM, Spiral, Iterative   -->   DevOps

- 12 Principles Behind the Agile Manifesto https://www.agilealliance.org/agile101/12-principles-behind-the-agile-manifesto/
- Agile 101 https://www.agilealliance.org/agile101/

能力成熟度模型集成 https://zh.wikipedia.org/wiki/%E8%83%BD%E5%8A%9B%E6%88%90%E7%86%9F%E5%BA%A6%E6%A8%A1%E5%9E%8B%E9%9B%86%E6%88%90 【[Capability Maturity Model Integration (CMMI)](https://en.wikipedia.org/wiki/Capability_Maturity_Model_Integration)】

### Builder pattern/生成器模式

Builder pattern https://en.wikipedia.org/wiki/Builder_pattern 【[生成器模式](https://zh.wikipedia.org/wiki/%E7%94%9F%E6%88%90%E5%99%A8%E6%A8%A1%E5%BC%8F)】

### Clean Code

Clean Code https://zh.wikipedia.org/wiki/Clean_Code

聊聊clean code - 美团技术团队的文章 - 知乎 https://zhuanlan.zhihu.com/p/25541626

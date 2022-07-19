
Devops Exercises -- Linux, Jenkins, AWS, SRE, Prometheus, Docker, Python, Ansible, Git, Kubernetes, Terraform, OpenStack, SQL, NoSQL, Azure, GCP, DNS, Elastic, Network, Virtualization. DevOps Interview Questions https://github.com/bregman-arie/devops-exercises
- Python Exercises https://github.com/bregman-arie/python-exercises
- Kubernetes Exercises https://github.com/bregman-arie/devops-exercises/blob/master/exercises/kubernetes/README.md

# others

Modernize your application deployment with Lift and Shift https://developers.redhat.com/blog/2018/10/18/modernize-your-application-deployment-with-lift-and-shift/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# AIOps

AIOps学习资料汇总，欢迎一起补全这个仓库，欢迎star https://github.com/linjinjin123/awesome-AIOps/

What is AIOps? https://www.appdynamics.com/central-nervous-system/what-is-ai-ops

AIOps在美团的探索与实践——故障发现篇 https://mp.weixin.qq.com/s/AjE7uP7ApVPyL_HdQDkk5g 【`美团技术团队`】

MLOps Zoomcamp https://github.com/DataTalksClub/mlops-zoomcamp
- > Free MLOps course from DataTalks.Club

MLOPs Primer https://github.com/dair-ai/MLOPs-Primer

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

### AIOps公司

dynatrace https://www.dynatrace.com/solutions/application-monitoring/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# ChatOps

🤖 A collection of awesome things about ChatOps – managing operations through a chat https://github.com/exAspArk/awesome-chatops

Become a ChatOps advocate https://www.ibm.com/cloud/architecture/content/course/chatops-advocate/what-is-chatops

What is ChatOps? A guide to its evolution, adoption, and significance https://www.atlassian.com/blog/software-teams/what-is-chatops-adoption-guide

## Prow

Command Help https://prow.k8s.io/command-help

Reviewing for approvers and reviewers https://v1-18.docs.kubernetes.io/docs/contribute/review/for-approvers/

Prow 快速入门向导 https://www.servicemesher.com/blog/prow-quick-start-guide/

## StackStorm

What is ChatOps? https://docs.stackstorm.com/chatops/chatops.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# GitOps

GitOps 常用工具盘点 https://mp.weixin.qq.com/s/d3a_hFdJLAFg9p5s6643hg
- > **什么是 GitOps？**
  * > GitOps 的目的是将 etcd 的这种声明式特性扩展到(保存代码的) Git 仓库，并作为 SSOT(single source of truth)。通过这种方式，我们可以利用 Git 带来的优势，如代码监视、历史变更、快速回滚、可追溯性等等。
  * > GitOps 的核心观点是使用包含当前期望的(生产环境基础设施的)声明式描述的 GIt 仓库，并通过自动化流程来确保生产环境与仓库中的期望状态保持一致。如果你想要部署一个新的应用或更新一个现有的应用，只需要更新相应的仓库即可(自动化流程会处理后续的事情)。这就像在生产中使用巡航控制来管理应用程序一样。
  * > GitOps 不仅限于 Kubernetes，实际上它还可以通过将 **基础设施作为代码** 保存到GIt仓库中来将应用代码延伸到基础设施中，这通常是通过 **Terraform** 这样的工具进行普及的。**声明式基础设施既代码** 在实现GitOps中扮演着一个重要的作用，但不仅限于此。GitOps围绕Git构建了整个生态系统和工具，并将其应用到基础设施，仅仅在Git中使用 Terraform 并不能保证基础设施的状态能够与生产环境保持一致，还需要持续运行 Terraform 命令(`trrraform apply`)来监控实时版本的变化，以及在流水线中实现手动审批等功能。
  * > GitOps 的理念是持续监控集群的状态并与 Git 仓库进行对比，在配置不一致时立即采取相应的动作，防止发生配置漂移。除此之外，你还可以获得 Git 带来的好处，如通过代码监视进行手动审批。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 堡垒机

JumpServer 多云环境下更好用的堡垒机 https://github.com/jumpserver/jumpserver

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# BMC & IPMI

BMC简介 https://blog.csdn.net/jiangwei0512/article/details/76358995

baseboard management controller：底板管理控制器 https://searchnetworking.techtarget.com.cn/whatis/12-24883/

BMC是什麼? 能吃嗎? https://medium.com/@lioukiki1/bmc%E6%98%AF%E4%BB%80%E9%BA%BC-%E8%83%BD%E5%90%83%E5%97%8E-bee457ea5c37

使用 ipmitool 实现 Linux 系统下对服务器的 ipmi 管理 https://www.ibm.com/developerworks/cn/linux/l-ipmi/index.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## BMC & IPMI wiki

Intelligent Platform Management Interface https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface 【[IPMI](https://zh.wikipedia.org/wiki/IPMI)】
- Out-of-band management https://en.wikipedia.org/wiki/Out-of-band_management 【[带外管理](https://zh.wikipedia.org/wiki/%E5%B8%A6%E5%A4%96%E7%AE%A1%E7%90%86)】

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

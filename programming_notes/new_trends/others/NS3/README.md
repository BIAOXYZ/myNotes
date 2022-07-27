
# 官方

ns-3-allinone https://gitlab.com/nsnam/ns-3-allinone

The Network Simulator, Version 3 https://github.com/nsnam/ns-3-dev-git
- > GitHub read-only mirror of ns-3-dev repository, will be kept in sync with main GitLab.com repository. Please DO NOT file pull requests here; instead, file issues and merge requests at https://gitlab.com/nsnam/ns-3-dev/

ns-3 https://www.nsnam.org/
- AODV Routing https://www.nsnam.org/doxygen/group__aodv.html

ns-3 Tutorial https://www.nsnam.org/docs/tutorial/html/

Main Page https://www.nsnam.org/wiki/Main_Page
- Installation https://www.nsnam.org/wiki/Installation

# 安装

Ubuntu18.04上安装NS-3 https://www.cnblogs.com/variablex/p/13928867.html

NS-3学习笔记（一）：NS-3的运行环境搭建 https://rainsia.github.io/2018/03/30/ns3-001/

# 调试

ns3 + VS Code开发环境配置完美版 https://www.bilibili.com/read/cv9932411/
- > **对应的视频讲解:** ns3+VSCode开发环境配置完美版 https://www.bilibili.com/video/BV1pU4y1W74Z

ns-3 https://blog.csdn.net/qq_31648921/category_10585790.html
- Ns3学习手记7——ns-3在ubuntu16.04下的安装以及eclipse结合开发过程记录 https://blog.csdn.net/qq_31648921/article/details/112203554
- ns3学习手记8——NS-3与eclipse结合的开发调试 https://blog.csdn.net/qq_31648921/article/details/112252346

## 个人实战

```sh
mkdir test
cd test/
git clone https://gitlab.com/nsnam/ns-3-allinone.git
python download.py
sudo apt update
sudo apt install -y g++ cmake
./build.py --enable-examples --enable-tests
```

# 其他

NS3教程（一）-如何创建一个基础网络 详细教程之基础篇 - LukasChen的文章 - 知乎 https://zhuanlan.zhihu.com/p/333875261

ns3网络模拟器视频教程 https://space.bilibili.com/488796480/channel/collectiondetail?sid=428415
- ns-3网络模拟中文入门视频教程02-安装 https://www.bilibili.com/video/BV1Wv4y1f7H7

【NS-3学习】ns-3模拟基础：目录结构，模块，仿真流程 https://www.cnblogs.com/myworld7/p/12189686.html
- > 对NS-3的总结，我写的比较浅薄，这里强推我老师的[博客](https://rainsia.github.io/)，深入浅出地剖析了NS-3的核心组成。

# ns3 for AODV

（4）NS3仿真--AODV协议 https://blog.csdn.net/qq_39346534/article/details/108555681

How to Run AODV in NS3 https://networksimulationtools.com/how-to-run-aodv-in-ns3/

MANET Routing Protocols | NS3 Tutorial | Free Source Codes https://www.youtube.com/watch?v=WaMK5Af_qh0

Complete Tutorial on AODV DSR and DSDV Routing Protocols using ns3 https://www.youtube.com/watch?v=fqGtpF_6G-0

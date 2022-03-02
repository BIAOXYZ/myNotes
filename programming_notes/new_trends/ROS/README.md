
# 官方

ROS - Robot Operating System https://www.ros.org/
- Documentation and tutorials for ROS 2 http://docs.ros.org/
- Legacy documentation and tutorials for ROS 1 https://wiki.ros.org/

Robot Operating System (ROS) https://github.com/ros/ros

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 官方文档

Documentation http://wiki.ros.org/

简体中文 http://wiki.ros.org/cn
- 简介 http://wiki.ros.org/cn/ROS/Introduction
  * > **2.目的**
    + > 语言独立：ROS框架可以简单地使用任何的现代编程语言实现。我们已经实现了[Python版本](http://wiki.ros.org/rospy)，[C++版本](http://wiki.ros.org/roscpp)和 Lisp版本。同时，我们也拥有Java 和 Lua版本的实验库。
- 安装 http://wiki.ros.org/cn/ROS/Installation
- 入门 http://wiki.ros.org/cn/ROS/StartGuide
- 教程 http://wiki.ros.org/cn/ROS/Tutorials || http://wiki.ros.org/ROS/Tutorials

roschina教程安装与配置ROS环境 http://wiki.ros.org/roschina/%E6%95%99%E7%A8%8B/%E5%AE%89%E8%A3%85%E4%B8%8E%E9%85%8D%E7%BD%AEROS%E7%8E%AF%E5%A2%83

docker / Tutorials http://wiki.ros.org/docker/Tutorials
- **1.ROS + Docker**
  * 1.Getting started with ROS and Docker http://wiki.ros.org/docker/Tutorials/Docker
    + > 1.Pulling ROS images
    + > 2.Running ROS containers

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `教程`部分

安装和配置ROS环境 http://wiki.ros.org/cn/ROS/Tutorials/InstallingandConfiguringROSEnvironment
- > 1.安装ROS
  * > 在开始学习这些教程之前，请先按照 [ROS安装指南](http://wiki.ros.org/cn/ROS/Installation) 完成安装。

ROS Kinetic 安装指南 http://wiki.ros.org/cn/kinetic/Installation
- > 非官方的安装选项: (Single line install) http://wiki.ros.org/ROS/Installation/TwoLineInstall
  + > `wget -c https://raw.githubusercontent.com/qboticslabs/ros_install_noetic/master/ros_install_noetic.sh && chmod +x ./ros_install_noetic.sh && ./ros_install_noetic.sh`

创建ROS软件包 http://wiki.ros.org/cn/ROS/Tutorials/CreatingPackage
```sh
$ rospack depends1 beginner_tutorials 
[rospack] Error: the rosdep view is empty: call 'sudo rosdep init' and 'rosdep update'

# 直接按提示做即可，需要先安装下 rosdep
$ apt-get install python3-rosdep -y
$ sudo rosdep init
$ rosdep update
$ rospack depends1 beginner_tutorials 
roscpp
rospy
std_msgs

# 如果安装的不是 desktop-full 版本，可能还要按下面的先搞一下？不过我开始就机智地选择的完全版。
# https://answers.ros.org/question/353570/rospack-error-the-rosdep-view-is-empty-call-sudo-rosdep-init-and-rosdep-update/
```

## `rospy` 相关

rospy http://wiki.ros.org/rospy
- http://wiki.ros.org/rospy_tutorials

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 书籍与课程

## 课程

中国大学MOOC---《机器人操作系统入门》课程讲义 https://sychaichangkun.gitbooks.io/ros-tutorial-icourse163/content/

中国大学MOOC《机器人操作系统入门》课程代码示例 https://github.com/DroidAITech/ROS-Academy-for-Beginners
- > forked from https://github.com/sychaichangkun/ROS-Academy-for-Beginners

## 书籍

A Gentle Introduction to ROS https://www.cse.sc.edu/~jokane/agitr/ || 机器人操作系统浅析 https://www.cse.sc.edu/~jokane/agitr/%E6%9C%BA%E5%99%A8%E4%BA%BA%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F%EF%BC%88ROS%EF%BC%89%E6%B5%85%E6%9E%90.pdf
- Chinese translation: [JD.com](https://item.jd.com/12074300.html) Dangdang.com

ROS by Example 
- http://file.ncnynl.com/ros/ros_by_example_v1_indigo.pdf
- http://file.ncnynl.com/ros/ros_by_example_v2_indigo.pdf

https://github.com/StevenShiChina/books

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 视频

【古月居】古月·ROS入门21讲 | 一学就会的ROS机器人入门教程 https://www.bilibili.com/video/BV1zt411G7Vn/ || https://www.youtube.com/playlist?list=PL4XGr_39oSTlRckDYw7FbGRyIOfH63Gc5

中科院软件所-机器人操作系统入门（ROS入门教程） https://www.bilibili.com/video/BV1mJ411R7Ni/
```console
机器人操作系统入门 https://www.icourse163.org/course/ISCAS-1002580008
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# from知乎

机器人操作系统 https://www.zhihu.com/topic/19821635/hot

Ubuntu系统及ros的安装 - 起个什么名字好呢的文章 - 知乎 https://zhuanlan.zhihu.com/p/364316712
- https://github.com/wsnewman/learning_ros_setup_scripts 【这个仓库倒不见得有用，但是这个人github上有很多 ROS 相关的项目，比如： https://github.com/wsnewman/learning_ros 】

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 问题解决

## `rosdep update` 超时

【已解决】完美解决 ROS 安装 rosdep update（timed out）报错超时问题 http://www.jishudaxue.com/cblog/python/3376.html

解决ROS系统 rosdep update超时问题的新方法 https://blog.csdn.net/leida_wt/article/details/115120940

## 小乌龟的包在简版里没有

Ubuntu20.04LTS 安装ROS Noetic - 知乎用户4XlOYT的文章 - 知乎 https://zhuanlan.zhihu.com/p/268677683
```console
问题2：[rospack] Error: package 'turtlesim' not found
解决方法：sudo apt install ros-noetic-turtlesim
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

机器人操作系统ROS(一)-初识 https://www.jianshu.com/p/0869eec39a3b

ros操作系统入门 https://xhy3054.github.io/ros/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## 行为树

ROS实验 | 行为树实现机器人智能 https://www.guyuehome.com/5311
- https://github.com/chenjm1109/robotics-guyuehome

行为树（BT）应用到机器人有哪些好例子？ - 知乎 https://www.zhihu.com/question/48057411

Behavior-tree 在ROS中的应用（入门） https://blog.csdn.net/atticus00/article/details/108123587
- https://github.com/miccol/ROS-Behavior-Tree

3.9 行为树 3.10 为ROS和行为树编程(ROS by example Ⅱ(若朋机器人) https://www.bilibili.com/video/BV1pb4y1Q7nD/

ROS行为树实现（Python） https://www.cnblogs.com/Ezekiel/p/9915262.html || https://blog.csdn.net/weixin_30337157/article/details/95532868

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

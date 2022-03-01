
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

中国大学MOOC---《机器人操作系统入门》课程讲义 https://sychaichangkun.gitbooks.io/ros-tutorial-icourse163/content/

ROS by Example 
- http://file.ncnynl.com/ros/ros_by_example_v1_indigo.pdf
- http://file.ncnynl.com/ros/ros_by_example_v2_indigo.pdf

https://github.com/StevenShiChina/books

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
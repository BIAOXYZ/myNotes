
# 官方

Configure a Python interpreter https://www.jetbrains.com/help/pycharm/configuring-python-interpreter.html
>> //notes：起因是某次调试发现 pycharm 的 debug 配置界面找不到 anaconda 的虚拟环境里的解释器。后来发现需要先去配置解释器，然后才能在 debug 的时候选择该解释器。

# pycharm general

## pycharm in cloud-native

使用 PyCharm、Okteto 和 Kubernetes 搭建远程开发环境 https://www.qikqiak.com/post/remote-deploy-env-with-okteto/

# pycharm日常

<<pycharm快捷键、常用设置、配置管理>> http://blog.csdn.net/pipisorry/article/details/39909057
```
Ctrl + /    行注释/取消行注释
Ctrl + Shift + F  或者连续2次敲击shift   全局查找{可以在整个项目中查找某个字符串什么的，如查找某个函数名字符串看之前是怎么使用这个函数的}
Ctrl + Y  删除当前插入符所在的行
Ctrl + G  查看当前行号、字符号 (跳转到输入的指定行)
Ctrl + D  复制选定的区域或行
```

Pycharm跳转与回退 https://www.jianshu.com/p/b9a3f2110b22
- > 1.使用pycharm的toolbar工具栏，默认隐藏
- > 2.使用快捷键
  ```console
  跳转： ctrl + alt + 向右箭头
  回退： ctrl + alt + 向左箭头
  ```

你有哪些想要分享的 PyCharm 使用技巧？ - 知乎
https://www.zhihu.com/question/37787004

喏，你们要的 PyCharm 快速上手指南
https://zhuanlan.zhihu.com/p/26066151

## 设置多行标签

【PyCharm中文教程 12】开启多行标签页 https://blog.csdn.net/weixin_36338224/article/details/114596450

## 设置可打开的最大标签数

pycharm 常用设置，打开文件数量 https://www.cnblogs.com/mxh1099/p/5102086.html
- > `File --> Settings -->Editor -->General --> Editor Tabs --> Tab limit 然后输入你想打开的文件最大数量。`

# pycharm问题

Pycharm下运行程序查看每个变量的值的方法（类似于Spyder和MATLAB）
https://www.cnblogs.com/tq007/p/7285239.html


为什么用pycharm在同目录下import，pycharm会报错，但是实际可以运行？ - regin的回答 - 知乎
https://www.zhihu.com/question/52880389/answer/134369870


{linux下安装pycharm有问题，目前还没时间看}
https://stackoverflow.com/questions/27727826/problems-installing-pycharm

pycharm的configuration相关
- https://www.jetbrains.com/help/pycharm/creating-and-editing-run-debug-configurations.html
- https://www.jetbrains.com/help/pycharm/running-without-any-previous-configuring.html

***--------------------------------------------------分割线--------------------------------------------------***

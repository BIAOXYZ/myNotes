
# 实战1

使用 `update-alternatives` 升级系统自带 python。主要参考了链接`【1】`，其他只是拿来看看这个命令的一些参数。
- `【1】` Update Python 3 on Debian https://www.vultr.com/docs/update-python3-on-debian
- 在Linux上升级Python版本 https://www.jianshu.com/p/0a12b7c7a261
- Linux中使用update-alternatives切换默认程序 https://www.jianshu.com/p/08d08713f0d1
- ubuntu升级python3.8 https://www.jenny.fit/article/2021/6/9/16.html

使用update-alternatives管理多个版本的Python，以及对应版本Python的第三方库的安装 https://blog.csdn.net/l1216766050/article/details/82796409

## 问题1

>> //notes：升级完成后可能 `pip` 会有问题，报类似 `subprocess.CalledProcessError: Command '('lsb_release', '-a')' returned non-zero exit status 1.` 的错。参见pip部分的笔记即可。
>>> 其实核心步骤就是新安装的python版本的pip少了 `lsb_release.py`，那么直接复制已有的过去即可：`sudo cp /usr/lib/python3/dist-packages/lsb_release.py /usr/local/lib/python3.7/`。

## 问题2

>> //notes：当安装了多个版本的python后（我的情况是系统自带2.7和3.5，然后自己安装了3.9.5和3.7.10），有时 `pip` 会因为路径原因切换不过来：

```sh
root# which python
/usr/bin/python
root# which pip
/usr/local/bin/pip
```

看了这个帖子（ [update-alternatives does not work due to /usr/local/bin precedence](https://askubuntu.com/questions/1077481/update-alternatives-does-not-work-due-to-usr-local-bin-precedence) ），大意是这样：`It pretty normal for any Linux distribution to search /usr/local/bin before /usr/bin for executables, as this gives you the freedom to put any binaries and libraries into /usr/local without interfering with the dpkg packages.`

翻译到我这个场景就是 `/usr/local/bin/pip` 比 `/usr/bin/pip` 优先级高。所以我按照 `【1】` 的办法执行 `update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip3.9 2` 和 `update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip3.7 1` 后，再用 `update-alternatives --config pip` 去切。就算提示切换成功了，执行 `pip -V` 显示的还不是想要的 `pip` 路径 —— 因为你现在切来切去，***切换的都是 `/usr/bin/pip`，但是你执行 `pip -V` 时，优先级更高的 `/usr/local/bin/pip` 该怎么样还是怎么样***。所以简单来说算是个低级错误。

修改方法就是把 `/usr/bin/pip` 路径下的 `pip` 从 `update-alternatives` 维护的列表里移除，而是改为维护 `/usr/local/bin/pip` 路径下的 `pip`。
```sh
# 执行删除操作之前建议先 --help 看一下，remove相关有两个命令，但是就用下面那个就行。
root# update-alternatives --help
...
...
  --remove <name> <path>   remove <path> from the <name> group alternative.
  --remove-all <name>      remove <name> group from the alternatives system.
...
...

root# update-alternatives --remove-all pip
root#
```

但是执行时有时会有问题，还是会导致切换不成功，如下所示：
```sh
root# update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.7 1
update-alternatives: using /usr/local/bin/pip3.7 to provide /usr/local/bin/pip (pip) in auto mode
update-alternatives: warning: not replacing /usr/local/bin/pip with a link
root# update-alternatives --install /usr/local/bin/pip pip /usr/local/bin/pip3.9 2
update-alternatives: using /usr/local/bin/pip3.9 to provide /usr/local/bin/pip (pip) in auto mode
update-alternatives: warning: not replacing /usr/local/bin/pip with a link
root#
```

解决方法是参考这个帖子（ [[SOLVED] update-alternatives warning: broken link group?](http://dev1galaxy.org/viewtopic.php?id=649) ）里的一个回复，总之不管三七二十一直接执行下面这句即可。
```sh
yes '' | sudo update-alternatives --force --all
```

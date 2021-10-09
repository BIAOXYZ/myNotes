
# 实战1

使用 `update-alternatives` 升级系统自带 python。主要参考了链接`【1】`，其他只是拿来看看这个命令的一些参数。
- `【1】` Update Python 3 on Debian https://www.vultr.com/docs/update-python3-on-debian
- 在Linux上升级Python版本 https://www.jianshu.com/p/0a12b7c7a261
- Linux中使用update-alternatives切换默认程序 https://www.jianshu.com/p/08d08713f0d1
- ubuntu升级python3.8 https://www.jenny.fit/article/2021/6/9/16.html

>> //notes：升级完成后可能 `pip` 会有问题，报类似 `subprocess.CalledProcessError: Command '('lsb_release', '-a')' returned non-zero exit status 1.` 的错。参见pip部分的笔记即可。

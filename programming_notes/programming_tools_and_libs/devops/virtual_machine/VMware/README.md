
# 官方

## 产品链接

VMware Products https://www.vmware.com/products.html

VMware Workstation Player -- Local Virtual Machines https://www.vmware.com/products/workstation-player.html  【`Windows 下的个人版貌似已经完全免费了？`】
- > Easily run multiple operating systems as virtual machines on your Windows or Linux PC with VMware Workstation Player.

VMware Fusion -- Run Windows and More on Mac https://www.vmware.com/products/fusion.html
- > Harness the full power of your Mac when you use VMware Fusion to run Windows, Linux, containers, Kubernetes and more in virtual machines (VMs) without rebooting.
- Try VMware Fusion or Fusion Pro https://www.vmware.com/products/fusion/fusion-evaluation.html

## 其他

VMware Customer Connect | Get Personalized Support https://customerconnect.vmware.com
- https://customerconnect.vmware.com/account-registration  【`对于 Mac 下的个人版，要在这儿注册一个 VM 的 id，然后就可以用了`】
- https://customerconnect.vmware.com/dashboard

VMware Fusion Player – Personal Use License https://customerconnect.vmware.com/group/vmware/evalcenter?p=fusion-player-personal

## 官方文档

挂起和恢复虚拟机 https://docs.vmware.com/cn/VMware-Workstation-Pro/16.0/com.vmware.ws.using.doc/GUID-A4536112-10A6-4574-ADE5-60D9BBAE1F02.html
- > 可以使用挂起和恢复功能保存虚拟机的当前状态。在恢复虚拟机时，在挂起之前运行的应用程序将恢复运行状态，而不更改其内容。
- > 执行挂起操作的速度取决于在启动虚拟机后更改的数据量。第一次挂起操作通常比后续挂起操作花费的时间多。在挂起虚拟机时，Workstation Pro 在工作目录中创建一个虚拟机挂起状态（`.vmss` 或 `.vmem`）文件集。执行恢复操作的速度取决于虚拟机的活跃程度。虚拟机越活跃，恢复所需的时间就越长。这还取决于虚拟机挂起状态（`.vmss` 或 `.vmem`）文件集是否已位于主机系统的物理内存中。如果是，虚拟机的恢复速度要快得多。
- > 在恢复虚拟机并进行更多工作后，您无法恢复到挂起虚拟机时的状态。要重复恢复到同一状态，则必须拍摄快照。

从全屏幕模式恢复为其他模式 https://docs.vmware.com/cn/VMware-Fusion/12/com.vmware.fusion.using.doc/GUID-27A8A842-A1CA-4A0B-9572-84C55B5C2E78.html
- > 要退出全屏幕模式以进入单独窗口模式，请在全屏幕标题栏中选择 `显示 > 单独窗口` 或使用键盘快捷键 `Command 键 + Control + F`。

# wiki

VMware Workstation Player https://en.wikipedia.org/wiki/VMware_Workstation_Player

VMware Fusion https://en.wikipedia.org/wiki/VMware_Fusion

# 其他

VMware Fusion Player 个人免费版 https://blog.csdn.net/ZhangWangYang/article/details/110927837
- > 不要访问中文网站，以下链接都是英文网站，如果之前将该网站的国家设置成中国，请将其设置回美国后再打开链接。

关于VMWARE的【挂起】与【关机】的区别 https://blog.csdn.net/qq_41306795/article/details/78950939
- > 1.挂起，相当于物理机中的休眠，会将内存中的数据全部存放到对应的休眠文件中，占用的空间为内存大小，并且会对虚拟机执行关机操作。【休眠后的虚拟机不占任何CPU、内存】
- > 2.区别：挂起相对于关机，只是多了一个和内存大小相同的休眠文件而已。

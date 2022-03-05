
Docker中使用GDB调试 https://zhoubofsy.github.io/2019/09/24/linux/gdb-in-docker/
- > **方法一**
  * > 其实gdb调试容器内app也不难，只要做到两点就可以成功调试了。
    + > 1.你所使用的镜像里必须得有gdb工具，没有怎么调试啊。要么做镜像的时候将gdb安装进去，要么使你的gdb与被调试app的容器处于同一命名空间。
    + > 2.使用一些工具(`nsenter`)侵入到容器命名空间后再运行gdb调试。eg: `sudo nsenter -t {容器的PID} -m -p gdb -p {容器内被调试app的PID}`
- > **方法二**
  * > 方法二也需要在被调试的容器上先装有gdb，然后在启动容器的时候通过增加一些特权参数。待需要调试的时候直接登录到容器内就可以调试了。
    + > 1.在启动docker容器的时候需要增加`--privileged`参数
    + > 由于gdb调试需要的`SYS_PTRACE`属性被禁止掉了，所以在启动容器时候需要增加这个属性`--cap-add sys_ptrace`
    + > gdb调试时，需要关闭linux虚拟地址随机化（虚拟地址随机化是为了安全考虑而出现的，gdb调试只是暂时关闭）。关闭有两种方法，一是通过gdb的命令`set disable-randomization off`关闭。二是通过设置docker的参数`--security-opt seccomp=unconfined`。

Debug C/C++ Programs in Docker Container https://leimao.github.io/blog/Debug-CPP-In-Docker-Container/

如何在docker中进行gdb调试 https://www.jianshu.com/p/1c4476c3d0ee

Debugging C/C++ code in Docker containers with VisualGDB https://visualgdb.com/tutorials/linux/docker/

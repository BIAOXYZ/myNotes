
# 1

【[:star:][`*`]】 linux cgroups 简介 https://www.cnblogs.com/sparkdev/p/8296063.html  【from `sparkdev`】
- > cgroups(Control Groups) 是 linux 内核提供的一种机制，***这种机制可以根据需求把一系列`系统任务`及其`子任务`整合(或分隔)到按资源划分等级的不同`组`内***，从而为系统资源管理提供一个统一的框架。简单说，cgroups 可以限制、记录任务组所使用的物理资源。***本质上来说，cgroups 是内核附加在程序上的一系列钩子(hook)，通过程序运行时对资源的调度触发相应的钩子以达到资源追踪和限制的目的***。本文以 `Ubuntu 16.04` 系统为例介绍 cgroups，所有的 demo 均在该系统中演示。
- > **cgroups 工具**
  * > 在介绍通过 systemd 应用 cgroups 之前，我们先使用 `cgroup-bin` 工具包中的 `cgexec` 来演示 demo。Ubuntu 默认没有安装 `cgroup-bin` 工具包，请通过下面的命令安装：
    ```sh
    $ sudo apt install cgroup-bin
    ```
- > **demo：限制进程可用的 CPU**
  * > 在我们使用 cgroups 时，最好不要直接在各个子系统的根目录下直接修改其配置文件。***推荐的方式是为不同的需求在子系统树中定义不同的节点***。比如我们可以在 `/sys/fs/cgroup/cpu` 目录下新建一个名称为 nick_cpu 的目录：
    ```sh
    $ cd  /sys/fs/cgroup/cpu
    $ sudo mkdir nick_cpu
    ```
  * > 然后查看新建的目录下的内容：![](https://images2017.cnblogs.com/blog/952033/201801/952033-20180116130749521-392021135.png)
  * > 是不是有点吃惊，cgroups 的文件系统会在创建文件目录的时候自动创建这些配置文件！
    >> 【[:star:][`*`]】 //notes：注意这里有个文件的名字叫 `tasks`！我估计应该是可以通过往这个文件里写入进程号（线程怎么办？目前不知道）的方式来达到不使用 `cgexec` 也能限制的目的。

Cgroups控制系统资源的分配（cpu、mem、io） https://www.cnblogs.com/cuishuai/p/7815896.html
- > **5、cgroups限制io**
  * > 找到 `bklio`，及它的挂载目录。创建新的group，进行io限制。可以提前使用一个命令先占用系统io，仅限于测试：
    ```sh
    dd if=/dev/sda of=/dev/null &
    ```
  * > 使用 `iotop –o` 查看当前的 `DISK READ` 的值，可以看到是600多：![](https://images2017.cnblogs.com/blog/1200972/201711/1200972-20171110180835091-1758922579.png)
  * > 暂时设置这几个值就够用了，`10485760` 是字节数，即表示的是 `10M` 左右，根据自己的情况设置这个值。
    ```sh
    mkdir /sys/fs/cgroup/blkio/spark
    cd /sys/fs/cgroup/blkio/spark
    echo '8:0 10485760' > blkio.throttle.read_bps_device
    echo '8:0 10485760' > blkio.throttle.write_bps_device
    ```
  * > 最后将 `pid` 写入到spark目录下的 `tasks` 文件：
    ```sh
    echo 2735 > tasks
    ```
    >> 【[:star:][`*`]】 //notes：这一步很关键，上面那个文章虽然很好，但是是用 `cgexec` 来演示的。实际编程时候肯定不能用 `cgexec` 吧，所以我理解可以用这种方式（***把要限制的程序的 `pid` 记录到自己创建的资源组下面的 `tasks` 文件里***）。

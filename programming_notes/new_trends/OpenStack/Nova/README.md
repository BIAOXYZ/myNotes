
# 官方

OpenStack Compute (Nova). Mirror of code maintained at opendev.org. https://github.com/openstack/nova
- https://github.com/openstack/nova/tree/stable/stein

# 其他

【[:star:][`*`]】 OpenStack的Nova组件详解 https://www.cnblogs.com/mh20131118/p/12939358.html
- > **三：工作流程**
  * > ![](https://img2020.cnblogs.com/blog/1610676/202005/1610676-20200523191854485-507945733.png)

openstack中创建一个虚拟机经过的51步 https://blog.51cto.com/arkling/2329742
- > **一、前言**
  * > 本文在林海峰老师“openstack创建一个VM所需的29步”基础上进行了补充和修改，文中只用到了openstack六个核心组件，为了便于理解，架构中不同组件内的rabbit mq和db为同一个（可以为每个组件配置单独的db和rabbit mq）。openstack组件之间通过REST调用，组件内通过RPC协议通信，RPC协议又是基于AMQP模型实现的，rabbit mq就是运用该模型的一款软件。
- > **三、创建VM的过程详解**
  * > ![](http://s2.51cto.com/images/blog/201812/13/c6c5d91ef3233973e3f8c8baa9fe9948.png)

OpenStack Nova 总结（01）- 架构及组件详解 https://blog.csdn.net/dylloveyou/article/details/80698420

OpenStack —— 计算服务Nova(四) https://developer.aliyun.com/article/434203

【From 听雪落的光阴】：
- OpenStack入门之核心组件梳理（2）——Nova篇 https://blog.51cto.com/u_14557673/2476104
  * > **2.5 Nova-Conductor**
    + > Nova核心服务组件。Nova-Conductor 主要是为了使Nova-Compute服务与数据库（云数据库）之间进行交互。也就是说，有了Nova-Conductor，在实际运行中，消除了Nova-Compute服务对云数据库的直接访问，而是通过Nova-Conductor实现对数据库的访问。
    + > 此外，该组件支持水平扩展到多个节点上同时运行（Nova在水平扩展时采用的是Cell的部署方式），但是不能将之部署到运行Nova-Compute的计算节点上，否则无法实现Nova-Compute与数据库之间的隔离。
  * > **3.1 Nova逻辑架构图梳理**
    + > Hypervisor呢，是运行于物理服务器和操作系统之间的软件层，主要是调度客户机系统对共享的物理硬件资源的使用请求，是虚拟化的基础，也是云计算的核心基础。所以上述的Nova-Compute组件就是依赖于Hypervisor API的调用来实现实例的创建以及终止的。
    + > 而cell呢，该功能模块主要是为了解决大规模Nova计算节点部署过程中的集群瓶颈问题，该问题涉及到传统集群架构与云计算架构之间的区别了，有兴趣的朋友可以进行资料查阅。该问题就是共享消息队列系统的性能在大规模的计算节点部署集群（上百个，500个以上）大大降低。而有了Cell模块，就基具备支持OpenStack计算节点水平扩展和大规模部署的能力，本文重点并不再次，关于Cell的具体原理和实现的过程在这里就不做详细介绍了。
- OpenStack入门之核心组件梳理（5）——Neutron篇 https://blog.51cto.com/u_14557673/2477886

openstack学习笔记之五：nova简介与手动安装部署 https://blog.51cto.com/u_8355320/2492113

# live migration of an instance in Nova

live_migrate.png https://github.com/int32bit/openstack-workflow/blob/master/output/nova/live_migrate.png
- https://raw.githubusercontent.com/int32bit/openstack-workflow/master/output/nova/live_migrate.png

Live-migrate instances https://docs.openstack.org/nova/pike/admin/live-migration-usage.html
- > **Addressing migration timeouts¶**
  * > **Enable post-copy**
    + > This is a Libvirt feature. ***Libvirt detects that the migration does not progress and responds by activating the virtual machine on the destination host before all its memory has been copied***. Access to missing memory pages result in page faults that are satisfied from the source host.

Configure live migrations https://docs.openstack.org/nova/pike/admin/configuring-migrations.html || https://docs.openstack.org/nova/stein/admin/configuring-migrations.html  【为啥 p 版本比 s 版本的更新日期还晚。。。】
- > **Advanced configuration for KVM and QEMU¶**
  * > **1.Live migration completion timeout**
  * > **2.Live migration progress timeout**

Nova/Live Migration https://wiki.openstack.org/wiki/Nova/Live_Migration

Dive Into VM Live Migration -- OpenStack Liberty Summit 2015 https://01.org/sites/default/files/dive_into_vm_live_migration_2.pdf

Openstack Live migration, What? Why? How? https://stackbees.co/post/live-migration-openstack/
- > **Pre-migration**
- > **Reservation**
  * > Confirm the availability of resource in `compute-02`. Reserve the resouce for incoming guest `VM1`
- > **Iterative pre-copy**
  * > Memory is copied to `compute-02` from `compute-01`. After that dirtied pages are iteratively copied.
- > **Stop and Copy**
  * > Suspend the `VM1` and copying remaining pages. Finally the CPU state. ***The suspend state doesnt mean, virtual machine is DOWN***.
- > **Commitment**
  * > The `compute-02` will be the primary residence for `VM1`
- > Pitfalls
  * > Guest virtual machines with intensive memory consumption are hard to workload
  * > Live migration will generate a heavy load on the Network
  * > Memory overconsumption
  * > Different CPU architecture in destination host will interrupt the Live migration
  * > NOVA wont allow any operation on the Guest VM during Live migration
  * > But you can use `virsh` command in compute host to interact.
- > Futher reading
  * > Openstack - (Manually) migrating (KVM) Nova compute virtual machines https://raymii.org/s/articles/Openstack_-_(Manually)_migrating_(KVM)_Nova_Compute_Virtual_Machines.html

Migrate an OpenStack instance across compute nodes https://cloud.garr.it/support/kb/openstack/manual_VM_host_migration/

OpenStack实践(十一):Instance Live Migrate and Evacuate https://cloud.tencent.com/developer/article/1501292

本地存储条件下的热迁移 https://cloud.tencent.com/developer/article/1357918

基于OpenStack的虚拟机在线迁移 https://cloud.tencent.com/developer/article/2035202

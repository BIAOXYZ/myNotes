
# 官方

OpenStack Compute (Nova). Mirror of code maintained at opendev.org. https://github.com/openstack/nova
- https://github.com/openstack/nova/tree/stable/stein

# 其他

【[:star:][`*`]】 OpenStack的Nova组件详解 https://www.cnblogs.com/mh20131118/p/12939358.html

OpenStack Nova 总结（01）- 架构及组件详解 https://blog.csdn.net/dylloveyou/article/details/80698420

OpenStack —— 计算服务Nova(四) https://developer.aliyun.com/article/434203

# live migration of an instance in Nova

Live-migrate instances https://docs.openstack.org/nova/pike/admin/live-migration-usage.html

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

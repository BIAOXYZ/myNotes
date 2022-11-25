
# 1

【[:star:][`*`]】 并发扣款，如何保证一致性 https://www.51cto.com/article/720873.html || https://mp.weixin.qq.com/s/Mp1SH33BCabrsQrkHrTwow
- > **问题三：有什么常见的解决方案？**
  * > 对于此案例，同一个用户，并发扣款时，有小概率会出现异常，可以对每一个用户进行**分布式锁互斥**，例如：在redis/zk里抢到一个key才能继续操作，否则禁止操作。
  * > 这种**悲观锁**方案确实可行，但要引入额外的组件(redis/zk)，并且会降低吞吐量。
  * > **对于小概率的不一致，有没有乐观锁的方案呢？**
  * > 对并发扣款进行进一步的分析发现：
    + > （1）业务1写回时，旧余额100，这是一个**初始状态**；新余额28，这是一个**结束状态**。理论上只有在旧余额为100时，新余额才应该写回成功。而业务1并发写回时，旧余额确实是100，理应写回成功。
    + > （2）业务2写回时，旧余额100，这是一个**初始状态**；新余额38，这是一个**结束状态**。理论上只有在旧余额为100时，新余额才应该写回成功。可实际上，这个时候数据库中的金额已经变为28了，所以业务2的并发写回，不应该成功。
  * > **如何低成本实施乐观锁？**
    + > 在set写回的时候，加上初始状态的条件compare，只有初始状态不变时，才允许set写回成功，`Compare And Set（CAS）`，是一种常见的降低读写锁冲突，保证数据一致性的方法。
  * > **此时业务要怎么改？**
    + > 使用`CAS`解决高并发时数据一致性问题，***只需要在进行set操作时，compare初始值，如果初始值变换，不允许set成功***。
    + > 具体到这个case，只需要将：
      ```sql
      UPDATE t_yue SET money=$new_money WHERE uid=$uid;
      ```
    + > 升级为：
      ```sql
      UPDATE t_yue SET money=$new_money WHERE uid=$uid AND money=$old_money;
      ```
    + > 并发操作发生时：
    + > 业务1执行：
      ```sql
      UPDATE t_yue SET money=28 WHERE uid=$uid AND money=100;
      ```
    + > 业务2执行：
      ```sql
      UPDATE t_yue SET money=38 WHERE uid=$uid AND money=100;
      ```
    + > 这两个操作同时进行时，只可能有一个执行成功。
  * > **怎么判断哪个并发执行成功，哪个并发执行失败呢？**
    + > set操作，其实无所谓成功或者失败，业务能通过affect rows来判断：
      - > 写回成功的，affect rows为1；
      - > 写回失败的，affect rows为0；
    + > 高并发“查询并修改”的场景，可以用CAS（Compare and Set）的方式解决数据一致性问题。对应到业务，即在set的时候，加上初始条件的比对即可。优化不难，只改了半行SQL，但确实能解决问题。
- > **问题四：能不能使用直接扣减的方法**
  ```sql
  UPDATE t_yue SET money=money-$diff WHERE uid=$uid;
  ```
  * > 来进行余额扣减？明显不行，在并发情况下，会将money扣成负数。
- > **问题五：为了保证余额不被扣成负数，再加一个where条件：**
  ```sql
  UPDATE t_yue SET money=money-$diff WHERE uid=$uid AND money-$diff>0;
  ```
  * > 这样是否可行？很遗憾，仍然不行。这个方案不幂等。
  * > **那什么是幂等性？**​
    + > 聊幂等性之前，先看另一个测试用例的case。

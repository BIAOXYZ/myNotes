
# 源头
// 真正的源头当然也远早于这个，不过早就不可能回忆起来了。

`ExecStart=/usr/bin/kubelet KUBELETKUBECONFIGARGSKUBELET_CONFIG_ARGS KUBELETKUBEADMARGSKUBELET_EXTRA_ARGS (code=exited, status=255)` https://github.com/kubernetes/kubernetes/issues/83936
- > the kubelet logs e.g. using `journalctl -xeu kubelet` should provide more details about the failure.

# 相关命令

- `systemctl`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

linux journalctl 命令 https://www.cnblogs.com/sparkdev/p/8795141.html  【from `sparkdev`】
- > **匹配(match)**
  * > 我们可以通过 "FIELD=VALUE" 的格式来匹配具体的日志记录, 如：`_SYSTEMD_UNIT=cron.service`
    + > 日志信息的定义也类似一个实体类型，具体的信息被保存在各个对应的字段中，比如 `MESSAGE`、`MESSAGE_ID`、`_PID`、`_UID`、`_HOSTNAME`、`_SYSTEMD_UNIT` 等等(通过 man 7 `systemd.journal-fields` 可以查看所有可用的 match 字段)。因此可以通过这些字段的内容匹配相关的日志记录：![](https://images2018.cnblogs.com/blog/952033/201804/952033-20180411130309333-256541287.png)
    + > 上图中的输出是 cron.service 服务相关的日志记录。
  * > **可以同时添加多个字段进行匹配，它们之间是与的关系**，就是同时符合多个条件的记录才会被匹配，比如添加 `PRIORITY` 字段的匹配条件：
    ```sh
    $ journalctl _SYSTEMD_UNIT=cron.service PRIORITY=6
    ```
    + > 注意各个字段的取值，比如为 `PRIORITY` 设置 debug、info 是不工作的，必须设置为对应的数字。可以通过 `-F` 选项来查看某个字段的可选值：
    + > 具体的对应方式如下：
      ```console
      0: emerg
      1: alert
      2: crit
      3: err
      4: warning
      5: notice
      6: info
      7: debug
      ```
  * > **对同一个字段应用多个 match 条件的情况**，比如：

# 个人实战

```sh
[root@bandore1 ~]# journalctl -xeu kubelet
-- Unit kubelet.service has finished shutting down.
Apr 18 03:02:47 bandore1.fyre.ibm.com systemd[1]: Started kubelet: The Kubernetes Node Agent.
-- Subject: Unit kubelet.service has finished start-up
-- Defined-By: systemd
-- Support: http://lists.freedesktop.org/mailman/listinfo/systemd-devel
--
-- Unit kubelet.service has finished starting up.
--
-- The start-up result is done.
Apr 18 03:02:47 bandore1.fyre.ibm.com kubelet[10367]: F0418 03:02:47.584726   10367 server.go:199] failed to load Kubelet config file /var/lib/kubelet/con
Apr 18 03:02:47 bandore1.fyre.ibm.com systemd[1]: kubelet.service: main process exited, code=exited, status=255/n/a
Apr 18 03:02:47 bandore1.fyre.ibm.com systemd[1]: Unit kubelet.service entered failed state.
Apr 18 03:02:47 bandore1.fyre.ibm.com systemd[1]: kubelet.service failed.
Apr 18 03:02:57 bandore1.fyre.ibm.com systemd[1]: kubelet.service holdoff time over, scheduling restart.
Apr 18 03:02:57 bandore1.fyre.ibm.com systemd[1]: Stopped kubelet: The Kubernetes Node Agent.
-- Subject: Unit kubelet.service has finished shutting down
-- Defined-By: systemd
-- Support: http://lists.freedesktop.org/mailman/listinfo/systemd-devel
--
-- Unit kubelet.service has finished shutting down.
Apr 18 03:02:57 bandore1.fyre.ibm.com systemd[1]: Started kubelet: The Kubernetes Node Agent.
-- Subject: Unit kubelet.service has finished start-up
-- Defined-By: systemd
-- Support: http://lists.freedesktop.org/mailman/listinfo/systemd-devel
--
-- Unit kubelet.service has finished starting up.
--
-- The start-up result is done.
Apr 18 03:02:57 bandore1.fyre.ibm.com kubelet[10469]: F0418 03:02:57.816707   10469 server.go:199] failed to load Kubelet config file /var/lib/kubelet/con
Apr 18 03:02:57 bandore1.fyre.ibm.com systemd[1]: kubelet.service: main process exited, code=exited, status=255/n/a
Apr 18 03:02:57 bandore1.fyre.ibm.com systemd[1]: Unit kubelet.service entered failed state.
Apr 18 03:02:57 bandore1.fyre.ibm.com systemd[1]: kubelet.service failed.
lines 1445-1476/1476 (END)
[root@bandore1 ~]#
```

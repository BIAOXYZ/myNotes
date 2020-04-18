
# 源头
// 真正的源头当然也远早于这个，不过早就不可能回忆起来了。

ExecStart=/usr/bin/kubelet KUBELETKUBECONFIGARGSKUBELET_CONFIG_ARGS KUBELETKUBEADMARGSKUBELET_EXTRA_ARGS (code=exited, status=255) https://github.com/kubernetes/kubernetes/issues/83936
- > the kubelet logs e.g. using `journalctl -xeu kubelet` should provide more details about the failure.

# 相关命令

- `systemctl`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

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

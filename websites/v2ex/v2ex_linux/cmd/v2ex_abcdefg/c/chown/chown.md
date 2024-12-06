
闯了大祸,根目录权限变成我自己了。 https://www.v2ex.com/t/1095187
- > 进 rescue ，mount 后，把别的同版本 OS 的关键文件都 rsync 过去。
- > 记得我知乎看过一个热帖就是根目录权限被改掉了，好像挺难恢复的
- > 用你自己的用户把 sudo.conf 改成 root 不行？
- > 找个 liveCD 进去，把 docker tar 包放 home ，home 里面的文件应该是同一用户的，-R 直接改 owner 就行。 <br> 对于 docker 的配置，在 `/var/lib/docker/containers/*/config.v2.json` 可以拿到相关信息。 <br> 至于系统本身是没救了，尤其是 etc ，不同文件对应不同 owner 。
- > 其实还可以救。用 livecd 或者恢复环境进去，`chroot` 方式重新安装 sudo 以及 su 的包。这样保证你能进正常系统用 sudo 和 su ，其他有权限问题的可执行文件用这种方式解决。普通文件有 sudo 后改下权限就行了，就是有点麻烦。
- > https://metamug.com/article/networking/unable-to-access-sudoers-owned-by-uid-1000.html
- > 可以备份回滚 挺多 linux 发行版支持，比如 opensuse 的 snapper
- > `chown -R` 的威力如同 `rm -rf`
- > 先别重启，有个 `docker-autocompose` 应用，能把你正在跑的容器转成 docker-comopse.yml ，可以备份当前容器的各种配置，不过你的系统已经烂了，试试能不能把 autocompose 镜像拉下来，然后逐个备份容器生成 yml 文件
- > 找个虚拟机，备份一下权限，然后 livecd 进去恢复权限试试？
- > 一般系统提供的包管理软件，以 rpm 为例 <br> `--setperms` set permissions of files in a package <br> `--setugids` set user/group ownership of files in a <br> 这个是可以修复权限的，可以去试试
- > 还好只是 chown ，如果是 chmod -R 那就惨了得对着具体文件恢复，你这样找个正常的相同系统直接对着恢复就行。恢复必须要 liveCD 环境，随便找个闲置的存储设备插进去启动就行，另外 sudo 有问题不代表就不能用了，这只是一个软件包没有也能切到 root 。

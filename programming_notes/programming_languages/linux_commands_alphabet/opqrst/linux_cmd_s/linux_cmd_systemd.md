
Difference between systemd and terminal starting program https://unix.stackexchange.com/questions/339638/difference-between-systemd-and-terminal-starting-program

如何使用Systemctl来管理Systemd服务和单位 https://www.howtoing.com/how-to-use-systemctl-to-manage-systemd-services-and-units

systemctl 命令完全指南 https://linux.cn/article-5926-1.html

***阮一峰systemd教程***：
- Systemd 入门教程：命令篇 http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html
- Systemd 入门教程：实战篇 http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html

How To Use Systemctl to Manage Systemd Services and Units https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units
- > Masking and Unmasking Units
  * > We saw in the service management section how to stop or disable a service, but `systemd` also has the ability to mark a unit as completely unstartable, automatically or manually, by linking it to `/dev/null`. This is called masking the unit, and is possible with the mask command: `sudo systemctl mask nginx.service`


Difference between systemd and terminal starting program https://unix.stackexchange.com/questions/339638/difference-between-systemd-and-terminal-starting-program

如何使用Systemctl来管理Systemd服务和单位 https://www.howtoing.com/how-to-use-systemctl-to-manage-systemd-services-and-units
- > 另一种常见的滤波器是--type=过滤器。 我们可以告诉systemctl到我们感兴趣的类型只显示单元例如，只查看有效的服务单位，我们可以使用：`systemctl list-units --type=service`

systemctl 命令完全指南 https://linux.cn/article-5926-1.html

***阮一峰systemd教程***：
- Systemd 入门教程：命令篇 http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html
- Systemd 入门教程：实战篇 http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html

linux systemctl 命令 https://www.cnblogs.com/sparkdev/p/8472711.html 【by sparkdev】

How To Use Systemctl to Manage Systemd Services and Units https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units
- > Masking and Unmasking Units
  * > We saw in the service management section how to stop or disable a service, but `systemd` also has the ability to mark a unit as completely unstartable, automatically or manually, by linking it to `/dev/null`. This is called masking the unit, and is possible with the mask command: `sudo systemctl mask nginx.service`

运行 systemctl status 或 service status 后如何不等待输入 / 输出。 https://www.v2ex.com/t/659530
> --no-pager <br> Do not pipe output into a pager.

# systemd 视频

Linux Systemd完全入门 ｜ 一个视频搞懂systemd的使用 https://www.bilibili.com/video/BV1Tz4y1s7QW

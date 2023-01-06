
# 权威指南

Cron https://zh.wikipedia.org/wiki/Cron

# From thegeekstuff

Linux Crontab: 15 Awesome Cron Job Examples https://www.thegeekstuff.com/2009/06/15-practical-crontab-examples

How to Run Cron Every 5 Minutes, Seconds, Hours, Days, Months https://www.thegeekstuff.com/2011/07/cron-every-5-minutes/

# 其他文章

每天一个linux命令（50）：crontab命令 https://www.cnblogs.com/peida/archive/2013/01/08/2850483.html

`19. crontab 定时任务` https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/crontab.html  -->  【这个基本是从第一个copy过来的，但是因为排版好一点，再加上这本开源电子书别的地方还是有可取之处的，所以还是记一下。】

‘crontab’ in Linux with Examples https://www.geeksforgeeks.org/crontab-in-linux-with-examples/

linux定时任务的设置 crontab 配置指南 https://blog.csdn.net/xiyuan1999/article/details/8160998

linux crontab & 每隔10秒执行一次 https://www.cnblogs.com/juandx/archive/2015/11/24/4992465.html || https://www.cnblogs.com/aaronLinux/p/8918047.html
- > 很多时候，我们计划任务需要精确到秒来执行，根据以下方法，可以很容易地以秒执行任务。以下方法将**每10秒执行一次**
  ```sh
  # crontab -e
  * * * * * /bin/date >>/tmp/date.txt
  * * * * * sleep 10; /bin/date >>/tmp/date.txt
  * * * * * sleep 20; /bin/date >>/tmp/date.txt
  * * * * * sleep 30; /bin/date >>/tmp/date.txt
  * * * * * sleep 40; /bin/date >>/tmp/date.txt
  * * * * * sleep 50; /bin/date >>/tmp/date.txt
  ```
  >> //notes：核心就是一分钟内重复6次，从而达到每10秒一次的效果。

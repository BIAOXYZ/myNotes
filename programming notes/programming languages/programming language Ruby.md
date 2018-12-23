

# Jekyll

https://jekyllrb.com/


## Jekyll实战


Step by Step Tutorial https://jekyllrb.com/docs/step-by-step/01-setup/


- 谁占了我的端口 for Windows http://www.cnblogs.com/lxconan/archive/2016/01/11/who-is-using-my-port.html
- 对这个 jekyll 博客主题的改版和重构 https://643435675.github.io/2016/03/12/jekyll-theme-version-2.0/
> notes: 这两个第一个帖子时间上比较早，但是第二个帖子内容更全。比如，为了解决FxService服务占用本地4000端口的问题，需要把该服务关闭。第一个帖子没说怎么去关闭该服务，第二个帖子就很详细地说了怎么去关闭。不过从我笔记本的情况看，还是别去关这个服务了，即使关了，下次一打开FoxitReader，还是会打开该服务，福昕阅读器这点也是挺流氓的。此外还有两种方法，一是在配置文件_config.yml中添加端口号设置；二是启动jekyll服务的时候指定端口号。我用了最后一种，直接执行`jekyll serve --port 3000`最省事。

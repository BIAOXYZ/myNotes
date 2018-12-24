

# Jekyll

## Jekyll官网

- Transform your plain text into static websites and blogs. https://jekyllrb.com/
  * Step by Step Tutorial https://jekyllrb.com/docs/step-by-step/01-setup/
- 将纯文本转换为静态博客网站 http://jekyllcn.com/ 【其实这个应该不是官网的，但是翻译的很好，基本照官网来，除了内容没有即使更新以外。总之这上面的教程也很不错】

## Jekyll非官网教程

搭建一个免费的，无限流量的Blog----github Pages和Jekyll入门 http://www.ruanyifeng.com/blog/2012/08/blogging_with_jekyll.html

## Jekyll实战

> 总结：整个实战过程其实就是按照Jekyll官网的[`Step by Step Tutorial`](https://jekyllrb.com/docs/step-by-step/01-setup/)来的，这个教程写得挺好的，基本一步一步来就可以（当然还是有几个小问题，会在下面一一记述解决方案）。不过，有的步骤（比如Step 9）内容比较多，就commit了不止一次，但是保证每次commit都是一个能用的blog。


- 谁占了我的端口 for Windows http://www.cnblogs.com/lxconan/archive/2016/01/11/who-is-using-my-port.html
- 对这个 jekyll 博客主题的改版和重构 https://643435675.github.io/2016/03/12/jekyll-theme-version-2.0/
> notes: 这两个第一个帖子时间上比较早，但是第二个帖子内容更全。比如，为了解决FxService服务占用本地4000端口的问题，需要把该服务关闭。第一个帖子没说怎么去关闭该服务，第二个帖子就很详细地说了怎么去关闭。不过从我笔记本的情况看，还是别去关这个服务了，即使关了，下次一打开FoxitReader，还是会打开该服务，福昕阅读器这点也是挺流氓的。此外还有两种方法，一是在配置文件_config.yml中添加端口号设置；二是启动jekyll服务的时候指定端口号。我用了最后一种，直接执行`jekyll serve --port 3000`最省事。

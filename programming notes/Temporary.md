
About CRC:

http://blog.csdn.net/authorlcy/article/details/39941521

https://stackoverflow.com/questions/12428575/multiple-small-crc-checks-or-a-single-large-crc-check

<<PostgreSQL中current_user和current_user()的区别>>
http://blog.csdn.net/wanghai__/article/details/5516938


>:couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple:  :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple:  :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple:

http://www.cnblogs.com/gaojian/p/3164792.html

http://www.cnblogs.com/databaseaffair/p/6864070.html



https://www.cnblogs.com/biterror/p/7161631.html


http://blog.csdn.net/hunanchenxingyu/article/details/8101795

<<pthread的pthread_join()函数理解实验>>
http://blog.csdn.net/dinghqalex/article/details/42921931



<<基于 Raft 构建分布式系统 TiKV>>
https://toutiao.io/posts/17r5g9/preview

## git相关临时记录

关于git pull在branch1上往branch2拉代码的问题（测试版本为git 2.1.3）：
```
当前处于master分支: 
git pull remoterepo master:branch2 -- 除了把最新代码拉到branch2上，会把master也更新到最新。

当前处于branch1分支: 
git pull remoterepo master:branch2 -- 除了把最新代码拉到branch2上，会把branch1也更新到最新。

当前处于branch2分支: 
git pull remoterepo master:branch2 -- 只会把branch2更新到最新。
```

How to remove local (untracked) files from the current Git working tree?
https://stackoverflow.com/questions/61212/how-to-remove-local-untracked-files-from-the-current-git-working-tree
```
If untracked directory is a git repository of its own (e.g. submodule), you need to use -f twice:

git clean -d -f -f
```

《Git权威指南》GotGit 书稿开源
https://segmentfault.com/p/1210000008626219
>http://www.worldhello.net/gotgit/

猴子都能懂的GIT入门
https://backlog.com/git-tutorial/cn/contents/

Git 常用命令整理
http://justcoding.iteye.com/blog/1830388


- 猴子都能懂的GIT入门 -- 教程2 操作标签
https://backlog.com/git-tutorial/cn/stepup/stepup5_2.html
- 易百教程 -- git tag命令 
https://www.yiibai.com/git/git_tag.html

#### Gerrit

易百教程 -- Gerrit概述
https://www.yiibai.com/gerrit/gerrit_overview.html

[原创]CI持续集成系统环境---部署gerrit环境完整记录
https://www.cnblogs.com/kevingrace/p/5624122.html

Gerrit代码Review入门实战
http://geek.csdn.net/news/detail/85681

#### Jenkins

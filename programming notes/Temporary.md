
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


查看80端口被哪个程序占用
```
netstat -anp | grep 80
```

<<基于 Raft 构建分布式系统 TiKV>>
https://toutiao.io/posts/17r5g9/preview

关于git pull在branch1上往branch2拉代码的问题（测试版本为git 2.1.3）：
```
当前处于master分支: 
git pull remoterepo master:branch2 -- 除了把最新代码拉到branch2上，会把master也更新到最新。

当前处于branch1分支: 
git pull remoterepo master:branch2 -- 除了把最新代码拉到branch2上，会把branch1也更新到最新。

当前处于branch2分支: 
git pull remoterepo master:branch2 -- 只会把branch2更新到最新。
```

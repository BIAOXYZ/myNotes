


http://www.cnblogs.com/xiaojiang1025/p/5863984.html

http://www.cnblogs.com/TianFang/archive/2013/01/23/2872645.html

<<Linux Shell常用技巧(目录)>>
http://www.cnblogs.com/stephen-liu74/archive/2011/12/20/2285454.html

```
#!/bin/sh

while true;
        do
                ps -ef|grep postgres|grep -v grep|awk '{print$2}' | xargs kill -9
                if [ $? -eq 0 ] 
                then
                        exit
                fi  
        done
```
<< linux使用脚本杀死指定名称的进程 [问题点数：40分，结帖人mervyn807] >>
http://bbs.csdn.net/topics/360151075

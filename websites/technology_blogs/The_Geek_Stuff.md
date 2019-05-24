

# Linux related

## history

15 Linux Bash History Expansion Examples You Should Know https://www.thegeekstuff.com/2011/08/bash-history-expansion/
```
有些技巧就没必须要学了，比较复杂用处也不广而且易忘，这里只总结下常用好用的：
----------------------------------------------------------------------------------------------------
1. Execute a specific command from the history using !n

!4     //执行history命令显示的结果里序号为4的命令
!-2    //执行history命令显示的结果里序号为倒数第二的命令，所以 !-1 等于重复执行上一次执行过的命令
!!     //等于 !-1

"You can also press <Ctrl>-P (if you are in the default emacs mode) to get to the previous command."
----------------------------------------------------------------------------------------------------
2. Execute a command with keywords using !string and !?string

//执行之前以ps作为关键词**开头**的命令
$ !ps
ps -ef | grep http

//执行之前**包含**apache作为关键词的命令  -->  个人理解主要就是有时候是某个目录或者文件名比较特殊，所以这种方便找
$ !?apache
/usr/local/apache2/bin/apachectl restart
----------------------------------------------------------------------------------------------------
3. Replace a string from the previous command using ^str1^str2^

$ ls /etc/cron.daily/logrotate

$ ^ls^cat^
cat /etc/cron.daily/logrotate
----------------------------------------------------------------------------------------------------
4. Get the 1st argument of a command using :^

$ cp /etc/passwd /backup

$ ls -l !cp:^
ls -l /etc/passwd
----------------------------------------------------------------------------------------------------
5. Get the last argument of a command using :$

$ cp /etc/passwd /backup

$ ls -l !cp:$
ls -l /backup
----------------------------------------------------------------------------------------------------
```

15 Examples To Master Linux Command Line History https://www.thegeekstuff.com/2008/08/15-examples-to-master-linux-command-line-history/
```
1. Display timestamp using HISTTIMEFORMAT

# export HISTTIMEFORMAT='%F %T '
# history | more
1  2008-08-05 19:02:39 service network restart
2  2008-08-05 19:02:39 exit
3  2008-08-05 19:02:39 id
4  2008-08-05 19:02:39 cat /etc/redhat-release

```

## sed

Unix Sed Tutorial: Advanced Sed Substitution Examples https://www.thegeekstuff.com/2009/10/unix-sed-tutorial-advanced-sed-substitution-examples/

## yum

15 Linux Yum Command Examples – Install, Uninstall, Update Packages https://www.thegeekstuff.com/2011/08/yum-command-examples/

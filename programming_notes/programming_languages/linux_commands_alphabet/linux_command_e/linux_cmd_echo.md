

- 解决shell脚本中 echo 怎么写入换行到文件 https://blog.csdn.net/dcx1205/article/details/46855235
>> 问题起因：`echo {somecontent} >> {file}`形式向file写入内容时如何写空行进去？
```
测试环境：ubuntu12.04 LTS版本

echo >> file.txt即可，



这种方法对于脚本开头是bash和sh效果都一样，

而echo -e >> file.txt这种只适合与bash

对于sh，会输入-e到文件然后再换行。



而echo -e "\n" >> file.txt对于bash会连续换2行，

对于sh，会输入-e和一个新空行到文件。
```

```shell
个人实战（没管sh，就测了测bash就行了）：

root@cloudsec2:~$ echo step1 >> test.log
root@cloudsec2:~$ cat test.log
step1
root@cloudsec2:~$ echo >> test.log
root@cloudsec2:~$ cat test.log
step1

root@cloudsec2:~$ echo step2 >> test.log
root@cloudsec2:~$ cat test.log
step1

step2
root@cloudsec2:~$ echo -e >> test.log
root@cloudsec2:~$ cat test.log
step1

step2

root@cloudsec2:~$ echo step3 >> test.log
root@cloudsec2:~$ cat test.log
step1

step2

step3
root@cloudsec2:~$ echo -e "\n" >> test.log
root@cloudsec2:~$ cat test.log
step1

step2

step3


root@cloudsec2:~$ echo end >> test.log
root@cloudsec2:~$ cat test.log
step1

step2

step3


end
```

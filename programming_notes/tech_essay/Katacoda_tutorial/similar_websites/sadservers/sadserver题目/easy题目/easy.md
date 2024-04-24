
# 1 "Saint John": what is writing to this log file?
- Description: A developer created a testing program that is continuously writing to a log file /var/log/bad.log and filling up disk. You can check for example with tail -f /var/log/bad.log. This program is no longer needed. Find it and terminate it.
- 题目描述：***文件 `/var/log/bad.log` 在不停地被某个程序写入，找到写内容的程序并结束它***。

https://sadservers.com/newserver/saint-john
1. You can use ps to list all processes and see if you see something related, for example with: `ps auxf`. Ignore system processes [in brackets]. <br> A better way is to use the command to list open files: `lsof`.
2. Find the name (first column) and Process ID (PID, second column) of the process related to /var/log/bad.log by running lsof and filtering the rows to the one(s) containing bad.log. <br> You can also use the "fuser" command to quickly find the offending process: `fuser /var/log/bad.log`.
3. Run: ***`lsof | grep bad.log`*** and get the PID (second column). <br> With the PID of the process, it's not necessary but we can find its current working directory (program location) by doing `pwdx PID` or for more detail: `lsof -p PID` and check the cwd row. This will allow us to check its ownership and perhaps inspect its offending code if it's a script (not a binary). <br> (Open window once more to see the complete solution).
4. Solution: Using the PID found, terminate (kill) the process with `kill -9 PID`.

实战过程：
```sh
# 所以用 ps 再 grep 不太行，还是 lsof 好一些。
$ ps -auxf | grep bad.log
admin        824  0.0  0.1   5268   700 pts/1    S<+  14:22   0:00                  \_ grep bad.log
$
$ lsof | grep bad.log
badlog.py 586                    admin    3w      REG              259,1    33687 265802 /var/log/bad.log

# 上面得到进程 ID 后其实可以直接 kill 了，但是我们还是做得更好些。
$ lsof | grep bad.log | awk '{print}'
badlog.py 586                    admin    3w      REG              259,1    63248 265802 /var/log/bad.log
$ 
$ lsof | grep bad.log | awk '{print $2}'
586
$ 
$ lsof | grep bad.log | awk '{print $2}' | xargs
586
$ 

# 最终形成一行搞定的版本
$ lsof | grep bad.log | awk '{print $2}' | xargs kill -9
$ 
$ lsof | grep bad.log
$ 
```

# 2 "Saskatoon": counting IPs.
- Description: There's a web server access log file at /home/admin/access.log. The file consists of one line per HTTP request, with the requester's IP address at the beginning of each line. <br> Find what's the IP address that has the most requests in this file (there's no tie; the IP is unique). Write the solution into a file /home/admin/highestip.txt. For example, if your solution is "1.2.3.4", you can do echo "1.2.3.4" > /home/admin/highestip.txt
- 题目描述：***文件 `/home/admin/access.log` 是一些 http 请求的日志，这些日志的每一行都以 ip 地址开头；找到请求次数最多的 ip***。

https://sadservers.com/newserver/saskatoon
1. To get the first field (IP) of the file, you can do `awk '{print $1}' access.log` or ***using "cut" with delimiter of space (-d' ') and picking the first field (-f1): `cat access.log | cut -d' ' -f1`***. You may want to append a pipe | head or | tail as you construct the command to see how your filters are working.
2. After the previous step, you want to sort the IPs so they are together and can be counted: `cat access.log | awk '{print $1}' | sort`
3. Now you want to do the count with "uniq -c", so we have so far: `awk '{print $1}' access.log | sort | uniq -c`
4. Finally you want to sort the results with "sort" (goes in ascending order) and get the latest one (with "tail -1" for example), or sort in reverse order with "sort -r" and get the top result: `awk '{print $1}' access.log| sort | uniq -c | sort -r | head -1`.

实战过程：
```sh
admin@ip-172-31-27-155:/$ cat /home/admin/access.log | wc -l
10000
admin@ip-172-31-27-155:/$ 
admin@ip-172-31-27-155:/$ head -n 5 /home/admin/access.log 
83.149.9.216 - - [17/May/2015:10:05:03 +0000] "GET /presentations/logstash-monitorama-2013/images/kibana-search.png HTTP/1.1" 200 203023 "http://semicomplete.com/presentations/logstash-monitorama-2013/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36"
83.149.9.216 - - [17/May/2015:10:05:43 +0000] "GET /presentations/logstash-monitorama-2013/images/kibana-dashboard3.png HTTP/1.1" 200 171717 "http://semicomplete.com/presentations/logstash-monitorama-2013/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36"
83.149.9.216 - - [17/May/2015:10:05:47 +0000] "GET /presentations/logstash-monitorama-2013/plugin/highlight/highlight.js HTTP/1.1" 200 26185 "http://semicomplete.com/presentations/logstash-monitorama-2013/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36"
83.149.9.216 - - [17/May/2015:10:05:12 +0000] "GET /presentations/logstash-monitorama-2013/plugin/zoom-js/zoom.js HTTP/1.1" 200 7697 "http://semicomplete.com/presentations/logstash-monitorama-2013/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36"
83.149.9.216 - - [17/May/2015:10:05:07 +0000] "GET /presentations/logstash-monitorama-2013/plugin/notes/notes.js HTTP/1.1" 200 2892 "http://semicomplete.com/presentations/logstash-monitorama-2013/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36"
admin@ip-172-31-27-155:/$
admin@ip-172-31-27-155:/$ awk '{print $1}' /home/admin/access.log | head
83.149.9.216
83.149.9.216
83.149.9.216
83.149.9.216
83.149.9.216
83.149.9.216
83.149.9.216
83.149.9.216
83.149.9.216
83.149.9.216
admin@ip-172-31-27-155:/$
admin@ip-172-31-27-155:/$ awk '{print $1}' /home/admin/access.log | sort | uniq -c | sort -r | head -1
    482 66.249.73.135
admin@ip-172-31-27-155:/$ 

# 或者等价的： 
admin@ip-172-31-27-155:/$ awk '{print $1}' /home/admin/access.log | sort | uniq -c | sort | tail -1
    482 66.249.73.135
admin@ip-172-31-27-155:/$
```

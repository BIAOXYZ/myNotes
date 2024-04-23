
# 官方

SadServers https://github.com/fduran/sadservers

# Easy

## 1 "Saint John": what is writing to this log file?
【***文件 `/var/log/bad.log` 在不停地被某个程序写入，找到写内容的程序并结束它***。】

Scenario: "Saint John": what is writing to this log file? https://sadservers.com/newserver/saint-john
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
$ lsof | grep bad.log | awk '{print $2}' | xargs kill -9
$ 
$ lsof | grep bad.log
$ 
```

## 2 "Saskatoon": counting IPs.

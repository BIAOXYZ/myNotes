
# diff比较两个文件夹的不同

linux 比较两个文件夹不同 (diff命令, md5列表) https://www.cnblogs.com/xudong-bupt/p/6493903.html
```sh
比较文件夹diff，可以直接使用diff命令
[root@~]# diff -urNa dir1 dir2
　　-a Treat all files as text and compare them line-by-line, even if they do not seem to be text.
　　-N, --new-file
　　　　In directory comparison, if a file is found in only one directory, treat it as present but empty in the other directory.
　　-r When comparing directories, recursively compare any subdirectories found.

　　-u Use the unified output format.
 
 
比较文件夹diff，也可以比较文件MD5列表。下面命令可以获取文件夹中文件md5列表
find /home/ -type f -not \( -name '.*' \) -exec md5sum {} \;
说明：(1) /home/文件目录
　　  (2) -type f 文件类型为普通文件
　　  (3) -not \( -name '.*' \)  过滤掉隐藏文件。可以过滤掉不需要考虑的文件
     (4) -exec md5sum {} \;  对每个文件执行md5sum命令


用tar命令压缩后，比较文件的MD5是不行的。tar压缩会带上文件的时间
```

Linux下快速比较两个目录的不同 https://www.cnblogs.com/f-ck-need-u/p/9071033.html

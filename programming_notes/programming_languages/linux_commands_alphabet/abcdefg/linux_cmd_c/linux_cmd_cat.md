
cat 显示指定行 https://www.cnblogs.com/lelin/p/12833348.html
```console
【一】从第3000行开始，显示1000行。即显示3000~3999行
cat filename | tail -n +3000 | head -n 1000

【二】显示1000行到3000行
cat filename| head -n 3000 | tail -n +1000

*注意两种方法的顺序
分解：
    tail -n 1000：显示最后1000行
    tail -n +1000：从1000行开始显示，显示1000行以后的
    head -n 1000：显示前面1000行

【三】用sed命令
sed -n '5,10p' filename 这样你就可以只查看文件的第5行到第10行
```


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

**个人简单总结**：

| 命令               | 选项         | 含义                                 |
|--------------------|--------------|------------------------------------|
| `tail -n NUM`      | 不加 `+`     | 打印文件的最后 `NUM` 行               |
| `tail -n +NUM`     | 加 `+`       | （不打印文件的前 `NUM` 行）即：从第 `NUM` 行开始打印，直到文件末尾     |
| `head -n NUM`      | 不加 `-`     | 打印文件的前 `NUM` 行                 |
| `head -n -NUM`     | 加 `-`       | （不打印文件的后 `NUM` 行）即：打印文件的所有行，除了最后 `NUM` 行     |


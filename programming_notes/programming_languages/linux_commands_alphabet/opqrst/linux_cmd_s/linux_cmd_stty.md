
# 其他博客类链接

Fixing Terminal Settings with stty https://www.peachpit.com/articles/article.aspx?p=659655&seqNum=13

# 个人实战

## 实战1. vim打开文件时，不是全屏状态，只有屏幕的一小部分是 vim 的显示区域

```sh
# 找一个正常的终端看看行和列是怎么设置的
stty -a
# 回到显示错误的屏幕，设置行和列
stty rows 51 cols 197
```

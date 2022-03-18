
Comparison of database tools https://en.wikipedia.org/wiki/Comparison_of_database_tools

Navicat vs DataGrip vs TablePlus - Quick Comparison https://tableplus.com/blog/2018/10/navicat-vs-datagrip-vs-tableplus.html

Hue -- Hue is a mature open source SQL Assistant for querying any Databases & Data Warehouses and collaborating: https://github.com/cloudera/hue || https://gethue.com/

# DBeaver

DBeaver Community https://dbeaver.io/

Download https://dbeaver.io/download/
- > Mac OS X
  * > Brew Cask (`brew install --cask dbeaver-community`)

## DBeaver快捷键

DBeaver笔记-快捷键篇 https://blog.csdn.net/lewky_liu/article/details/79797169
```console
ctrl + enter 执行sql
ctrl + alt + ↑ 向上复制一行
ctrl + alt + ↓ 向下复制一行
ctrl + shift + ↑ 向上移动一行
ctrl + shift + ↓ 向下移动一行
ctrl + alt + F 对sql语句进行格式化，对于很长的sql语句很有用
ctrl + d 删除当前行
alt + ↑ 向上选定一条sql语句
alt + ↓ 向下选定一条sql语句
ctrl + / 行注释
ctrl + shift+ / 块注释
ctrl + f 查找、替换
ctrl + space sql提示(如果写了from table后也会自动提示field)
ctrl + shift + E 执行计划
ctrl + shift + U 将选定的sql转换成大写字母
ctrl + shift + L 将选定的sql转换成小写字母
```
- > 小技巧
  * > 有一些快捷键在使用时，只需要将光标移动到某一条sql语句上就行，不需要选定整条完整的语句。
  * > 有一些快捷键使用时是默认对当前一整个 Script 页面生效，可以通过光标来选定只想生效的范围。
  * > 双击sql语句里的括号边缘，可以直接选定括号内的内容(不包括该括号)，这个功能很方便。
  * > 单引号/双引号的内侧可以直接选定被单引号/双引号包括起来的内容。

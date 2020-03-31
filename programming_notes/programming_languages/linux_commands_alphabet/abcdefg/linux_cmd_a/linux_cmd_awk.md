
awk 入门教程 http://www.ruanyifeng.com/blog/2018/11/awk.html

使用awk和grep做简单的统计 https://www.cnblogs.com/softidea/p/5562355.html
- > awk工作流程是这样的：读入有'\n'换行符分割的一条记录，然后将记录按指定的域分隔符划分域，填充域，$0则表示所有域,$1表示第一个域,$n表示第n个域。默认域分隔符是"空白键" 或 "[tab]键",所以$1表示登录用户，$3表示登录用户ip,以此类推。

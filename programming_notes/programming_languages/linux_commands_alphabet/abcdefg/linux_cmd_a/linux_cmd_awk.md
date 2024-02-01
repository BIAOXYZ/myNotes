
awk 入门教程 http://www.ruanyifeng.com/blog/2018/11/awk.html

使用awk和grep做简单的统计 https://www.cnblogs.com/softidea/p/5562355.html
- > awk是一个强大的文本分析工具，相对于grep的查找，sed的编辑，awk在其对数据分析并生成报告时，显得尤为强大。简单来说awk就是把文件逐行的读入，以空格为默认分隔符将每行切片，切开的部分再进行各种分析处理。
<br> awk有3个不同版本: awk、nawk和gawk，未作特别说明，一般指gawk，gawk 是 AWK 的 GNU 版本。
<br> awk其名称得自于它的创始人 Alfred Aho 、Peter Weinberger 和 Brian Kernighan 姓氏的首个字母。实际上 AWK 的确拥有自己的语言： AWK 程序设计语言 ， 三位创建者已将它正式定义为“样式扫描和处理语言”。它允许您创建简短的程序，这些程序读取输入文件、为数据排序、处理数据、对输入执行计算以及生成报表，还有无数其他的功能。
- > `awk工作流程是这样的：读入有'\n'换行符分割的一条记录，然后将记录按指定的域分隔符划分域，填充域，$0则表示所有域,$1表示第一个域,$n表示第n个域。默认域分隔符是"空白键" 或 "[tab]键",所以$1表示登录用户，$3表示登录用户ip,以此类推。`

# awk具体例子

## 合并一个目录下多个csv文件，只保留一个的header

Unix:merge multiple CSV files with same header by keeping the header of the first file Unix:merge multiple CSV files with same header by keeping the header of the first file
- https://stackoverflow.com/questions/16890582/unixmerge-multiple-csv-files-with-same-header-by-keeping-the-header-of-the-firs/16890695#16890695
  * > `awk 'FNR==1 && NR!=1{next;}{print}' *.csv`

Merging Multiple CSV Files without merging the header https://apple.stackexchange.com/questions/80611/merging-multiple-csv-files-without-merging-the-header

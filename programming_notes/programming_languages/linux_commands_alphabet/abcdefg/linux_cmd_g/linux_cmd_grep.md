
Linux: grep多个关键字“与”和“或” https://blog.csdn.net/mmbbz/article/details/51035401
```shell
1、或操作

grep -E '123|abc' filename  // 找出文件（filename）中包含123或者包含abc的行
egrep '123|abc' filename    // 用egrep同样可以实现
awk '/123|abc/' filename   // awk 的实现方式

2、与操作

grep pattern1 files | grep pattern2 //显示既匹配 pattern1 又匹配 pattern2 的行。

3、其他操作

grep -i pattern files   //不区分大小写地搜索。默认情况区分大小写，
grep -l pattern files   //只列出匹配的文件名，
grep -L pattern files   //列出不匹配的文件名，
grep -w pattern files  //只匹配整个单词，而不是字符串的一部分（如匹配‘magic’，而不是‘magical’），
grep -C number pattern files //匹配的上下文分别显示[number]行，
```

```sh
// 个人实战了下，通过管道后的grep多个关键词也是可以的。

// 准备阶段：含有cmd的文件有84个；含有printing的文件有2个
root@myopenshift:operator-sdk$ git ls-files | grep cmd | wc -l
84
root@myopenshift:operator-sdk$ git ls-files | grep printing | wc -l
2

// 三种求“或”（并集）的方式
root@myopenshift:operator-sdk$ git ls-files | grep -E 'cmd|printing' | wc -l
85
root@myopenshift:operator-sdk$ git ls-files | egrep 'cmd|printing' | wc -l
85
root@myopenshift:operator-sdk$ git ls-files | awk '/cmd|printing/' | wc -l
85

// 求“与”（交集）的方式
root@myopenshift:operator-sdk$ git ls-files | grep cmd | grep printing | wc -l
1
```

grep命令:匹配多个单词 https://www.jianshu.com/p/747c97f4b4ac

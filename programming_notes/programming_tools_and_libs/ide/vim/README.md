----------------------------------------------------------------------------------------------------
# 0.vim commands cheatsheet:
----------------------------------------------------------------------------------------------------

## 执行类命令总结

```
//TODO
```

## 速查表参考文献

Vim cheatsheet https://devhints.io/vim

史上最全的Vim命令 - HChan的文章 - 知乎 https://zhuanlan.zhihu.com/p/51440836
- > 好像我做这个比你的更丰富点。 https://github.com/skywind3000/awesome-cheatsheets/blob/master/editors/vim.txt
- > 恕我直言写这些二手文档没意义，你自己总结还可以，放出来给别人看就不对了。这才是史上最全的Vim命令，官方的，中文的。 https://github.com/yianwillis/vimcdoc/releases

2021 年了，你还在用 Vim 吗（一份 vim 导航快捷键） https://www.v2ex.com/t/741463
- > 原图来自这里： https://quickref.me/vim

----------------------------------------------------------------------------------------------------
# 1.general vim commands part:
----------------------------------------------------------------------------------------------------

## vim一般性命令

### vim设置和取消显示行号
```
:set nu  
:set nonu
```

```
最好的办法是直接修改/etc/vimrc文件，在末尾添加
set nu
```
>> 该文件也可能位于`/etc/vim/vimrc`，如果没网又没vim，那么vi的配置文件和vim的就在一个位置，名字叫`virc`；如果只想改某个用户的vim配置，可以修改（如果不存在自己先建一个）该用户目录下的`.vimrc`（即`~/.vimrc`文件）。

### 其他设置类

<<vim 常用命令>> http://blog.chinaunix.net/uid-20769502-id-112737.html
```
:set hlsearch 高亮显示搜索结果 (自己试了下取消高亮显示搜索果然是 :set nohlsearch )
```

在vim中取消搜索的高亮 https://blog.csdn.net/k7arm/article/details/77370181
- > 使用vim的高亮搜索功能之后，如果不取消的话，代码中就会有像补丁一样的一块一块的高亮。之前用的方法很土，就是找一个再重新搜索一个很少用到的字符，万一不幸，在源码中存在的话，那就换下一个，这样一直换下去。后来觉得这样不行，太low了，网上搜了一下，很简单，在命令状态下直接输入：
  ```console
  :noh
  ```
- > 瞬间清净了。

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

### vim显示当前正在编辑的文件名和路径
```
:f 或 ctrl+G
```

```
:args 只显示文件名不显示路径
```

### 替换和撤销(Undo)命令

```
r+<待替换字母>	将游标所在字母替换为指定字母
R	连续替换，直到按下Esc
cc	替换整行，即删除游标所在行，并进入插入模式
cw	替换一个单词，即删除一个单词，并进入插入模式
C(大写)	替换游标以后至行末
~	反转游标所在字母大小写
u{n}	撤销一次或n次操作
U(大写)	撤销当前行的所有修改
Ctrl+r	redo，即撤销undo的操作
```
> R 大写R会直接进入REPLACE模式，然后可以方便连续替换

:couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple:  :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple:  :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple:


## vim移动命令

### vim跳转到文件头和文件尾
```
:1 或 gg 或者 1gg
:$ 或 G 或 shift + g

此外，ctrl + o 可以快速返回跳转前光标所在位置（行级别的跳转）

h	左
l	右（小写L）
j	下
k	上
```

### vim行内跳转
```
w	到下一个单词的开头
e	到当前单词的结尾
b	到前一个单词的开头
ge	到前一个单词的结尾
0或^	到行头
$	到行尾

f<字母>	向后搜索<字母>并跳转到第一个匹配的位置(非常实用)
F<字母>	向前搜索<字母>并跳转到第一个匹配的位置
t<字母>	向后搜索<字母>并跳转到第一个匹配位置之前的一个字母(不常用)
T<字母>	向前搜索<字母>并跳转到第一个匹配位置之后的一个字母(不常用)
```

【[:star:][`*`]】 Vim基础篇——快速移动 - 张翼腾的文章 - 知乎 https://zhuanlan.zhihu.com/p/30132173
```console
<Ctrl-b> 向下移动一个屏幕
<Ctrl-f> 向上移动一个屏幕
<Ctrl-u> 向下移动半个屏幕
<Ctrl-d> 向上移动半个屏幕
```

:couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple:  :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple:  :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple:

## vim编辑命令

```console
:e <文件路径> 打开该文件

i	在当前光标处进行编辑
I	在行首插入
A	在行末插入
a	在光标后插入编辑
o	在当前行后插入一个新行
O	在当前行前插入一个新行
cw	替换从光标所在位置后到一个单词结尾的字符
```

```console
:q!	强制退出，不保存
:q	退出
:wq!	强制保存并退出
:w <文件路径>	另存为
:saveas 文件路径	另存为
:x	保存并退出
:wq	保存并退出
```
> **`shift + zz` 普通模式下输入Shift+zz即可保存退出vim，等价于ZZ**
>> **`shift + zz`或者(大写的)`ZZ`是“保存并退出当前文件”的意思说白了等于`:wq`。后来在想那不保存退出（也就是`:q`或`:q!`）呢？但是好像找过没找到，今天终于偶然间看到了————不保存并强制退出的快捷键为`shift + zq`或者(大写的)`ZQ`。**
>>> Vim 实用技术，第 1 部分 实用技巧 https://www.ibm.com/developerworks/cn/linux/l-tip-vim1/index.html

```console
x	删除游标所在的字符
X	删除游标所在前一个字符
Delete	同x
dd	删除整行
dw	删除一个单词（不适用中文）
d$或D	删除至行尾
d^	删除至行首
dG	删除到文档结尾处
d1G	删至文档首部
```
> 2dd 删除两行
> d3w 删除三个单词

轻快的VIM（三）：删除 https://www.cnblogs.com/cmt/p/14553189.html
```console
dw            删除到下一个单词开头
de            删除到本单词末尾
dE            删除到本单词末尾包括标点在内
db            删除到前一个单词
dB            删除到前一个单词包括标点在内
```

### 复制及粘贴文本
```
普通模式中使用y复制

普通模式中，yy复制游标所在的整行（3yy表示复制3行）
普通模式中，y^ 复制至行首，或y0。不含光标所在处字符。
普通模式中，y$ 复制至行尾。含光标所在处字符。
普通模式中，yw 复制一个单词。
普通模式中，y2w 复制两个单词。
普通模式中，yG 复制至文本末。
普通模式中，y1G 复制至文本开头。
普通模式中使用p粘贴

普通模式中，p(小写)代表粘贴至光标后（下）
普通模式中，P(大写)代表粘贴至光标前（上）
```
> ddp 实现了快速交换光标所在行与它下面的行


## vim查找和替换

```
:1,$s/old/new/g 
将文件中所有的『old』改成『new』。
```

## vim格式化代码

【[:star:][`*`]】 如何在vim中快速格式化这个代码？ https://segmentfault.com/q/1010000007842413
```console
gg
vG
=
```

VIM-代码格式化快捷键 https://blog.csdn.net/Xminyang/article/details/80710636
```console
gg 				#当前光标跳转到首行
Shift + v 		#转为可视模式
Shift + g 		#选中整个文件内容
=				#格式化
```

----------------------------------------------------------------------------------------------------
# 2.other vim commands part:
----------------------------------------------------------------------------------------------------

<<vim常用命令总结>>
http://www.cnblogs.com/Nice-Boy/p/6124177.html

Practical Vim https://book.douban.com/subject/10599776/
- https://the-eye.eu/public/Books/IT%20Various/practical_vim.pdf

简明 VIM 练级攻略 https://coolshell.cn/articles/5426.html

笨方法学vim中英版：
- Learn Vimscript the Hard Way http://learnvimscriptthehardway.stevelosh.com/
- 笨方法学Vimscript http://learnvimscriptthehardway.onefloweroneworld.com/

----------------------------------------------------------------------------------------------------
# 3.vim多窗口操作:
----------------------------------------------------------------------------------------------------

## vimdiff

```
:qa  Close all files //用vimdiff对比两次git的commit时非常有效，一次同时退出左右两个文件。可以参考`git difftool -t vimdiff -y HEAD HEAD~`那里。
```

# 其他

Vim Games – Games You Can Play with the Vim Editor https://linuxhint.com/vim_editor_games/
- Vim Adventures
  * https://vim-adventures.com/

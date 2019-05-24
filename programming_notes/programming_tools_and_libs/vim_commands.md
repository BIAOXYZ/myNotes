----------------------------------------------------------------------------------------------------
# 1.general vim commands part:
----------------------------------------------------------------------------------------------------

## vim一般性命令

### 设置类命令

>> 个人设置总结，方便复制：
```
set nu
syntax on
set cursorline
set showmatch
set hlsearch

"1.原来用的是set mouse=a。后来发现在某些机器上会提示E538: No mouse support: mouse=a。搜索了下发现用带if的形式比较好。
"2.本来注释掉这句用的是#set mouse=a，结果报错E488: Trailing characters: #set mouse=a。又搜索了下才知道
"  原来vimrc里的注释不是#号，而是一个双引号开头后面写内容。不知道支不支持换行，反正不管了。 
"set mouse=a   
if has('mouse')
  set mouse=a
endif
```

#### vim设置和取消显示行号
```
:set nu  
:set nonu
```

```
最好的办法是直接修改/etc/vimrc文件，在末尾添加
set nu
```
>> 该文件也可能位于`/etc/vim/vimrc`，如果没网又没vim，那么vi的配置文件和vim的就在一个位置，名字叫`virc`；如果只想改某个用户的vim配置，可以修改（如果不存在自己先建一个）该用户目录下的`.vimrc`（即`~/.vimrc`文件）。

#### 其他设置类

<<vim 常用命令>>
http://blog.chinaunix.net/uid-20769502-id-112737.html
```
:set hlsearch 高亮显示搜索结果 (自己试了下取消高亮显示搜索果然是 :set nohlsearch )
```

Vim 配置入门 http://www.ruanyifeng.com/blog/2018/09/vimrc.html
```
syntax on 打开语法高亮

```

我的vim配置（带注释） https://blog.csdn.net/dongtingzhizi/article/details/8472093

use vim as IDE https://github.com/yangyangwithgnu/use_vim_as_ide

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
R 大写R会直接进入REPLACE模式，然后可以方便连续替换

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

:couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple:  :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple:  :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple: :couple:

## vim编辑命令

```
:e <文件路径> 打开该文件

i	在当前光标处进行编辑
I	在行首插入
A	在行末插入
a	在光标后插入编辑
o	在当前行后插入一个新行
O	在当前行前插入一个新行
cw	替换从光标所在位置后到一个单词结尾的字符
```

```
:q!	强制退出，不保存
:q	退出
:wq!	强制保存并退出
:w <文件路径>	另存为
:saveas 文件路径	另存为
:x	保存并退出
:wq	保存并退出
```
**shift + zz 普通模式下输入Shift+zz即可保存退出vim，等价于ZZ**

```
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
2dd 删除两行
d3w 删除三个单词


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
ddp 实现了快速交换光标所在行与它下面的行


## vim查找和替换

```
:1,$s/old/new/g 
将文件中所有的『old』改成『new』。
```

----------------------------------------------------------------------------------------------------
# 2.other vim commands part:
----------------------------------------------------------------------------------------------------

<<vim常用命令总结>>
http://www.cnblogs.com/Nice-Boy/p/6124177.html

## Vim配置

有哪些编程必备的 Vim 配置？ - 知乎
https://www.zhihu.com/question/19989337


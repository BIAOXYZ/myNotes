
# my config

>> //notes：个人设置总结，方便复制。ps：Vim 的全局配置一般在`/etc/vim/vimrc`或者`/etc/vimrc`，对所有用户生效。用户个人的配置在`~/.vimrc`。
```vim
"""""""""" MY personal config
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
```
补充：
1. 设置了 set mouse=a 的话用 ctrl+v 复制时总是进入visual模式，网上有几种办法，但是对我适用的只有手动先禁用一下，即：
   :set mouse-=a
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# vim临时配置（需要的时候用一下，然后切回去）

Liunx vim 粘贴代码出现换行混乱的情况 https://juejin.cn/post/7133822973592469541
- > 原因
  * > 终端处理粘贴的文本时，会存入键盘缓存 (Keyboard Buffer)。Vim 处理时，会把这些内容作为用户键盘输入来处理。所以如果 Vim 开启了自动缩进，那么在遇到换行符时，就会默认把上一行的缩进插入到下一行的开头。
- > 解决
  * > ***Vim 编辑模式中有一个 `Paste` 模式，在该模式下，可将文本保持原样粘贴到 Vim 中***。在 Vim 中键入命令：
    ```sh
    :set paste
    # 取消 粘贴模式
    :set nopaste
    ```
  * > 在粘贴模式下进行粘贴，就不会遇到缩进混乱的问题了。***其中 `paste` 模式主要帮我们做了如下事情***：
    ```sh
    wrapmargin 设置为0
    set noai
    set nosi
    softtabstop 设置为0
    revins 重置
    ruler 重置
    showmatch 重置
    formatoptions 使用空值
    ```

vim粘贴代码的时候取消自动缩进 https://blog.csdn.net/tiandidishitian/article/details/104788642
- > ~~方法一~~  -->  【[:star:][`*`]】 ***notes：用方法二就好，更方便，不需要用方法一！***
  * > 按 `Esc` 退出插入模式，按 `:` 进入命令模式，
    ```sh
    set nosmartindent
    set noautoindent
    然后回到插入模式，直接粘贴就可以。
    ```
  * > 粘贴完再设置回去就可以。粘贴完按 `Esc` 然后按 `:` 进入命令模式
    ```sh
    set smartindent
    set autoindent
    ```
    > 或者使用缩写
    ```sh
    set si
    set ai
    ```
- > 方法二
  * > 进入命令模式，也就是按 `:` 以后
    ```sh
    set paste
    ```
  * > 回车后就进入粘贴模式，此时再进入插入模式粘贴就不会自动缩进，在粘贴完以后一定记得退出粘贴模式
    ```sh
    set paste!  或  set nopaste
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 开箱即用vim配置

The ultimate Vim configuration (vimrc) https://github.com/amix/vimrc
- https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim

搭建基于 Vim 的 C++和 Python 开发环境[持续更新] https://juejin.cn/post/6844903844736925703
- > 我的 `.vimrc` 参考： https://github.com/cposture/my-vim

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# old

## Vim配置

有哪些编程必备的 Vim 配置？ - 知乎 https://www.zhihu.com/question/19989337

## 将vim打造成IDE

~~如何在 Linux 上使用 Vundle 管理 Vim 插件 https://linux.cn/article-9416-1.html~~  【//notes：Vundle可能已经过时了】

use vim as IDE https://github.com/yangyangwithgnu/use_vim_as_ide

我的vim配置（带注释） https://blog.csdn.net/dongtingzhizi/article/details/8472093

vi/vim使用进阶: 目录 https://blog.easwy.com/archives/advanced-vim-skills-catalog/

## Vim定制版

Vim 配置入门 http://www.ruanyifeng.com/blog/2018/09/vimrc.html
- 回复：
  * > 可以用现成的吖， https://github.com/amix/vimrc
    + > **The Basic**: If you want something small just copy [basic.vim](https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim) into your `~/.vimrc` and you will have a good basic setup

【B站的vim-vide】Lightest vimrc, while strong enough. 最轻的vim配置，却足够强！ https://github.com/bilibili/vim-vide

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

如何在 Linux 下利用 Vim 搭建 C/C++ 开发环境? - 知乎 https://www.zhihu.com/question/47691414
- 如何在 Linux 下利用 Vim 搭建 C/C++ 开发环境? - 韦易笑的回答 - 知乎 https://www.zhihu.com/question/47691414/answer/373700711
  * 《Vim 中文版入门到精通》 https://github.com/wsdjeg/vim-galore-zh_cn
  * 《Vim 中文速查表》 https://github.com/skywind3000/awesome-cheatsheets/blob/master/editors/vim.txt

2020年vim的C/C++配置 https://www.jianshu.com/p/249850f2cc64

2022 年 vim 的 C/C++ 配置 https://martins3.github.io/My-Linux-Config/docs/nvim.html
- > **入门 vim**
  * > 其实关于 vim 的基本知识教程有很多，这里我推荐两个网站
    + > [openvim](https://www.openvim.com/tutorial.html): 交互式的学习 vim
    + > [vim check sheet](https://vim.rtorr.com/lang/zh_cn): vim 常用快捷键清单

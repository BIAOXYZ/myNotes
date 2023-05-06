
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

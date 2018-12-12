
# Latex服务

TeXample.net http://www.texample.net/tikz/
- Example: A Venn diagram with PDF blending http://www.texample.net/tikz/examples/venn/

## Latex Online Service

Compiling documents online https://tex.stackexchange.com/questions/3/compiling-documents-online

LaTeX.Online https://latexonline.cc/
> https://github.com/aslushnikov/latex-online

Online Latex Editor (TeX Live 2016) https://www.tutorialspoint.com/online_latex_editor.php

# Latex攻略集合

- TeX/LaTeX Resources http://texblog.org/tex-resources/
- awesome-LaTeX https://github.com/egeerardyn/awesome-LaTeX
- LaTeXStudio https://github.com/latexstudio
  - 常用宏包说明的中文本地化项目 https://github.com/latexstudio/LaTeXPackages-CN
  - 给大家普及本已普及了的LaTeX知识。 https://github.com/latexstudio/LaTeX-TeXWiki 
  
## Latex个人博客

yhl_leo https://blog.csdn.net/yhl_leo/article/category/5798949

# Latex基本类

## list, itemize, enumerate, description

http://troubleshooters.com/linux/lyx/ownlists.htm

```latex
当后三个环境定制效果不太理想时，用最基本的list环境。list环境里这两个变量比较有用。
\setlength\labelwidth{3in}
\setlength\leftmargin{1.27in}
```

# Latex数学公式

https://en.wikibooks.org/wiki/LaTeX/Mathematics

## \newenvironment(\renewenvironment) \newcommand(\renewcommand)

https://www.overleaf.com/learn/latex/Defining_your_own_commands
- https://www.overleaf.com/learn/latex/Commands
- https://www.overleaf.com/learn/latex/Environments
- https://www.overleaf.com/learn/latex/Theorems_and_proofs

# Latex宏包类

## latex使用中文的宏包或解决方案

***总结：1，2是旧方法，3，4是新方法。排版效果 3>4>2>1; 方便程度 1>2>4>3。
(原因：3，4得换成XeLaTeX，经常会出你这儿环境可以到别人那不行了。而且应该是在哪看过，XeLaTeX对某些图片格式支持不太好。所以总体来说用后两者有一定风险。)***

- 1.只需要在导言区加上宏包`\usepackage{ctex}`
> 我的 beamer 幻灯片模板 http://bbs.ctex.org/forum.php?mod=viewthread&tid=27695
- 2.导言区加宏包`\usepackage{CJKutf8}`，正文部分：
```
\begin{document}
\begin{CJK}{UTF8}{gkai}
...
\end{CJK}
\end{document}

注: 或者各种参数不同但类似的版本，比如：
导言区加\usepackage{CJK}，然后正文部分：

\begin{document}
\begin{CJK*}{GBK}{kai}
...
\end{CJK*}
\end{document}
```
- 3.文章类型要换成`\documentclass[UTF8]{ctexart}`，然后以 UTF-8 编码保存，使用 XeLaTeX 编译。
> 一份其实很短的 LaTeX 入门文档 https://liam0205.me/2014/09/08/latex-introduction/
- 4.(文章类型不用换)只需要在导言区加上宏包`\usepackage{xeCJK}`，但是依然必须使用 XeLaTeX 编译。
> Chinese https://www.overleaf.com/learn/latex/Chinese


## Tikz宏包

Latex--TikZ和PGF--高级文本绘图，思维绘图，想到--得到！ http://www.cnblogs.com/tsingke/p/6649800.html

### Latex批注功能

<<使用 TikZ 对 LaTeX 文档添加批注>>
http://bbs.ctex.org/forum.php?mod=viewthread&tid=40633

注意：作者的代码似乎有些问题，应该再往下翻会提到一些修改，目前我实验的成功的代码是这样的(注意注释，还需要CJK宏包应该应该用GBK编码--可能是因为要用中文的原因，如果英文或许不用GBK--但是既然要写注释，一般不用英文了)。此外后面还提到了CTAN的todonotes宏包( https://www.ctan.org/pkg/todonotes )，功能更强大，但是我还没有去试。

```
%- for comments -% 
% it also requires CJK macro package and should be used between \begin{CJK*}{GBK}{song} \end{CJK*}
\usepackage{bm,tikz}
\newcommand{\annmark}[1]{%
    \textcolor{red}{$\bm\langle$#1$\bm\rangle$}%
}%
\newcommand{\ann}[1]{%
    \begin{tikzpicture}[remember picture, baseline=-0.75ex]%
        \node[coordinate] (inText) {};%
    \end{tikzpicture}%
    \marginpar{%
        \renewcommand{\baselinestretch}{1.0}%
        \begin{tikzpicture}[remember picture]%
            \definecolor{orange}{rgb}{1,0.5,0}%
            \draw node[fill=red!20,rounded corners,text width=\marginparwidth] (inNote){\footnotesize#1};%
    \end{tikzpicture}%
    }%
    \begin{tikzpicture}[remember picture, overlay]%
        \draw[draw = orange, thick]
            ([yshift=-0.2cm] inText)
                -| ([xshift=-0.2cm] inNote.west)
                -| (inNote.west);%
    \end{tikzpicture}%
}%
```

<<Latex批注功能实现>> (未验证)
http://blog.csdn.net/xiaokun19870825/article/details/50813604

<<LaTeX技巧871：用 LaTeX 怎么进行批注和修改？>> (未验证)
http://www.latexstudio.net/archives/8903


# Latex其他

<<让latex写论文更方便的几个工具>> (未验证)
http://blog.csdn.net/garfielder007/article/details/51620626

PC -> LaTeX Converter Quick Comparison List http://tug.org/utilities/texconv/pc2txtbl.html

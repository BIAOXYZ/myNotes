
### Latex批注功能

<<使用 TikZ 对 LaTeX 文档添加批注>>
http://bbs.ctex.org/forum.php?mod=viewthread&tid=40633

注意：作者的代码似乎有些问题，应该再往下翻会提到一些修改，目前我实验的成功的代码是这样的（注意注释，还需要CJK宏包应该应该用GBK编码——可能是因为要用中文的原因，如果英文或许不用GBK——但是既然要写注释，一般不用英文了）。此外后面还提到了CTAN的todonotes宏包，功能更强大，但是我还没有去试。

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


## latex其他

<<让latex写论文更方便的几个工具>> (未验证)
http://blog.csdn.net/garfielder007/article/details/51620626

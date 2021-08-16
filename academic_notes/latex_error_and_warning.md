
# `*.sty file not found`

latex缺少sty文件的解决方法--宏包导入 https://blog.csdn.net/qizhemamakanxiyang/article/details/115329802
```console
1. 在该网址中搜索缺少的安装包名（无后缀），选择最相近的包下载到本地；
2. 解压后查看是否有.sty文件，若有跳至第6步；
3. 查看是否有.ins文件，若有，跳至第5步；
4. 通过其中.dtx文件编译.sty文件：该文件存储目录下执行命令tex name.dtx
5. 通过其中.ins文件编译.sty文件：该文件存储目录下执行命令latex name.ins
6. 将整个文件拷贝到latex安装目录下，我的目录为：E:\CTEX\MiKTeX\tex\latex
7. 关闭当前latex和winedt
8. 在我的电脑程序中找到latex或CTex->settings(admin),点击refresh FNDB选项即可。
```

How can I manually install a package on MiKTeX (Windows) https://tex.stackexchange.com/questions/2063/how-can-i-manually-install-a-package-on-miktex-windows
- https://tex.stackexchange.com/questions/2063/how-can-i-manually-install-a-package-on-miktex-windows#2066

Windows10下Latex缺少sty文件时的安装方法 https://blog.csdn.net/GodWriter/article/details/97624231
```console
方案二
- 访问 https://www.ctan.org/tex-archive/macros/latex/contrib/
- 搜索缺少的安装包名，如appendix，下载到本地
- 一般是zip文件，解压，里面有Ins文件
- cmd进入解压后的文件，并执行命令：latex appendix.ins，会生成相对应的appendix.sty文件
- 将整个文件拷贝到latex安装目录下“\MiKTex2.9\tex\latex”
- win+R召唤cmd，执行texhash刷新Tex文件数据库即可
```
- https://blog.csdn.net/guojingjuan/article/details/84878630
- https://blog.csdn.net/lvshu_yuan/article/details/80487752

Latex安装包找不到错误not found https://blog.csdn.net/sollin/article/details/97744984
- > 1、下载相应的安装包，地址https://ctan.org/pkg
- > 2、解压包文件，放置latex安装目录，如C:\CTEX\MiKTeX\tex\latex
- > 3、更新latex包：在开始菜单中搜索settings，进入latex更新包的界面，在general选项卡单击"Refresh FNDB"按钮，开始更新包，此时应关闭latext，每次有新包都要更新下。
- > 或直接在Latex中找到这个更新操作：

# 编码类

inputenc Error: Unicode char \u8: not set up for use with LaTeX https://tex.stackexchange.com/questions/83440/inputenc-error-unicode-char-u8-not-set-up-for-use-with-latex
- https://tex.stackexchange.com/questions/83440/inputenc-error-unicode-char-u8-not-set-up-for-use-with-latex/83455#83455
  * > Solution: add in your preamble
    ```tex
    \DeclareUnicodeCharacter{00A0}{ }
    ```

--------------------------------------------------

XeLeTeX字体警告"EU1/SimSun(0)/m/it' undefined的原因 https://blog.csdn.net/robertchenguangzhi/article/details/48978053

--------------------------------------------------

### errorUnknown graphics extension: .eps.

Why can't pdflatex print EPS figures? https://tex.stackexchange.com/questions/383/why-cant-pdflatex-print-eps-figures
```
Yes it can and it will be default in TeXLive2010.

You need:

1.\usepackage{epstopdf} in the preemble
2.Include graphics without extension e.g \includegraphics{picture}
3.pdflatex -shell-escape or enabling write18 on windows
```

### “job aborted, file error in nonstop mode” error in Texmaker

How to resove “job aborted, file error in nonstop mode” error in Texmaker (64-bit)? https://tex.stackexchange.com/questions/160532/how-to-resove-job-aborted-file-error-in-nonstop-mode-error-in-texmaker-64-bi
>> 把.tex文件里的空格全部改成下划线，编译通过。

### overfull hbox/vbox类

What does “overfull hbox” mean? https://tex.stackexchange.com/questions/35/what-does-overfull-hbox-mean

# 待分类

```Critical Package ctex Error: CTeX fontset `mac' is unavailable in current(ctex) mode. }```
- http://tomgu1991.github.io/blog/Technical/THUthesis.html
- https://github.com/3b1b/manim/issues/64

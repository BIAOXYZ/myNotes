
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


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



# markdown general

<<markdown总结>> http://www.jianshu.com/p/cd044443a1a6

<<Learning-Markdown (Markdown 入门参考)>> http://xianbai.me/learn-md/index.html

***--------------------------------------------------分割线--------------------------------------------------***

创建和突显代码块 https://docs.github.com/cn/github/writing-on-github/working-with-advanced-formatting/creating-and-highlighting-code-blocks
- > 我们使用 Linguist 来执行语言检测并选择第三方语法进行语法突显。 您可以在语言 YAML 文件中找出哪些关键词有效。
  * https://github.com/github/linguist/blob/master/lib/linguist/languages.yml
- > 延伸阅读: GitHub Flavored Markdown 规格
  * > https://github.github.com/gfm/

GitHub上README写法暨GFM语法解读 https://blog.csdn.net/guodongxiaren/article/details/23690801
- EMOJI CHEAT SHEET https://www.webpagefx.com/tools/emoji-cheat-sheet/
- https://github.com/guodongxiaren/README/blob/master/emoji.md

如何实现Github markdown 目录/页内跳转？ - 知乎 https://www.zhihu.com/question/58630229
- 如何实现Github markdown 目录/页内跳转？ - 鉴津Jackie的回答 - 知乎 https://www.zhihu.com/question/58630229/answer/191984051
  * https://github.com/guodongxiaren/README

***--------------------------------------------------分割线--------------------------------------------------***

Basic writing and formatting syntax https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax
- > **Alerts**
  ```console
  > [!NOTE]
  > Useful information that users should know, even when skimming content.

  > [!TIP]
  > Helpful advice for doing things better or more easily.

  > [!IMPORTANT]
  > Key information users need to know to achieve their goal.

  > [!WARNING]
  > Urgent info that needs immediate user attention to avoid problems.

  > [!CAUTION]
  > Advises about risks or negative outcomes of certain actions.
  ```
- > Here are the rendered alerts:
  
  > [!NOTE]
  > Useful information that users should know, even when skimming content.

  > [!TIP]
  > Helpful advice for doing things better or more easily.

  > [!IMPORTANT]
  > Key information users need to know to achieve their goal.

  > [!WARNING]
  > Urgent info that needs immediate user attention to avoid problems.

  > [!CAUTION]
  > Advises about risks or negative outcomes of certain actions.


Complete list of github markdown emoji markup https://gist.github.com/rxaviers/7360908 

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

### Github markdown task lists

About task lists https://help.github.com/en/articles/about-task-lists
```
- [x] Finish my changes
- [ ] Push my commits to GitHub
- [ ] Open a pull request
```
- [x] Finish my changes
- [ ] Push my commits to GitHub
- [ ] Open a pull request

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

### `<details>`以及`<details>`+`<p>`实现下拉箭头效果

- Using `<details>` in GitHub https://gist.github.com/ericclemmons/b146fe5da72ca1f706b2ef72a20ac39d
- collapsible markdown? https://gist.github.com/joyrexus/16041f2426450e73f5df9391f7f7ae5f

--------------------------------------------------
**例1：只能隐藏普通内容，不能隐藏代码块**

<details>
<summary>Stack Trace for `require('does.not.exist')`</summary>
 ```shell
 require('does.not.exist')
 Error: Cannot find module 'does.not.exist'
   at Function.Module._resolveFilename (module.js:336:15)
   at Function.Module._load (module.js:286:25)
   at Module.require (module.js:365:17)
 ```
</details>

--------------------------------------------------
**例2：通过混合使用`<p>`可以把代码块内容也隐藏**（但是我发现**标题里**有些比如加粗或斜体之类的标记还是有问题）

<details><summary>CLICK ME</summary>
<p>

#### yes, even hidden code blocks!

```python
print("hello world!")
```

</p>
</details>

--------------------------------------------------

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# markdown小技巧

## markdown中使用html

markdown表格内如何进行换行？ https://blog.csdn.net/microcosmv/article/details/51868178
> "可以用html的代码，插入代码`<br>`"

**原始表格代码和效果：**
```
|姓名|爱好|
--|--|
张三|足球、篮球
李四|羽毛球、乒乓球
```
|姓名|爱好|
--|--|
张三|足球、篮球
李四|羽毛球、乒乓球

**使用`<br>`在表格内换行的代码和效果：**
```
|姓名|爱好|
--|--|
张三|足球<br>篮球
李四|羽毛球<br>乒乓球
```
|姓名|爱好|
--|--|
张三|足球<br>篮球
李四|羽毛球<br>乒乓球

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

Markdown的常用语法(个人总结) https://www.jianshu.com/p/82e730892d42

**markdown脚注：**
```
这是一个脚注的例子[^1]

[^1]: 这里是脚注
```
这是一个脚注的例子[^1]

[^1]: 这里是脚注


**字体大小及颜色：**
```
<font face="微软雅黑" color="red" size="6">字体及字体颜色和大小</font>
<font color="#0000ff">字体颜色</font>
```
<font face="微软雅黑" color="red" size="6">字体及字体颜色和大小</font>
<font color="#0000ff">字体颜色</font>


**文本对齐方式：**
```
<p align="left">居左文本</p>
<p align="center">居中文本</p>
<p align="right">居右文本</p>
```
<p align="left">居左文本</p>
<p align="center">居中文本</p>
<p align="right">居右文本</p>


**下划线：**
```
<u>下划线文本</u>
```
<u>下划线文本</u>


:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

### 其他可以用在Github markdown的html标签

HTML Tags You Can Use on GitHub https://gist.github.com/seanh/13a93686bf4c2cb16e658b3cf96807f2
- > Subscripts<sub>sub</sub> and superscripts<sup>sup</sup> with `<sub>` and `<sup>`.
- > Inserted text with `<ins>`: <ins>inserted</ins> and deleted text with `<del>`: <del>deleted</del>. These can both have the `cite` attribute.

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

### markdown图片大小调整：

关于 Markdown 的一些奇技淫巧 https://mazhuang.org/2017/09/01/markdown-odd-skills/
```console
**图片默认显示效果：**

![](https://raw.githubusercontent.com/mzlogin/mzlogin.github.io/master/images/posts/markdown/demo.png)

**加以控制后的效果：**

<div align="center"><img width="65" height="75" src="https://raw.githubusercontent.com/mzlogin/mzlogin.github.io/master/images/posts/markdown/demo.png"/></div>

**数值也可以用百分比（防止因自己选的值不合适导致图片变形）：**

<img width=10% height=10% src="https://raw.githubusercontent.com/mzlogin/mzlogin.github.io/master/images/posts/markdown/demo.png" />
```
**图片默认显示效果：**

![](https://raw.githubusercontent.com/mzlogin/mzlogin.github.io/master/images/posts/markdown/demo.png)

**加以控制后的效果：**

<div align="center"><img width="65" height="75" src="https://raw.githubusercontent.com/mzlogin/mzlogin.github.io/master/images/posts/markdown/demo.png"/></div>

**数值也可以用百分比（防止因自己选的值不合适导致图片变形）：**

<img width=10% height=10% src="https://raw.githubusercontent.com/mzlogin/mzlogin.github.io/master/images/posts/markdown/demo.png" />

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## markdown中数学公式

How to show math equations in general github's markdown(not github's blog) https://stackoverflow.com/questions/11256433/how-to-show-math-equations-in-general-githubs-markdownnot-githubs-blog
```
本来mathjax挺好的解决方案，github偏偏不支持，垃圾！
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

### markdown数学公式1
MathJax Chinese Doc 2.0 documentation - 入门指南 http://mathjax-chinese-doc.readthedocs.io/en/latest/start.html
```
使用我们的服务器使用MathJax，你需要做两件事情：

1.链接MathJax到要包含公式的网页中。
2.将公式放入网页让MathJax可以展示它。
要完成第一步，你可以放置

<script type="text/javascript"
  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>

到页面的 <head> 块中。如果需要的话也可以放置到 <body> 块中，但是head是更好的选择。
这样就会从分发服务器中加载最新版本的MathJax，并配置它识别用Tex和MathML符号书写的公式。
如果浏览器原生支持MathML格式，MathJax就会生成用MathML输出，不然的话就用HTML和CSS去显示公式。
这是最常见的配置，它可以满足大部分人的需求。
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

### markdown数学公式2

***总结：【1】里的办法必须在网页上生成，【2】的办法可以生成以后自己看情况改，就是注意markdown斜杠要转义——所以数学公式里有的地方用了两个斜杠。这两个的网址是同一个网站的，但是【2】的不太好用，统一用【1】的吧。***
> https://www.codecogs.com/latex/eqneditor.php

- 关于 Markdown 的一些奇技淫巧 - mzlogin的文章 - 知乎 http://zhuanlan.zhihu.com/p/28987530  【1】
  * 复制生成图片地址时，选项用URL Encoded （这是原文里的方法）
`![](https://latex.codecogs.com/gif.latex?%5Cfrac%7B1%7D%7B1&plus;sin%28x%29%7D)`
![](https://latex.codecogs.com/gif.latex?%5Cfrac%7B1%7D%7B1&plus;sin%28x%29%7D)
  * 复制生成图片地址时，选项用URL （这是我自己试出来的方法，这个和下面那个帖子里的方法类似，但还是不如那个方便）
`![](https://latex.codecogs.com/gif.latex?\frac{1}{1&plus;sin(x)})`
![](https://latex.codecogs.com/gif.latex?\frac{1}{1&plus;sin(x)})
- github上Markdown不支持LaTeX吗？ - Alex dcrozz的回答 - 知乎 https://www.zhihu.com/question/26887527/answer/127906478 【2】
`![](http://latex.codecogs.com/gif.latex?\\frac{1}{1+sin(x)})`
![](http://latex.codecogs.com/gif.latex?\\frac{1}{1+sin(x)})

***还有一些奇怪的问题（不知道是不是github的原因），比如双$$符号的公式不换行，单个$符号的公式是非斜体：***
```
![](http://latex.codecogs.com/gif.latex?$$y=g^x$$);![](http://latex.codecogs.com/gif.latex?$$y=g^x$$)

![](http://latex.codecogs.com/gif.latex?y=g^x);![](http://latex.codecogs.com/gif.latex?y=g^x)

![](http://latex.codecogs.com/gif.latex?$y=g^x$)
```
![](http://latex.codecogs.com/gif.latex?$$y=g^x$$);![](http://latex.codecogs.com/gif.latex?$$y=g^x$$)

![](http://latex.codecogs.com/gif.latex?y=g^x);![](http://latex.codecogs.com/gif.latex?y=g^x)

![](http://latex.codecogs.com/gif.latex?$y=g^x$)

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

### markdown数学公式3（非latex数学公式，方便复制的）

符号大全 -- 常用数学符号 http://www.fhdq.net/sx/43.html
```console
常用数学符号：
＋ － × ÷ ﹢ ﹣ ± ／ ＝ ≈ ≡ ≠ ∧ ∨ ∑ ∏ ∪ ∩ ∈ ⊙ ⌒ ⊥ ∥ ∠ ∽ ≌ 
＜ ＞ ≤ ≥ ≮ ≯ ∧ ∨ √ ﹙ ﹚ [ ] ﹛ ﹜ ∫ ∮ ∝ ∞ ⊙ ∏ º ¹ ² ³ ⁴ ⁿ ₁ ₂ 
₃ ₄ · ∶ ½ ⅓ ⅔ ¼ ¾ ⅛ ⅜ ⅝ ⅞ ∴ ∵ ∷ α β γ δ ε ζ η θ ι κ λ μ ν ξ 
ο π ρ σ τ υ φ χ ψ ω ％ ‰ ℅ ° ℃ ℉ ′ ″ ￠ 〒 ¤ ○ ㎎ ㎏ ㎜ ㎝ ㎞ 
㎡ ㎥ ㏄ ㏎ m l m o l ㏕ P a ＄ ￡ ￥ ㏒ ㏑ 壹 贰 叁 肆 伍 陆 柒 捌 
玖 拾 微 毫 厘 分 百 千 万 亿 兆 吉 

几何符号：
⊥ ‖ ∠ ⌒ ⊙ ≡ ≌ △

代数符号：
∝ ∧ ∨ ～ ∫ ≠ ≤ ≥ ≈ ∞ ∶

运算符号：
× ÷ √ ±

集合符号：
∪ ∩ ∈ ⊆ ⊂ ⊇ ⊃

特殊符号：
∑ π（圆周率）

推理符号：
|a| ⊥ ∽ △ ∠ ∩ ∪ ≠ ≡ ± ≥ ≤ ∈ ← ↑ → ↓ ↖ ↗ ↘ ↙ ‖ ∧ ∨
```

Markdown符号：整除、不整除、恰整除、不恰整除 https://blog.csdn.net/ic_esnow/article/details/103847188
```console
整除	    \mid	       ∣ 
不整除	  \nmid	       ∤ 
恰整除	  \parallel	   ∥ 
不恰整除	\nparallel	 ∦ 
```

双箭头 双箭头符号大全可复制 https://www.qqwmw.com/fuhao/teshu/482.html
```console
双向箭头
↔ ↕
双线箭头
⇈ ⇊ ⇉ ⇇ ⇍ ⇎ ⇏ ⇐ ⇑ ⇒ ⇓ ⇖ ⇗ ⇘ ⇙
双线双向箭头
⇄ ⇅ ⇆ ⇋ ⇌ ⇔
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

https://www.douban.com/group/topic/16607780/
> `『』、「」`

MathJax 支持的 Latex 符号总结(各种箭头符号) https://blog.csdn.net/liyuanbhu/article/details/51473886

勾号、叉号、圈号的收集 https://blog.csdn.net/xuhuan_wh/article/details/8533675
- > `1、对号、钩号，符号为：✓、✔、☑、（✓）等`
- > `2、叉号符号为： ✗, ✘, x, ×, X, ✕, ☓, ✖ 、（✗）、☒ 等`

http://daily.zhihu.com/story/2375993
> 其他符号中，至少有四个可能被混淆用于姓名的居中圆点：「∙」「•」「・」「●」，分别叫做「Bullet Operator」、「Bullet」、「Katakana Middle Dot」、「Black Circle」附图：

https://blog.gtwang.org/windows/word-insert-circle-numbers-tutorial/
> ① ② ③ ④ ⑤ ⑥ ⑦ ⑧ ⑨ ⑩ ⑪ ⑫ ⑬ ⑭ ⑮ ⑯ ⑰ ⑱ ⑲ ⑳

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

Html Entities Symbols https://www.htmlsymbol.com/html-entities/
- https://www.htmlsymbol.com/html-entities/left-floor.html
- https://www.htmlsymbol.com/html-entities/right-floor.html

Unicode https://www.compart.com/en/unicode/
Unicode Character “⌊” (U+230A) https://www.compart.com/en/unicode/U+230A
Unicode Character “⌋” (U+230B) https://www.compart.com/en/unicode/U+230B

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

GitHub 原生支持写数学公式了，亲测有效 https://www.ithome.com/0/619/812.htm  【`2022.05.22`，github终于官方支持数学公式了。。。】
- > 需要注意的是：
  * > （1）如果你的公式包含“$”，则需要在前面加上“\”进行转义；
  * > （2）如果在公式之外你的正文也包含“$”，则需要用“`<span></span>`”标记；
- > 参考链接：
  * https://docs.github.com/cn/get-started/writing-on-github/working-with-advanced-formatting/organizing-information-with-tables
  * Math support in Markdown https://github.blog/2022-05-19-math-support-in-markdown/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

Include diagrams in your Markdown files with Mermaid https://github.blog/2022-02-14-include-diagrams-markdown-files-mermaid/
```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# markdown相关工具（主要是博客，公众号相关）

### Md2All

Md2All,让公众号完美显示Latex数学公式 https://www.cnblogs.com/garyyan/p/9228994.html
> http://md.aclickall.com

- 玩转各博客平台、公众号的排版，你不知到的方法 https://segmentfault.com/a/1190000012952170
- 公众号的Markdown排版利器:Md2All https://segmentfault.com/a/1190000012751767

### Markdown-Weixin

一个在线将 Markdown 转换为微信公众帐号文章格式的工具 https://github.com/cnych/markdown-weixin
> https://md.qikqiak.com/

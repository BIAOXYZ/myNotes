
# markdown general

<<markdown总结>> http://www.jianshu.com/p/cd044443a1a6

<<Learning-Markdown (Markdown 入门参考)>> http://xianbai.me/learn-md/index.html

### markdown数学公式

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


# markdown相关工具（主要是博客，公众号相关）

### Md2All

Md2All,让公众号完美显示Latex数学公式 https://www.cnblogs.com/garyyan/p/9228994.html
> http://md.aclickall.com

- 玩转各博客平台、公众号的排版，你不知到的方法 https://segmentfault.com/a/1190000012952170
- 公众号的Markdown排版利器:Md2All https://segmentfault.com/a/1190000012751767



<<markdown总结>>
http://www.jianshu.com/p/cd044443a1a6

<<Learning-Markdown (Markdown 入门参考)>>
http://xianbai.me/learn-md/index.html

### markdown数学公式

MathJax Chinese Doc 2.0 documentation - 入门指南
http://mathjax-chinese-doc.readthedocs.io/en/latest/start.html
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
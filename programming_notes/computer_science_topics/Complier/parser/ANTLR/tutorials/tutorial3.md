
# 1

ANTLR4 Mega Tutorial https://github.com/gabriele-tomassetti/antlr-mega-tutorial

【[:star:][`*`]】 The ANTLR Mega Tutorial https://tomassetti.me/antlr-mega-tutorial/ || https://web.archive.org/web/20240209042355/https://tomassetti.me/antlr-mega-tutorial/
- > **What is ANTLR?**
  * > Notice that technically what you get from ANTLR is a parse tree rather than an AST. ***The difference is that a parse tree is exactly what comes out of the parser, while the AST is a more refined version of the parse tree***. You create the AST by manipulating the parse tree, in order to get something that is easier to use by subsequent parts of your program. ***<ins>These changes are sometimes necessary because a parse tree might be organized in a way that make parsing easier or better performing. However, you might prefer something more user friendly in the rest of the program</ins>***.
- > **Are not Regular Expressions Enough?**
  * > If you are the typical programmer, you may ask yourself why can’t I use a regular expression? A regular expression is quite useful, such as when you want to find a number in a string of text, but it also has many limitations.
  * > ***The most obvious is the lack of recursion: you cannot find a (regular) expression inside another one***, unless you code it by hand for each level. Something that quickly became unmaintainable. But the larger problem is that it is not really scalable: if you are going to put together even just a few regular expressions, you are going to create a fragile mess that would be hard to maintain.
  * > ***Have you ever tried parsing HTML with a regular expression? It is a terrible idea, for one you risk summoning Cthulhu, but more importantly it does not really work***. You do not believe me? Let’s see, you want to find the elements of a table, so you try a regular expression like this one: `<table>(.*?)</table>`. Brilliant! You did it! Except somebody adds attributes to their table, such as style or id. It does not matter, you do this: `<table.*?>(.*?)</table>`. Still, you actually cared about the data inside the table. So you now need to parse `tr` and `td`, but they are full of tags.
  * > Therefore you need to eliminate that, too. And somebody dares even to use comments like `<!--- my comment &gtl--->`. Comments can be used everywhere, and that is not easy to treat with your regular expression. Is it?
  * > ***So you forbid the internet to use comments in HTML: problem solved***.
    >> //notes：可以，解决不了注释就解决写注释的（行为）。。。
  * > Or alternatively you use `ANTLR`, whatever seems simpler to you.

# 2

Lexical Analysis with ANTLR https://web.mit.edu/dmaze/school/6.824/antlr-2.7.0/doc/lexer.html || https://web.archive.org/web/20240429043931/https://web.mit.edu/dmaze/school/6.824/antlr-2.7.0/doc/lexer.html

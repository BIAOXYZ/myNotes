
# 官方

ANTLR https://www.antlr.org/
- > Quick Start
  * > To try ANTLR immediately, jump to the new ANTLR Lab! http://lab.antlr.org/
  * > To install locally, use [`antlr4-tools`](https://github.com/antlr/antlr4-tools), which installs Java and ANTLR if needed and creates `antlr4` and `antlr4-parse` executables:
    ```sh
    $ pip install antlr4-tools
    ```

ANTLR v4 https://github.com/antlr/antlr4
- Getting Started with ANTLR v4 https://github.com/antlr/antlr4/blob/master/doc/getting-started.md
- https://github.com/antlr/antlr4/blob/572bc7eb6fe27af67646a83af673b8e02dcb21f0/doc/python-target.md
  * > How to create a Python lexer or parser? This is pretty much the same as creating a Java lexer or parser, except you need to specify the language target, for example:
    ```sh
    $ antlr4 -Dlanguage=Python2 MyGrammar.g4
    ```
    > or
    ```sh
    $ antlr4 -Dlanguage=Python3 MyGrammar.g4
    ```

grammars-v4 https://github.com/antlr/grammars-v4

ANTLR https://zh.wikipedia.org/wiki/ANTLR

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# antlr books

ANTLR 4简明教程 https://wizardforcel.gitbooks.io/antlr4-short-course/content/ || ANTLR 4简明教程 https://github.com/dohkoos/antlr4-short-course
- > 《The Definitive ANTLR 4 Reference》中译版书籍已出（和我无关），所以此项目已被放弃……

《ANTLR 4 权威指南》学习笔记 https://github.com/kun-song/the-definitive-antlr4-reference

ANTLR-4-Resource-Code https://github.com/GaoGian/ANTLR-4-Resource-Code
- > ANTLR4 权威指南源代码

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# antlr tools

vscode-antlr4 https://github.com/mike-lischke/vscode-antlr4/tree/master || ANTLR4 grammar syntax support https://marketplace.visualstudio.com/items?itemName=mike-lischke.vscode-antlr4
- Graphical Visualizations https://github.com/mike-lischke/vscode-antlr4/blob/master/doc/graphical-visualizations.md

## grun

GRUN for Antlr4: How to use? https://stackoverflow.com/questions/69001510/grun-for-antlr4-how-to-use

### 个人实战

```sh
$ grun Hello r -gui
hello bob
^D
# 弹出生成的图片

$ cd 1-hello/
$ grun Hello r -gui testhello.txt                    
# 弹出生成的图片
$
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# antlr 相关概念

## ATN

ANTLR4 what does ATN stand for? https://stackoverflow.com/questions/41306505/antlr4-what-does-atn-stand-for
- https://stackoverflow.com/questions/41306505/antlr4-what-does-atn-stand-for/41306655#41306655
  * > Augmented Transition Networks, the description in the context of ANTLR could be found e.g. here http://www.antlr.org/papers/LL-star-PLDI11.pdf

How to understand ATN graph generated for ANTLR grammar? https://stackoverflow.com/questions/45473333/how-to-understand-atn-graph-generated-for-antlr-grammar

## invokingState

What is invokingState in RuleContext class implementations? https://stackoverflow.com/questions/50680438/what-is-invokingstate-in-rulecontext-class-implementations
- https://stackoverflow.com/questions/50680438/what-is-invokingstate-in-rulecontext-class-implementations/50693658#50693658

What is the meaning of different values of invokingState? #1455 https://github.com/antlr/antlr4/issues/1455

## 其他概念

What's the difference between ExitRule and EnterRule in Antlr4? https://stackoverflow.com/questions/68316550/whats-the-difference-between-exitrule-and-enterrule-in-antlr4

Get original text of an Antlr rule https://stackoverflow.com/questions/7443860/get-original-text-of-an-antlr-rule

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# antlr for Non-SQL

“轻量级” C++ Parser 方案 - Ubp.a的文章 - 知乎 https://zhuanlan.zhihu.com/p/157661251

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

如何学习ANTLR? - 知乎 https://www.zhihu.com/question/437337408

用 ANTLR4 和 python 十多行代码写一个计算器 https://blog.keyi-li.com/2020/04/16/ANTRL4-Python-Calculator/
- > calculANTLR-python3 https://github.com/cjhahaha/calculANTLR-python3
- > **step4. 通过 Visitor 来遍历 AST**
  * > Visitor 的具体介绍可以看[官方文档](https://wizardforcel.gitbooks.io/antlr4-short-course/content/calculator-visitor.html)。看 `dist/CalculantlrVisitor.py`，这个 `CalculantlrVisitor` 继承了 `ParseTreeVisitor`，并且有：

人人都可以实现的SQL parser - tobe的文章 - 知乎 https://zhuanlan.zhihu.com/p/121545985
- > Antlr4是一个Java实现的开源项目，用户需要编写g4后缀的语法文件，Antlr4可以自动生成词法解析器和语法解析器，提供给开发者的接口是已经解析好的抽象语法树以及易于访问的Listener和Visitor基类。什么意思呢，就是如果你要实现一个SQL parser，只要提供一个SQL语法规范的g4描述文件，这个文件可以从Presto或Spark项目中获得，那么Antlr就会生成编译过程中的抽象语法树，***用户也只需要写一个Java类来选择感兴趣的节点接口***，g4文件格式需要符合Antlr要求但因为是标准SQL我们不用自己重新写可以复用Presto或Spark的。
- > 基于现有的语法文件和开源库，用户只要只要传入SQL字符串，就可以马上得到SQL的抽象语法树了。这里推荐使用IntelliJ IDEA，安装antlr插件后，输入SQL资源就可以可视化这棵抽象语法树，方面后续遍历抽象语法树实现自己的业务逻辑。

使用ANTLR和Go实现DSL入门 https://tonybai.com/2022/05/10/introduction-of-implement-dsl-using-antlr-and-go/

使用antlr4解析clickhouse sql获取表名 https://www.jianshu.com/p/1b83721e0020

【python】使用Antlr4实现识别sql中的表或视图名 https://www.darkathena.top/archives/antlr4-sql-tablename

## 掘金上偶然（以关键词`antlr4权威指南中文pdf`）搜到的

antlr4权威指南中文pdf https://juejin.cn/s/antlr4%E6%9D%83%E5%A8%81%E6%8C%87%E5%8D%97%E4%B8%AD%E6%96%87pdf
- 从定义到AST及其遍历方式，一文带你搞懂Antlr4 https://juejin.cn/post/6922252291256893453
- Antlr4 前端应用与实践 https://juejin.cn/post/6872931804362309640
- ANTLR：在浏览器中玩语法解析 https://juejin.cn/post/6844903539978813453
- 编译技术在前端的实践（二）—— Antlr 及其应用 https://juejin.cn/post/7057354419888717855
- IDE 中的魔法 - 如何实现一个 parser https://juejin.cn/post/7051403665919180807
- 编译原理实战五：使用编译器前端工具Antlr生成词法、语法分析器(上) https://juejin.cn/post/6944574979392569358
- 精读《手写 SQL 编译器 - 语法分析》 https://juejin.cn/post/6844903641891995656 || https://github.com/ascoders/weekly/blob/0b06c714fa7191883e49c8cfef342d575fdfaff7/%E7%BC%96%E8%AF%91%E5%8E%9F%E7%90%86/66.%E7%B2%BE%E8%AF%BB%E3%80%8A%E6%89%8B%E5%86%99%20SQL%20%E7%BC%96%E8%AF%91%E5%99%A8%20-%20%E8%AF%AD%E6%B3%95%E5%88%86%E6%9E%90%E3%80%8B.md

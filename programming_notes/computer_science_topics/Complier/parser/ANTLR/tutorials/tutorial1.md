
# 1

ANTLR 4简明教程 https://wizardforcel.gitbooks.io/antlr4-short-course/content/

# 2

Antlr4系列（一）：语法分析器学习 - 先锋的文章 - 知乎 https://zhuanlan.zhihu.com/p/483679676

Antlr4系列（三）：实现SQL Parser - 先锋的文章 - 知乎 https://zhuanlan.zhihu.com/p/611682602

# 3

100 Languages Speedrun
- 100 Languages Speedrun: Episode 18: PLY Python Lex-Yacc https://dev.to/taw/episode-18-ply-python-lex-yacc-11bl
- 100 Languages Speedrun: Episode 74: Python ANTLR 4 https://dev.to/taw/100-languages-speedrun-episode-74-python-antlr-4-234l
- 100 Languages Speedrun: Episode 75: Abstract Syntax Trees with Python ANTLR 4 https://dev.to/taw/100-languages-speedrun-episode-75-abstract-syntax-trees-with-python-antlr-4-54j4
- 100 Languages Speedrun: Episode 76: Python SLY https://dev.to/taw/100-languages-speedrun-episode-76-python-sly-5bfb

# 4

Build SQL parser using ANTLR4 -Part1 https://medium.com/@sasidharc/build-sql-parser-using-antlr4-part1-2044916a8406 || https://web.archive.org/web/20220930094656/https://medium.com/@sasidharc/build-sql-parser-using-antlr4-part1-2044916a8406

Build SQL parser using ANTLR4 -Part2 https://medium.com/@sasidharc/build-sql-parser-using-antlr4-part2-1f8cdb011721 || https://web.archive.org/web/20220903041130/https://medium.com/@sasidharc/build-sql-parser-using-antlr4-part2-1f8cdb011721
- > **Flow**
  * > We will for now focus on the listener. In the code generated earlier, we can see a listener class generated as ***`pocketsListener`***. Take a look at the class and ***see <ins>all the rules are defined as functions with `enter`/`exit` prefix</ins> which means <ins>every time we walk through the tree and enter/exit a node, we can perform required actions</ins>***.
- > **Project**
  * > then we can override the required function where we need to perform actions as shown below.
    ```py
    class SQLParser(pocketsListener):
        def __init__(self):
            self.tokens = None

        def parse_sql(self, sql: str):
            print(f"Parsing SQL: {sql}")
            data = InputStream(sql)
            lexer = pocketsLexer(data)
            stream = CommonTokenStream(lexer)
            self.tokens = stream
            parser = pocketsParser(stream)
            tree = parser.pocket()
            walker = ParseTreeWalker()
            walker.walk(self, tree)

        def exitCreate(self, ctx:pocketsParser.CreateContext):
            print(f"Inside the create method - SQL Context:{self.tokens.getText(ctx.start, ctx.stop)}")
    ```

# 5

ANTLR快餐教程(1) - 有好多现成例子啊 https://www.jianshu.com/p/4bedad8dd70a

【[:star:][`*`]】 ANTLR快餐教程(2) - ANTLR其实很简单 https://www.jianshu.com/p/1f5e72156075 || https://blog.csdn.net/lusing/article/details/62043826
- > ANTLR是通过递归下降的方式来解析一个语法的。所谓的递归下降，其实很简单，不过就是一些模式匹配而己。
- > **简单的模式匹配**
  * > 我们看下官方的一个简单的例子，这是一个赋值表达式的例子。语法这样写：
    ```g4
    assign : ID '=' expr ';' ;
    ```
  * > 解析器的代码类似于下面这样：
    ```java
    void assign() {
      match(ID);
      match('=');
      expr();
      match(';');
    ```
  * > 解析只分为两种情况：第一种情况是直接模式匹配，第二种情况是调用其它函数继续分析。
  * > 我们写个完整的赋值语句的语法吧。我们简化一下，先不做递归下降，将表达式化简成只支持数字：
    ```g4
    grammar assign;
    assign : ID '=' expr ';' ;
    ID : [a-z]+ ;
    expr : NUMBER ;
    NUMBER : [1-9][0-9]*|[0]|([0-9]+[.][0-9]+) ;
    ```
  * > ID我们简化成只支持小写字母的组合，数字我们写个比较详细的。上面的代码存成`assign.g4`，用`antlr4 assign.g4`命令，就可以生成java解析器代码了。
  * > 我们来看看生成的parser中的片段，跟上面的像不像：
    ```java
        public final AssignContext assign() throws RecognitionException {
            AssignContext _localctx = new AssignContext(_ctx, getState());
            enterRule(_localctx, 0, RULE_assign);
            try {
                enterOuterAlt(_localctx, 1);
                {
                setState(4);
                match(ID);
                setState(5);
                match(T__0);
                setState(6);
                expr();
                setState(7);
                match(T__1);
                }
            }
            catch (RecognitionException re) {
                _localctx.exception = re;
                _errHandler.reportError(this, re);
                _errHandler.recover(this, re);
            }
            finally {
                exitRule();
            }
            return _localctx;
        }
    ```
  * > 下面是解析expr的情况：
    ```java
        public final ExprContext expr() throws RecognitionException {
            ExprContext _localctx = new ExprContext(_ctx, getState());
            enterRule(_localctx, 2, RULE_expr);
            try {
                enterOuterAlt(_localctx, 1);
                {
                setState(9);
                match(NUMBER);
                }
            }
            catch (RecognitionException re) {
                _localctx.exception = re;
                _errHandler.reportError(this, re);
                _errHandler.recover(this, re);
            }
            finally {
                exitRule();
            }
            return _localctx;
        }
    ```
- > **多种分支的情况**
  * > 如果有多种可能的话，在语法里用`"|"`符号分别列出来就是了。ANTLR会把它翻译成switch case一样的语句。
  * > 我们把我们上面的例子扩展一下，不光支持`'='`还支持`':='`赋值
    ```g4
    grammar assign2;
    assign : ID '=' expr ';' 
             | ID ':=' expr ';' ;
    ID : [a-z]+ ;
    expr : NUMBER ;
    NUMBER : [1-9][0-9]*|[0]|([0-9]+[.][0-9]+) ;
    ```
  * > 生成的Parser就变成switch case了：
    ```java
        public final AssignContext assign() throws RecognitionException {
            AssignContext _localctx = new AssignContext(_ctx, getState());
            enterRule(_localctx, 0, RULE_assign);
            try {
                setState(14);
                _errHandler.sync(this);
                switch ( getInterpreter().adaptivePredict(_input,0,_ctx) ) {
                case 1:
                    enterOuterAlt(_localctx, 1);
                    {
                    setState(4);
                    match(ID);
                    setState(5);
                    match(T__0);
                    setState(6);
                    expr();
                    setState(7);
                    match(T__1);
                    }
                    break;
                case 2:
                    enterOuterAlt(_localctx, 2);
                    {
                    setState(9);
                    match(ID);
                    setState(10);
                    match(T__2);
                    setState(11);
                    expr();
                    setState(12);
                    match(T__1);
                    }
                    break;
                }
            }
            catch (RecognitionException re) {
                _localctx.exception = re;
                _errHandler.reportError(this, re);
                _errHandler.recover(this, re);
            }
            finally {
                exitRule();
            }
            return _localctx;
        }
    ```
- > **二义性文法**
  * > 选择太多了也未必见得是好事儿，有一种副作用就是选择不是唯一的，这叫做『二义性文法』。
  * > 最简单的二义性文法就是把同一条规则写两遍，比如上面例子的`":="`我们就改成`"="`，让`"|"`之前和之后两条都一样。
    ```g4
    grammar assign2;
    assign : ID '=' expr ';' 
             | ID '=' expr ';' ;
    ID : [a-z]+ ;
    expr : NUMBER ;
    NUMBER : [1-9][0-9]*|[0]|([0-9]+[.][0-9]+) ;
    ```
  * > 但是ANTLR4是兼容这种情况的，不报错。在实际应用的时候，它选择第一条符合条件的规则，请看生成的代码
    ```java
            try {
                setState(14);
                _errHandler.sync(this);
                switch ( getInterpreter().adaptivePredict(_input,0,_ctx) ) {
                case 1:
                    enterOuterAlt(_localctx, 1);
                    {
                    setState(4);
                    match(ID);
                    setState(5);
                    match(T__0);
                    setState(6);
                    expr();
                    setState(7);
                    match(T__1);
                    }
                    break;
                case 2:
                    enterOuterAlt(_localctx, 2);
                    {
                    setState(9);
                    match(ID);
                    setState(10);
                    match(T__0);
                    setState(11);
                    expr();
                    setState(12);
                    match(T__1);
                    }
                    break;
                }
            }
    ```
  * > 最著名的二义性的例子就是关键字。***在常见的编程语言中，`关键字`都是和`标识符`冲突的***。比如我们定义一个if关键字：
    ```g4
    IF : 'if' ;
    ID : [a-z]+ ;
    ```
  * > 明显，`IF`和`ID`两个规则都可以解析'if'这个串，那到底是按IF算，还是按ID算呢？在ANTLR里，规则很简单，按照可以匹配的第一条处理。
  * > 但是，光靠第一条优先，也还是解决不了所有的问题。我们看两类新的问题
    + > 第一类：`1 + 2 * 3`。这个如何处理，是先算`+`还是先算`*`? 前人想出了三种办法来解决：
      - > 从左到右：管人是如何理解乘除加减的，我就从左到右算。Smalltalk就是这样做的
      - > 中缀转前缀：带来问题的是中缀表达式，我们给换个形式不就OK了吗，比如改成这样`(+ 1 (* 2 3))`，lisp就是这么做的
      - > 运算符优先级：最常用的一种作法，后面我们详情分析。基本上大部分常见的语言都有一个运算符优先级的表。
    + > 第二类，是一些语言的设计所导致的，给词法分析阶段带来困难。
      - > 比如`"*"`运算符，在大部分语言中都只表示乘法，但是在C语言中表示指针，当`i*j`时，表示乘法，但是当`int *j;`时，就变成表示指针。
      - > 所以像Go语言在设计时，就把类型定义移到了后面。我们入门阶段暂时也不打算解析这么复杂的，将来用到了再说。
- > **下一步做啥**
  * > 经过前面学习的写grammar的过程，我们可以把字符流CharStream，转换成一棵ParseTree。
  * > ***`CharStream`是字符流，经过词法分析会变成`Token流`。Token流再最终组装成一棵`ParseTree`，叶子节点是`TerminalNode`，非叶子节点是`RuleNode`***. ![](https://upload-images.jianshu.io/upload_images/1638145-adb92cce49135c79.png)
  * > 为了节省空间，Token流之上都没有复制字符流的内容，都是通过指向字符流区缓冲区来获取内容。***空白字符在Token流以上就不存在了***。
  * > 既然有了ParseTree，后面的事情就好办了。我们只要遍历这棵ParseTree，就可以访问所有的节点，然后继续做代码生成之类的后端的工作。
  * > 为了方便使用，ANTLR将这些节点，封装成`RuleNode`的子类，前面代码中我们看到的`xxxContext`类，就是这些子类。比如AssignContext，ExprContext等。
  * > 具体的接口，请看图：![](https://upload-images.jianshu.io/upload_images/1638145-046bc2378cca9862.png)
  * > 我们看个AssignContext是如何被实现的：
    ```java
        public static class AssignContext extends ParserRuleContext {
            public TerminalNode ID() { return getToken(assign2Parser.ID, 0); }
            public ExprContext expr() {
                return getRuleContext(ExprContext.class,0);
            }
            public TerminalNode IF() { return getToken(assign2Parser.IF, 0); }
            public AssignContext(ParserRuleContext parent, int invokingState) {
                super(parent, invokingState);
            }
            @Override public int getRuleIndex() { return RULE_assign; }
            @Override
            public void enterRule(ParseTreeListener listener) {
                if ( listener instanceof assign2Listener ) ((assign2Listener)listener).enterAssign(this);
            }
            @Override
            public void exitRule(ParseTreeListener listener) {
                if ( listener instanceof assign2Listener ) ((assign2Listener)listener).exitAssign(this);
            }
        }
    ```
- > **两种访问ParserTree的方法**
  * > Listener方法有点类似于解析XML的SAX方法。废话不多说了，这篇文章已经有点长了，我们直接上代码：
    ```java
    // Generated from assign2.g4 by ANTLR 4.6
    import org.antlr.v4.runtime.tree.ParseTreeListener;

    /**
     * This interface defines a complete listener for a parse tree produced by
     * {@link assign2Parser}.
     */
    public interface assign2Listener extends ParseTreeListener {
        /**
         * Enter a parse tree produced by {@link assign2Parser#assign}.
         * @param ctx the parse tree
         */
        void enterAssign(assign2Parser.AssignContext ctx);
        /**
         * Exit a parse tree produced by {@link assign2Parser#assign}.
         * @param ctx the parse tree
         */
        void exitAssign(assign2Parser.AssignContext ctx);
        /**
         * Enter a parse tree produced by {@link assign2Parser#expr}.
         * @param ctx the parse tree
         */
        void enterExpr(assign2Parser.ExprContext ctx);
        /**
         * Exit a parse tree produced by {@link assign2Parser#expr}.
         * @param ctx the parse tree
         */
        void exitExpr(assign2Parser.ExprContext ctx);
    }
    ```
  * > 开始解析Assign的时候，会回调`etnterAssign方法`，结束时回调`exitAssign方法`。
  * > 另一种是采用visitor模式的方法，我们调用antlr4的时候要增加`-visitor`参数来生成。Visitor仍然非常简单，我们直接看代码：
    ```java
    // Generated from assign2.g4 by ANTLR 4.6
    import org.antlr.v4.runtime.tree.ParseTreeVisitor;

    /**
     * This interface defines a complete generic visitor for a parse tree produced
     * by {@link assign2Parser}.
     *
     * @param <T> The return type of the visit operation. Use {@link Void} for
     * operations with no return type.
     */
    public interface assign2Visitor<T> extends ParseTreeVisitor<T> {
        /**
         * Visit a parse tree produced by {@link assign2Parser#assign}.
         * @param ctx the parse tree
         * @return the visitor result
         */
        T visitAssign(assign2Parser.AssignContext ctx);
        /**
         * Visit a parse tree produced by {@link assign2Parser#expr}.
         * @param ctx the parse tree
         * @return the visitor result
         */
        T visitExpr(assign2Parser.ExprContext ctx);
    }
    ```

# 6

【ANTLR学习笔记】4：语法导入和访问者(Visitor)模式 https://lauzyhou.blog.csdn.net/article/details/106331151

【ANTLR学习笔记】5：使用监听器构建翻译程序，在g4文件中定制语法分析过程 https://lauzyhou.blog.csdn.net/article/details/106362871

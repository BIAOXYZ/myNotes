
# 1

探究Presto SQL引擎(1)-巧用Antlr https://segmentfault.com/a/1190000040490309 || https://juejin.cn/post/6994614394621526047 || http://blog.itpub.net/69912579/viewspace-2786120/
- > **3.2.1 使用Visitor模式**
  * > 代码编写完成后，就是运行 `Calc`。运行 `Calc` 的 `main` 函数，在交互命令行输入相应的运算表达式，`换行` `Ctrl+D` 即可看到运算结果。例如 `1+3*4=13`。
- > **五、总结**
  * > 本文基于四则运算器和使用SQL查询csv数据两个案例阐述了ANTLR4在项目开发中的应用思路和过程，相关的代码可以在[github](https://github.com/shgy/db-practice)上看到。
    >> //notes：另外自己也fork了一个，方便后续回顾： https://github.com/BIAOXYZ/forked--db-practice  -->  因为完全没接触过 java，作者原版仓库里的代码去编译都踩了坑，所以还是 fork 一份省得作者更新后再想回顾的时候更麻烦。。。

## 实战过程（第一部分）

```sh
# "Ubuntu 20.04.3 LTS"，装java用的下面这句：
apt update
apt install -y openjdk-13-jdk-headless

#// 一、需要注意两点：1.提前准备好java环境；2.curl那里添加 --insecure 参数。
cd /usr/local/lib
curl -O https://www.antlr.org/download/antlr-4.9-complete.jar --insecure
export CLASSPATH=".:/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH"
alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'
```

```sh
#// 二、这里不用文章里一步步写的了，直接用作者仓库里的。反正知道怎么写就行。
mkdir -p ~/test
cd ~/test/
git clone https://github.com/BIAOXYZ/forked--db-practice.git
cd forked--db-practice/
```

```sh
#// 三、下面是（我这样的 java 初学者）关于 java 编译碰到的坑，以及解决方法。
cd src/main/calc/org/example/calc/visitor/
$ pwd
/root/test/forked--db-practice/src/main/calc/org/example/calc/visitor
$ ls
Calc.java         LabeledExprBaseVisitor.java  LabeledExprLexer.tokens  LabeledExpr.tokens
EvalVisitor.java  LabeledExprLexer.java        LabeledExprParser.java   LabeledExprVisitor.java

# 在当前目录去编译 Calc.java，根本编译不过。。。
$ javac Calc.java 
Calc.java:19: error: cannot find symbol
        LabeledExprLexer lexer = new LabeledExprLexer(input);
        ^
  symbol:   class LabeledExprLexer
  location: class Calc
Calc.java:19: error: cannot find symbol
        LabeledExprLexer lexer = new LabeledExprLexer(input);
                                     ^
  symbol:   class LabeledExprLexer
  location: class Calc
Calc.java:21: error: cannot find symbol
        LabeledExprParser parser = new LabeledExprParser(tokens);
        ^
  symbol:   class LabeledExprParser
  location: class Calc
Calc.java:21: error: cannot find symbol
        LabeledExprParser parser = new LabeledExprParser(tokens);
                                       ^
  symbol:   class LabeledExprParser
  location: class Calc
Calc.java:24: error: cannot find symbol
        EvalVisitor eval = new EvalVisitor();
        ^
  symbol:   class EvalVisitor
  location: class Calc
Calc.java:24: error: cannot find symbol
        EvalVisitor eval = new EvalVisitor();
                               ^
  symbol:   class EvalVisitor
  location: class Calc
Note: Calc.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
6 errors

# 后来才知道应该找对位置。。。这里 Calc.java 的第一行是这样的：`package org.example.calc.visitor;`
# 所以，我们应该到 org 的上级目录（这里是 `....../calc/` 目录）去编译，执行也是在这级目录发起。
# 怀疑还有更简单的方法，但是我试了试 -d 没成功反正，回头再说吧，先能编译通过跑起来再说。。。
$ 
$ cd ~/test/forked--db-practice/src/main/calc/
$ pwd
/root/test/forked--db-practice/src/main/calc
$ 
$ ls
org
$ 
$ javac org/example/calc/visitor/Calc.java
Note: org/example/calc/visitor/Calc.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
$ 
$ ls org/example/calc/visitor/
Calc.class                             LabeledExprParser$ExprContext.class
Calc.java                              LabeledExprParser$IdContext.class
EvalVisitor.class                      LabeledExprParser$IntContext.class
EvalVisitor.java                       LabeledExprParser.java
LabeledExprBaseVisitor.class           LabeledExprParser$MulDivContext.class
LabeledExprBaseVisitor.java            LabeledExprParser$ParensContext.class
LabeledExprLexer.class                 LabeledExprParser$PrintExprContext.class
LabeledExprLexer.java                  LabeledExprParser$ProgContext.class
LabeledExprLexer.tokens                LabeledExprParser$StatContext.class
LabeledExprParser$AddSubContext.class  LabeledExpr.tokens
LabeledExprParser$AssignContext.class  LabeledExprVisitor.class
LabeledExprParser$BlankContext.class   LabeledExprVisitor.java
LabeledExprParser.class
$ 
$ java org.example.calc.visitor.Calc
1+3*4
Ctrl + D
ANTLR Tool version 4.6 used for code generation does not match the current runtime version 4.9ANTLR Tool version 4.6 used for code generation does not match the current runtime version 4.9
13
$ 
```

```sh
# // Another 二、
#// 如果前面的第二步不想用现成的，想完全一步步来，可以这样：
mkdir -p ~/test/test2/src/main/calc/org/example/calc/visitor
cd ~/test/test2/src/main/calc/org/example/calc/visitor/

cat << EOF > ~/test/test2/src/main/calc/org/example/calc/visitor/LabeledExpr.g4
grammar LabeledExpr; // rename to distinguish from Expr.g4
 
prog:   stat+ ;
 
stat:   expr NEWLINE                # printExpr
    |   ID '=' expr NEWLINE         # assign
    |   NEWLINE                     # blank
    ;
 
expr:   expr op=('*'|'/') expr      # MulDiv
    |   expr op=('+'|'-') expr      # AddSub
    |   INT                         # int
    |   ID                          # id
    |   '(' expr ')'                # parens
    ;
 
MUL :   '*' ; // assigns token name to '*' used above in grammar
DIV :   '/' ;
ADD :   '+' ;
SUB :   '-' ;
ID  :   [a-zA-Z]+ ;      // match identifiers
INT :   [0-9]+ ;         // match integers
NEWLINE:'\r'? '\n' ;     // return newlines to parser (is end-statement signal)
WS  :   [ \t]+ -> skip ; // toss out whitespace
EOF

# 被下面这句也坑了一会，最后还是对比github仓库里（肯定能运行的版本）和自己用 antlr 生成的版本
# 对应文件前面的 package 路径才找出来问题（参见后面的代码块，一个diff语句就说明问题了。）
# antlr4 -package org.example.calc -no-listener -visitor LabeledExpr.g4
antlr4 -package org.example.calc.visitor -no-listener -visitor LabeledExpr.g4

cat << EOF > ~/test/test2/src/main/calc/org/example/calc/visitor/Calc.java
package org.example.calc.visitor;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

public class Calc {

    public static void main(String[] args) throws IOException {
        String inputFile = null;
        if ( args.length>0 ) inputFile = args[0];
        InputStream is = System.in;
        if ( inputFile!=null ) is = new FileInputStream(inputFile);
        ANTLRInputStream input = new ANTLRInputStream(is);
        LabeledExprLexer lexer = new LabeledExprLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        LabeledExprParser parser = new LabeledExprParser(tokens);
        ParseTree tree = parser.prog(); // parse

        EvalVisitor eval = new EvalVisitor();
        eval.visit(tree);
    }
}
EOF

cat << EOF > ~/test/test2/src/main/calc/org/example/calc/visitor/EvalVisitor.java
package org.example.calc.visitor; /***
 * Excerpted from "The Definitive ANTLR 4 Reference",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tpantlr2 for more book information.
***/
import java.util.HashMap;
import java.util.Map;

public class EvalVisitor extends LabeledExprBaseVisitor<Integer> {
    /** "memory" for our calculator; variable/value pairs go here */
    Map<String, Integer> memory = new HashMap<String, Integer>();

    /** ID '=' expr NEWLINE */
    @Override
    public Integer visitAssign(LabeledExprParser.AssignContext ctx) {
        String id = ctx.ID().getText();  // id is left-hand side of '='
        int value = visit(ctx.expr());   // compute value of expression on right
        memory.put(id, value);           // store it in our memory
        return value;
    }

    /** expr NEWLINE */
    @Override
    public Integer visitPrintExpr(LabeledExprParser.PrintExprContext ctx) {
        Integer value = visit(ctx.expr()); // evaluate the expr child
        System.out.println(value);         // print the result
        return 0;                          // return dummy value
    }

    /** INT */
    @Override
    public Integer visitInt(LabeledExprParser.IntContext ctx) {
        return Integer.valueOf(ctx.INT().getText());
    }

    /** ID */
    @Override
    public Integer visitId(LabeledExprParser.IdContext ctx) {
        String id = ctx.ID().getText();
        if ( memory.containsKey(id) ) return memory.get(id);
        return 0;
    }

    /** expr op=('*'|'/') expr */
    @Override
    public Integer visitMulDiv(LabeledExprParser.MulDivContext ctx) {
        int left = visit(ctx.expr(0));  // get value of left subexpression
        int right = visit(ctx.expr(1)); // get value of right subexpression
        if ( ctx.op.getType() == LabeledExprParser.MUL ) return left * right;
        return left / right; // must be DIV
    }

    /** expr op=('+'|'-') expr */
    @Override
    public Integer visitAddSub(LabeledExprParser.AddSubContext ctx) {
        int left = visit(ctx.expr(0));  // get value of left subexpression
        int right = visit(ctx.expr(1)); // get value of right subexpression
        if ( ctx.op.getType() == LabeledExprParser.ADD ) return left + right;
        return left - right; // must be SUB
    }

    /** '(' expr ')' */
    @Override
    public Integer visitParens(LabeledExprParser.ParensContext ctx) {
        return visit(ctx.expr()); // return child expr's value
    }
}
EOF
```
```sh
# 然后就是找对路径再编译；以及编译后运行。
ubuntu $ cd /root/test/test2/src/main/calc
ubuntu $ pwd
/root/test/test2/src/main/calc
ubuntu $ 
ubuntu $ ls
org
ubuntu $ 
ubuntu $ javac org/example/calc/visitor/Calc.java
Note: org/example/calc/visitor/Calc.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
ubuntu $ 
ubuntu $ java org.example.calc.visitor.Calc
1+3*5+3
CTRL+D
19
ubuntu $ 
```
```sh
# 补充：自己用 antlr 生成时，因路径错误编译不过，然后diff发现的：
ubuntu $ diff LabeledExprBaseVisitor.java ~/test/forked--db-practice/src/main/calc/org/example/calc/visitor/LabeledExprBaseVisitor.java 
1,2c1,2
< // Generated from LabeledExpr.g4 by ANTLR 4.9
< package org.example.calc;
---
> // Generated from .\LabeledExpr.g4 by ANTLR 4.6
> package org.example.calc.visitor;
```

### 参考链接
>> //notes：基本没接触过 java，所以开始时甚至用原版的代码都没法验证。。。还是网上搜了搜，参考下面这个文章里靠前的部分，才算编过。。。
  
第1期：抛开IDE，了解一下javac如何编译 - 毛帅的文章 - 知乎 https://zhuanlan.zhihu.com/p/74229762
- > **带个包名**
  * > 一切都很顺利，但没有包名是不专业的，所以我们加一个牛逼的包 `com.imshuai.javalinux`：
    ```java
    package com.imshuai.javalinux;
    public class HelloWorld{
        public static void main(String[] args){
            System.out.println("Hello, World!");
        }
    }
    ```
    > 还是一样用 `javac` 编译，查看当前目录下 `HelloWorld.class` 生成了，很顺利。
  * > 还是一样用 `java` 命令，瞬间被打脸：
    ```console
    maoshuai@ms:~/javaLinux/w1$ java HelloWorld 
    Error: Could not find or load main class HelloWorld
    ```
  * > 想了想，`HelloWorld` 已经有自己的包名了，所以它的名字不在是没有姓氏的 `HelloWorld`，新名字叫 `com.imshuai.javalinux.HelloWorld`，那么传给 `java` 自然要用新名字，再试一试：
    ```console
    maoshuai@ms:~/javaLinux/w1$ java com.imshuai.javalinux.HelloWorld
    Error: Could not find or load main class com.imshuai.javalinux.HelloWorld
    ```
  * > 还是被打脸，这时候老司机告诉你，创建一个 `com/imshuai/javalinux` 目录，然后把 `HelloWorld.class` 放进来，执行：
    ```console
    maoshuai@ms:~/javaLinux/w1$ mkdir -p com/imshuai/javalinux
    maoshuai@ms:~/javaLinux/w1$ mv HelloWorld.class com/imshuai/javalinux
    maoshuai@ms:~/javaLinux/w1$ java com.imshuai.javalinux.HelloWorld
    Hello, World!
    ```
    > 果然，正常打印出了Hello, World!
  * > 上面的步骤，说明了两点： 1. 增加了package名，所以class名也变了，行不改名坐不改姓，自然要带上姓（即所谓全限定名）。 2. Java 会根据包名对应出目录结构，并从class path搜索该目录去找class文件。由于默认的class path是当前目录，所以 `com.imshuai.javalinux.HelloWorld` 必须存储在 `./com/imshuai/javalinux/HelloWorld.class`
  * > 当然每次自己创建包路径的目录太麻烦。`-d` 参数可以代劳上面的工作：
    ```console
    maoshuai@ms:~/javaLinux/w1$ javac -d . HelloWorld.java 
    maoshuai@ms:~/javaLinux/w1$ ls
    com  HelloWorld.java
    maoshuai@ms:~/javaLinux/w1$ java com.imshuai.javalinux.HelloWorld
    Hello, World!
    ```
    > `-d` 指定了生成class文件的根目录（这里用的是当前目录），并且会根据class的包路径创建子目录。

## 实战过程（第二部分）

```

```

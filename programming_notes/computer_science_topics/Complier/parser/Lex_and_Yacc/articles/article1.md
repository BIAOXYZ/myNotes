
# 1

使用Flex Bison 和LLVM编写自己的编译器 https://haoel.blog.csdn.net/article/details/4789364
- > 本文由赵锟翻译，酷壳发布，转载请注明译者和出处，请勿用于商业用途 <br> 原文出处：http://gnuu.org/2009/09/18/writing-your-own-toy-compiler

【[:star:][`*`]】 Writing Your Own Toy Compiler Using Flex, Bison and LLVM https://gnuu.org/2009/09/18/writing-your-own-toy-compiler/
- > **Update (March 19 2010)**: this article was updated for **LLVM 2.6** thanks to a great patch by [John Harrison](https://github.com/ashgti/my_toy_compiler). He rocks!
- > I’ve always been interested in compilers and languages, but interest only gets you so far. A lot of the concepts of compiler design can easily go way over most programmers’ heads, even the intelligent ones. Needless to say, I’ve tried, without much success, to write a small toy language/compiler before. I’d usually get caught up at the semantic parsing stage. And again, needless to say, this post is mostly inspired by my latest attempt, though this one has been much more successful (so far).
- > Fortunately over the last few years I’ve been involved in [some projects](http://yard.soen.ca/) that helped give me perspective and experience on what’s really involved in building a compiler. The other thing I’ve been lucky to have in my corner this time is the help of [LLVM](https://llvm.org/), a tool which I’m hardly qualified to talk too much about, but it’s been quite handy in implementing most of the business end (read: complex aspects) of my toy compiler.
- > **So Why Are You Reading This?**
  * > Maybe you want to see what I’ve been doing with my time. It’s more likely, however, that you’re probably interested in compilers and languages as I am, and have probably been hitting similar roadblocks. You’ve probably wanted to try this but never found the resources, or did but couldn’t quite follow. The goal of this article is to provide such a resource and explain in a relatively step by step manner how to create the most basic-but-functional compiler from start to “finish”.
  * > I won’t be covering much theory, so if you haven’t brushed up on your [BNF grammars](https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_Form), [AST data structures](https://en.wikipedia.org/wiki/Abstract_syntax_tree) and the basic [compiler pipeline](https://en.wikipedia.org/wiki/Compiler), I suggest you do so. That said, I plan on keeping this as simple as possible. The goal, of course, is to make this an easy-to-understand introductory resource for people interested but not experienced with compilers.
- > **What You Will End Up With**
  * > If you follow this article, you should ***end up with a language that can define functions, call functions, define variables, assign data to variables and perform basic math operations. It will support two basic types, doubles and integers***. Some of the functionality is unimplemented, so you can have the satisfaction of actually implementing some of this stuff yourself and get the hang of writing a compiler with a little help.
- > **Let’s Get Some Questions Out of the Way**
  * > **1.What languages do I need to know?**
    + > The tools we’ll be using are C/C++ based. LLVM is specifically C++ and our toy language will follow suit since there are some niceties of OOP and the STL (C++’s stdlib) that make for fewer lines of code. ***In addition to C, both `Lex` and `Bison` have their own syntax which may seem daunting at first, but I’ll try to explain as much as possible***. The grammar we’re dealing with is actually very tiny (`~100 LOC`), so it should be feasible.
  * > **2.Is this really complicated?**
    + > Yes and no. There is plenty of stuff going on here and it might seem scary at first, but honestly, this is about as simple as it gets. We will also use a lot of tools to abstract the layers of complexity and make it manageable.
  * > **3.How long will it take?**
    + > What we will be building took me about ***3 days*** of toying with, but I have a few failed attempts under my belt and those do have impact on my comprehension. Of course, this will be a “follow me” kind of deal, so it should be much shorter for you. To understand completely everything might take a little longer, but you should be able to run through all of this stuff (and hopefully understand a good amount of it) in ***an afternoon***.
  * > So, if you’re ready, let’s get started.
- > **The Basic Compiler Recipe**
  * > Although you should already pretty much know this, ***a compiler is really a grouping of three to four components*** (there are some more sub-components) where data is fed from one to the next in a pipeline fashion. We will be using a different tool to help us build out each of these components. Here is a diagram of each step and the tool we will use: ![](https://gnuu.org/uploads/2009/09/pipeline.png?resize=620%2C76)
  * > You’ll notice the linker step is greyed out. ***Our toy language won’t be supporting compile time linking*** (plus <ins>***most languages don’t do compile time linking anymore anyway***</ins>). To do our lexing we will be using the open source tool `Lex`, mostly available these days as `Flex`. Lexing usually goes hand in hand with semantic parsing, which we’ll be performing with the help of `Yacc`, better known as `Bison`. Finally, once semantic parsing is done we can walk over our AST and generate our “bytecode”, or machine code. For this, we’ll be using `LLVM`, which technically generates intermediate bytecode, but we will be using LLVM’s `JIT` (Just In Time) compilation to execute this bytecode on our machine.
  * > To summarize, the steps are as follows:
    + > **1.Lexical Analysis with `Flex`**: Split input data into a set of tokens (identifiers, keywords, numbers, brackets, braces, etc.)
    + > **2.Semantic Parsing with `Bison`**: Generate an AST while parsing the tokens. Bison will do most of the legwork here, we just need to define our AST.
    + > **3.Assembly with `LLVM`**: This is where we walk over our AST and generate byte/machine code for each node. ***As crazy as it sounds, this is probably the easiest step***.
  * > Before moving too far along, you should probably consider installing `Flex`, `Bison` and `LLVM`, if you haven’t already. We’re going to need them pretty soon.
- > ***`--------------------------------------------------本文从下面开始看就行了--------------------------------------------------`***
- > **Defining Our Grammar**
  * > Our grammar is naturally the most central part of our language. From our grammar we inherently allow or disallow functionality. For our toy compiler, we will be using a standard C-like syntax because it’s familiar and simple to parse. The canonical ***example of our toy language*** will be the following code:
    ```c
    int do_math(int a) {
      int x = a * 5 + 3
    }

    do_math(10)
    ```
  * > Looks simple enough. We can see it’s typed the same way C is, ***but there are no semicolons separating statements***. You’ll also notice ***there is no “return” statement in our grammar***; this is something you can implement on your own.
  * > ***There’s also no mechanism to print any results or anything***. We will ***verify the correctness of our programs by inspecting the very pretty instruction listing that LLVM can print of the bytecode we’ve compiled***, but more on that later.
- > **Step 1. Lexical Analysis with `Flex`**
  * > This is the simplest step. Given our grammar, ***we need to break down our input into a list of known tokens***. As mentioned before, ***our grammar has very basic tokens: `identifiers, numbers (integers and floats), the mathematical operators, parentheses and braces`***. Our lex file “***`tokens.l`***”, which has a somewhat specialized grammar, is simply defined as: `||` `这是最简单的一步，给定语法之后，我们需要将我们的输入转换一系列内部标记token。如前所述，我们的语法具有非常基础的标记token:标示符identifier ，数字常量(整型和浮点型)，数学运算符号，括号，中括号，我们的文法定义文件称为token.l，它具有一些固定的语法。定义如下：`
  * > Listing of ***`tokens.l`***:
    ```lex
    %{
    #include <string>
    #include "node.h"
    #include "parser.hpp"
    #define SAVE_TOKEN yylval.string = new std::string(yytext, yyleng)
    #define TOKEN(t) (yylval.token = t)
    extern "C" int yywrap() { }
    %}

    %%

    [ \t\n]                 ;
    [a-zA-Z_][a-zA-Z0-9_]*  SAVE_TOKEN; return TIDENTIFIER;
    [0-9]+.[0-9]*           SAVE_TOKEN; return TDOUBLE;
    [0-9]+                  SAVE_TOKEN; return TINTEGER;
    "="                     return TOKEN(TEQUAL);
    "=="                    return TOKEN(TCEQ);
    "!="                    return TOKEN(TCNE);
    "<"                     return TOKEN(TCLT);
    "<="                    return TOKEN(TCLE);
    ">"                     return TOKEN(TCGT);
    ">="                    return TOKEN(TCGE);
    "("                     return TOKEN(TLPAREN);
    ")"                     return TOKEN(TRPAREN);
    "{"                     return TOKEN(TLBRACE);
    "}"                     return TOKEN(TRBRACE);
    "."                     return TOKEN(TDOT);
    ","                     return TOKEN(TCOMMA);
    "+"                     return TOKEN(TPLUS);
    "-"                     return TOKEN(TMINUS);
    "*"                     return TOKEN(TMUL);
    "/"                     return TOKEN(TDIV);
    .                       printf("Unknown token!n"); yyterminate();

    %%
    ```
  * > ***The first section declares some specialized C code***. We use a “**SAVE_TOKEN**” macro to ***keep the text of identifiers and numbers somewhere safe (instead of just the token itself)***, since `Bison` won’t have access to our ‘`yytext`’ variable. ***<ins>The first token tells us to skip all whitespace</ins>***. You’ll also notice that we have some equality comparison tokens and such. Those are unimplemented for now, feel free to support them in your toy compiler! `||` `在第一节(译者注：即%{%}中定义的部分)声明了一些特定的C代码。由于Bison不会去访问我门的yytext变量，我们使用宏”SAVE_TOKEN”来保证标示符的文本和文本长度是安全的(而不是靠标记本身来保证)。第一个token告诉我们要忽略掉那些空白字符。你会注意到我们有些一些等价性比较的标记和其他。还有一些标记还没有实现，你可以非常自由的将这些标记加到你自己的编译器中去。`
  * > So ***all we’re doing here is <ins>defining the tokens and their symbolic names</ins>***. These symbols (`TIDENTIFIER`, etc.) will become “`terminal symbols`” in our grammar. We’re just returning them, but we’ve never defined them. **Where are they defined?** Why, in the bison grammar, of course. The ***`parser.hpp`*** file we’ve included will be generated by `bison`, and ***all the tokens inside it will be generated and available for use***. `||` `现在我们在这里做的是定义这些标记和他们的符号名。符号(比如TIDENTFIER)将成为我们语法中的终结符。我们只是返回它，我们从未定义它，他们是在什么地方定义的？当然是在bison语法文件中。我们包含的parser.hpp头文件将会被bison所生成，并且里面的所有符号都将被生成，并被我们在这里使用。`
  * > We run `Flex` on this ***`tokens.l`*** file to generate our “***`tokens.cpp`***” file, which will be compiled alongside our parser and provide the `yylex()` function that recognizes all of these tokens. ***We will run this command later though, because we need to generate that header file from `bison` first!*** `||` `我们对这个token.l运行flex命令，并生成tokens.cpp文件，这个程序将会和我们的语法分析器一起编译并提供yylex()函数来识别这些标记。我们将在稍后运行这个命令，因为现在我们需要从bison那里生成头文件。`
- > **Step 2. Semantic Parsing with `Bison`**
  * > This is the challenging part of our mission. Generating an accurate, unambiguous grammar is not simple and takes a little bit of practice. Fortunately, our grammar is both simple and, for your benefit, mostly completed. Before we get into implementing our grammar, though, we need to talk design for a bit.
- > **Designing the AST**
  * > ***The end product of semantic parsing is an AST***. As we will see, `Bison` is quite elegantly optimized to generate AST’s; it’s really only a matter of plugging our nodes into the grammar. `||` `语法分析的最终结果是抽象语法树AST，正如我们将看到的，Bison生成抽象语法树的最优工具；我们唯一需要做的事情就是将我们的代码插入到语法中去。`
  * > The same way a string such as “`int x`” represents our language in text form, our ***AST is what represents our language in memory*** (before it is assembled). As such, ***we need to build up the data structures we will be using before we have the chance of plugging them into our grammar file***. This process is pretty straightforward because ***we are basically creating a structure for every semantic that can be expressed by our language***. `Method calls, method declarations, variable declarations, references`, these are ***all candidates for `AST nodes`***. A complete diagram of the nodes in our language is as follows:  `||` `文本形式字符串，例如”int x”代表了我们语言的文本形式，和这个类似，抽象语法树AST则代表了我们语言在内存中的表现形式一样(在语言在组装成而进程码之前)。正因如此，我们要在把这些插入在语法分析中的数据结构首先设计好。这个过程是非常直接的，因为我们为语法中的每个语义单元创建了一个结构。方法声明、方法调用，变量声明，引用，这些都构成了抽象语法树的节点。我们语言的抽象语法树的节点如下图：`
    >> ![](https://gnuu.org/uploads/2009/09/ClassDiagram.png?resize=640%2C505)
  * > The C++ that represents the above specifications is:
  * > Listing of ***`node.h`***:
    ```cpp
    #include <iostream>
    #include <vector>
    #include <llvm/Value.h>

    class CodeGenContext;
    class NStatement;
    class NExpression;
    class NVariableDeclaration;

    typedef std::vector<NStatement*> StatementList;
    typedef std::vector<NExpression*> ExpressionList;
    typedef std::vector<NVariableDeclaration*> VariableList;

    class Node {
    public:
        virtual ~Node() {}
        virtual llvm::Value* codeGen(CodeGenContext& context) { }
    };

    class NExpression : public Node {
    };

    class NStatement : public Node {
    };

    class NInteger : public NExpression {
    public:
        long long value;
        NInteger(long long value) : value(value) { }
        virtual llvm::Value* codeGen(CodeGenContext& context);
    };

    class NDouble : public NExpression {
    public:
        double value;
        NDouble(double value) : value(value) { }
        virtual llvm::Value* codeGen(CodeGenContext& context);
    };

    class NIdentifier : public NExpression {
    public:
        std::string name;
        NIdentifier(const std::string& name) : name(name) { }
        virtual llvm::Value* codeGen(CodeGenContext& context);
    };

    class NMethodCall : public NExpression {
    public:
        const NIdentifier& id;
        ExpressionList arguments;
        NMethodCall(const NIdentifier& id, ExpressionList& arguments) :
            id(id), arguments(arguments) { }
        NMethodCall(const NIdentifier& id) : id(id) { }
        virtual llvm::Value* codeGen(CodeGenContext& context);
    };

    class NBinaryOperator : public NExpression {
    public:
        int op;
        NExpression& lhs;
        NExpression& rhs;
        NBinaryOperator(NExpression& lhs, int op, NExpression& rhs) :
            lhs(lhs), rhs(rhs), op(op) { }
        virtual llvm::Value* codeGen(CodeGenContext& context);
    };

    class NAssignment : public NExpression {
    public:
        NIdentifier& lhs;
        NExpression& rhs;
        NAssignment(NIdentifier& lhs, NExpression& rhs) : 
            lhs(lhs), rhs(rhs) { }
        virtual llvm::Value* codeGen(CodeGenContext& context);
    };

    class NBlock : public NExpression {
    public:
        StatementList statements;
        NBlock() { }
        virtual llvm::Value* codeGen(CodeGenContext& context);
    };

    class NExpressionStatement : public NStatement {
    public:
        NExpression& expression;
        NExpressionStatement(NExpression& expression) : 
            expression(expression) { }
        virtual llvm::Value* codeGen(CodeGenContext& context);
    };

    class NVariableDeclaration : public NStatement {
    public:
        const NIdentifier& type;
        NIdentifier& id;
        NExpression *assignmentExpr;
        NVariableDeclaration(const NIdentifier& type, NIdentifier& id) :
            type(type), id(id) { }
        NVariableDeclaration(const NIdentifier& type, NIdentifier& id, NExpression *assignmentExpr) :
            type(type), id(id), assignmentExpr(assignmentExpr) { }
        virtual llvm::Value* codeGen(CodeGenContext& context);
    };

    class NFunctionDeclaration : public NStatement {
    public:
        const NIdentifier& type;
        const NIdentifier& id;
        VariableList arguments;
        NBlock& block;
        NFunctionDeclaration(const NIdentifier& type, const NIdentifier& id, 
                const VariableList& arguments, NBlock& block) :
            type(type), id(id), arguments(arguments), block(block) { }
        virtual llvm::Value* codeGen(CodeGenContext& context);
    };
    ```
  * > Again, fairly straightforward. We’re not using any getters or setters here, just public data members; there’s really no need for data hiding. Ignore the `codeGen` method for now. It will come in handy later, when we want to export our AST as `LLVM bytecode`. `||` `非常的清晰明了，我们省略了getter和setter方法，这里只列出了共有成员；这些类也不需要影藏私有数据，并省略了codeGen方法。在我们导出AST成LLVM的字节码时，就需要使用到这个方法。`
- > **Back to Bison**
  * > Anyway, here comes ***the most complex part and by the same token, the hardest to explain***. It’s not technically complicated, but I’d have to spend a while discussing the details of ***`Bison`’s syntax***, so let’s take a lot of it for granted right now. Realize this, though: we’ll be declaring the makeup of each of our valid statements and expressions (***the ones representing the nodes we’ve defined above***) using `terminal and non-terminal symbols`, basically like a `BNF grammar`. The syntax is also similar: `||` `bison的语法定义文件同样是由这些标记构成的最复杂的部分。这并不是说技术上有多复杂，但是我也会花一些时间来讨论一下Bison的语法细节，好，现在让我们立刻来熟悉一下Bison的语法。我们将使用基于类似于BNF的语法，使用定义的好终结符和非终结符来组成我们有效的每一个语句和表达式(这些语句和表达式就代表我们之前定义的AST节点)。例如：`
    ```console
    if_stmt : IF '(' condition ')' block { /* do stuff when this rule is encountered */ }
            | IF '(' condition ')'       { ... }
            ;
    ```
  * > The above would define an `if statement` (if we supported it). The real difference is that ***<ins>with each grammar comes a set of actions</ins> (inside the braces)*** which are ***executed after it is recognized***. This is done recursively over the symbols ***in leaf-to-root order***, where each `non terminal` is eventually merged into one big tree. ***<ins>The “`$$`” symbol you will be seeing represents the current root node of each leaf</ins>***. `||` `在上面例子中，我们定义了一个if语句(如果我们支持if语句话)，它和BNF不同之处在于，每个语法后面都跟了一系列动作(在’{'和’}'之间的内容)。这个动作将在此条语法被识别(译者注：归约)的时候被执行。这个过程将会递归地按从叶子符号到根节点符号的次序执行，在这个过程，每一个非终结符最终会被合并为一棵大的语法树。你将会看到的 "$$" 符号代表着当前树的跟节点(译者注："$$" 代表本条语法规则中冒号左边的部分的语义内容)。`
  * > Furthermore, ***“`$1`” represents the leaf for the 1st symbol in the rule***. In the above example, the “`$$`” we assigned from our “condition” rule would be available as “`$3`” in our “if_stmt” rule. It might start becoming clear how our AST ties into this. We will basically be assigning a node to “`$$`” at each of our rules which will eventually be merged into our final AST. If not, don’t worry. The `Bison` part of our toy language is again, the most complex portion of our language. It might take a while to sink in. Besides, you haven’t even seen the code yet, so, here it is: `||` `此外 "$1" 代表了本条规则叶子中的第一个符号(译者注："$1" 代表了本条语法规则冒号右边的内容，"$1" 代表冒号右边的第一个符号的语义值)。在上面的例子中，当 ’condition’ 有效时我们将会把 "$3" 赋值给。这个例子可以解释如何将我们AST和语法规则关联起来。我们将在每一条规则中通常赋值一个节点到，最后这些规则会合并成一个大的抽象语法树。Bison的部分是我们语言最复杂的部分，你需要花一点时间去理解它。此外到此为止，你还没有看到完整的代码。下面就是完整的Bison部分的代码：`
  * > Listing of ***`parser.y`***:
    ```yacc
    %{
        #include "node.h"
        NBlock *programBlock; /* the top level root node of our final AST */

        extern int yylex();
        void yyerror(const char *s) { printf("ERROR: %sn", s); }
    %}

    /* Represents the many different ways we can access our data */
    %union {
        Node *node;
        NBlock *block;
        NExpression *expr;
        NStatement *stmt;
        NIdentifier *ident;
        NVariableDeclaration *var_decl;
        std::vector<NVariableDeclaration*> *varvec;
        std::vector<NExpression*> *exprvec;
        std::string *string;
        int token;
    }

    /* Define our terminal symbols (tokens). This should
       match our tokens.l lex file. We also define the node type
       they represent.
     */
    %token <string> TIDENTIFIER TINTEGER TDOUBLE
    %token <token> TCEQ TCNE TCLT TCLE TCGT TCGE TEQUAL
    %token <token> TLPAREN TRPAREN TLBRACE TRBRACE TCOMMA TDOT
    %token <token> TPLUS TMINUS TMUL TDIV

    /* Define the type of node our nonterminal symbols represent.
       The types refer to the %union declaration above. Ex: when
       we call an ident (defined by union type ident) we are really
       calling an (NIdentifier*). It makes the compiler happy.
     */
    %type <ident> ident
    %type <expr> numeric expr 
    %type <varvec> func_decl_args
    %type <exprvec> call_args
    %type <block> program stmts block
    %type <stmt> stmt var_decl func_decl
    %type <token> comparison

    /* Operator precedence for mathematical operators */
    %left TPLUS TMINUS
    %left TMUL TDIV

    %start program

    %%

    program : stmts { programBlock = $1; }
            ;
            
    stmts : stmt { $$ = new NBlock(); $$->statements.push_back($<stmt>1); }
          | stmts stmt { $1->statements.push_back($<stmt>2); }
          ;

    stmt : var_decl | func_decl
         | expr { $$ = new NExpressionStatement(*$1); }
         ;

    block : TLBRACE stmts TRBRACE { $$ = $2; }
          | TLBRACE TRBRACE { $$ = new NBlock(); }
          ;

    var_decl : ident ident { $$ = new NVariableDeclaration(*$1, *$2); }
             | ident ident TEQUAL expr { $$ = new NVariableDeclaration(*$1, *$2, $4); }
             ;
            
    func_decl : ident ident TLPAREN func_decl_args TRPAREN block 
                { $$ = new NFunctionDeclaration(*$1, *$2, *$4, *$6); delete $4; }
              ;
        
    func_decl_args : /*blank*/  { $$ = new VariableList(); }
              | var_decl { $$ = new VariableList(); $$->push_back($<var_decl>1); }
              | func_decl_args TCOMMA var_decl { $1->push_back($<var_decl>3); }
              ;

    ident : TIDENTIFIER { $$ = new NIdentifier(*$1); delete $1; }
          ;

    numeric : TINTEGER { $$ = new NInteger(atol($1->c_str())); delete $1; }
            | TDOUBLE { $$ = new NDouble(atof($1->c_str())); delete $1; }
            ;
        
    expr : ident TEQUAL expr { $$ = new NAssignment(*$<ident>1, *$3); }
         | ident TLPAREN call_args TRPAREN { $$ = new NMethodCall(*$1, *$3); delete $3; }
         | ident { $<ident>$ = $1; }
         | numeric
         | expr comparison expr { $$ = new NBinaryOperator(*$1, $2, *$3); }
         | TLPAREN expr TRPAREN { $$ = $2; }
         ;
        
    call_args : /*blank*/  { $$ = new ExpressionList(); }
              | expr { $$ = new ExpressionList(); $$->push_back($1); }
              | call_args TCOMMA expr  { $1->push_back($3); }
              ;

    comparison : TCEQ | TCNE | TCLT | TCLE | TCGT | TCGE 
               | TPLUS | TMINUS | TMUL | TDIV
               ;

    %%
    ```
- > **Generating Our Code**
  * > So we have our “***`tokens.l`***” file for `Flex` and our “***`parser.y`***” file for `Bison`. To generate our C++ source files from these definition files we need to pass them through the tools. Note that `Bison` will also be creating a “***`parser.hpp`***” header file for `Flex`; it does this because of the `–d` switch, which separates our token declarations from the source so we can include and use those tokens elsewhere. The following commands should create our ***`parser.cpp`***, ***`parser.hpp`*** and ***`tokens.cpp`*** source files. `||` `现在我们有了Flex的token.l文件和Bison的parser.y文件。我们需要将这两个文件传递给工具，并由工具来生成c++代码文件。注意Bison同时会为Flex生成parser.hpp头文件；这样做是通过-d开关实现的，这个开关是的我们的标记声明和源文件分开，这样就是的我们可以让这些token标记被其他的程序使用。下面的命令创建parser.cpp，parser.hpp和tokens.cpp源文件。`
    ```sh
    $ bison -d -o parser.cpp parser.y
    $ lex -o tokens.cpp tokens.l
    ```
  * > If everything went well we should now have ***2 out of 3*** parts of our compiler. If you want to test this, create a short main function in a `main.cpp` file:
  * > Listing of `main.cpp`:
    ```cpp
    #include <iostream>
    #include "node.h"
    extern NBlock* programBlock;
    extern int yyparse();

    int main(int argc, char **argv)
    {
        yyparse();
        std::cout << programBlock << std::endl;
        return 0;
    }
    ```
  * > You can then compile your source files:
    ```sh
    $ g++ -o parser parser.cpp tokens.cpp main.cpp
    ```
  * > You will need to have installed `LLVM` by now for the `llvm::Value` reference in “***`node.h`***”. If you don't want to go that far just yet, you can comment out the `codeGen()` methods in ***`node.h`*** to test just your lexer/parser combo. `||` `现在你需要安装LLVM了，因为llvm::Value被node.h引用了。如果你不想这么做，只是想测试一下Flex和Bison部分，你可以注释掉node.h中codeGen()方法。`
  * > If all goes well you should now have a “parser” binary that takes source in `stdin` and prints out a hopefully ***nonzero address representing the root node*** of our AST in memory. `||` `如果上述工作都完成了，你现在将有一个语法分析器，这个语法分析器将从标准输入读入，并打出在内存中代表抽象语法树跟节点的内存非零地址。`
- > **Step 3. Assembling the AST with LLVM**

## 个人实战

```sh
# 开始还以为 CentOS 装 g++ 的语句是：yum install -y g++ 
yum install -y gcc-c++
yum install -y clang clang-devel llvm-devel

# 然和各种编不过，太生草了。。。这个文章时间太落后了，比如 node.h 头文件包含里的 Value.h 位置都变了。。。
# 现在应该是 #include "llvm/IR/Value.h" 而不是 #include "llvm/Value.h" 了。 https://llvm.org/doxygen/classllvm_1_1Value.html
# 然而还是不行，烦死了。猜测是目前 llvm 版本远超写文章时的 2.6 版本造成的。。。看到有人说折腾 llvm 折腾了一天，算了，先不管了，没那么多时间。
g++ -o parser parser.cpp tokens.cpp main.cpp `llvm-config --libs core jit native --cxxflags --ldflags`
```

# 2

TiDB SQL Parser 的实现 https://cn.pingcap.com/blog/tidb-source-code-reading-5/ || https://cloud.tencent.com/developer/article/1070299

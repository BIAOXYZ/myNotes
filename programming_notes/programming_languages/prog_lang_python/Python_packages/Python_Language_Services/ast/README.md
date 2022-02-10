
# 官方

ast --- 抽象语法树 https://docs.python.org/zh-cn/3/library/ast.html

# 其他

Python 3.x: how to use ast to search for a print statement https://stackoverflow.com/questions/57806591/python-3-x-how-to-use-ast-to-search-for-a-print-statement

Python ast.Str() Examples https://www.programcreek.com/python/example/4603/ast.Str

Python AST 抽象语法树 https://www.jianshu.com/p/a6a9c7010e1b

How to work with python ast module to analyse if-statements https://stackoverflow.com/questions/58547854/how-to-work-with-python-ast-module-to-analyse-if-statements
- Deciphering Python: How to use Abstract Syntax Trees (AST) to understand code https://www.mattlayman.com/blog/2018/decipher-python-ast/

## 从抽象语法树反向生成代码

convert AST node to python code https://stackoverflow.com/questions/40029973/convert-ast-node-to-python-code

Given an AST, is there a working library for getting the source? https://stackoverflow.com/questions/3774162/given-an-ast-is-there-a-working-library-for-getting-the-source

Parse a .py file, read the AST, modify it, then write back the modified source code https://stackoverflow.com/questions/768634/parse-a-py-file-read-the-ast-modify-it-then-write-back-the-modified-source-c

# `ast.literal_eval()`

How to differentiate eval() and ast.literal_eval() in Python https://www.kite.com/python/answers/how-to-differentiate-eval()-and-ast.literal_eval()-in-python
- > Both `eval()` and `ast.literal_eval()` evaluate strings containing Python code in the current Python environment, ***but `ast.literal_eval()` restricts its evaluation to a subset of valid Python datatypes***, while `eval()` does not.

Using python's eval() vs. ast.literal_eval() https://stackoverflow.com/questions/15197673/using-pythons-eval-vs-ast-literal-eval

Python中eval与ast.literal_eval区别 https://blog.csdn.net/Jerry_1126/article/details/68831254
- > 简单点说 `ast` 模块就是帮助Python应用来处理抽象的语法解析的。而该模块下的 `literal_eval()` 函数：则会判断需要计算的内容计算后是不是合法的python类型，如果是则进行运算，否则就不进行运算。

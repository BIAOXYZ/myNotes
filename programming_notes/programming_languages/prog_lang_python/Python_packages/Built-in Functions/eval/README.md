
深度辨析 Python 的 eval() 与 exec() https://juejin.cn/post/6844903805931225095
- > **1、`eval` 的基本用法**
  * > 语法：`eval(expression, globals=None, locals=None)`
  * > 它有三个参数，其中 expression 是一个字符串类型的表达式或代码对象，用于做运算；globals 与 locals 是可选参数，默认值是 None。
  * > 具体而言，expression 只能是单个表达式，不支持复杂的代码逻辑，例如赋值操作、循环语句等等。（PS：单个表达式并不意味着“简单无害”，参见下文第 4 节）
  * > globals 用于指定运行时的全局命名空间，类型是字典，缺省时使用的是当前模块的内置命名空间。locals 指定运行时的局部命名空间，类型是字典，缺省时使用 globals 的值。两者都缺省时，则遵循 eval 函数执行时的作用域。值得注意的是，这两者不代表真正的命名空间，只在运算时起作用，运算后则销毁。
- > **2、`exec` 的基本用法**
- > **3、一些细节辨析**
  * > 两个函数都很强大，它们将字符串内容当做有效的代码执行。这是一种字符串驱动的事件 ，意义重大。然而，在实际使用过程中，存在很多微小的细节，此处就列出我所知道的几点吧。
  * > 常见用途：将字符串转成相应的对象，例如 string 转成 list ，string 转成 dict，string 转 tuple 等等。
  * > `eval()` 函数的返回值是其 expression 的执行结果，在某些情况下，它会是 None，例如当该表达式是 print() 语句，或者是列表的 append() 操作时，这类操作的结果是 None，因此 `eval()` 的返回值也会是 None。
  * > `exec()` 函数的返回值只会是 None，与执行语句的结果无关，所以，将 `exec()` 函数赋值出去，就没有任何必要。所执行的语句中，如果包含 return 或 yield ，它们产生的值也无法在 `exec` 函数的外部起作用。
  * > `compile()` 函数编译后的 code 对象，可作为 `eval` 和 `exec` 的第一个参数。`compile()` 也是个神奇的函数，我翻译的上一篇文章《[Python骚操作：动态定义函数](https://mp.weixin.qq.com/s/o-HuE3VxgHedfe8X5fUrMA)》就演示了一个动态定义函数的操作。
- > **4、为什么要慎用 eval() ？**
  * > 为什么要慎用 `eval()` 呢？主要出于安全考虑，对于不可信的数据源，`eval` 函数很可能会招来代码注入的问题。
    ```py
    >>> eval("__import__('os').system('whoami')")
    desktop-fa4b888\pythoncat
    >>> eval("__import__('subprocess').getoutput('ls ~')")
    #结果略，内容是当前路径的文件信息
    ```
    > 在以上例子中，我的隐私数据就被暴露了。而更可怕的是，如果将命令改为 `rm -rf ~` ，那当前目录的所有文件都会被删除干净。 <br> 针对以上例子，有一个限制的办法，即指定 globals 为 `{'__builtins__': None}` 或者 `{'__builtins__': {}}` 。
- > **5、安全的替代用法**
  * > `ast` 模块的 `literal()` 是 `eval()` 的安全替代，与 `eval()` 不做检查就执行的方式不同，`ast.literal()` 会先检查表达式内容是否有效合法。它所允许的字面内容如下：
    ```py
    strings, bytes, numbers, tuples, lists, dicts, sets, booleans, 和 None
    ```
    > 一旦内容非法，则会报错：
    ```py
    import ast
    ast.literal_eval("__import__('os').system('whoami')")
    
    报错：ValueError: malformed node or string
    ```
  * > 不过，它也有缺点：AST 编译器的栈深（stack depth）有限，解析的字符串内容太多或太复杂时，可能导致程序崩溃。
  * > 至于 `exec()` ，似乎还没有类似的替代方法，毕竟它本身可支持的内容是更加复杂多样的。

What's the difference between eval, exec, and compile? https://stackoverflow.com/questions/2220699/whats-the-difference-between-eval-exec-and-compile
- https://stackoverflow.com/questions/2220699/whats-the-difference-between-eval-exec-and-compile/29456463#29456463

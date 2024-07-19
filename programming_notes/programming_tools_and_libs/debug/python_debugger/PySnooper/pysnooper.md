
# PySnooper常用配置

## 1

目前最常用配置（小规模程序直接单步就可以，都没必要用到 pysnooper。而大规模程序基本都是靠日志的，所以上来就设置 `color=False` 在大型程序下基本是刚需；当然，如果是打印到标准输出，还是带上颜色好。）：
```py
import pysnooper

@pysnooper.snoop(color=False, prefix="##########", max_variable_length=None)
```

## 2

```py
# sd 是自己起的名字 snoop_decorator 的缩写
sd = lambda func: __import__('pysnooper').snoop(color=False, prefix="##########", max_variable_length=None)(func)

# 然后装饰器加到需要调试的函数上即可
@sd
def your_func():
    pass
```

```py
sd = lambda func: __import__('pysnooper').snoop(color=False, prefix="##########", max_variable_length=None)(func)

@sd
def func1(x):
    return x + 1

@sd
def func2(x):
    return x * 2

if __name__ == "__main__":
    print("func1 Result:", func1(3))
    print("func2 Result:", func2(3))
```
```console
$ python3 tmp.py
##########Source path:... tmp.py
##########Starting var:.. x = 3
##########02:28:39.685348 call         4 def func1(x):
##########02:28:39.685540 line         5     return x + 1
##########02:28:39.685572 return       5     return x + 1
##########Return value:.. 4
##########Elapsed time: 00:00:00.000480
func1 Result: 4
##########Source path:... tmp.py
##########Starting var:.. x = 3
##########02:28:39.685648 call         8 def func2(x):
##########02:28:39.685690 line         9     return x * 2
##########02:28:39.685710 return       9     return x * 2
##########Return value:.. 6
##########Elapsed time: 00:00:00.000101
func2 Result: 6
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# PySnooper官方

PySnooper - Never use print for debugging again https://github.com/cool-RR/PySnooper
- Advanced Usage https://github.com/cool-RR/PySnooper/blob/0f1e67b26b94584e7c7e7e463cf43d506135fe4c/ADVANCED_USAGE.md
  * > Start all snoop lines with a prefix, to grep for them easily:
    ```py
    @pysnooper.snoop(prefix='ZZZ ')
    ```
  * > The output is colored for easy viewing by default, except on Windows. Disable colors like so:
    ```py
    @pysnooper.snoop(color=False)
    ```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# PySnooper文章

理解Python的神器PySnooper调试程序 https://www.byto.top/article/PySnooper-basis/
- > **高级用法**
  * > 默认情况下，变量和异常被截断为100个字符。您可以自定义：
    ```py
    @pysnooper.snoop(max_variable_length = 200)
    ```
    > 您也可以使用 `max_variable_length=None` 它从不截断它们。

实时可视化Debug：VS Code 开源新工具，一键解析代码结构 - 机器之心的文章 - 知乎 https://zhuanlan.zhihu.com/p/109212146
- > 项目地址： https://github.com/hediet/vscode-debug-visualizer
- > 之前机器之心曾介绍过极简 DeBug 工具 [PySnooper]() ，我们只需要向感兴趣的函数增加一个装饰器，就能得到该函数的详细 log，包含哪行代码能运行、什么时候运行以及本地变量变化的确切时间等等。
- > 效果上确实非常惊艳，它与之前的 DeBug 方式采用完全不同的展现形式。目前该 VS Code Debug Visualizer 在 JavaScript/TypeScript 上有比较好的效果，在 C#、Java 和 PHP 上也正在积极测试，其它语言也还都能用。

Python 代码调试神器：PySnooper https://www.cnblogs.com/wongbingming/p/13974982.html

PySnooper 源码阅读 https://zdyxry.github.io/2019/04/27/PySnooper-%E6%BA%90%E7%A0%81%E9%98%85%E8%AF%BB/

史上最方便的Python Debug工具|腾讯技术说 - 腾讯技术工程的文章 - 知乎 https://zhuanlan.zhihu.com/p/65750184

Python 代码调试神器：PySnooper https://www.cnblogs.com/wongbingming/p/13974982.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

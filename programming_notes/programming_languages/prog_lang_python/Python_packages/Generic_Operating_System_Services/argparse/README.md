
# 官方

argparse --- 命令行选项、参数和子命令解析器 https://docs.python.org/zh-cn/3/library/argparse.html || argparse — Parser for command-line options, arguments and sub-commands https://docs.python.org/3/library/argparse.html

Argparse 教程 https://docs.python.org/zh-cn/3/howto/argparse.html

# 其他

Build Command-Line Interfaces With Python's argparse https://realpython.com/command-line-interfaces-python-argparse/

argparse模块用法实例详解 - HiDaDeng的文章 - 知乎 https://zhuanlan.zhihu.com/p/56922793

Python-argparse-命令行与参数解析 - Devin Yang的文章 - 知乎 https://zhuanlan.zhihu.com/p/34395749

# 问题

## `argparse` 所在的文件被其他模块导入时，有时会有问题

### 比较粗糙的解决办法就是这种，适用于 `argparse` 所在的文件只会被当成主模块来运行的情况

python import of script with argparse [closed] https://stackoverflow.com/questions/19977741/python-import-of-script-with-argparse
- https://stackoverflow.com/questions/19977741/python-import-of-script-with-argparse/19978792#19978792
  * > In your script A, check if you are the "main script" before parsing arguments and doing A job, otherwise this will be ran too when you only need to use A as a library.
    ```py
    if __name__ == "__main__":
        parser = argparse.ArgumentParser()
        parser.add_argument("-k", dest = "foo",  action='store_true')
        args = parser.parse_args()
        # do things...
    ```

### 使用 `args=[]` —— 但是不确定是不是所有情况都有效。

解决SystemExit: 2，args = parser.parse_args() 的问题 https://blog.csdn.net/sinat_39620217/article/details/126579156
- > **解决方法一：**
  ```py
  args = parser.parse_args()
  改成
  args = parser.parse_args(args=[])
  ```
  > 原因分析：
  ```py
  parse_args(args=["-n3"，"-b2"]) #表示给n参数赋值为3，b参数赋值为2。其他参数默认。
  parse_args(args=[]) #表示所有参数使用默认。
  ```
  > 而我们的报错情况是形式1，一旦执行parse_args()语句，python系统就会执行读取参数的操作（我们看不到），此时jupyter notebook系统默认会给一个奇怪的参数：
  > 因此：将 `parse_args()` 由形式1换成形式2。

SystemExit: 2 error when calling parse_args() within ipython https://stackoverflow.com/questions/42249982/systemexit-2-error-when-calling-parse-args-within-ipython

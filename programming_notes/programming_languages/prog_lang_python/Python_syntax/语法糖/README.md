
Python 有哪些好玩的语法糖？ - 知乎 https://www.zhihu.com/question/57470958
- Python 有哪些好玩的语法糖？ - 路人甲的回答 - 知乎 https://www.zhihu.com/question/57470958/answer/153632413
  * > for/while 循环与 else 语句块搭配，当循环（for/while循环语句冒号后面的语句块）正常结束的时候才会执行一遍else语句块；如果是非正常结束的（例如break语句跳出，出现异常等情况），则不会执行else语句块。
    ```py
    for i in [1,1,2]:
        if i == 0:
            break
    else: print("i was never 0")
    ```
    ```console
    i was never 0
    ```
  * > 第三条的具体执行逻辑可以看一下这里（图片来自：[Python中else语句块（和if、while、for、try搭配使用） - 目标120 - 博客园](http://www.cnblogs.com/zyq-blog/p/5590816.html)） <br> ![](https://pic1.zhimg.com/80/v2-4c35e17e33de2b96a2bc098572a1985d_1440w.jpg?source=1940ef5c)

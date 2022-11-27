
ln -s 软链接的问题 https://www.v2ex.com/t/898104
```console
1.代码仓库是 /codebase/test_version 2.代码访问路径是 /code/test
现在想要的目的是把 test_version 代码软链接到 test 下 但是操作出来的效果是 /code/test/test_version 所以想知道正确的命令是什么
```
- > `ln -s /codebase/test_version /code/test`
- > 注意这两点就行：
  * > 1.软链接的时候使用完整的绝对路径。
  * > 2.记住 ***`ln` 和 `mv`, `cp` 的顺序是一毛一样的***。
- > 要注意的是，软链接是一个文件，不管你链接的是目录还是文件。所以不能存在 `/code/test` 这个文件或目录，<br> ***`ln -s /codebase/test_version /code/test/` 这种情况下，链接文件就会创建在 `/code/test/` 目录下***。
  >> 说的意思我大概明白了。但是我有一个疑问就是，比如我第一次软链接到 `/code/test/` 第二次执行的话，`/code/test` 已经存在了，我如果删除了 `/code/test` 那正访问该服务器的请求就挂了。这里不太理解 <br> 我是参考 walle 来写发版工具的，但是出来的结果不太一样。
  ```sh
  cd /codebase/ && ln -sfn /codebase/1_390_20221121_152026 /codebase/current-tmp-390
  cd /codebase/ && mv -fT /codebase/current-tmp-390 /code/test
  ```
  >>> 可能是存在 test 目录的问题。
- > 噢，对，最后不能加斜杠

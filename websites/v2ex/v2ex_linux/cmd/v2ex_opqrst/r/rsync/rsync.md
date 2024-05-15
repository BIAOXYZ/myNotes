
在不用 Git 的情况下，有什么软件能实现 git-status 的作用？ https://www.v2ex.com/t/837132
- > rsync 不是能列表吗？
  > 谢谢！忘了从这个角度想了 https://serverfault.com/questions/618735/how-to-output-a-list-of-changed-files-from-rsync 应该能基本解决问题
- > rsync 本身就能支持增量，你要获取列表 tee 日志输出一下就好了 <br> oss 也支持增量，参考一下 api 文档，就是一个 -u 参数的事情
  >> 记错了，oss 不是查 api ，是 ossutil 工具 <br> 给你找了，https://www.alibabacloud.com/help/zh/doc-detail/179388.htm#concept-1937458 <br> 所以其实你根本也不需要获取更新列表，直接调对象存储或网盘的 API 或接口就好了

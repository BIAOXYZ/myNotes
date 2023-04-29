
Linux 的 OOM Killer 机制分析 http://senlinzhan.github.io/2017/07/03/oom-killer/

oom killer 详解 https://www.cnblogs.com/xibuhaohao/p/11087922.html

OOM Killer机制 https://blog.csdn.net/weixin_48101150/article/details/117220082

阻止被linux-OOM-kill https://www.jianshu.com/p/5a908df47188
- > 设置进程 `oom_score_adj` 为负数来避免被kill
  * > 可以设置 `-200`
  * > `-1000` 代表完全禁止被kill

出现OOM Killer的原因与解决方案 https://help.aliyun.com/document_detail/316785.html

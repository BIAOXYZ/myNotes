
# 官方

git-shortlog - Summarize git log output https://git-scm.com/docs/git-shortlog
```console
-n
--numbered
Sort output according to the number of commits per author instead of author alphabetic order.

-s
--summary
Suppress commit description and provide a commit count summary only.

-e
--email
Show the email address of each author.
```

# 参数解析

## `-s` `-n`

>> 这俩经常一起用。

# 其他帖子

git shortlog命令 https://www.yiibai.com/git/git_shortlog.html
```console
$ git shortlog
这个命令会返回这个 git repository 底下每个用户进行 commit 的次数，以及每次 commit 的注释。

-s 参数省略每次 commit 的注释，仅仅返回一个简单的统计。
-n 参数按照 commit 数量从多到少的顺利对用户进行排序
```

# 个人实战

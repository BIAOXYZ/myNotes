
# 官方

git-log - Show commit logs https://git-scm.com/docs/git-log
```console
--oneline
This is a shorthand for "--pretty=oneline --abbrev-commit" used together.
```

2.3 Git Basics - Viewing the Commit History https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History
- > One of the more helpful options is `-p` or `--patch`, which shows the difference (the patch output) introduced in each commit. You can also limit the number of log entries displayed, such as using `-2` to show ***only the last two entries***.

# 参数解析

## `--merges`

>> 只显示merge commits。

## `--oneline`

## `-p`

## `--reverse`
>> 顾名思义，从最早的commit开始，倒着显示。

# 其他帖子

Advanced Git log https://www.atlassian.com/git/tutorials/git-log
- > **Oneline**
  * > The `--oneline` flag condenses each commit to a single line. By default, it displays only the commit ID and the first line of the commit message. Your typical `git log --oneline` output will look something like this:
    ```console
    0e25143 Merge branch 'feature'
    ad8621a Fix a bug in the feature
    16b36c6 Add a new feature
    23ad9ad Add the initial code base 
    ```
- > **Decorating**
  * > Many times it’s useful to know which branch or tag each commit is associated with. The `--decorate` flag makes git log display all of the references (e.g., branches, tags, etc) that point to each commit.
  * > This can be combined with other configuration options. For example, running `git log --oneline --decorate` will format the commit history like so:
    ```console
    0e25143 (HEAD, main) Merge branch 'feature'
    ad8621a (feature) Fix a bug in the feature
    16b36c6 Add a new feature
    23ad9ad (tag: v0.9) Add the initial code base
    ```

# 个人实战

## 找到 github 上某个项目最早的 commit

如何快速查看github代码库中第一次commit的记录 https://www.cnblogs.com/saysmy/p/7292177.html
```console
点击一次older发现url格式为：

https://github.com/lodash/lodash/commits/master?after=c2616dd4f3ab267d000a2b4f564e1c76fc8b8378+34

后面的after即代表展示 SHA为c2616dd4f3ab267d000a2b4f564e1c76fc8b8378 的后面第35条commit。
```

How to navigate to the earliest commit in a repository? https://stackoverflow.com/questions/28533602/how-to-navigate-to-the-earliest-commit-in-a-repository
- https://stackoverflow.com/questions/28533602/how-to-navigate-to-the-earliest-commit-in-a-repository/49647826#49647826
  * > There's no obvious UI to do this, but there is a way to construct the right URL to go to page one of the commit log.
  * > Suppose we want to find the first commit of the [dotnet/runtime repository](https://github.com/dotnet/runtime). First take a note of the number of commits in the repository: it is currently `125,882`. Now go to the list of commits (click on commit count), and click "Older" once. The URL will be something like this: https://github.com/dotnet/runtime/commits/main?after=2aec3816f9bbc0eda3261daa335a05ea0df31b9c+34
  * >   Notice the `+34` part. That's how many commits are skipped. Change that to `125,882` minus `1` minus `35` per page, that gives us [this URL](https://github.com/dotnet/runtime/commits/main?after=2aec3816f9bbc0eda3261daa335a05ea0df31b9c+125846), which takes you right to the first page of the dotnet/runtime commit history.
    >> //notes：`125846 = 125882 - 1 - 35` —— 也就是先点 `Older`（现在网页上显示的是 `Next` 了），然后把网址末尾的`+34`改成加仓库总的commit数减去 `36` 后那个数字。

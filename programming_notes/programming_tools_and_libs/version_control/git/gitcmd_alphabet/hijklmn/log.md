
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

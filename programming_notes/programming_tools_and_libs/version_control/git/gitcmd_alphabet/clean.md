
# 官方

git-clean - Remove untracked files from the working tree https://git-scm.com/docs/git-clean

# 参数解析

## `-d`
> `Remove untracked directories in addition to untracked files. If an untracked directory is managed by a different Git repository, it is not removed by default. Use -f option twice if you really want to remove such a directory.`

## `-f` = `--force`
>> notes：

## `-n` = `--dry-run`
>> notes：

## `-x`
>> notes：

## `-X`
>> notes：

# 其他帖子

How to remove local (untracked) files from the current Git working tree? https://stackoverflow.com/questions/61212/how-to-remove-local-untracked-files-from-the-current-git-working-tree
- https://stackoverflow.com/questions/61212/how-to-remove-local-untracked-files-from-the-current-git-working-tree/64966#64966
- https://stackoverflow.com/questions/61212/how-to-remove-local-untracked-files-from-the-current-git-working-tree/14521765#14521765
  ```sh
  If untracked directory is a git repository of its own (e.g. submodule), you need to use -f twice:
  
  git clean -d -f -f
  ```

七个你无法忽视的Git使用技巧 http://blog.csdn.net/leedaning/article/details/50125375
```console
6. 从当前Git分支移除未追踪的本地文件
假设你凑巧有一些未被追踪的文件（因为不再需要它们），不想每次使用git status命令时让它们显示出来。下面是解决这个问题的一些方法：

$ git clean -f -n         # 1
$ git clean -f            # 2
$ git clean -fd           # 3
$ git clean -fX           # 4
$ git clean -fx           # 5

(1): 选项-n将显示执行（2）时将会移除哪些文件。
(2): 该命令会移除所有命令（1）中显示的文件。
(3): 如果你还想移除文件件，请使用选项-d。
(4): 如果你只想移除已被忽略的文件，请使用选项-X。
(5): 如果你想移除已被忽略和未被忽略的文件，请使用选项-x。
```

git如何删除本地所有未提交的更改 https://www.v2ex.com/t/66718
```sh
git clean -df 一般用这个就可以，但是注意要选对目录:目录太低删不干净。
git clean -ndf 有-n参数就是只是显示哪些会被删，但不做删除
git clean -xdf -x参数的意义如下：

默认情况下，git clean 命令只会移除没有忽略的未跟踪文件。 任何与 .gitiignore 
或其他忽略文件中的模式匹配的文件都不会被移除。 如果你也想要移除那些文件，例如
为了做一次完全干净的构建而移除所有由构建生成的 .o 文件，可以给 clean 命令增加一个 -x 选项。
(https://git-scm.com/book/zh/v2/Git-%E5%B7%A5%E5%85%B7-%E5%82%A8%E8%97%8F%E4%B8%8E%E6%B8%85%E7%90%86)
```

# 个人实战

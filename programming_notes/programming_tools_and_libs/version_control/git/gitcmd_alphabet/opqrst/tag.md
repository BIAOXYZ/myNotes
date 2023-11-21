
# git tag

git笔记：tag常用操作，查询，拉取，合并，推送，创建，删除 https://www.cnblogs.com/Wind-stormger/p/17381535.html
```console
git tag -l  列出所有tag
git tag -d <tagname>  删除本地指定tag
git fetch <remote> --prune  从远程拉取所有信息
git ls-remote --tags <remote>  查询远程tags
git fetch <remote> --tags  从远程拉取所有tags
~~git fetch <remote> --tags <tagname> 从远程拉取指定tags~~  -->  这个还是拉取所有tag了，正确的应该是： git fetch <remote> tag <tagname>
git pull <remote> --tags  合并远程的所有tags到本地
git pull <remote> --tags <tagname>  合并远程的指定tags到本地
git push <remote> --tags  推送所有本地tag到远程
git push <remote> --tags <tagname>  推送指定本地tag到远程
git push <remote> :refs/tags/<tagname>  删除远程tag版本
git branch -a --contains <tagname>  看看哪个分支包含这个 tag/commit
git tag -l <tagname>  列出符合条件的tag（筛选作用），例如 v1.*
git tag <tagname>  创建轻量tag（无-m标注信息）
git tag -a <tagname>  创建含注解的tag
git show <tagname>  显示指定tag详细信息
```

易百教程 -- git tag命令 https://www.yiibai.com/git/git_tag.html

廖雪峰git教程 -- 标签管理 https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/0013762144381812a168659b3dd4610b4229d81de5056cc000
```
git tag   查看当前所有tag
git show tagname    查看名为tagname的tag的信息
git tag -a tagname -m "tag message" [commit id]   在commit id上增加名为tagname，信息为tag message的tag
git tag -d tagname  删除名为tagname的tag
git push origin v1.0  推送v1.0标签到origin
git push origin --tags 推送所有标签到origin
git push origin :refs/tags/v0.9 将本地的v0.9标签删除操作推送到远程
                              （之前当然要先本地执行删除tag操作: git tag -d v0.9）
```

Git查看、删除、重命名远程分支和tag https://yq.aliyun.com/articles/382627
```
git push origin --delete tag v1.0  删除远程tag的另一种（更自然的）方式
git fetch origin tag v1.0  从远程获取tag

另外这个贴里面关于分支的操作也不错，补一些：
git remote show branchname (以前只是用git remote show，这样只会显示所有分支名。加了分支名称后显示信息很详细)
git remote prune origin 或 git fetch -p (删除不存在对应远程分支的本地分支————这个回来再研究下吧) 
git branch -av 比git branch -a显示信息全多了
```

.6 Git 基础 - 打标签 https://git-scm.com/book/zh/v1/Git-%E5%9F%BA%E7%A1%80-%E6%89%93%E6%A0%87%E7%AD%BE

How to Delete a Remote Git Tag from the Git Server https://www.systutorials.com/how-to-delete-a-remote-git-tag-from-the-git-server/
- > To delete a remote git tag TAG, run
  ```sh
  git push --delete origin TAG
  ```
- > If the git repository uses the same name for some tags and branches (because git tags and branches are in different namespace and a tag and a branch can have the same name), use the full ref as follows.
  ```sh
  git push --delete origin refs/tags/TAG
  ```
- > Note: after deleting the remote git tag, the locally cloned repository still has the tag. The local git tag can be removed by `git tag -d TAG`.
- > Please note, the remote tag deletion operation is not a commit and this operation is not revertible.

# tag 相关命令

>> 起因是这样的：某个项目（`tf-encrypt`）clone下来后，准备新建个分支并切到某个 tag 对应的代码（就比如 `0.3.0` 吧）。但是有个环境（在 VMware Fusion 里装的 Ubuntu 虚拟机）直接 `git checkout -b 0.3.0 origin/0.3.0` 成功了，有个环境没成功。。。于是想到直接查找该tag对应的commit id，然后用commit id去切换。后来查了下，有两种最简单的做法。其中第一种好像只适用于 “**Unannotated tags**”。
```sh
$ git tag
0.1.0
0.2.0
0.3.0
0.4.0
0.5.0
0.5.1
0.5.2
0.5.3
0.5.4
0.5.5
0.5.6
0.5.7
0.5.8
0.5.9
0.6.0-rc0
$
$ git show-ref -s 0.3.0
0f3eb51ff720edd69e50c50647f81cfe09ccad0c
$ git rev-list -n 1 0.3.0
0f3eb51ff720edd69e50c50647f81cfe09ccad0c
$
```

Get the commit hash for a tag https://stackoverflow.com/questions/16818025/get-the-commit-hash-for-a-tag
- https://stackoverflow.com/questions/16818025/get-the-commit-hash-for-a-tag/16818124#16818124

How to tell which commit a tag points to in Git? https://stackoverflow.com/questions/1862423/how-to-tell-which-commit-a-tag-points-to-in-git
- https://stackoverflow.com/questions/1862423/how-to-tell-which-commit-a-tag-points-to-in-git/1862542#1862542

## 最常见流程：先从远端 fetch 某个（而不是全部）特定 tag，再本地基于该 tag 创建一个新分支
```sh
$ git fetch origin tag r1.9.0
$ git checkout -b r1.9.0 tags/r1.9.0
Switched to a new branch 'r1.9.0'
```

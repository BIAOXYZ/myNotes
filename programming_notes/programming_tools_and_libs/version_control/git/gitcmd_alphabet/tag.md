
# git tag

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

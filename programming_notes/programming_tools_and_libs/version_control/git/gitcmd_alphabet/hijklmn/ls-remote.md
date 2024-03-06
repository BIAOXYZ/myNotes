
# 官方

git-ls-remote - List references in a remote repository https://git-scm.com/docs/git-ls-remote.html

# 其他

## 查看远端所有分支
>> //notes：远端仓库（如`origin`）也可以直接用网址的形式： `git ls-remote --heads https://github.com/git/git.git`
>>> //notes2：***一般情况下，直接省略远端地址使用就可以***： `git ls-remote --heads`

How do I list all remote branches in Git 1.7+? https://stackoverflow.com/questions/3471827/how-do-i-list-all-remote-branches-in-git-1-7
- https://stackoverflow.com/questions/3471827/how-do-i-list-all-remote-branches-in-git-1-7/3472296#3472296
  * > For the vast majority of visitors here, the correct and simplest answer to the question "How do I list all remote branches in Git 1.7+?" is:
    ```sh
    git branch -r
    ```
  * > For a small minority `git branch -r` does not work. If `git branch -r` does not work try:
    ```sh
    git ls-remote --heads <remote-name>
    ```
  * > If `git branch -r` does not work, then maybe as Cascabel says ["you've modified the default refspec, so that `git fetch` and `git remote update` don't fetch all the remote's branches"](https://stackoverflow.com/questions/3471827/how-do-i-list-all-remote-branches-in-git-1-7#comment3623773_3471827).
  * > As of the writing of this footnote 2018-Feb, I looked at the comments and see that the `git branch -r` works for the vast majority (about 90% or 125 out of 140).
  * > If `git branch -r` does not work, check `git config --get remote.origin.fetch` contains a wildcard (`*`) as per this answer

## 查看远端的 tags
>> //notes：远端仓库（如`origin`）也可以直接用网址的形式： `git ls-remote --tags https://github.com/git/git.git`

How to see remote tags? https://stackoverflow.com/questions/25984310/how-to-see-remote-tags
- https://stackoverflow.com/questions/25984310/how-to-see-remote-tags/25987991#25987991
  * > You can list the tags on remote repository with ls-remote, and then check if it's there. Supposing the remote reference name is origin in the following.
    ```sh
    git ls-remote --tags origin
    ```
  * > And you can list tags local with tag.
    ```sh
    git tag
    ```

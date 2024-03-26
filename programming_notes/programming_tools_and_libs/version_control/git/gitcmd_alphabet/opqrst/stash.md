
# 其他文章

How to see stashed changes using git stash https://howto.lintel.in/how-to-see-stashed-changes-using-git-stash/
- > You can list all stashed change using the command  git stash list,
  ```sh
  $ git stash list
  stash@{0}: 
  stash@{1}:
  stash@{2}:
  stash@{3}:
  ```
- > Every time you stash your working directory, git will save the state of working directory into somethine which mantins history of stash tree. Every time you stash your changes it will be save as a kind of commit in stash tree. All stashed changes are stacked in the order with serial or reference. `stash@{0}` is the first or top most or recent stash. Every time if you want to refer a particular stash you have to use the it’s reference id something like `stash@{3}`, `stash@{5}`… etc
- > **Think of each stash as a separate  commit. These commits are stored and stacked differently and not overlapped with conventional git commit history** 
- > The following command can be used to extract diff of stashed change againest any other stash or commit or branch or HEAD.
  ```sh
  git stash show
  git show
  git diff
  git difftool
  ```
- > **Command `git stash show`**
  * > The simple command **`git stash show`** gives very brief summary of changes of file, but will not show the diff of changes against current `HEAD`. Something like,
    ```sh
    git stash show
    etc/project.conf | 6 +-----
    1 file changed, 1 insertion(+), 5 deletions(-)
    ```
  * > Some times this is not so useful. You may want to see the difference against current `HEAD` or any specific commit or current directory.
  * > If you use **`git stash show`** along with option **`-p`**, It will show all changes.
    ```sh
    $ git stash show -p
    ```
  * > Check diff against selected stash.
    ```sh
    git stash show -p stash@{0}
    ```
- > **Command `git show`**
  * > Synopsis: 
    ```sh
    git show [options] <object>…
    ```
  * > To see top most stash difference against `HEAD`:
    ```sh
    $ git show stash
    ```
  * > To get diff of of selected stash against `HEAD`:
    ```sh
    $ git show stash@{1}
    ```
  * > See selected complete whole file as if stash is applied from selected stash:
    ```sh
    $ git show stash@{0}:<file_name>
    ```
  >> //notes：感觉 `git show stash@{0}` 或者等价的 ***`git show stash`*** 就差不多够用了- -注意，***`git show stash`*** 和上一部分里的 `git stash show` 本质上是完全不同的命令。。。一个的核心是 `show`，另一个的核心是 `stash`。
  >>> 【[:star:][`*`]】 //notes2：因此一个比较好的用法是先 `git stash show` （不用带 `-p`）看看有哪些文件改动；然后 `git show stash -- file_path` 看具体的改动。
    ```sh
    # 这里不是 git stash show 的结果错了，而是一共6个文件改动，只复制（因为还得改名字- -）整理了4个- -
    $ git stash show
     src/prefix1/prefix2/xxxxx.py                          |  14 +++++++++++++-
     src/prefix1/prefix2/test/yyyyyyyyyyyy.py              |  24 ++++++++++++++++++++++++
     src/prefix1/prefix2/zzz.sh                            |  40 ++++++++++++++++++++--------------------
    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------
     src/prefix111/aaaaaaaaaaabbbbbbbbbbbbbbbbccccccccc.py |   8 +++++++-
     6 files changed, 192 insertions(+), 70 deletions(-)
    $
    # 这里改动详情略
    $ git show stash -- src/prefix1/prefix2/xxxxx.py
    ...
    ...
    ...
    ```
- > **Command `git diff`**
- > **Command `git difftool`**

【[:star:][`*`]】 Git stash https://www.atlassian.com/git/tutorials/saving-changes/git-stash
- > **Stashing untracked or ignored files**
  * > Adding the `-u` option (or `--include-untracked`) tells `git stash` to also stash your untracked files:
- > **Managing multiple stashes**
  * > To provide a bit more context, it's good practice to annotate your stashes with a description, using `git stash save "message"`:
- > **Viewing stash diffs**
  * > You can view a summary of a stash with `git stash show`:
  * > Or pass the `-p` option (or `--patch`) to view the full diff of a stash:
- > **Partial stashes**
  * > You can also choose to ***stash just a single file, a collection of files, or individual changes from within files***. If you pass the `-p` option (or `--patch`) to `git stash`, it will iterate through each changed "hunk" in your working copy and ask whether you wish to stash it:
    ```diff
    $ git stash -p
    diff --git a/style.css b/style.css
    new file mode 100644
    index 0000000..d92368b
    --- /dev/null
    +++ b/style.css
    @@ -0,0 +1,3 @@
    +* {
    +  text-decoration: blink;
    +}
    Stash this hunk [y,n,q,a,d,/,e,?]? y
    diff --git a/index.html b/index.html
    index 9daeafb..ebdcbd2 100644
    --- a/index.html
    +++ b/index.html
    @@ -1 +1,2 @@
    +<link rel="stylesheet" href="style.css"/>
    Stash this hunk [y,n,q,a,d,/,e,?]? n
    ```
- > **Creating a branch from your stash**
  * > If the changes on your branch diverge from the changes in your stash, you may run into conflicts when popping or applying your stash. Instead, you can use `git stash branch` to create a new branch to apply your stashed changes to:
    ```sh
    $ git stash branch add-stylesheet stash@{1}
    Switched to a new branch 'add-stylesheet'
    On branch add-stylesheet
    Changes to be committed:

        new file:   style.css

    Changes not staged for commit:

        modified:   index.html

    Dropped refs/stash@{1} (32b3aa1d185dfe6d57b3c3cc3b32cbf3e380cc6a)
    ```
    > This checks out a new branch based on the commit that you created your stash from, and then pops your stashed changes onto it.
- > **Cleaning up your stash**
  * > If you decide you no longer need a particular stash, you can delete it with `git stash drop`:
    ```sh
    $ git stash drop stash@{1}
    Dropped stash@{1} (17e2697fd8251df6163117cb3d58c1f62a5e7cdb)
    ```
  * > Or you can delete all of your stashes with:
    ```sh
    $ git stash clear
    ```
- > **How git stash works**
  * > If you just wanted to know how to use `git stash`, you can stop reading here. But if you're curious about how Git (and `git stash`) works under the hood, read on!
  * > ***Stashes are actually encoded in your repository as commit objects***. The special ref at `.git/refs/stash` points to your most recently created stash, and previously created stashes are referenced by the stash ref's reflog. This is why you refer to stashes by `stash@{n}:` you're actually referring to the nth reflog entry for the `stash` ref. Since a stash is just a commit, you can inspect it with `git log`:
    ```sh
    $ git log --oneline --graph stash@{0}
    *-.   953ddde WIP on main: 5002d47 our new homepage
    |\ \ 
    | | * 24b35a1 untracked files on main: 5002d47 our new homepage
    | * 7023dd4 index on main: 5002d47 our new homepage
    |/ 
    * 5002d47 our new homepage
    ```
  * > Depending on what you stashed, a single `git stash` operation creates either two or three new commits. The commits in the diagram above are:

A practical guide to using the git stash command https://opensource.com/article/21/4/git-stash
- > **Checking out to a new branch**
  * > You might come across a situation where the changes in a branch and your stash diverge, causing a conflict when you attempt to reapply the stash. A clean fix for this is to use the command `git stash branch <new_branch_name stash_id>`, which creates a new branch based on the commit the stash was created from and pops the stashed changes to it:
    ```console
    $ git stash branch test_2 stash@{0}
    Switched to a new branch 'test_2'
    On branch test_2
    Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working directory)
    modified: .graphqlrc.yml
    modified: generated-frontend.ts
    modified: package.json
    no changes added to commit (use "git add" and/or "git commit -a")
    Dropped stash@{0} (fe4bf8f79175b8fbd3df3c4558249834ecb75cd1)
    ```
- > **Stashing without disturbing the stash reflog**
  >> //notes：感觉这个功能很坑，轻易别用。。。
  * > In rare cases, you might need to create a stash while keeping the stash reference log (reflog) intact. These cases might arise when you need a script to stash as an implementation detail. This is achieved by the `git stash create` command; it creates a stash entry and returns its object name without pushing it to the stash reflog:
    ```sh
    $ git stash create "sample stash" 
    63a711cd3c7f8047662007490723e26ae9d4acf9
    ```
  * > Sometimes, you might decide to push the stash entry created via `git stash create` to the stash reflog:
    ```sh
    $ git stash store -m "sample stash testing.." "63a711cd3c7f8047662007490723e26ae9d4acf9"
    $ git stash list
    stash @{0}: sample stash testing..
    ```

How would I extract a single file (or changes to a file) from a git stash? https://stackoverflow.com/questions/1105253/how-would-i-extract-a-single-file-or-changes-to-a-file-from-a-git-stash

# 个人实战

## 自定义 stash message

```sh
# git stash save <description_msg>
git stash save "stash for latest xxx-feature"
```

## 只apply单个stashed文件

How to unstash only certain files? https://stackoverflow.com/questions/15264553/how-to-unstash-only-certain-files
```sh
# 查看 stash 的列表，先确定在哪个 stash 里
git stash list

# 先查看下 stash 了哪些文件，主要是为了确定要apply的那个文件的路径
#（因为你既然已经准备要apply单个文件了，你肯定已经知道**这个stash里的这个文件可以无脑apply下去**）
git stash show  # 如果不是最上层的那个stash，需要指定stash的序号，比如：git stash show stash@{1}

# 用 checkout 恢复你想 apply 的那个文件
git checkout stash@{0} src/prefix1/prefix2/conf.yaml
```

# 恢复丢失的 stash

How do I recover a dropped stash in Git? https://stackoverflow.com/questions/89332/how-do-i-recover-a-dropped-stash-in-git

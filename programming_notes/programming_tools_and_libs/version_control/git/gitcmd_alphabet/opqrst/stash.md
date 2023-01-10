
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
- > **Managing multiple stashes**
- > **Viewing stash diffs**
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

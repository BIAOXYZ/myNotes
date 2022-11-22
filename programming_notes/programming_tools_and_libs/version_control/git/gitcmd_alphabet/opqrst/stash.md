
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

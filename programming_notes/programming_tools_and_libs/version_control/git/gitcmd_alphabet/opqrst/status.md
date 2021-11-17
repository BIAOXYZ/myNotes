
# 技巧

## `git status --porcelain | sed s/^...//`
>> //notes：该命令主要是把所有改动的文件完整路径输出了，方便写脚本之类的。

How can I run "git status" and just get the filenames https://stackoverflow.com/questions/5237605/how-can-i-run-git-status-and-just-get-the-filenames
- https://stackoverflow.com/questions/5237605/how-can-i-run-git-status-and-just-get-the-filenames/5238537#5238537
  * > The output of `git status --porcelain`, designed to be easy to parse in a script, outputs the full paths rather than relative paths regardless of where your current directory is within the tree.
  * > Each line output by `git status --porcelain` has two leading characters indicating the status of the file (e.g. whether it's untracked, modified, new, deleted, etc.) followed by a space, so if you just want the full paths of everything that would be mentioned in the output of `git status` you can do:
    ```sh
    git status --porcelain | sed s/^...//
    ```

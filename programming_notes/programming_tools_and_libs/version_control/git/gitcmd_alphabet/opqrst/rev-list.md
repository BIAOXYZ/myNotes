
# 官方

# 其他

Git: Get commit count for specific folder https://gist.github.com/Xipiryon/415a908c34b6dce44183a7d9b6c35416
```sh
#!/bin/bash

git log --name-only --pretty=format: -- $1 | sort | uniq -c | head -n 1

# --name-only         = Show only names of changed files
# --pretty=format:    = Remove the information, leaving only filenames
# -- $1               = Only show commits in that path (expected as argument)

# first sort will make sure things are sorted, so ...
# ... uniq -c can effectively merge all duplicates lines, counting them
# The first line is the total number of commits in that folder, retrieved by head -n 1
```
- > 3x faster: `git log . | grep ^commit | wc -l`
- > Faster: `git rev-list --count HEAD -- <path>`

How do I get the Git commit count? https://stackoverflow.com/questions/677436/how-do-i-get-the-git-commit-count
- https://stackoverflow.com/questions/677436/how-do-i-get-the-git-commit-count/4061706#4061706
  * > To get a commit count for a revision (`HEAD`, `master`, a commit hash):
    ```sh
    git rev-list --count <revision>
    ```
  * > To get the commit count across all branches:
    ```sh
    git rev-list --all --count  # 其实换一下变成 git rev-list --count --all 更好。
    ```
  * > I recommend against using this for build identifier, but if you must, it's probably best to use the count for the branch you're building against. That way the same revision will always have the same number. If you use the count for all branches, activity on other branches could change the number.
- https://stackoverflow.com/questions/677436/how-do-i-get-the-git-commit-count/21607276#21607276
  * > A simple way is:
    ```sh
    git log --oneline | wc -l
    ```

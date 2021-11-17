
# 官方

git-ls-remote - List references in a remote repository https://git-scm.com/docs/git-ls-remote.html

# 其他

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

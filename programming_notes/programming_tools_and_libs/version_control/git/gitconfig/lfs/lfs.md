
# 官方

Releases https://github.com/git-lfs/git-lfs/releases/

Git Large File Storage (LFS) https://git-lfs.github.com/
- > **Getting Started**
- > 1.[Download]() and install the Git command line extension. Once downloaded and installed, set up Git LFS for your user account by running:
  ```sh
  git lfs install
  ```
  > You only need to run this once per user account.
- > 2.In each Git repository where you want to use Git LFS, select the file types you'd like Git LFS to manage (or directly edit your `.gitattributes`). You can configure additional file extensions at anytime.
  ```sh
  git lfs track "*.psd"
  ```
  > Now make sure `.gitattributes` is tracked:
  ```sh
  git add .gitattributes
  ```
  > Note that defining the file types Git LFS should track will not, by itself, convert any pre-existing files to Git LFS, such as files on other branches or in your prior commit history. To do that, use the [git lfs migrate]()[1] command, which has a range of options designed to suit various potential use cases.
- > 3.There is no step three. Just commit and push to GitHub as you normally would; for instance, if your current branch is named `main`:
  ```sh
  git add file.psd
  git commit -m "Add design file"
  git push origin main
  ```
  > Check out our [wiki](), [discussion forum](), and [documentation]() for help with any questions you might have!

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## `git lfs` from github

Managing large files https://docs.github.com/en/repositories/working-with-files/managing-large-files
- Installing Git Large File Storage https://docs.github.com/en/repositories/working-with-files/managing-large-files/installing-git-large-file-storage
- Configuring Git Large File Storage https://docs.github.com/en/repositories/working-with-files/managing-large-files/configuring-git-large-file-storage

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他 `git lfs` 攻略

Git LFS https://www.atlassian.com/git/tutorials/git-lfs
- > **What is Git LFS?**
  * > Git is a distributed version control system, meaning the entire history of the repository is transferred to the client during the cloning process. For projects containing large files, particularly large files that are modified regularly, this initial clone can take a huge amount of time, as every version of every file has to be downloaded by the client. Git LFS (Large File Storage) is a Git extension developed by Atlassian, GitHub, and a few other open source contributors, that ***reduces the impact of large files in your repository by downloading the relevant versions of them lazily***. Specifically, large files are downloaded ***during the checkout process rather than during cloning or fetching***.
  * > Git LFS does this by ***replacing large files in your repository with tiny pointer files***. During normal usage, ***you'll never see these pointer files as they are handled automatically by Git LFS***:
    + > 1.When you add a file to your repository, Git LFS ***replaces its contents with a pointer***, and ***stores the file contents in a local Git LFS cache***.
    + > 2.When you push new commits to the server, any Git LFS files referenced by the newly pushed commits are transferred from your local Git LFS cache to the remote Git LFS store tied to your Git repository.
    + > 3.When you checkout a commit that contains Git LFS pointers, they are replaced with files from your local Git LFS cache, or downloaded from the remote Git LFS store.
  * > Git LFS is seamless: in your working copy you'll only see your actual file content. This means you can use Git LFS without changing your existing Git workflow; you simply `git checkout`, edit, `git add`, and `git commit` as normal. `git clone` and `git pull` operations will be significantly faster as you only download the versions of large files referenced by commits that you actually check out, rather than every version of the file that ever existed.
- > **Installing Git LFS**

Git Large File Storage (LFS) https://docs.gitlab.com/ee/topics/git/lfs/

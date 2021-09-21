
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
- > There is no step three. Just commit and push to GitHub as you normally would; for instance, if your current branch is named `main`:
  ```sh
  git add file.psd
  git commit -m "Add design file"
  git push origin main
  ```
  > Check out our [wiki](), [discussion forum](), and [documentation]() for help with any questions you might have!

## git lfs from github

Managing large files https://docs.github.com/en/repositories/working-with-files/managing-large-files
- Installing Git Large File Storage https://docs.github.com/en/repositories/working-with-files/managing-large-files/installing-git-large-file-storage
- Configuring Git Large File Storage https://docs.github.com/en/repositories/working-with-files/managing-large-files/configuring-git-large-file-storage

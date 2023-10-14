
# 官方

git-revert - Revert some existing commits https://git-scm.com/docs/git-revert
```console
--no-edit
With this option, git revert will not start the commit message editor.
```

# 参数解析

## `--no-edit`
>> //notes：直接使用 `git revert commit_id` 时会弹出一个编辑器窗口（一般都是vim的），让你写提交信息，如果你不想写提交信息，可以使用 `--no-edit` 参数，直接使用默认提交信息。

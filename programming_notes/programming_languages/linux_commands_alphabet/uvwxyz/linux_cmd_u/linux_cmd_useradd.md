
# 源头

# 相关命令

- `groupadd`
- `passwd`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

How to Create Users in Linux (useradd Command) https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/
- > **How to Add a New User and Create Home Directory**
  >
  > In most Linux distros, when creating a new user account with the `useradd` command the user home directory is not created.
  > 
  > Use the `-m` (`--create-home`) option to create the user home directory as `/home/username`:
  >> `$ sudo useradd -m username`
- > **Creating a User with Specific Home Directory**
  >
  > If you want to create the user’s home directory in other location then the default `/home` directory use the `d` (`--home`) option.
  > 
  > For example, to create a new user named `username` with a home directory of `/opt/username` you’ll need to run the following command:
  >> `$ sudo useradd -m -d /opt/username username`
- > **Creating a User and Assign Multiple Groups**
  >
  > There are two types of groups in Linux operating systems Primary group and Secondary or supplementary group. Each user can belong to exactly one primary group and zero or more secondary groups.
  >
  > The `-G` (`--groups`) option allows you to specify a list of supplementary groups which the user will be a member of.
  >
  > The following command will create a new user named `username` with primary group `users` and secondary groups `wheel` and `docker`.
  >> `$ sudo useradd -g users -G wheel,developers username`

# 个人实战

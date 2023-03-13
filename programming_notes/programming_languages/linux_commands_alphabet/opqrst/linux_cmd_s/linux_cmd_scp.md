
# 相关命令

- `sftp`
- `cp`
- `rsync`

# 官方链接

# 已有书籍类链接

# 相关wiki链接

安全复制 https://zh.wikipedia.org/wiki/%E5%AE%89%E5%85%A8%E5%A4%8D%E5%88%B6
- > 安全复制（英语：Secure copy，缩写SCP）是指在本地主机与远程主机或者两台远程主机之间基于Secure Shell（SSH）协议安全地传输电脑文件。“SCP”通常指安全复制协议或者程序本身。

# 其他博客类链接

scp和sftp常用操作 https://www.cnblogs.com/ggjucheng/archive/2012/08/19/2646031.html

How to use SCP (secure copy) with ssh key authentication https://www.techrepublic.com/article/how-to-use-secure-copy-with-ssh-key-authentication/
- > **Using scp with your key**
  * > `scp -i ~/.ssh/id_rsa.pub FILENAME USER@SERVER:/home/USER/FILENAME`
    >> //notes：这点和标准的 `ssh -i <your_key_path>` 是一样的用法。

10 Practical Examples of Using scp Command https://linuxhandbook.com/scp-command/
- > But first let’s take a look at the syntax of scp command:
  ```sh
  scp <options> source_path destination_path
  ```
- > A typical path to file or a directory on the server is represented in this format:
  ```sh
  <username>@<ip_address_of_system>:<path_to_the file/directory>
  ```
  >> //notes：以前的使用一般仅涉及两台机器。其实是可以 ***在`机器1`上使用scp，将`机器2`上的文件直接拷贝的`机器3`的***，比如下面的语句成功的从mac执行scp命令，把虚机1上的文件拷贝到了虚机2上（直接在 vm1 往 vm2 上 scp，或者在 vm2 上用 scp 从 vm1 拿文件都不行 —— 其实肯定是利用到了这个mac同时联通 vm1 和 vm2，能做中转，但是这里细节就不再深究了）。
  ```sh
  biaoxyz@MacBook-Pro $ scp biaoxyz@<ip_or_hostname_vm1>:/home/biaoxyz/tmpfiles/bigdata_3col.csv biaoxyz@<ip_or_hostname_vm2>:~/data/ 
  bigdata_3col.csv                                                            100% 2915MB   8.3MB/s   05:51
  ```

# 个人实战

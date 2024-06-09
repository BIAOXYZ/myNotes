
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

## 1 `cp`、`scp`和`rsync` 命令如果是处理目录时，根据`源地址`和`目标地址`末尾带不带斜杠，可以分成四种情况

**准备数据：**
```sh
mkdir -p ~/test_cp_scp_rsync/{test_cp,test_scp,test_rsync}

# 在每个测试目录中创建四个子目录
mkdir -p ~/test_cp_scp_rsync/test_cp/{src_slash_dst_slash,src_slash_dst_no_slash,src_no_slash_dst_slash,src_no_slash_dst_no_slash}
mkdir -p ~/test_cp_scp_rsync/test_scp/{src_slash_dst_slash,src_slash_dst_no_slash,src_no_slash_dst_slash,src_no_slash_dst_no_slash}
mkdir -p ~/test_cp_scp_rsync/test_rsync/{src_slash_dst_slash,src_slash_dst_no_slash,src_no_slash_dst_slash,src_no_slash_dst_no_slash}

# 在每个源目录中创建示例文件和子目录
for dir in src_slash_dst_slash src_slash_dst_no_slash src_no_slash_dst_slash src_no_slash_dst_no_slash; do
    mkdir -p ~/test_cp_scp_rsync/test_cp/$dir/source_dir/sub_dir
    echo "file1" > ~/test_cp_scp_rsync/test_cp/$dir/source_dir/file1.txt
    echo "file2" > ~/test_cp_scp_rsync/test_cp/$dir/source_dir/file2.txt
    echo "file3" > ~/test_cp_scp_rsync/test_cp/$dir/source_dir/sub_dir/file3.txt

    mkdir -p ~/test_cp_scp_rsync/test_scp/$dir/source_dir/sub_dir
    echo "file1" > ~/test_cp_scp_rsync/test_scp/$dir/source_dir/file1.txt
    echo "file2" > ~/test_cp_scp_rsync/test_scp/$dir/source_dir/file2.txt
    echo "file3" > ~/test_cp_scp_rsync/test_scp/$dir/source_dir/sub_dir/file3.txt

    mkdir -p ~/test_cp_scp_rsync/test_rsync/$dir/source_dir/sub_dir
    echo "file1" > ~/test_cp_scp_rsync/test_rsync/$dir/source_dir/file1.txt
    echo "file2" > ~/test_cp_scp_rsync/test_rsync/$dir/source_dir/file2.txt
    echo "file3" > ~/test_cp_scp_rsync/test_rsync/$dir/source_dir/sub_dir/file3.txt
done
```
```sh
# 执行完上述语句后
$ tree ~/test_cp_scp_rsync/
/home/tiger/test_cp_scp_rsync/
├── test_cp
│   ├── src_no_slash_dst_no_slash
│   │   └── source_dir
│   │       ├── file1.txt
│   │       ├── file2.txt
│   │       └── sub_dir
│   │           └── file3.txt
│   ├── src_no_slash_dst_slash
│   │   └── source_dir
│   │       ├── file1.txt
│   │       ├── file2.txt
│   │       └── sub_dir
│   │           └── file3.txt
│   ├── src_slash_dst_no_slash
│   │   └── source_dir
│   │       ├── file1.txt
│   │       ├── file2.txt
│   │       └── sub_dir
│   │           └── file3.txt
│   └── src_slash_dst_slash
│       └── source_dir
│           ├── file1.txt
│           ├── file2.txt
│           └── sub_dir
│               └── file3.txt
├── test_rsync
│   ├── src_no_slash_dst_no_slash
│   │   └── source_dir
│   │       ├── file1.txt
│   │       ├── file2.txt
│   │       └── sub_dir
│   │           └── file3.txt
│   ├── src_no_slash_dst_slash
│   │   └── source_dir
│   │       ├── file1.txt
│   │       ├── file2.txt
│   │       └── sub_dir
│   │           └── file3.txt
│   ├── src_slash_dst_no_slash
│   │   └── source_dir
│   │       ├── file1.txt
│   │       ├── file2.txt
│   │       └── sub_dir
│   │           └── file3.txt
│   └── src_slash_dst_slash
│       └── source_dir
│           ├── file1.txt
│           ├── file2.txt
│           └── sub_dir
│               └── file3.txt
└── test_scp
    ├── src_no_slash_dst_no_slash
    │   └── source_dir
    │       ├── file1.txt
    │       ├── file2.txt
    │       └── sub_dir
    │           └── file3.txt
    ├── src_no_slash_dst_slash
    │   └── source_dir
    │       ├── file1.txt
    │       ├── file2.txt
    │       └── sub_dir
    │           └── file3.txt
    ├── src_slash_dst_no_slash
    │   └── source_dir
    │       ├── file1.txt
    │       ├── file2.txt
    │       └── sub_dir
    │           └── file3.txt
    └── src_slash_dst_slash
        └── source_dir
            ├── file1.txt
            ├── file2.txt
            └── sub_dir
                └── file3.txt

39 directories, 36 files
```

**进行四种组合的测试：**
```sh
# cp 命令测试
# 1. 源地址带斜杠，目标地址带斜杠：
cp -r ~/test_cp_scp_rsync/test_cp/src_slash_dst_slash/source_dir/ ~/test_cp_scp_rsync/test_cp/src_slash_dst_slash/target_dir/

# 2. 源地址带斜杠，目标地址不带斜杠：
cp -r ~/test_cp_scp_rsync/test_cp/src_slash_dst_no_slash/source_dir/ ~/test_cp_scp_rsync/test_cp/src_slash_dst_no_slash/target_dir

# 3. 源地址不带斜杠，目标地址带斜杠：
cp -r ~/test_cp_scp_rsync/test_cp/src_no_slash_dst_slash/source_dir ~/test_cp_scp_rsync/test_cp/src_no_slash_dst_slash/target_dir/

# 4. 源地址不带斜杠，目标地址不带斜杠：
cp -r ~/test_cp_scp_rsync/test_cp/src_no_slash_dst_no_slash/source_dir ~/test_cp_scp_rsync/test_cp/src_no_slash_dst_no_slash/target_dir
```
```sh
# scp 命令测试（假设本地和远程机器都是同一台机器，仅用于测试目的）
# 1. 源地址带斜杠，目标地址带斜杠：
scp -r ~/test_cp_scp_rsync/test_scp/src_slash_dst_slash/source_dir/ localhost:~/test_cp_scp_rsync/test_scp/src_slash_dst_slash/target_dir/

# 2. 源地址带斜杠，目标地址不带斜杠：
scp -r ~/test_cp_scp_rsync/test_scp/src_slash_dst_no_slash/source_dir/ localhost:~/test_cp_scp_rsync/test_scp/src_slash_dst_no_slash/target_dir

# 3. 源地址不带斜杠，目标地址带斜杠：
scp -r ~/test_cp_scp_rsync/test_scp/src_no_slash_dst_slash/source_dir localhost:~/test_cp_scp_rsync/test_scp/src_no_slash_dst_slash/target_dir/

# 4. 源地址不带斜杠，目标地址不带斜杠：
scp -r ~/test_cp_scp_rsync/test_scp/src_no_slash_dst_no_slash/source_dir localhost:~/test_cp_scp_rsync/test_scp/src_no_slash_dst_no_slash/target_dir
```
```sh
# rsync 命令测试
# 1. 源地址带斜杠，目标地址带斜杠：
rsync -av ~/test_cp_scp_rsync/test_rsync/src_slash_dst_slash/source_dir/ ~/test_cp_scp_rsync/test_rsync/src_slash_dst_slash/target_dir/

# 2. 源地址带斜杠，目标地址不带斜杠：
rsync -av ~/test_cp_scp_rsync/test_rsync/src_slash_dst_no_slash/source_dir/ ~/test_cp_scp_rsync/test_rsync/src_slash_dst_no_slash/target_dir

# 3. 源地址不带斜杠，目标地址带斜杠：
rsync -av ~/test_cp_scp_rsync/test_rsync/src_no_slash_dst_slash/source_dir ~/test_cp_scp_rsync/test_rsync/src_no_slash_dst_slash/target_dir/

# 4. 源地址不带斜杠，目标地址不带斜杠：
rsync -av ~/test_cp_scp_rsync/test_rsync/src_no_slash_dst_no_slash/source_dir ~/test_cp_scp_rsync/test_rsync/src_no_slash_dst_no_slash/target_dir
```
```sh
# 验证结果
# cp 命令测试结果：
tree ~/test_cp_scp_rsync/test_cp/src_slash_dst_slash/target_dir/
tree ~/test_cp_scp_rsync/test_cp/src_slash_dst_no_slash/target_dir
tree ~/test_cp_scp_rsync/test_cp/src_no_slash_dst_slash/target_dir/
tree ~/test_cp_scp_rsync/test_cp/src_no_slash_dst_no_slash/target_dir

# scp 命令测试结果：
tree ~/test_cp_scp_rsync/test_scp/src_slash_dst_slash/target_dir/
tree ~/test_cp_scp_rsync/test_scp/src_slash_dst_no_slash/target_dir
tree ~/test_cp_scp_rsync/test_scp/src_no_slash_dst_slash/target_dir/
tree ~/test_cp_scp_rsync/test_scp/src_no_slash_dst_no_slash/target_dir

# rsync 命令测试结果：
tree ~/test_cp_scp_rsync/test_rsync/src_slash_dst_slash/target_dir/
tree ~/test_cp_scp_rsync/test_rsync/src_slash_dst_no_slash/target_dir
tree ~/test_cp_scp_rsync/test_rsync/src_no_slash_dst_slash/target_dir/
tree ~/test_cp_scp_rsync/test_rsync/src_no_slash_dst_no_slash/target_dir
```

```sh
# 1. 源地址带斜杠，目标地址带斜杠：
$ tree ~/test_cp_scp_rsync/test_cp/src_slash_dst_slash/target_dir/
/home/tiger/test_cp_scp_rsync/test_cp/src_slash_dst_slash/target_dir/
├── file1.txt
├── file2.txt
└── sub_dir
    └── file3.txt

1 directory, 3 files

# 2. 源地址带斜杠，目标地址不带斜杠：
tiger@n199-020-021:~$ tree ~/test_cp_scp_rsync/test_cp/src_slash_dst_no_slash/target_dir
/home/tiger/test_cp_scp_rsync/test_cp/src_slash_dst_no_slash/target_dir
├── file1.txt
├── file2.txt
└── sub_dir
    └── file3.txt

1 directory, 3 files

# 3. 源地址不带斜杠，目标地址带斜杠：
tiger@n199-020-021:~$ tree ~/test_cp_scp_rsync/test_cp/src_no_slash_dst_slash/target_dir/
/home/tiger/test_cp_scp_rsync/test_cp/src_no_slash_dst_slash/target_dir/
├── file1.txt
├── file2.txt
└── sub_dir
    └── file3.txt

1 directory, 3 files

# 4. 源地址不带斜杠，目标地址不带斜杠：
tiger@n199-020-021:~$ tree ~/test_cp_scp_rsync/test_cp/src_no_slash_dst_no_slash/target_dir
/home/tiger/test_cp_scp_rsync/test_cp/src_no_slash_dst_no_slash/target_dir
├── file1.txt
├── file2.txt
└── sub_dir
    └── file3.txt

1 directory, 3 files
```

TODO：scp 和 rsync 的因为要 localhost 建互信（但是单位的机器不行），所以不测了。
```sh

```

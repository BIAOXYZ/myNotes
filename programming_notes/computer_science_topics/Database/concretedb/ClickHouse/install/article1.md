
# 1

How to deploy and configure a remote clickhouse db instance with docker https://stackoverflow.com/questions/64888752/how-to-deploy-and-configure-a-remote-clickhouse-db-instance-with-docker
- https://stackoverflow.com/questions/64888752/how-to-deploy-and-configure-a-remote-clickhouse-db-instance-with-docker/64888753#64888753

```sh
# 第一步
docker run -d --name some-clickhouse-server -p 8123:8123 --ulimit nofile=262144:262144 --volume=$HOME/some_clickhouse_database:/var/lib/clickhouse yandex/clickhouse-server


# （建议这个做为）第三步
# 这句建议迟一点执行（虽然帖子里是紧接着就执行的），因为这句一执行完，当前窗口就被 ClickHouse 客户端的命令行界面给占着了。
# 但是你还没配置客户端的一些配置文件呢。。。所以建议执行完后面修改配置文件的步骤后再执行这步。
docker run -it --rm --link some-clickhouse-server:clickhouse-server yandex/clickhouse-client --host clickhouse-server
    CREATE USER IF NOT EXISTS user1 IDENTIFIED WITH PLAINTEXT_PASSWORD BY 'pass1'
    SHOW USERS
    CREATE DATABASE IF NOT EXISTS db1
    SHOW DATABASES
    GRANT ALL PRIVILEGES ON db1.* TO user1


# （建议这个做为）第二步
docker exec -it some-clickhouse-server bash
    apt update && apt install -y vim
    cd /etc/clickhouse-server/
    vim users.xml


# 第四步
# 注意：因为这个容器是用 user1 去连接数据库的，不像前面那个连接（那个用的是 default）。执行同样的命令效果是不一样的。
# 可以试试 SHOW USERS 和 SHOW DATABASES 就知道，前者 user1 无权限，后者 user1 的返回结果里只能显示 db1。
docker run -it --rm --link some-clickhouse-server:clickhouse-server yandex/clickhouse-client --host clickhouse-server -u user1 --password pass1
    SHOW GRANTS
    SHOW DATABASES
    USE db1
    CREATE TABLE names (id UInt64, name String, created DateTime) ENGINE = MergeTree() PRIMARY KEY id ORDER BY id;
    SHOW TABLES
```

```console
# 如果没放开 user.xml 里的那行注释，就会报这个错。
eef56cb5d207 :) CREATE USER IF NOT EXISTS user1 IDENTIFIED WITH PLAINTEXT_PASSWORD BY 'pass1'

CREATE USER IF NOT EXISTS user1 IDENTIFIED WITH plaintext_password BY 'pass1'

Query id: 8a4e56a8-9cb0-49be-b0c4-399888451327


0 rows in set. Elapsed: 0.004 sec.

Received exception from server (version 21.12.3):
Code: 497. DB::Exception: Received from clickhouse-server:9000. DB::Exception: default: Not enough privileges. To execute this query it's necessary to have grant CREATE USER ON *.*. (ACCESS_DENIED)

eef56cb5d207 :)
```

# 2

## CK方便快捷使用（from `alitrack`）

Python访问ClickHouse的方法汇总 https://mp.weixin.qq.com/s/wrxIsi8JuzETT6YudLPsNg
- 免安装 Clickhouse 体验单表40亿行大数据的方法 https://mp.weixin.qq.com/s/kXgEKhqDAIsJUiJjb7kyWQ

免安装 Clickhouse 体验单表40亿行大数据的方法 https://mp.weixin.qq.com/s/kXgEKhqDAIsJUiJjb7kyWQ
- > ClickHouse 的安装体验很方便，我之前分享了 [macOS]()、[Linux]() 以及[手机]()上安装体验的方法，现在再分享几个不用安装就可以体验（学习）的方法。
  * MacOS 下快速体验 ClickHouse https://mp.weixin.qq.com/s/TEYhuWx5eZZmQX-FADK36w
  * ClickHouse 与 HDFS https://mp.weixin.qq.com/s/J7v1vwaH-5EtcSWEEunnow
  * 体验arm版本的 ClickHouse https://mp.weixin.qq.com/s/zdjxwDOjJRGAcaAPDDOemw

MacOS 下快速体验 ClickHouse https://mp.weixin.qq.com/s/TEYhuWx5eZZmQX-FADK36w
- > 在 Docker 中运行 ClickHouse
  ```sh
  docker run -d --name clickhouse-server -p 8123:8123 -p 9000:9000 --ulimit nofile=262144:262144 yandex/clickhouse-server
  ```
  >> 【[:star:][`*`]】 //notes：个人补充一下：如果不想下CK的客户端，可以参照前面的部分，直接用 docker 版客户端，一句即可搞定：
  ```sh
  docker run -it --rm --link clickhouse-server:clickhouse-server yandex/clickhouse-client --host clickhouse-server
  ```
- > 客户端连接 ClickHouse
- > DBeaver 连接 Clickhouse

# 其他

ClickHouse Server in 1 minute with Docker https://dev.to/titronium/clickhouse-server-in-1-minute-with-docker-4gf2

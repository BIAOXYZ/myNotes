
# 基本命令

```
$ head --help
Usage: head [OPTION]... [FILE]...
Print the first 10 lines of each FILE to standard output.
With more than one FILE, precede each with a header giving the file name.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.
  -c, --bytes=[-]NUM       print the first NUM bytes of each file;
                             with the leading '-', print all but the last
                             NUM bytes of each file
  -n, --lines=[-]NUM       print the first NUM lines instead of the first 10;
                             with the leading '-', print all but the last
                             NUM lines of each file
  -q, --quiet, --silent    never print headers giving file names
  -v, --verbose            always print headers giving file names
  -z, --zero-terminated    line delimiter is NUL, not newline
      --help     display this help and exit
      --version  output version information and exit

NUM may have a multiplier suffix:
b 512, kB 1000, K 1024, MB 1000*1000, M 1024*1024,
GB 1000*1000*1000, G 1024*1024*1024, and so on for T, P, E, Z, Y.

GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
Full documentation at: <http://www.gnu.org/software/coreutils/head>
or available locally via: info '(coreutils) head invocation'
```

# 用法

## 

> 本身`docker ps`会显示很多容器信息，此时可以用`head -n $行数`过滤。行数指定为1时只有每列的标题所组成的行，行数指定为2时就是标题行+第一行。
```
$ docker ps | head -n 1
CONTAINER ID        IMAGE                         COMMAND                  CREATED             STATUS              PORTS               NAMES
$
$ docker ps | head -n 2
CONTAINER ID        IMAGE                         COMMAND                  CREATED             STATUS              PORTS               NAMES
6d0fa1fa9870        katacoda/docker-http-server   "/app"                   19 minutes ago      Up 19 minutes                           k8s_docker-http-server_first-deployment-8cbf74484-jxwzm_default_9c3581ef-9589-478b-8e52-7c347f6ea1c3_0
```

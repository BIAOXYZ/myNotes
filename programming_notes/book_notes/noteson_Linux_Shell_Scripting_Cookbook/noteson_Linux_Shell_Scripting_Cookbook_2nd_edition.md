
- 《Linux Shell Scripting Cookbook》 2nd edition 2013
- 《LINUX SHELL脚本攻略》2011年翻译，所以应该是第一版————确定是第一版，因为翻译版第一章开头部分只有14个任务，英文版第一章开头有16个。

# 1 Shell Something Out

```
In this chapter, we will cover:
   Printing in the terminal
   Playing with variables and environment variables
   Function to prepend to environment variables
   Math with the shell
   Playing with file descriptors and redirection
   Arrays and associative array
   Visiting aliases
   Grabbing information about the terminal
   Getting and setting dates and delays
   Debugging the script
   Functions and arguments
   Reading output of a sequence of commands in a variable
   Reading n characters without pressing the return key
   Running a command until it succeeds
   Field separators and iterators
   Comparisons and tests
```

## Introduction

#### page 8

> "$ represents regular users and # represents the administrative user root."

```
A shell script is a text file that typically begins with a shebang, as follows:
    #!/bin/bash
Shebang is a line on which #! is prefixed to the interpreter path. /bin/bash is the
interpreter command path for Bash.
```

#### page 9

> "Execution of a script can be done in two ways. Either we can run the script as a command-line argument to bash or we can grant execution permission to the script so it becomes executable."

> "When a shell is started, it initially executes a set of commands to define various settings such as prompt text, colors, and much more. This set of commands are read from a shell script at ~/.bashrc (or ~/.bash_profile for login shells) located in the home directory of the user. The Bash shell also maintains a history of commands run by the user. It is available in the ~/.bash_history file."

> [Tips] "A login shell is the shell which you get just after logging in to a machine. However, if you open up a shell while logged in to a graphical environment (such as GNOME, KDE, and so on), then it is not a login shell."

## Printing in the terminal

#### page 10-11 
```shell
关于echo命令的无引号，单引号，双引号的实战情况：

1.WSL Ubuntu

wsl@DESKTOP-5LVLGG9:~$ echo hello world!
hello world!
wsl@DESKTOP-5LVLGG9:~$ echo 'hello world!'
hello world!
wsl@DESKTOP-5LVLGG9:~$ echo "hello world!"
hello world!
wsl@DESKTOP-5LVLGG9:~$ echo "cannot include exclamation - ! within double quotes"
cannot include exclamation - ! within double quotes


wsl@DESKTOP-5LVLGG9:~$ echo hello; hello
hello

Command 'hello' not found, but can be installed with:

sudo apt install hello
sudo apt install hello-traditional

2. VitualBox CentOS 7.5.2

test2@localhost:~\> echo hello world!
hello world!
test2@localhost:~\> echo 'hello world!'
hello world!
test2@localhost:~\> echo "hello world!"
-bash: !": event not found
test2@localhost:~\> echo "cannot include exclamation - ! within double quotes"
cannot include exclamation - ! within double quotes

test2@localhost:~\> echo hello; hello
hello
-bash: hello: 未找到命令

```

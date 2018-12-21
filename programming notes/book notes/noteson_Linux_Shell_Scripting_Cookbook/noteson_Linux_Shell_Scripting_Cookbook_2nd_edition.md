
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

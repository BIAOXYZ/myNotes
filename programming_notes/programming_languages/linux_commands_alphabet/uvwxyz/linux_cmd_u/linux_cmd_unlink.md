
unlink (Unix) https://en.wikipedia.org/wiki/Unlink_(Unix)

What is the difference between unlink and rm? https://serverfault.com/questions/38816/what-is-the-difference-between-unlink-and-rm
```
Both are a wrapper to the same fundamental function which is an unlink() system call.

To weigh up the differences between the userland utilies.

rm(1):

◦ More options.
◦ More feedback.
◦ Sanity checking.
◦ A bit slower for single calls as a result of the above.
◦ Can be called with multiple arguments at the same time.

unlink(1):

◦ Less sanity checking.
◦ Unable to delete directories.
◦ Unable to recurse.
◦ Can only take one argument at a time.
◦ Marginally leaner for single calls due to it's simplicity.
◦ Slower when compared with giving rm(1) multiple arguments.
```

What is the difference between 'rm' and 'unlink'? https://unix.stackexchange.com/questions/151951/what-is-the-difference-between-rm-and-unlink/326711
- 【from cuonglm】： 
  * > On some systems, unlink can also remove directory. At least in GNU system, unlink can never delete the name of a directory.
- 【from Kaz】：
  * > The unlink utility isn't exactly a stripped-down `rm`. It performs a subset of what `rm` does, but it has semantics which is a combination of `rm` with `-f` and `rm` without `-f`.

**所以总结一下就是：1.`unlink`比`rm`更简单效率更高些，`rm`因为有安全检查（比如要删的文件没权限）和更多的参数，所以比`unlink`更复杂。2.有人说`unlink`不能删目录，实际来看应该是有的系统能删有的不能删。**

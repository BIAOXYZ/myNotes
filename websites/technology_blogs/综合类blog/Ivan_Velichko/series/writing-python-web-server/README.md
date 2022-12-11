
# Writing Web Server in Python Learning Series https://iximiuz.com/en/series/writing-python-web-server/

Writing Web Server in Python: sockets https://iximiuz.com/en/posts/writing-web-server-in-python-sockets/
- > **What networking programming look alike?**
  * > In Unix-like operating systems, it's pretty common to [treat I/O devices as files](https://en.wikipedia.org/wiki/Everything_is_a_file). Much like regular files on disk, computer mice, printers, modems, etc can be opened, read/written, and then closed. <br> ![](https://iximiuz.com/writing-web-server-in-python-sockets/dev-files-opt.png)
  * > For every opened file, the operating system creates a so-called file descriptor. Simplifying a bit, a [file descriptor](https://en.wikipedia.org/wiki/File_descriptor) is just a unique integer identifier of a file within a process. The operating system provides a set of <del>functions</del> system calls to manipulate files that accept a file descriptor as an argument. Here is a canonical example with [`read()`](https://man7.org/linux/man-pages/man2/read.2.html) and [`write()`](https://man7.org/linux/man-pages/man2/read.2.html) operations:
    ```c
    int fd = open("/path/to/my/file", ...);

    char buffer[2048];
    read(fd, buffer, 2048);
    write(fd, "some data", 10);

    close(fd);
    ```
  * > Since network communication is also a form of I/O, it'd be reasonable to expect that it should boil down to working with files as well. And indeed, there is a special kind of file for that called **sockets**.
- > **How programs communicate over network**
  * > Imagine there is an application that wants to send a relatively long piece of text over the network. Let's suppose the socket has already been opened and the program is about to write (or, in networking parlance, send) this data to the socket. How this data will be transmitted?

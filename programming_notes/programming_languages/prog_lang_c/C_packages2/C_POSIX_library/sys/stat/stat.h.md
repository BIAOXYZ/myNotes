
# 官方

8.63 sys/stat.h https://www.gnu.org/software/gnulib/manual/html_node/sys_002fstat_002eh.html

https://github.com/torvalds/linux/blob/master/include/uapi/linux/stat.h

sys_stat.h(0p) — Linux manual page https://man7.org/linux/man-pages/man0/sys_stat.h.0p.html

`<sys/stat.h>` https://pubs.opengroup.org/onlinepubs/7908799/xsh/sysstat.h.html || https://pubs.opengroup.org/onlinepubs/009604499/basedefs/sys/stat.h.html
- `stat - get file status` https://pubs.opengroup.org/onlinepubs/7908799/xsh/stat.html

# 其他

C Programming/POSIX Reference/sys/stat.h https://en.wikibooks.org/wiki/C_Programming/POSIX_Reference/sys/stat.h

`#include <sys/stat.h>` https://blog.51cto.com/2942350/620854
- > 文件对应的属性
  ```c
  struct stat {
      mode_t     st_mode;       //文件对应的模式，文件，目录等
      ino_t      st_ino;        //inode节点号
      dev_t      st_dev;        //设备号码
      dev_t      st_rdev;       //特殊设备号码
      nlink_t    st_nlink;      //文件的连接数
      uid_t      st_uid;        //文件所有者
      gid_t      st_gid;        //文件所有者对应的组
      off_t      st_size;       //普通文件，对应的文件字节数
      time_t     st_atime;      //文件最后被访问的时间
      time_t     st_mtime;      //文件内容最后被修改的时间
      time_t     st_ctime;      //文件状态改变时间
      blksize_t  st_blksize;    //文件内容对应的块大小
      blkcnt_t   st_blocks;     //伟建内容对应的块数量
  };
  ```
- > 示例：
  ```c
  #include <sys/stat.h>
  #include <unistd.h>
  #include <stdio.h>
  
  int main() {
      struct stat buf;
      stat("/etc/hosts", &buf);
      printf("/etc/hosts file size = %d\n", buf.st_size);
  }
  ```

#include <sys/stat.h>分析文件 https://www.jianshu.com/p/f718458f102e

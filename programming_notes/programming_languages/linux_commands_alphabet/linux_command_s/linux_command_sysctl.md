
# 命令基本信息

sysctl https://en.wikipedia.org/wiki/Sysctl

CHAPTER 2. WORKING WITH SYSCTL AND KERNEL TUNABLES https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/kernel_administration_guide/working_with_sysctl_and_kernel_tunables
- > 2.1. What is a kernel tunable?
  >> Kernel tunables are used to customize the behavior of Red Hat Enterprise Linux at boot, or on demand while the system is running. Some hardware parameters are specified at boot time only and cannot be altered once the system is running, most however, can be altered as required and set permanent for the next boot.
- > 2.2. How to work with kernel tunables
  >> There are three ways to modify kernel tunables.
  >>> 1. Using the sysctl command
  >>> 2. By manually modifying configuration files in the /etc/sysctl.d/ directory
  >>> 3. Through a shell, interacting with the virtual file system mounted at /proc/sys
  
- http://man7.org/linux/man-pages/man8/sysctl.8.html
```
SYSCTL(8)                   System Administration                  SYSCTL(8)
NAME
       sysctl - configure kernel parameters at runtime
SYNOPSIS
       sysctl [options] [variable[=value]] [...]
       sysctl -p [file or regexp] [...]
DESCRIPTION
       sysctl is used to modify kernel parameters at runtime.  The
       parameters available are those listed under /proc/sys/.  Procfs is
       required for sysctl support in Linux.  You can use sysctl to both
       read and write sysctl data.
PARAMETERS
       variable
              The name of a key to read from.  An example is kernel.ostype.
              The '/' separator is also accepted in place of a '.'.

       variable=value
              To set a key, use the form variable=value where variable is
              the key and value is the value to set it to.  If the value
              contains quotes or characters which are parsed by the shell,
              you may need to enclose the value in double quotes.

       -n, --values
              Use this option to disable printing of the key name when
              printing values.

       -e, --ignore
              Use this option to ignore errors about unknown keys.

       -N, --names
              Use this option to only print the names.  It may be useful
              with shells that have programmable completion.

       -q, --quiet
              Use this option to not display the values set to stdout.

       -w, --write
              Use this option when all arguments prescribe a key to be set.

       -p[FILE], --load[=FILE]
              Load in sysctl settings from the file specified or
              /etc/sysctl.conf if none given.  Specifying - as filename
              means reading data from standard input.  Using this option
              will mean arguments to sysctl are files, which are read in the
              order they are specified.  The file argument may be specified
              as regular expression.

       -a, --all
              Display all values currently available.

       --deprecated
              Include deprecated parameters to --all values listing.

       -b, --binary
              Print value without new line.

       --system
              Load settings from all system configuration files. Files are
              read from directories in the following list in given order
              from top to bottom.  Once a file of a given filename is
              loaded, any file of the same name in subsequent directories is
              ignored.
              /run/sysctl.d/*.conf
              /etc/sysctl.d/*.conf
              /usr/local/lib/sysctl.d/*.conf
              /usr/lib/sysctl.d/*.conf
              /lib/sysctl.d/*.conf
              /etc/sysctl.conf

       -r, --pattern pattern
              Only apply settings that match pattern.  The pattern uses
              extended regular expression syntax.

       -A     Alias of -a

       -d     Alias of -h

       -f     Alias of -p

       -X     Alias of -a

       -o     Does nothing, exists for BSD compatibility.

       -x     Does nothing, exists for BSD compatibility.

       -h, --help
              Display help text and exit.

       -V, --version
              Display version information and exit.
EXAMPLES
       /sbin/sysctl -a
       /sbin/sysctl -n kernel.hostname
       /sbin/sysctl -w kernel.domainname="example.com"
       /sbin/sysctl -p/etc/sysctl.conf
       /sbin/sysctl -a --pattern forward
       /sbin/sysctl -a --pattern forward$
       /sbin/sysctl -a --pattern 'net.ipv4.conf.(eth|wlan)0.arp'
       /sbin/sysctl --system --pattern '^net.ipv6'
DEPRECATED PARAMETERS
       The base_reachable_time and retrans_time are deprecated.  The sysctl
       command does not allow changing values of these parameters.  Users
       who insist to use deprecated kernel interfaces should push values to
       /proc file system by other means.  For example:

       echo 256 > /proc/sys/net/ipv6/neigh/eth0/base_reachable_time
FILES
       /proc/sys
       /etc/sysctl.conf
SEE ALSO
       sysctl.conf(5) regex(7)
AUTHOR
       George Staikos ⟨staikos@0wned.org⟩
REPORTING BUGS
       Please send bug reports to ⟨procps@freelists.org⟩
```

# 个人实战


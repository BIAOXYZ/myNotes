
# 1

Why Snort 3? https://www.snort.org/snort3
- snort_user.pdf https://github.com/snort3/snort3/releases/download/3.1.25.0/snort_user.pdf 【不能在线打开，一点击就下载到本地了，但是无所谓了】

snort_user.pdf https://github.com/snort3/snort3/releases/download/3.1.25.0/snort_user.pdf
- > **1.1 First Steps**
  * > Now let’s examine the packets in a capture file (pcap):
    ```sh
    $ snort -r a.pcap
    ```
    >> 【[:star:][`*`]】 //notes：注：当时一时也没找到在哪下载 `.pcap` 文件，后来想到能不能自己生成一个。于是参照下面的帖子（一个窗口开 `tcpdump`；一个窗口产生些流量，比如 `ping` 某个网站），然后成功了。
    >>> Generate a pcap file https://ip-link.readthedocs.io/en/latest/tutorial.html
    ```sh
    cedric@debian:~$ mkdir captures data
    root@debian:~$ tcpdump -p -i eth0 -s 0 -w captures/capture.pcap
    ```
  * > If you want to see details on each packet, you can dump the packets to console like this:
    ```sh
    $ snort -r a.pcap -L dump
    ```
  * > Add the `-d` option to see the TCP and UDP payload. Now let’s switch to live traffic. Replace `eth0` in the below command with an
available network interface:
    ```sh
    $ snort -i eth0 -L dump
    ```
  * > Generally it is better to capture the packets for later analysis like this:
    ```sh
    $ snort -i eth0 -L pcap -n 10
    ```
  * > To leverage intrusion detection features of Snort you will need to provide some configuration details. The next section breaks
down what must be done.
- > **1.2 Configuration**
  * > Effective configuration of Snort is done via the environment, command line, a Lua configuration file, and a set of rules.
  * > The configuration of Snort 3 is done with Lua, so your old conf won’t work as is. Rules are still text based but with syntax tweaks, so your 2.X rules must be fixed up. However, `snort2lua` will help you convert your conf and rules to the new format.
    >> 【[:star:][`*`]】 //notes：难怪我用 `sudo find / -type d -name "*snort*"` 搜索，在 `/usr/local/etc/snort` 目录里找到的都是 `.lua` 文件。原来是过去的 `.conf` 到 Snort3 后改了。
- > **1.2.1 Command Line**
  * > `-c snort.lua` is the main configuration file. This is a Lua script that is executed when loaded.
  * > `-R cool.rules` contains some detection rules. You can write your own or obtain them from Talos (native 3.0 rules are not yet available from Talos so you must convert them with `snort2lua`). You can also ***put your rules directly in your configuration file***.
  * > `-A cmg` says to output intrusion events in "cmg" format, which has basic header details followed by the payload in hex and text.
- > **1.2.2 Configuration File**
  * > Snort is organized into a collection of builtin and plugin `modules`. If a module has parameters, it is configured by a Lua table of the same name. For example, we can see what the active module has to offer with this command:

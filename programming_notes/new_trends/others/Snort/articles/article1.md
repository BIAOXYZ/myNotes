
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

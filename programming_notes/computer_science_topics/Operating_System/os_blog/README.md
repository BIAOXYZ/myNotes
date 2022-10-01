
Linux 0.11 第 2 回 | 从 0x7c00 到 0x90000 https://www.ithome.com/0/644/371.htm || https://mp.weixin.qq.com/s/U-txDYt0YqLh5EeFOcB4NQ  【from `低并发编程`】

Linux 0.11 第一回 | 最开始的两行代码 https://www.ithome.com/0/644/055.htm  【from `低并发编程`】
- > 当你按下开机键的那一刻，在主板上提前写死的固件程序 BIOS 会将硬盘中启动区的 `512` 字节的数据，原封不动复制到内存中的 `0x7c00` 这个位置，并跳转到那个位置进行执行。
- > 启动区的定义非常简单，只要硬盘中的 `0 盘 0 道 1 扇区`的 512 个字节的最后两个字节分别是 `0x55` 和 `0xaa`，那么 BIOS 就会认为它是个启动区。

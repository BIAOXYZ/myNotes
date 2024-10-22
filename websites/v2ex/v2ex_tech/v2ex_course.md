
计算机组成原理推荐看哪个学校的 https://www.v2ex.com/t/1082496
- > 哈工大的 CSAPP 课
- > nand2tries
- > computer organization and design: the hardware/software interface
  >> 4 楼的那本书是非常好的选择。这本书是很有名的黑砖系列中的一本，目前有两个版本，讲 MIPS 和 RISCV 的。MIPS 版本非常经典可以看一下，当然时代变化 RISCV 的版本可能会更加适应潮流。我自己看过的是 MIPS 的版本，感觉对整个 CPU 的设计有了一个非常系统的了解，里面难度曲线比较合理，只包含了一点逻辑的内容，正常都能看懂。书里的资料可以帮助你完成一个简单的 CPU 。所以说楼主有需求的话可以考虑一下这本书。
- 个人补充链接：
  * nand2tetris -- The Elements of Computing Systems : Building a Modern Computer from First Principles https://www.nand2tetris.org/
  * nand2tetris -- 《计算机系统要素-从零开始构建现代计算机》 https://github.com/ReionChan/nand2tetris || https://reionchan.github.io/2015/08/27/the-elements-of-computing-systems/
  * 计算机系统要素 https://book.douban.com/subject/1998341/

6.828 课程的 RISC-V 版本建议选哪年的？ https://www.v2ex.com/t/1062198
```console
目前了解到，6.828 课程从 2019 开始就是使用的 RISC-V 版本了。

一篇知乎文章上提到，“从 2020 开始，MIT 6.828 有关课程有较大变动，原来的一门课被拆成两门，其中原 6.828 内容被放到新课 6.S081 ，而 6.828 作为研究生课程，讲授操作系统研究方面等深入内容。”

这一点会对学习有影响吗？因为之后的工作会就会让用到 RISC-V 了，刚好也可以顺便学习 RISC-V 和操作系统。之前是把 x86 版本的 lab1 快做完了。

主要想问，6.828 课程的 RISC-V 版本（从 2019 开始）各年的版本区别大吗？有没有 建议选哪个版本 这种说法？

不然我就随便选一个版本了。
```
- > 说实话，你去 6.s081 课程官网稍微对比下课表，和几个 lab 的文档就知道了，我印象里没啥区别。
- > 我当时在 22 年，选择了 20 年的 s081 的 lab 做
- > 影响不大，你要是看视频的话，就 20 版本的； wsl2 也可以，他们文档里面写了的
- > 路过贴一个 n 年前写的小笔记（虽然和 op 的问题无关但是如果能帮到 op 就更好了 https://zhuanlan.zhihu.com/p/508045883
- > 我是 wsl2 里安装的 arch Linux ，按照 lab 的指引里下载好 arch Linux 的相关包，就能正常调试了
- > 开发和调试的话，无非就是以下工具 vscode ，clangd ，bear <br> [Xv6 文件系统实现 (gdb 追踪 mkfs; buffer cache 和 log) [南京大学 2022 操作系统-P29]-哔哩哔哩] https://www.bilibili.com/video/BV1LT4y1B79b
- > 不管了，就选 20 年的。感觉 20 的，网上的视频和 笔记 都挺多的。
- > 我印象中涉及到汇编的不多，能看懂的水平就行，x86 和 riscv 原理都是一样的，就指令表达不一样
- > 不搞嵌入式 不用下探到指令集吧

做 6.828 课程，选择 x86 版本还是 RISCV 版本，差别大吗？ https://www.v2ex.com/t/1044510
```console
https://pdos.csail.mit.edu/6.828/2018/xv6.html

目前选择的是 2018 版，也就是最后一年的 x86 版本。目前完成了 lab1 的大部分练习。

在完成 lab1 的过程中，会直接接触一些 架构上老旧的东西，比如实模式和 32 位保护模式，但这个东西对学习操作系统本身来说是没有帮助的。

所以我有点担心，因为选择了 x86 版本，后续的 lab 过程，还会学习到这种老旧的东西（之所以说它老旧，是因为这种东西一般都是因为 x86 的历史原因才保留下来的东西）。
（ PS： https://blog.csdn.net/qicaiyuwu/article/details/108653923 ， 比如这篇博客里，有什么调用门、中断门、陷阱门、任务门，然后我就感觉 x86 里面这些东西好绕）

我主要想问大家：
选择 x86 版本还是 RISCV 版本，差别大吗？其实对我来说没有区别，甚至感觉选择了 RISCV 后还能顺便学习下 RISCV （个人有比较好的 arm 架构基础，应该比较好入门 RISCV 吧）
继续 x86 版本，后面会遇到这种老旧的东西吗？
```
- > 学完再说 不要想那么多 x86 老东西那些屎山代码 还是有点意思的
- > 知道保护模式那回事儿就差不多了吧。 不如 rsicv ，x86 有些历史包袱。
- > 建议学新的，学完之后你可以再去看另外一种。

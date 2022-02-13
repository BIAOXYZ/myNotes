
Awesome Rust https://github.com/rust-unofficial/awesome-rust

如何为TiKV做贡献 - 张汉东的文章 - 知乎 https://zhuanlan.zhihu.com/p/62370907
> 来This Week in Rust网站，然后会看到一个「Call for Participation」的分类，这下面的内容就是有人已经帮你选好的Rust生态中各种开源项目需要人帮忙的各种issues。上面也可以不定期地看到TiKV的各种issues
>> https://this-week-in-rust.org/

用Rust开发Linux驱动？内核维护者表示愿意接受 https://www.ithome.com/0/442/848.htm
> 不过底下有开发者指出了目前使用Rust实现驱动程序（ https://github.com/fishinabarrel/linux-kernel-module-rust ）的不便之处：
  - Linux内核不保证API/ABI的稳定性，因此很难设计通用的Rust接口。至少几乎不可能使它适用于所有版本的Linux。
  - 许多C语言特性没有相应的Rust支持。例如，构造具有位域（bitfield）的结构体似乎是无法实现的。
  
在不安装任何软件的情况下，学习 Rust https://www.v2ex.com/t/658299
- 如何在不安装任何软件的情况下，学习Rust https://juejin.im/post/5e81b40a6fb9a03c7e200308
  * > 通过 GitHub Actions，我们可以直接在你的浏览器中学习和探索 Rust 代码。

Rust语言圣经 (The Course) https://github.com/sunface/rust-course
- > “连续六年成为全世界最受喜爱的语言，无GC也无需手动内存管理、极高的性能和安全性、过程/OO/函数式编程、优秀的包管理、JS未来基石" — 工作之余的第二语言来试试Rust吧。`<<Rust语言圣经>>`拥有全面且深入的讲解、生动贴切的示例、德芙般丝滑的内容，甚至还有JS程序员关注的WASM和Deno等专题。这可能是目前最用心的Rust中文学习教程/书籍
- > 在线阅读
  * 官方：https://course.rs/
  * 国内镜像：https://book.rust.team/
  * 知乎：支持章节内目录跳转，很好用!  https://www.zhihu.com/column/c_1452781034895446017

Rust 程序设计语言 简体中文版 https://kaisery.github.io/trpl-zh-cn/ || https://github.com/KaiserY/trpl-zh-cn
- > 本书的 HTML 版本可以在 https://doc.rust-lang.org/stable/book/ （[简体中文译本](https://kaisery.github.io/trpl-zh-cn/title-page.html)）在线阅读，离线版则包含在通过 `rustup` 安装的 Rust 中；运行 `rustup docs --book` 可以打开。
- 4.认识所有权 https://kaisery.github.io/trpl-zh-cn/ch04-00-understanding-ownership.html

# Rust项目

RisingLight https://github.com/risinglightdb/risinglight

Type Exercise in Rust https://github.com/skyzh/type-exercise-in-rust
- > See Also...
  * > RisingLight is an OLAP database system for educational purpose. Most of the techniques described in this lecture have already been implemented in our educational database system “RisingLight”.

Nebari https://github.com/khonsulabs/nebari

# Rust相关新闻

[评论]Go语言的成功也预示着Rust的成功 - 软件和应用 - cnBeta.COM https://www.cnbeta.com/articles/tech/789181.htm

# Rust语法点

## 内存安全

Rust 是如何保障内存安全的 https://xie.infoq.cn/article/3cfc5d243a16fd14d85628033

Rust是如何做到内存安全的 - chunquedong的文章 - 知乎 https://zhuanlan.zhihu.com/p/92277421

Rust是如何实现内存安全的--理解RAII/所有权机制/智能指针/引用 https://blog.csdn.net/gengzhikui1992/article/details/111413056

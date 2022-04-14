
Fixed-point arithmetic https://en.wikipedia.org/wiki/Fixed-point_arithmetic || 定点数运算 https://zh.wikipedia.org/wiki/%E5%AE%9A%E9%BB%9E%E6%95%B8%E9%81%8B%E7%AE%97
- > 在电脑中，定点数（英语：fixed-point number）是指用固定整数字数表达分数的格式，属于实数数据类型中一种。***例如美元常会表示到二位小数，以分来表示，即为一种定点数***。有时定点数也会要求要有固定的整数字数。定点数与更复杂的浮点数相对。

Floating-point arithmetic https://en.wikipedia.org/wiki/Floating-point_arithmetic || 浮点数 https://zh.wikipedia.org/wiki/%E6%B5%AE%E7%82%B9%E6%95%B0

Appendix D -- What Every Computer Scientist Should Know About Floating-Point Arithmetic https://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html

Floating point versus fixed point: what are the pros/cons? https://stackoverflow.com/questions/3692738/floating-point-versus-fixed-point-what-are-the-pros-cons

Why are floating point numbers inaccurate? https://stackoverflow.com/questions/21895756/why-are-floating-point-numbers-inaccurate

Fixed Point and Floating Point Number Representations https://www.tutorialspoint.com/fixed-point-and-floating-point-number-representations
- > **Fixed-Point Representation**
- > **Example** − Assume number is using `32`-bit format which reserve `1` bit for the sign, `15` bits for the integer part and `16` bits for the fractional part.
  * > Then, `-43.625` is represented as following: 
  * > ![](https://www.tutorialspoint.com/assets/questions/media/18154/36_3.jpg)
  * > Where, `0` is used to represent `+` and `1` is used to represent `-`. `000000000101011` is `15` bit binary value for decimal `43` and `1010000000000000` is `16` bit binary value for fractional `0.625`.
- > The ***advantage*** of using a fixed-point representation is performance and ***disadvantage*** is relatively limited range of values that they can represent. So, it is usually inadequate for numerical analysis as it does not allow enough numbers and accuracy. A number whose representation exceeds 32 bits would have to be stored inexactly.
  * > ![](https://www.tutorialspoint.com/assets/questions/media/18154/36_4.jpg)
  * > These are above smallest positive number and largest positive number which can be store in `32`-bit representation as given above format. Therefore, the smallest positive number is $2^{-16}$ ≈ `0.000015` approximate and the largest positive number is $(2^{15} - 1) + (1 - 2^{-16}) = 2^{15} \times (1 - 2^{-16}) = 32768$, and gap between these numbers is $2^{16}$.
- > **Floating-Point Representation**
  * > This representation does not reserve a specific number of bits for the integer part or the fractional part. Instead it reserves a certain number of bits for the number (called the `mantissa` or `significand`) and a certain number of bits to say where within that number the decimal place sits (called the `exponent`).
  * > Only the `mantissa m` and the `exponent e` are physically represented in the register (including their sign). A floating-point binary number is represented in a similar manner except that is uses base 2 for the exponent. A floating-point number is said to be `normalized` if the most significant digit of the `mantissa` is `1`.
  * > So, actual number is $(-1)^s \times (1+m) \times 2^{(e-Bias)}$, where `s` is the `sign bit`, `m` is the `mantissa`, `e` is the `exponent` value, and `Bias` is the bias number.
  * > Note that signed integers and exponent are represented by either sign representation, or one’s complement representation, or two’s complement representation.
  * > The floating point representation is more flexible. Any non-zero number can be represented in the normalized form of $±(1.b_1b_2b_3 ...)_2 \times 2^n$. This is normalized form of a number `x`.
- > **Example** − Suppose number is using `32`-bit format: the `1` bit sign bit, `8` bits for signed exponent, and `23` bits for the fractional part. ***The leading bit 1 is not stored*** (as it is always 1 for a normalized number) and is referred to as a “hidden bit”.
  * > Then `-53.5` is normalized as  $-53.5 = (-110101.1)_2 = (-1.101011) \times 2^5$, which is represented as following below,
  * > ![](https://www.tutorialspoint.com/assets/questions/media/18154/36_6.jpg)
    >> //notes：注意图里 Mantissa part 的表示形式里其实是省略了一个1的（省略的是原来的形式里小数点左边唯一一个1 —— 具体说就是：`-1.101011` 里小数点左边唯一的那个1，只剩下小数点右边的 `101011`），这也是约定。
  * > Where `00000101` is the `8`-bit binary value of exponent value `+5`.

为什么叫浮点数? - 知乎 https://www.zhihu.com/question/19848808
- 为什么叫浮点数? - 灵剑的回答 - 知乎 https://www.zhihu.com/question/19848808/answer/120393769
  * > 定点数的优点是很简单，大部分运算实现起来和整数一样或者略有变化，但是缺点则是表示范围，比如我们刚才的例子中，最大只能表示32；而且在表示很小的数的时候，大部分位都是0，精度很差，不能充分运用存储单元。浮点数就是设计来克服这个缺点的，它相当于一个定点数加上一个阶码，阶码表示将这个定点数的小数点移动若干位。由于可以用阶码移动小数点，因此称为浮点数。
- 为什么叫浮点数? - zhanyd的回答 - 知乎 https://www.zhihu.com/question/19848808/answer/1774184018
  * > 由于 `1≤M<2`，也就是说，`M` 可以写成 `1.xxxxxx` 的形式，其中 `xxxxxx` 表示小数部分。`IEEE 754` 规定，在计算机内部保存 `M` 时，默认这个数的第一位总是`1`，因此可以被舍去，只保存后面的 `xxxxxx` 部分。***比如保存1.101的时候，只保存101，等到读取的时候，再把第一位的1加上去***。这样做的目的，是节省1位有效数字。以32位浮点数为例，留给M只有23位，将第一位的1舍去以后，等于可以保存24位有效数字。你看，一不小心又提高了一位精度，科学家为了少用1位的空间都绞尽脑汁，我们平时写程序经常浪费巨大的开销都浑然不觉，相比之下，实在汗颜。
- 为什么叫浮点数? - Tux ZZ的回答 - 知乎 https://www.zhihu.com/question/19848808/answer/120408664
  * > 二进制浮点数的表示方法类似科学计数法，用数学表示写出来是类似1.6142568乘2的3次方这样的 <br> 优点是可以表示很小或很大的数，同时保证有效位数
  * > 十进制浮点数就是纯粹的科学计数法，用数学表示写出来类似2.3333乘10的3次方这样的

【[:star:][`*`]】 谈谈二进制（五）——定点数与浮点数 https://segmentfault.com/a/1190000024485146
- > **0.概要**
  * > 二进制系列文章已经写到第五篇了，不出意外的话，这应该会是二进制系列的最后一篇。我们先来罗列一下前四篇：
    + > 谈谈二进制（一） https://segmentfault.com/a/1190000023833719
    + > 谈谈二进制（二）——四则运算 https://segmentfault.com/a/1190000023880414
    + > 谈谈二进制（三）——位运算及其应用 https://segmentfault.com/a/1190000023918713
    + > 谈谈二进制（四）——原码、补码、反码、移码 https://segmentfault.com/a/1190000024426172
  * > 其中，在上一篇里，我们认识了四种机器数，它们各司其职，但总的来说，有一个特点，就是在对计算机里的正负号做文章。今天介绍的定点数和浮点数，则是对小数点做文章。
  * > 上一篇文章的开头，我们说到，计算机中只能存储数字，因此需要用 `0` 和 `1` 来表示正负，同样的，计算机中的小数点，也要用特殊的形式来表示，共有两种，即本文所要讲的**定点数**和**浮点数**。
- > **1.定点数**
  * > 所谓定点数，就是指**小数点的位置是固定的，约定小数点在某一个位置上**，因此，机器在处理定点数时，并不存储它的小数点。使用定点数的机器，被称为定点机。当然了，现代计算机一般只要有运算部件，都会提供对定点数运算的支持。
  * > 虽然理论上，定点数的小数点的位置可以任意规定，<ins>但通常只会用定点数表示**纯小数**或**整数**</ins>，当表示纯小数时，小数约定在上一篇文章里反复提及的**符号位**和数值部分之间，同理，表示整数时，则在数值部分的后面。下图展示了定点小数和定点整数的结构： <br> ![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f5365151ca99439d8acb18a2502dd6bc~tplv-k3u1fbpfcp-zoom-1.image)
  * > 为什么通常只用定点数表示纯小数或整数呢？因为上面我们提到的，定点机在存储定点数时，并不存储小数点，因此我们的数字在定点机中是一串看上去像整数的东西，如果我们存入了非纯小数或整数，它们的计算结果就会很容易出现问题，譬如 `1.23` 和 `12.3`，在定点机中它们没有小数点，都是 `123`，那么它们在做加、减、除后的结果都是不对的，即便是乘法，其结果也需要我们自己再去算它的小数点位。
  * > 而纯小数或整数处理起来就方便多了，譬如整数，它的加、减、乘三种运算结果都是整数，而除法如果遇到除不尽的情况，一般也会取余处理。纯小数同理，但比整数稍微麻烦一点，主要是加法和除法，会有益处的风险，此时一些定点机可能会直接抛出异常。
  * > 定点机由于它的特性，在硬件层面设计会更简单。
- > **2.浮点数**
  * > 浮点数是大家比较熟悉的一个词汇，也就是我们平时编程语言中的 `float` 和 `double`。***<ins>前面定点数由于本身性质的限制，难以处理复杂的非纯小数和整数，此时就需要浮点数来处理了</ins>***。
  * > 所谓浮点，与定点相对，就是小数点是浮动的，不固定的，它的形式有点像我们熟悉的科学计数法，譬如 `12.34` 这个数，可以写成下面几种形式： <br> $12.34 = 1.234 \times 10^1 = 0.1234 \times 10^2 = 1234 \times 10^{-2}$
  * > 浮点数的标准形式如下： <br> $N = M \times B^E$
  * > 其中，`M` 为尾数，`B` 为基数，`E` 为阶码，这个式子和各个字母的含义已经非常清晰了，直接对照上面 `12.34` 这个例子看就好。当然了，`12.34` 这个例子举的是我们最熟悉的十进制，我们计算机中使用的当然是二进制，而根据前面几篇（应该是第一篇）二进制系列文章我们知道，二进制各个位数之间相差2倍，因此，如果要用浮点式表示一个二进制数时，这里的 `基数B` 就是 `2` 了，譬如： <br> $101.11 = 10.111 \times 2^1 = 1.0111 \times 2^2 = 10111 \times 2^{−2} = 0.10111 \times 2^3 = 0.010111 \times 2^4$
  * > 非常好理解。有些地方会把 `阶码E` 也表示成二进制的形式，譬如 `2` 次幂使用 `10` 次幂来表示，这个大家根据实际情况辨别即可，核心都是不变的。
  * > 通常来说，计算机为了提高数据精度和便于浮点数之间的比较，规定浮点数的 `尾数M` 用纯小数表示，即上面二进制 `101.11` 的最后两种表示形式。同时，将尾数最高位为 `1` 的浮点数称为规格化数，对于 `101.11` 来说，倒数第二种形式 $0.10111 \times 2^3$ 就是它的规格化表示。
- > **2.1 计算机中的浮点数**

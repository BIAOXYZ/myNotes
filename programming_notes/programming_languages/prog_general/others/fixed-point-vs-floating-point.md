
Fixed-point arithmetic https://en.wikipedia.org/wiki/Fixed-point_arithmetic

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
    >> //notes：注意图里 Mantissa part 里首位的1（该部分最左边——其实际对应的是原来的形式里小数点左边那唯一个1）被省略了，这也是约定。
  * > Where `00000101` is the `8`-bit binary value of exponent value `+5`.

为什么叫浮点数? - 知乎 https://www.zhihu.com/question/19848808
- 为什么叫浮点数? - 灵剑的回答 - 知乎 https://www.zhihu.com/question/19848808/answer/120393769
  * > 定点数的优点是很简单，大部分运算实现起来和整数一样或者略有变化，但是缺点则是表示范围，比如我们刚才的例子中，最大只能表示32；而且在表示很小的数的时候，大部分位都是0，精度很差，不能充分运用存储单元。浮点数就是设计来克服这个缺点的，它相当于一个定点数加上一个阶码，阶码表示将这个定点数的小数点移动若干位。由于可以用阶码移动小数点，因此称为浮点数。
- 为什么叫浮点数? - zhanyd的回答 - 知乎 https://www.zhihu.com/question/19848808/answer/1774184018
  * > 由于 `1≤M<2`，也就是说，`M` 可以写成 `1.xxxxxx` 的形式，其中 `xxxxxx` 表示小数部分。`IEEE 754` 规定，在计算机内部保存 `M` 时，默认这个数的第一位总是`1`，因此可以被舍去，只保存后面的 `xxxxxx` 部分。***比如保存1.101的时候，只保存101，等到读取的时候，再把第一位的1加上去***。这样做的目的，是节省1位有效数字。以32位浮点数为例，留给M只有23位，将第一位的1舍去以后，等于可以保存24位有效数字。你看，一不小心又提高了一位精度，科学家为了少用1位的空间都绞尽脑汁，我们平时写程序经常浪费巨大的开销都浑然不觉，相比之下，实在汗颜。
- 为什么叫浮点数? - Tux ZZ的回答 - 知乎 https://www.zhihu.com/question/19848808/answer/120408664
  * > 二进制浮点数的表示方法类似科学计数法，用数学表示写出来是类似1.6142568乘2的3次方这样的 <br> 优点是可以表示很小或很大的数，同时保证有效位数
  * > 十进制浮点数就是纯粹的科学计数法，用数学表示写出来类似2.3333乘10的3次方这样的

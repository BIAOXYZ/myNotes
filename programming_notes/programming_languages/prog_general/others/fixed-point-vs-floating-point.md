
Fixed-point arithmetic https://en.wikipedia.org/wiki/Fixed-point_arithmetic

Appendix D -- What Every Computer Scientist Should Know About Floating-Point Arithmetic https://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html

Floating point versus fixed point: what are the pros/cons? https://stackoverflow.com/questions/3692738/floating-point-versus-fixed-point-what-are-the-pros-cons

Why are floating point numbers inaccurate? https://stackoverflow.com/questions/21895756/why-are-floating-point-numbers-inaccurate

Fixed Point and Floating Point Number Representations https://www.tutorialspoint.com/fixed-point-and-floating-point-number-representations
- > **Example** − Assume number is using `32`-bit format which reserve `1` bit for the sign, `15` bits for the integer part and `16` bits for the fractional part.
  * > Then, `-43.625` is represented as following: 
  * > ![](https://www.tutorialspoint.com/assets/questions/media/18154/36_3.jpg)
  * > Where, `0` is used to represent `+` and `1` is used to represent `-`. `000000000101011` is `15` bit binary value for decimal `43` and `1010000000000000` is `16` bit binary value for fractional `0.625`.
- > The ***advantage*** of using a fixed-point representation is performance and ***disadvantage*** is relatively limited range of values that they can represent. So, it is usually inadequate for numerical analysis as it does not allow enough numbers and accuracy. A number whose representation exceeds 32 bits would have to be stored inexactly.
  * > ![](https://www.tutorialspoint.com/assets/questions/media/18154/36_4.jpg)
  * > These are above smallest positive number and largest positive number which can be store in `32`-bit representation as given above format. Therefore, the smallest positive number is $2^{-16}$ ≈ `0.000015` approximate and the largest positive number is $(2^{15} - 1) + (1 - 2^{-16}) = 2^{15} \times (1 - 2^{-16}) = 32768$, and gap between these numbers is $2^{16}$.

为什么叫浮点数? - 知乎 https://www.zhihu.com/question/19848808
- 为什么叫浮点数? - 灵剑的回答 - 知乎 https://www.zhihu.com/question/19848808/answer/120393769
  * > 定点数的优点是很简单，大部分运算实现起来和整数一样或者略有变化，但是缺点则是表示范围，比如我们刚才的例子中，最大只能表示32；而且在表示很小的数的时候，大部分位都是0，精度很差，不能充分运用存储单元。浮点数就是设计来克服这个缺点的，它相当于一个定点数加上一个阶码，阶码表示将这个定点数的小数点移动若干位。由于可以用阶码移动小数点，因此称为浮点数。


Eigen 简明教程 https://juejin.cn/post/6844904094713249800
- > **Which should I choose: matrix or array**
  * > 在 Python（NumPy）中，你可以用 `np.matrix` 创建矩阵，`np.array` 创建数组，但是官方推荐用 `np.array`，原因是：
  * > 由于 NumPy 的便利性，我们通常用 `np.array` 也能够完成线性代数相关的任务，进一步导致 `np.matrix` 存在感很弱。
  * > 但在 Eigen 中 `matrix` 与 `array` 是有明确区别的，总的来说，Eigen 中的 `matrix` 与线性代数息息相关，它设计的初衷就是为了解决线性代数问题，例如解线性方程组、求矩阵特征值、矩阵的秩、QR分解等等。而 `array` 则负责系数运算，例如所有系数加上一个常数或者两个 `array` 系数相乘。
  * > 因此，如果你需要线性代数的操作时，请使用 matrix；如果你需要系数操作时，请使用 array。但有时候事情不会那么简单，你可能需要同时使用 matrix 和 array，这种情况下，你需要对 matrix 和 array 进行相互转换。一个 matrix 通过 `.array()` 来得到一个 array 表达式；相似的，一个 array 通过 `.matrix()` 来得到一个 matrix 表达式。`.array()` 和 `.matrix()` 不会有任何运行时开销，它们是在编译期完成的。
- > **Initialization**
  * > **Repeating**
  * > **Miss those elements out**
- > **Slicing**
- > **Indexing and accessing elements**
- > **Maximum and minimum**
- > **Concatenation**
- > **Coefficient-wise math functions**

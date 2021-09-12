
How to draw a vertical line of desired length in equations. https://tex.stackexchange.com/questions/8138/how-to-draw-a-vertical-line-of-desired-length-in-equations
- https://tex.stackexchange.com/questions/8138/how-to-draw-a-vertical-line-of-desired-length-in-equations/8139#8139
  * > Try enclosing your expression into `\left.` and `\right\vert`, as in 
  * > `\left.\frac{\partial L}{\partial\bm{\beta}}\right\vert_{\hat\beta}=-2\bm{X'y}+2\bm{X'X\hat\beta}=0`
  * > which yields: ![](https://i.stack.imgur.com/cTQrM.png)
  >> 【[:star:][`*`]】 //notes：这个帖子主要是想记录下 Security Game 里常用到的长竖线的画法——如果需要很长的竖线的话，只用 `\Big \big` 之类的是不够的。正确的思路应该是类似画***自适应括号***时的办法，用 `\left \right` （单边括号另一边用 `\left.` 或 `\right.`）。那么问题来了，括号可以用`( [ \{` 或 `) ] \}`，竖线呢？用 `\vert`。
  >>> 个人实战例子如下：
      ```latex
      \begin{equation*}
      \left[ 
      \mathbf{Verify}(\pi_{veri}, \pi_{proof}) = 1 
      ~~ \left\vert ~~
      \begin{aligned}
         & params \leftarrow \mathbf{Setup}(1^{\kappa}); \\
         & acc_S \leftarrow \mathcal{A}^{ \mathbf{AccGen}(params, S)}; \\
         & y_{pp} \leftarrow \mathcal{A}^{ \mathbf{PreProve}(params, y, r_{veri})} \wedge y \notin S; \\
         & r_{proof} \leftarrow \mathbf{Prove}(params, acc_S, x_{pp});
      \end{aligned}
      \right.
      \right] \leq negl(\cdot)
      \end{equation*}
      ```

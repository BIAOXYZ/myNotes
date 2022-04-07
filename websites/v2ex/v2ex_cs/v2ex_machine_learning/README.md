
用 keras 搭建出一个判断今天是周几的模型？ https://www.v2ex.com/t/844757
```console
有没有前辈，能不能教下，如何用 keras 搭建一个模型，例如

x=[[2022, 12, 31]] x.shape = (-1, 3) y=[[6]] y.shape = (-1, 1)
x 对应日期，y 对应星期几，生成从 1000 年到 2021 年所有的日期对应的周几进行训练，这种模型要如何搭建？

我用了 Dense(64, activation='relu', input_shape=(3,)) Dense(64, activation='relu') Dense(1) 模型训练，
并不能得到一个很好的结果。 刚入门，希望有前辈能给一点提示。
```
- > 有时候挺服搞机器学习的 搞了这算法那算法，一看效果还不如十几年前用 sql 写的数据分析。。。
  >> 人家这明显就是用来练习的练习题呀，我们当时作业还做过让 lstm 学习整数加法呢……
- > 推荐知乎镜像问题：如何用深度学习判断某数是否是 2 的倍数？ <br> 这类问题对这种依靠“经验”的概率模型无解 建议 OP 放弃尝试 转而去研究 cv
- > 机器学习不是魔法，需要特征工程。但是题目中的问题一旦涉及到特征工程，就和朴素的算星期几没有多少差别了。
  >
  > ps 补充“特征工程”这个论点。
  * > 如何用神经网络学习奇偶判定？直接放进去一个数是不行的，因为机器学习模型在这个问题上，任何超出训练集范围的数都是“训练分布外的数据”，不能得到有意义的输出。
  * > 正确的方法是比如，转换成二进制，拆成若干 0/1 串。。。。那恭喜你，正确答案就是看最低位的。这个机器学习能学到。但是已经转换成二进制了，那和直接写出奇偶判定的程序，也差别不大了。
  * > 当然你也可以转换成四进制、八进制，十进制，六进制。这几个进制对于奇偶判定的问题都比较 easy 。若是转换为三进制、五进制，多看几位应当也能搞定。这就是机器学习和人做奇偶判定程序有区别的地方了，人的话必须先二进制，然后才能给答案，第一步特征工程必须非常精确。但是机器学习的话，稍微有点偏差，给个 X 进制，也能凑合着学出来。所以它比普通的程序算法要稍微“智能”那么一点。
- > 神经网络很难做取模运算吧。可以试试输入二进制化后的一堆 0 和 1 ，输出改成分类而不是直接输出 1 个数字。
- > 如果不怎么在乎实现难度的话可以考虑把年月日转换成 embedding 输入。
- > 虽然在工业实践上不该这么做，但在学术上研究这些问题是有意义的
- > 我记得 莫烦 有个类似的例子, 但一下找不到了, 你找找看
  >
  > 找到了, 莫烦的例子是 https://mofanpy.com/tutorials/machine-learning/nlp/seq2seq/ 
  ```
  # 中文的 "年-月-日" -> "day/month/year"
  "98-02-26" -> "26/Feb/1998"
  ```
  > 当然, 你这个模型要比莫烦这个例子难不少, 有没有解都不好说.建议入门时选一些难度适宜的
- 个人补充：
  * 能否使用神经网络来判断奇偶数？ - 知乎 https://www.zhihu.com/question/364113452
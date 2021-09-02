
TensorFlow 2.0 Tutorial For Beginners | TensorFlow Demo | Deep Learning & TensorFlow | Simplilearn https://www.youtube.com/watch?v=QPDsEtUK_D4

【北京大学】Tensorflow2.0 https://www.bilibili.com/video/BV1B7411L7Qt
- P1 0开篇语-全 https://www.bilibili.com/video/BV1B7411L7Qt?p=1
- 回复：
  * > 自己整理的学习笔记和收集的老师上课的ppt，已经上传到github上了 地址： https://github.com/dxc19951001/Study_TF2.0 欢迎大家clone与star

tensorflow2.0入门与实战 2019年最通俗易懂的课程 https://www.bilibili.com/video/BV1Zt411T7zE
- P2 2.1 最新 Tensorflow 2.3 CPU 版本极简安装 https://www.bilibili.com/video/BV1Zt411T7zE?p=2
- P7 6.多层感知器（神经网络）与激活函数 https://www.bilibili.com/video/BV1Zt411T7zE?p=7
  * > `1:50`: 单层神经元的缺陷：无法拟合“异或”运算。
  * > `2:15`: 神经元要求数据必须是线性可分的，“异或”问题无法找到一条直线分割两个类，这个问题使得神经网络的发展停滞了很多年。
  * > `4:45`: 多层感知器，在`输入层`和`输出层`之间有若干层的`隐藏层`。
  * > `5:05`: 激活函数模拟了大脑中`神经元`的原理：对于传入的信号，如果满足某些条件，就继续往下执行；不满足条件就弱化或者不往下传递了。***激活能够为网络带来非线性，使得神经网络可以拟合非线性问题***。
  * > `6:30`: `relu` 激活、`sigmod` 激活、`tanh` 激活、`Leaky ReLU` 激活
    >> //notes：原来所谓的 `ReLU` 激活函数，不过是“***输入小于等于0时屏蔽掉，大于0时原样输出***”，也就是其实质是 $ReLU(x) = max(0, x)$。
- P9 8.逻辑回归与交叉熵 https://www.bilibili.com/video/BV1Zt411T7zE?p=9
  * > `3:00`: ***平方差所惩罚的是与损失为同一数量级的情形***。对于分类问题，我们最好使用`交叉熵损失函数`会更有效。交叉熵会输出一个更大的“损失”。
    >> //notes：个人觉得这个观点也算是有点道理吧。比如feature值都很大（房价），但是预测结果就是0和1（买或者不买），确实有量级的差距（但是这个时候一般不都是用feature value缩放嘛）。
- P10 9.逻辑回归实现 https://www.bilibili.com/video/BV1Zt411T7zE?p=10
  * > `0:45`: 对于没有列名那一行（也就是第一行就是数据行）的数据集，`pd.read_csv()` 时加上 `header=None`。
  * > `1:25`: `data.iloc[:, -1].value_counts()` 方法，统计名为 `data`（该数据集最后一列为label）的数据集的最后一列的值的情况。
    ```console
    1     357
    -1    296
    Name: 15,  dtype: int64 
    ```
  * > `3:20`: 从数据集 `data` 中分别取训练集和标签，并且把标签里的 -1 换成 0。
    ```py
    x = data.iloc[:, :-1]
    y = data.iloc[:, -1].replace(-1, 0)
    ```

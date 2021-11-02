
# numpy官方

Data type objects (dtype) https://numpy.org/doc/stable/reference/arrays.dtypes.html

Broadcasting https://numpy.org/doc/stable/user/basics.broadcasting.html

# numpy源码

# numpy语法

## shape
python: numpy--函数 shape用法 https://blog.csdn.net/xingchengmeng/article/details/62881859

## arange
Python 中的range(),arange()函数 https://blog.csdn.net/qianwenhong/article/details/41414809

## tile
- python numpy-tile函数 https://www.jianshu.com/p/4b74a367833c
- numpy 辨异（四）—— np.repeat 与 np.tile https://blog.csdn.net/lanchunhui/article/details/56017472

## stack(), vstack(), hstack()
- Numpy中stack()，hstack()，vstack()函数详解 https://blog.csdn.net/csdn15698845876/article/details/73380803
- Numpy array 合并 https://morvanzhou.github.io/tutorials/data-manipulation/np-pd/2-6-np-concat/
- 从数组到矩阵的迹，NumPy常见使用大总结 https://www.jiqizhixin.com/articles/2017-10-28

## numpy数据类型

What does dtype=object mean while creating a numpy array? https://stackoverflow.com/questions/29877508/what-does-dtype-object-mean-while-creating-a-numpy-array
- https://stackoverflow.com/questions/29877508/what-does-dtype-object-mean-while-creating-a-numpy-array/29877845#29877845
  * > NumPy arrays are stored as contiguous blocks of memory. They usually have a single datatype (e.g. integers, floats or fixed-length strings) and then the bits in memory are interpreted as values with that datatype.
  * > Creating an array with `dtype=object` is different. The memory taken by the array now is filled with pointers to Python objects which are being stored elsewhere in memory (much like a Python `list` is really just ***a list of pointers to objects, not the objects themselves***).

NumPy 数据类型 https://www.runoob.com/numpy/numpy-dtype.html

# numpy其他

np.linspace(): Create Evenly or Non-Evenly Spaced Arrays https://realpython.com/np-linspace-numpy/

【NumPy】 快速构建 ndarray 对象（np.empty、np.full、np.titl、np.r_、np.linspace） https://blog.csdn.net/tz_zs/article/details/87698697

Numpy.array()详解 、np.array与np.asarray辨析、 np.array和np.ndarry的区别 https://blog.csdn.net/sinat_28576553/article/details/89047893

Python中Numpy.append的用法解析 https://blog.csdn.net/sinat_28576553/article/details/90247286
- > 之前只见过列表list的append方法，昨天写代码的时候，看到了numpy库的append方法，记录一下。简单的说，该方法功能就是**将一个数组附加到另一个数组的尾部**。

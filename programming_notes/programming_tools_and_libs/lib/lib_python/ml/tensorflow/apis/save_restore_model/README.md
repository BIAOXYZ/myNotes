
# 官方

保存和恢复模型 https://www.tensorflow.org/tutorials/keras/save_and_load
- 使用 SavedModel 格式 https://tensorflow.google.cn/guide/saved_model
- 基于对象的保存 https://tensorflow.google.cn/guide/eager#%E5%9F%BA%E4%BA%8E%E5%AF%B9%E8%B1%A1%E7%9A%84%E4%BF%9D%E5%AD%98

训练检查点 https://www.tensorflow.org/guide/checkpoint

tf.compat.v1.train.Saver https://www.tensorflow.org/api_docs/python/tf/compat/v1/train/Saver

tf.train.Checkpoint https://www.tensorflow.org/api_docs/python/tf/train/Checkpoint || https://www.tensorflow.org/versions/r1.15/api_docs/python/tf/train/Checkpoint
- `class Checkpoint(tracking.AutoTrackable):` https://github.com/tensorflow/tensorflow/blob/v2.6.0/tensorflow/python/training/tracking/util.py#L1844-L2347
- `class CheckpointV1(tracking.AutoTrackable):` https://github.com/tensorflow/tensorflow/blob/v1.15.0/tensorflow/python/training/tracking/util.py#L1317-L1675

tf.train.Saver https://www.tensorflow.org/versions/r1.15/api_docs/python/tf/train/Saver 【这个貌似2.0以上没有了？ --> 应该是的，看来2.0以上用 `tf.train.Checkpoint` 代替 `tf.train.Saver` 了。】
- `class Saver(object):` https://github.com/tensorflow/tensorflow/blob/v1.15.0/tensorflow/python/training/saver.py#L606-L1338

tf.saved_model.save https://www.tensorflow.org/api_docs/python/tf/saved_model/save || https://www.tensorflow.org/versions/r1.15/api_docs/python/tf/saved_model/save

# `tf.train.Checkpoint`

tf.train.Checkpoint ：变量的保存与恢复 https://tf.wiki/zh_hans/basic/tools.html#tf-train-checkpoint || https://www.bookstack.cn/read/TensorFlow2.0/spilt.1.3b87bc87b85cbe5d.md
- > Checkpoint ***只保存模型的参数，不保存模型的计算过程***，因此一般用于在***具有模型源代码的时候恢复之前训练好的模型参数***。如果需要导出模型（无需源代码也能运行模型），请参考 “部署” 章节中的 SavedModel 。

【[:star:][`*`]】 Tensorflow模块：tf.train.Checkpoint https://www.jianshu.com/p/5006be1c5f59
- > 很多时候，我们希望在模型训练完成后能将训练好的参数（变量）保存起来。在需要使用模型的其他地方载入模型和参数，就能直接得到训练好的模型。可能你第一个想到的是用 Python 的序列化模块 `pickle` 存储 `model.variables`。但不幸的是，TensorFlow 的变量类型 `ResourceVariable` 并不能被序列化。
- > 总体而言，恢复与保存变量的典型代码框架如下：
  ```py
  # train.py 模型训练阶段
  
  model = MyModel()
  # 实例化Checkpoint，指定保存对象为model（如果需要保存Optimizer的参数也可加入）
  checkpoint = tf.train.Checkpoint(myModel=model)
  # ...（模型训练代码）
  # 模型训练完毕后将参数保存到文件（也可以在模型训练过程中每隔一段时间就保存一次）
  checkpoint.save('./save/model.ckpt')
  ```
  ```py
  # test.py 模型使用阶段
  
  model = MyModel()
  checkpoint = tf.train.Checkpoint(myModel=model)             # 实例化Checkpoint，指定恢复对象为model
  checkpoint.restore(tf.train.latest_checkpoint('./save'))    # 从文件恢复模型参数
  # 模型使用代码
  ```
- > `tf.train.Checkpoint` 与以前版本常用的 `tf.train.Saver` 相比，强大之处在于其支持在即时执行模式下 “延迟” 恢复变量。具体而言，当调用了 `checkpoint.restore()` ，但模型中的变量还没有被建立的时候，Checkpoint 可以等到变量被建立的时候再进行数值的恢复。即时执行模式下，模型中各个层的初始化和变量的建立是在模型第一次被调用的时候才进行的（好处在于可以根据输入的张量形状而自动确定变量形状，无需手动指定）。这意味着当模型刚刚被实例化的时候，其实里面还一个变量都没有，这时候使用以往的方式去恢复变量数值是一定会报错的。比如，你可以试试在 train.py 调用 `tf.keras.Model` 的 `save_weight()` 方法保存 model 的参数，并在 test.py 中实例化 model 后立即调用 `load_weight()` 方法，就会出错，只有当调用了一遍 model 之后再运行 `load_weight()` 方法才能得到正确的结果。可见， `tf.train.Checkpoint` 在这种情况下可以给我们带来相当大的便利。另外， `tf.train.Checkpoint` 同时也支持图执行模式。
- > 使用 `tf.train.CheckpointManager` 删除旧的 Checkpoint 以及自定义文件编号
  * > 这时，我们可以使用 TensorFlow 的 `tf.train.CheckpointManager` 来实现以上需求。具体而言，在定义 Checkpoint 后接着定义一个 CheckpointManager：
    ```py
    checkpoint = tf.train.Checkpoint(model=model)
    manager = tf.train.CheckpointManager(checkpoint, directory='./save', checkpoint_name='model.ckpt', max_to_keep=k)
    ```

# 其他

Save & Restore a Model https://github.com/aymericdamien/TensorFlow-Examples/blob/master/tensorflow_v2/notebooks/4_Utils/save_restore_model.ipynb
- > Save and Restore a model using TensorFlow v2. In this example, we will go over both low and high-level approaches:
  * > Low-level: TF Checkpoint.
  * > High-level: TF Module/Model saver.

A quick complete tutorial to save and restore Tensorflow 2.0 models https://cv-tricks.com/tensorflow-tutorial/save-restore-tensorflow-models-quick-complete-tutorial-2-x/

tensorflow 模型导出总结 - sergio的文章 - 知乎 https://zhuanlan.zhihu.com/p/113734249

## TFv1相关

TensorFlow学习笔记：Saver与Restore https://www.jianshu.com/p/b0c789757df6
- > **`tf.train.Saver`**
  * > 注意：saver()与restore()只是保存了session中的相关变量对应的值，并不涉及模型的结构。
- > **Saver**
  * > Defined in [`tensorflow/python/training/saver.py`](https://github.com/tensorflow/tensorflow/blob/r1.3/tensorflow/python/training/saver.py).

Save and Restore https://www.easy-tensorflow.com/tf-tutorials/basics/save-and-restore

TensorFlow入门（九）使用 tf.train.Saver()保存模型 https://blog.csdn.net/Jerr__y/article/details/78594494

TensorFlow保存和恢复变量——tf.train.Saver() https://blog.csdn.net/hustqb/article/details/80776306

# errors

## `Error: static assertion failed: std::string is no longer a scalar type, use tensorflow::tstring`
>> 原因就是TF在2.2.0版本后用自己的 `tensorflow::tstring` 代替了 `std::string`，所以只需要做如下类似修改即可：
- 以前： `const string& prefix_string = prefix.scalar<string>()();` https://github.com/tensorflow/tensorflow/blob/r1.14/tensorflow/core/kernels/save_restore_v2_ops.cc#L104
- 现在（从`r1.15`开始）： `const string& prefix_string = prefix.scalar<tstring>()();` https://github.com/tensorflow/tensorflow/blob/r2.6/tensorflow/core/kernels/save_restore_v2_ops.cc#L105

Make failed with C++ API used like external library. Error: static assertion failed: std::string is no longer a scalar type, use tensorflow::tstring #43150 https://github.com/tensorflow/tensorflow/issues/43150
- > https://github.com/tensorflow/tensorflow/issues/43150#issuecomment-691332546
  * > They have started to use tensorflow::tstring as you can see from https://github.com/tensorflow/tensorflow/commit/f05a57eefe9f03c9fae83d0fcb727ee07949d963

TensorFlow 2.2.0 Released: Intuitive Features Including New TensorFlow’s Docker Images https://analyticsindiamag.com/tensorflow-2-2-0-released-intuitive-features-including-new-tensorflows-docker-images/
- > The scalar type is replaced for string tensors from `std::string` to `tensorflow::tstring` and is now ABI stable.

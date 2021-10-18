
# 官方

保存和恢复模型 https://www.tensorflow.org/tutorials/keras/save_and_load
- 使用 SavedModel 格式 https://tensorflow.google.cn/guide/saved_model
- 基于对象的保存 https://tensorflow.google.cn/guide/eager#%E5%9F%BA%E4%BA%8E%E5%AF%B9%E8%B1%A1%E7%9A%84%E4%BF%9D%E5%AD%98

训练检查点 https://www.tensorflow.org/guide/checkpoint

tf.compat.v1.train.Saver https://www.tensorflow.org/api_docs/python/tf/compat/v1/train/Saver

tf.train.Checkpoint https://www.tensorflow.org/api_docs/python/tf/train/Checkpoint || https://www.tensorflow.org/versions/r1.15/api_docs/python/tf/train/Checkpoint
- `class Checkpoint(tracking.AutoTrackable):` https://github.com/tensorflow/tensorflow/blob/v2.6.0/tensorflow/python/training/tracking/util.py#L1844-L2347
- `class CheckpointV1(tracking.AutoTrackable):` https://github.com/tensorflow/tensorflow/blob/v1.15.0/tensorflow/python/training/tracking/util.py#L1317-L1675

tf.train.Saver https://www.tensorflow.org/versions/r1.15/api_docs/python/tf/train/Saver 【这个貌似2.0以上没有了？】
- `class Saver(object):` https://github.com/tensorflow/tensorflow/blob/v1.15.0/tensorflow/python/training/saver.py#L606-L1338

tf.saved_model.save https://www.tensorflow.org/api_docs/python/tf/saved_model/save || https://www.tensorflow.org/versions/r1.15/api_docs/python/tf/saved_model/save

# 其他

Save & Restore a Model https://github.com/aymericdamien/TensorFlow-Examples/blob/master/tensorflow_v2/notebooks/4_Utils/save_restore_model.ipynb
- > Save and Restore a model using TensorFlow v2. In this example, we will go over both low and high-level approaches:
  * > Low-level: TF Checkpoint.
  * > High-level: TF Module/Model saver.

TensorFlow学习笔记：Saver与Restore https://www.jianshu.com/p/b0c789757df6
- > **`tf.train.Saver`**
  * > 注意：saver()与restore()只是保存了session中的相关变量对应的值，并不涉及模型的结构。
- > **Saver**
  * > Defined in [`tensorflow/python/training/saver.py`](https://github.com/tensorflow/tensorflow/blob/r1.3/tensorflow/python/training/saver.py).

Save and Restore https://www.easy-tensorflow.com/tf-tutorials/basics/save-and-restore

A quick complete tutorial to save and restore Tensorflow 2.0 models https://cv-tricks.com/tensorflow-tutorial/save-restore-tensorflow-models-quick-complete-tutorial-2-x/

TensorFlow入门（九）使用 tf.train.Saver()保存模型 https://blog.csdn.net/Jerr__y/article/details/78594494

TensorFlow保存和恢复变量——tf.train.Saver() https://blog.csdn.net/hustqb/article/details/80776306

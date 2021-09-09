
Examples http://pycallgraph.slowchop.com/en/master/examples/index.html

# 1  

Basic http://pycallgraph.slowchop.com/en/master/examples/basic.html#source-code
- **Source Code**
```py
#!/usr/bin/env python
'''
This example demonstrates a simple use of pycallgraph.
'''
from pycallgraph import PyCallGraph
from pycallgraph.output import GraphvizOutput

class Banana:

    def eat(self):
        pass

class Person:

    def __init__(self):
        self.no_bananas()

    def no_bananas(self):
        self.bananas = []

    def add_banana(self, banana):
        self.bananas.append(banana)

    def eat_bananas(self):
        [banana.eat() for banana in self.bananas]
        self.no_bananas()

def main():
    graphviz = GraphvizOutput()
    graphviz.output_file = 'basic.png'

    with PyCallGraph(output=graphviz):
        person = Person()
        for a in xrange(10):
            person.add_banana(Banana())
        person.eat_bananas()

if __name__ == '__main__':
    main()
```

## 个人实战1

- 由于用的是 anaconda 的虚拟环境，所以删掉了第一行选择解释器路径那行
- 由于虚拟环境是 python3，所以把原始代码里 `xrange` 改成了 `range`。
- 保存成 `test.py` 后，直接 `python test.py`，本地就会生成名为 `basic.png` 的调用关系图（前提是依赖都装好了，我记得 conda 里没有 `pycallgraphy` 这个包，是用 pip 装的）。

```py
'''
This example demonstrates a simple use of pycallgraph.
'''
from pycallgraph import PyCallGraph
from pycallgraph.output import GraphvizOutput

class Banana:

    def eat(self):
        pass

class Person:

    def __init__(self):
        self.no_bananas()

    def no_bananas(self):
        self.bananas = []

    def add_banana(self, banana):
        self.bananas.append(banana)

    def eat_bananas(self):
        [banana.eat() for banana in self.bananas]
        self.no_bananas()

def main():
    graphviz = GraphvizOutput()
    graphviz.output_file = 'basic.png'

    with PyCallGraph(output=graphviz):
        person = Person()
        for a in range(10):
            person.add_banana(Banana())
        person.eat_bananas()

if __name__ == '__main__':
    main()
```

**总结**：所以最基本的用法（命令行的不算，这里仅指需要修改code的情形）核心点其实就是：
- 开头 `import` 进去两个对象（如果要配置哪些打印哪些不打印，还需要额外导入 `Config`、`GlobbingFilter` 之类的，也就是变成下面四句）
  ```py
  from pycallgraph import PyCallGraph
  from pycallgraph.output import GraphvizOutput
  from pycallgraph import Config
  from pycallgraph import GlobbingFilter
  ```
- 让程序的主函数部分在 `with PyCallGraph(output=graphviz):` 范围内运行。

所以，上面的那个例子的另一种写法（这种写法好像还更常见）是：

```py
'''
This example demonstrates a simple use of pycallgraph.
'''
from pycallgraph import PyCallGraph
from pycallgraph.output import GraphvizOutput

class Banana:

    def eat(self):
        pass

class Person:

    def __init__(self):
        self.no_bananas()

    def no_bananas(self):
        self.bananas = []

    def add_banana(self, banana):
        self.bananas.append(banana)

    def eat_bananas(self):
        [banana.eat() for banana in self.bananas]
        self.no_bananas()

def main():
    person = Person()
    for a in range(10):
        person.add_banana(Banana())
    person.eat_bananas()

if __name__ == '__main__':
    graphviz = GraphvizOutput()
    graphviz.output_file = 'basic.png'
    with PyCallGraph(output=graphviz):
        main()
```

我们再举一个现实中的真实例子，github上的 https://github.com/tf-encrypted/tf-encrypted/ 项目里的一个用例，其地址为： https://github.com/tf-encrypted/tf-encrypted/blob/b42d7affb7028f8b48b47962d1b9f3eeab3ef032/examples/simple-average/run.py
- 当前commit下原始代码为：
```py
"""Example of a simple average using TF Encrypted."""

import logging
import sys

import tensorflow as tf

import tf_encrypted as tfe

# use configuration from file if specified
# otherwise, fall back to default LocalConfig
if len(sys.argv) >= 2:
    # config file was specified
    config_file = sys.argv[1]
    config = tfe.RemoteConfig.load(config_file)
    tfe.set_config(config)
    tfe.set_protocol(tfe.protocol.Pond())


@tfe.local_computation(name_scope="provide_input")
def provide_input() -> tf.Tensor:
    # pick random tensor to be averaged
    return tf.random_normal(shape=(10,))


@tfe.local_computation("result-receiver", name_scope="receive_output")
def receive_output(average: tf.Tensor) -> tf.Operation:
    # simply print average
    return tf.print("Average:", average)


if __name__ == "__main__":

    logging.basicConfig(level=logging.DEBUG)

    # get input from inputters as private values
    inputs = [
        provide_input(
            player_name="inputter-0"
        ),  # pylint: disable=unexpected-keyword-arg
        provide_input(
            player_name="inputter-1"
        ),  # pylint: disable=unexpected-keyword-arg
        provide_input(
            player_name="inputter-2"
        ),  # pylint: disable=unexpected-keyword-arg
        provide_input(
            player_name="inputter-3"
        ),  # pylint: disable=unexpected-keyword-arg
        provide_input(
            player_name="inputter-4"
        ),  # pylint: disable=unexpected-keyword-arg
    ]

    # sum all inputs and divide by count
    result = tfe.add_n(inputs) / len(inputs)

    # send result to receiver
    result_op = receive_output(result)

    # run a few times
    with tfe.Session() as sess:
        sess.run(result_op, tag="average")
```
- 改编后可以成功生成调用关系图的代码为：
```py
"""Example of a simple average using TF Encrypted."""

import logging
import sys

import tensorflow as tf

import tf_encrypted as tfe

##################################################
from pycallgraph import PyCallGraph
from pycallgraph.output import GraphvizOutput
##################################################

# use configuration from file if specified
# otherwise, fall back to default LocalConfig
if len(sys.argv) >= 2:
    # config file was specified
    config_file = sys.argv[1]
    config = tfe.RemoteConfig.load(config_file)
    tfe.set_config(config)
    tfe.set_protocol(tfe.protocol.Pond())


@tfe.local_computation(name_scope="provide_input")
def provide_input() -> tf.Tensor:
    # pick random tensor to be averaged
    return tf.random_normal(shape=(10,))


@tfe.local_computation("result-receiver", name_scope="receive_output")
def receive_output(average: tf.Tensor) -> tf.Operation:
    # simply print average
    return tf.print("Average:", average)


if __name__ == "__main__":
    ##################################################
    graphviz = GraphvizOutput()
    graphviz.output_file = 'basic.png'
    with PyCallGraph(output=graphviz):
    ##################################################
        logging.basicConfig(level=logging.DEBUG)

        # get input from inputters as private values
        inputs = [
            provide_input(
                player_name="inputter-0"
            ),  # pylint: disable=unexpected-keyword-arg
            provide_input(
                player_name="inputter-1"
            ),  # pylint: disable=unexpected-keyword-arg
            provide_input(
                player_name="inputter-2"
            ),  # pylint: disable=unexpected-keyword-arg
            provide_input(
                player_name="inputter-3"
            ),  # pylint: disable=unexpected-keyword-arg
            provide_input(
                player_name="inputter-4"
            ),  # pylint: disable=unexpected-keyword-arg
        ]

        # sum all inputs and divide by count
        result = tfe.add_n(inputs) / len(inputs)

        # send result to receiver
        result_op = receive_output(result)

        # run a few times
        with tfe.Session() as sess:
            sess.run(result_op, tag="average")
```
PS：运行命令是不会变的，仍然是在项目根目录下把 tfe 需要的环境配好后直接 `python python examples/simple-average/run.py`。原始的运行效果（打印出平均值）不会受影响，只是额外生成了调用关系图。

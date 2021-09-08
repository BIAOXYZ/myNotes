
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

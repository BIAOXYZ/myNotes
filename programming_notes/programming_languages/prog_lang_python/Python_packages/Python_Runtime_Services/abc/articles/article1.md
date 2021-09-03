
# 文章1

Python之abc模块 https://blog.csdn.net/haiyanggeng/article/details/81983627
- > **1.为什么使用 `abc`？**
  * > Abstract base classes由一组接口组成，检查比 `hasattr()` 更严格。通过定义一个抽象基类，可以为一组子类定义一个通用的API。这对于第三方为应用提供插件等非常有用，另外当您在一个大型的团队中工作或在一个大型的代码库中，同时将所有的类放在您的头脑中是困难或不可能的时，它也可以帮助您。
- > **2.`abc`怎么工作**
  * > `abc` 通过***把基类中的方法标记为抽象方法***，并且***注册具体类为基类的实现的方式***工作。
  * > 定义基类: `abc_base.py`
    ```py
    import abc
    
    class PluginBase(object):
        __metaclass__ = abc.ABCMeta
    
        @abc.abstractmethod
        def load(self, input):
            """Retrieve data from the input source and return an object."""
            return
    
        @abc.abstractmethod
        def save(self, output, data):
            """Save the data object to the output."""
            return
    ```
  * > 有两种方法表明一个具体类实现了一个抽象类
  * > **a) 第一种方法：通过使用 `abc` 注册，这种方法下 `RegisteredImplementation` 并不是由 `PluginBase` 派生，而是通过注册方式**.
  * > `abc_register.py`
    ```py
    import abc
    from abc_base import PluginBase

    class RegisteredImplementation(object):

        def load(self, input):
            return input.read()

        def save(self, output, data):
            return output.write(data)

    PluginBase.register(RegisteredImplementation)

    if __name__ == '__main__':
        print 'Subclass:', issubclass(RegisteredImplementation, PluginBase)
        print 'Instance:', isinstance(RegisteredImplementation(), PluginBase)
    ```
  * > output:
    ```console
    Subclass: True
    Instance: True
    ```
  * > **b) 另一种方法：通过实现 `PluginBase` API，是派生**.
  * > `abc_subclass.py`
    ```py
    import abc
    from abc_base import PluginBase
    
    class SubclassImplementation(PluginBase):
    
        def load(self, input):
            return input.read()
    
        def save(self, output, data):
            return output.write(data)
    
    if __name__ == '__main__':
        print 'Subclass:', issubclass(SubclassImplementation, PluginBase)
        print 'Instance:', isinstance(SubclassImplementation(), PluginBase)
    ```
  * > output:
    ```console
    Subclass: True
    Instance: True
    ```
  * > **两种方式的不同**：
    + > `SubclassImplementation` 在 `PluginBase.__subclasses__()` 中，而 `RegisteredImplementation` 不在.
    + > `SubclassImplementation` 必须实现 `PluginBase` 中的所有抽象方法，否则会在运行时报错；而 `RegisteredImplement` 不需要.
- > **3.抽象方法的实现**
  * > **在抽象类中抽象方法也可以提供通用的逻辑实现，这样具体类中就可以通过调用 `super()` 重用抽象方法的实现**.
    ```py
    import abc
    from cStringIO import StringIO
    
    class ABCWithConcreteImplementation(object):
        __metaclass__ = abc.ABCMeta
    
        @abc.abstractmethod
        def retrieve_values(self, input):
            print 'base class reading data'
            return input.read()
    
    class ConcreteOverride(ABCWithConcreteImplementation):
    
        def retrieve_values(self, input):
            base_data = super(ConcreteOverride, self).retrieve_values(input)
            print 'subclass sorting data'
            response = sorted(base_data.splitlines())
            return response
    
    input = StringIO("""line one
    line two
    line three
    """)
    
    reader = ConcreteOverride()
    print reader.retrieve_values(input)
    ```
    > output:
    ```console
    base class reading data
    subclass sorting data
    ['line one', 'line three', 'line two']
    ```
- > **4.抽象特性(Abstract Properties)**
  * > 如果你的API规范中还包括属性，那么你可以使用 `@abstractproperty` 来定义.

## 个人实战文章1

//notes：上面文章的例子是在两个 py 文件里的，为了方便，合成了一个文件。只要想表达的意思对上就行。

1. ***a) 第一种方法：通过使用 `abc` 注册***
```py
import abc

class PluginBase(object):
    __metaclass__ = abc.ABCMeta

    @abc.abstractmethod
    def load(self, input):
        """Retrieve data from the input source and return an object."""
        return

    @abc.abstractmethod
    def save(self, output, data):
        """Save the data object to the output."""
        return

class RegisteredImplementation(object):

    def load(self, input):
        return input.read()

    def save(self, output, data):
        return output.write(data)

PluginBase.register(RegisteredImplementation)

if __name__ == '__main__':
    print ('Subclass:', issubclass(RegisteredImplementation, PluginBase))
    print ('Instance:', isinstance(RegisteredImplementation(), PluginBase))

##################################################
$ python main.py
('Subclass:', True)
('Instance:', True)
```

PS：上面这段代码只能 Python2 成功运行，Python3 有问题。
```py
$ python3 main.py
Traceback (most recent call last):
  File "main.py", line 24, in <module>
    PluginBase.register(RegisteredImplementation)
AttributeError: type object 'PluginBase' has no attribute 'register'
```

2. ***b) 第一种方法：通过实现 `PluginBase` API***
```py
import abc

class PluginBase(object):
    __metaclass__ = abc.ABCMeta

    @abc.abstractmethod
    def load(self, input):
        """Retrieve data from the input source and return an object."""
        return

    @abc.abstractmethod
    def save(self, output, data):
        """Save the data object to the output."""
        return

class SubclassImplementation(PluginBase):

    def load(self, input):
        return input.read()

    def save(self, output, data):
        return output.write(data)

if __name__ == '__main__':
    print ('Subclass:', issubclass(SubclassImplementation, PluginBase))
    print ('Instance:', isinstance(SubclassImplementation(), PluginBase))

##################################################
$ python main.py
('Subclass:', True)
('Instance:', True)
```


# 文章1

`【1】` pybind11的最佳实践 - Gemfield的文章 - 知乎 https://zhuanlan.zhihu.com/p/192974017 
- `【2】` 使用pybind11 将C++代码编译为python模块 - Gemfield的文章 - 知乎 https://zhuanlan.zhihu.com/p/52619334

## 个人实战1（用的还是人家原文里的例子）

### pybind11 安装

```sh
# 其他的比如 cmake、boost 之类的机器上已经有了，故省略。【2】里有更详细的安装过程。
python3 -m pip install pytest

mkdir test && cd test/
git clone https://github.com/pybind/pybind11
mkdir _build
cd _build/
cmake ..
make check -j 4
sudo make install
```

### pybind11 基本例子

```cpp
//syszux.cpp
#include <pybind11/pybind11.h>

int syszuxAdd(int i, int j) {
    return i + j;
}

PYBIND11_MODULE(syszux, m) {
    m.doc() = "pybind11 example plugin"; // optional module docstring
    m.def("syszuxAdd", &syszuxAdd, "A function which adds two numbers");
}
```

```sh
# 这句不能少，不然会报错找不到 pybind11 这个 module
## 这句的核心功能是把clone下来的 pybind11 仓库目录的路径添加到 PYTHONPATH 里。
export PYTHONPATH=$PYTHONPATH:/home/<your_user_name>/test/pybind11

# -fPIC 那句后面紧接着的 -I/usr/include/python3.5m 是可以不用的，因为后面那个表达式结果里包含了，
# 但是这里还是执行一下把结果列一下了。
$ python3-config --includes
-I/usr/include/python3.5m -I/usr/include/python3.5m

# 那干脆把下面编译的语句里用到的表达式也执行一下，结果列一下吧。
$ python3 -m pybind11 --includes
-I/usr/include/python3.5m -I/home/biaoxyz/github-repo-vm1/pybind11/include
$
$ python3-config --extension-suffix
.cpython-35m-x86_64-linux-gnu.so
$
```

```sh
# 然后就是下面这个生草的错误，后来发现是因为 —— main和后面那句之间不能有空格。。。
# 因为是把 main 和后面语句 `python3-config --extension-suffix` 的输出连起来作为编译出的动态库的名字的。
$ g++ -O3 -Wall -shared -std=c++11 -fPIC -I/usr/include/python3.5m `python3 -m pybind11 --includes` main.cpp -o main `python3-config --extension-suffix`
g++: error: .cpython-35m-x86_64-linux-gnu.so: No such file or directory
$
# 去掉main和后面语句的空格就可以编过了。
$ g++ -O3 -Wall -shared -std=c++11 -fPIC -I/usr/include/python3.5m `python3 -m pybind11 --includes` main.cpp -o main`python3-config --extension-suffix`
$ ll
total 140
drwxr-xr-x 2 biaoxyz biaoxyz   4096 Aug 31 16:34 .
drwxr-xr-x 9 biaoxyz biaoxyz   4096 Aug 31 15:46 ..
-rw-r--r-- 1 biaoxyz biaoxyz    270 Aug 31 15:48 main.cpp
-rwxr-xr-x 1 biaoxyz biaoxyz 129104 Aug 31 16:34 main.cpython-35m-x86_64-linux-gnu.so

# 然后如果把这个动态库命名成 main 看来是不行的。。。
$ python3
Python 3.5.3 (default, Apr  5 2021, 09:00:41)
[GCC 6.3.0 20170516] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import main
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: dynamic module does not define module export function (PyInit_main)
>>>

# 于是改回原文里的名字 syszux，然后就可以编过并正常在 python 里使用了。  -->  但是，原文的编译语句有一点不好：
## 有了 `python3 -m pybind11 --includes`，那前面的 -I/usr/include/python3.5m 就多余了（其实不止多余，还容易引入环境相关错误），所以可以直接用：
## g++ -O3 -Wall -shared -std=c++11 -fPIC `python3 -m pybind11 --includes` syszux.cpp -o syszux`python3-config --extension-suffix`
$ cp main.cpp syszux.cpp
$ g++ -O3 -Wall -shared -std=c++11 -fPIC -I/usr/include/python3.5m `python3 -m pybind11 --includes` syszux.cpp -o syszux`python3-config --extension-suffix`
$ ll
total 272
drwxr-xr-x 2 biaoxyz biaoxyz   4096 Aug 31 16:39 .
drwxr-xr-x 9 biaoxyz biaoxyz   4096 Aug 31 15:46 ..
-rw-r--r-- 1 biaoxyz biaoxyz    270 Aug 31 15:48 main.cpp
-rwxr-xr-x 1 biaoxyz biaoxyz 129104 Aug 31 16:34 main.cpython-35m-x86_64-linux-gnu.so
-rw-r--r-- 1 biaoxyz biaoxyz    270 Aug 31 16:38 syszux.cpp
-rwxr-xr-x 1 biaoxyz biaoxyz 129104 Aug 31 16:39 syszux.cpython-35m-x86_64-linux-gnu.so
$ 
$ python3
Python 3.5.3 (default, Apr  5 2021, 09:00:41)
[GCC 6.3.0 20170516] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import syszux
>>> syszux.syszuxAdd(3,4)
7
>>>
```

### pybind11 绑定 C++ 类

```cpp
// class_pybind.cpp

#include <pybind11/pybind11.h>
#include <iostream>

class CivilNet {
    public:
        CivilNet(const std::string &name) : name_(name) { }
        void setName(const std::string &name) { name_ = name; }
        const std::string &getName() const { return name_; }
    private:
        std::string name_;
};

PYBIND11_MODULE(syszux, m) {
    pybind11::class_<CivilNet>(m, "CivilNet")
        .def(pybind11::init<const std::string &>())
        .def("setName", &CivilNet::setName)
        .def("getName", &CivilNet::getName);
}
```

```sh
$ g++ -O3 -Wall -shared -std=c++11 -fPIC `python3 -m pybind11 --includes` class_pybind.cpp -o syszux`python3-config --extension-suffix`
$ 
$ python3
Python 3.5.3 (default, Apr  5 2021, 09:00:41)
[GCC 6.3.0 20170516] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import syszux
>>> 
>>> dir(syszux)
['CivilNet', '__doc__', '__file__', '__loader__', '__name__', '__package__', '__spec__']
>>>
>>> x = syszux.CivilNet('gemfield')
>>>
>>> x.getName
<bound method PyCapsule.getName of <syszux.CivilNet object at 0x7f7bab410a40>>
>>>
>>> x.getName()
'gemfield'
>>>
>>> x.setName('civilnet')
>>>
>>> x.getName()
'civilnet'
>>>
```

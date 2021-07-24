
# 个人实战

https://github.com/Freemanzxp/GBDT_Simple_Tutorial
>> 以该项目为例，下载好把需要的库都装好后，需要执行的语句是： `python example.py --model regression`。那么就出现了一个问题，这种程序该怎么用vscode调试？第一反应是改vscode的debug配置文件，加参数，但是目前没走通；第二个办法就是让程序不从vsc里面启动，而是先在vscode外面运行起来，然后attach上去，下面展示的就是这个过程。
>>> PS：pdb之类的调试手段不算，因为那是命令行的，那种没有太多障碍。

## 1.需要下载微软官方的 debugpy，anaconda的话只用简单的`conda install`还不行

debugpy - a debugger for Python https://github.com/microsoft/debugpy

`conda-forge / packages / debugpy 1.3.0` https://anaconda.org/conda-forge/debugpy
```sh
conda install -c conda-forge debugpy -y
```

## 2.debug用的 json 配置文件参考这俩帖子就行，其实就是官方原版

Python debug configurations in Visual Studio Code https://code.visualstudio.com/docs/python/debugging
- > **Command line debugging**
  * > You would then use the following configuration to attach from the VS Code Python extension.
    ```json
    {
      "name": "Python: Attach",
      "type": "python",
      "request": "attach",
      "connect": {
        "host": "localhost",
        "port": 5678
      }
    }
    ```

VSCode调试在命令行输入的Python指令（如：带-m参数的Python指令） https://blog.csdn.net/weixin_39278265/article/details/107705492

**// PS：个人实际写的是这个**。
```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    
    "version": "0.2.0",
    "configurations": [
        // {
        //     "name": "Python: Current File",
        //     "type": "python",
        //     "request": "launch",
        //     "program": "${file}",
        //     "console": "integratedTerminal",
        //     "args": ["example.py", "--model regression"]
        // }

        {
            "name": "Python: Attach",
            "type": "python",
            "request": "attach",
            "connect": {
              "host": "localhost",
              "port": 5678
            }
        }

    ]
}
```

```sh
# 如果没有 --wait-for-client，程序直接就运行到结束了。。。
$ python -m debugpy --listen 5678 example.py --model regression

# 应该用这句。
$ python -m debugpy --listen 5678 --wait-for-client example.py --model regression

# PS：看这个项目的代码，二分类和多分类就是把最后的 regression 换成 binary_cf 或 multi_cf 即可。
```

## 3.一些结果（跟debug无关了，就是记一下方便后续看）

分别在该项目训练完成后和预测完成后打印一下训练数据和测试数据，方便看过程（**在另一个仓库有更详细的数据和图片**）。PS：这个项目熟了以后就不用开图形了，又慢又麻烦。
```py
model.fit(data)
print(data)

model.predict(test_data)
print(test_data)
```

```sh
# 回归的
$ python example.py --model regression
   id  age  weight  label    f_0  res_1     f_1   res_2      f_2    res_3  \
0   1    5      20    1.1  1.475 -0.375  1.4375 -0.3375  1.40375 -0.30375   
1   2    7      30    1.3  1.475 -0.175  1.4575 -0.1575  1.44175 -0.14175   
2   3   21      70    1.7  1.475  0.225  1.4975  0.2025  1.51775  0.18225   
3   4   30      60    1.8  1.475  0.325  1.5075  0.2925  1.53675  0.26325   

        f_3     res_4       f_4     res_5       f_5  
0  1.373375 -0.273375  1.346037 -0.246037  1.321434  
1  1.427575 -0.127575  1.414818 -0.114818  1.403336  
2  1.535975  0.164025  1.552377  0.147622  1.567140  
3  1.563075  0.236925  1.586768  0.213232  1.608091  
   id  age  weight    f_0     f_1      f_2       f_3       f_4      f_5  \
0   5   25      65  1.475  1.4975  1.51775  1.535975  1.552377  1.56714   

   predict_value  
0        1.56714  
$ 
```

```sh
# 二分类的
$ python example.py --model binary_cf
   id  age  weight  label  f_0  res_1  f_1     res_2       f_2     res_3  \
0   1    5      20      0  0.0   -0.5 -0.2 -0.450166 -0.381873 -0.405675   
1   2    7      30      0  0.0   -0.5 -0.2 -0.450166 -0.381873 -0.405675   
2   3   21      70      1  0.0    0.5  0.2  0.450166  0.381873  0.405675   
3   4   30      60      1  0.0    0.5  0.2  0.450166  0.381873  0.405675   

        f_3     res_4       f_4     res_5      f_5  
0 -0.550131 -0.365834 -0.707819 -0.330081 -0.85709  
1 -0.550131 -0.365834 -0.707819 -0.330081 -0.85709  
2  0.550131  0.365834  0.707819  0.330081  0.85709  
3  0.550131  0.365834  0.707819  0.330081  0.85709  
   id  age  weight  f_0  f_1       f_2       f_3       f_4      f_5  \
0   5   25      65  0.0  0.2  0.381873  0.550131  0.707819  0.85709   

   predict_proba  predict_label  
0       0.702052              1  
$ 
```

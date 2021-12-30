
https://www.nowcoder.com/test/question/done?tid=51055197&qid=2225429
- > 执行以下程序，输出结果为（）
  ```py
  a = [['1','2'] for i in range(2)]
  b = [['1','2']]*2
  a[0][1] = '3'
  b[0][0] = '4'
  print(a,b) 
  ```
  ```console
  [['1', '3'], ['1', '2']] [['4', '2'], ['4', '2']]
  ```
  > 记得之前在 LeetCode （双）周赛碰到过一道题，当时发现原来二维的情形下两种初始化方法后面改变值的影响不一样。。。在上面代码的基础上 `print` 一下 `id` 的相等关系就能验证了：
  ```py
  print(id(a[0]) == id(a[1]))  # False
  print(id(b[0]) == id(b[1]))  # True
  ```

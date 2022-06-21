
# 脉脉算法与数据结构

面试题:一亿个数（范围0-10000），进行排序，什么方法效率最高 https://maimai.cn/web/gossip_detail?encode_id=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlZ2lkIjoiYjVjN2UwNWU1MzRhNDE3NDliNGYxYjQ1OGE2MmY3MjciLCJpZCI6MzA2MDg4NDYsInUiOjE5NTg5NTE5NX0.wet4RMxJFBoxtUqvGiCFya-4Qcupuoysk_Y04BVZEEo
- > 补充一下，每个数为0到10000的整数，所以肯定是有重复的
- > 招几个外包，一个一个数。
- > 计数排序 <br> 相似题目1，1亿人如何按照年龄排序？ <br> 相似题目2，5000万高考生如何按照成绩排序？
- > 长度为10000的一维数组，下标++，最后展开就行了

一人一道常见动态规划，我先来，股票问题 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mjc3Mjg2MTksImlhdCI6MTYwMzE3Mzg4MH0.kGexaKbTzspEtC4DvRrPpyETJvOMgzX3_rtr7_ukPa4
- > 最长公共子序列 【LC1143】
  >> 最长公共子序列用正则函数速解，`".*?(.+).*?"`喜提\1
- > 零钱问题凑数的总数，最少钱币数，还有就是从左上到右下最优走法，比较经典的是两个人从两边轮流拿金币最大取法，我感觉状压dp难很多
- > 两个人从两边拿钱，具体是哪个题
  >> leetcode877 【LC877. 石子游戏】
- 背包问题
- > 扔鸡蛋
  >> poj3783 【POJ3783,leetcode887 扔鸡蛋(经典线性DP问题)】
- > 打家劫舍
- > 和最大子矩阵，看有几个人会
- > 俄罗斯套娃 【LC354. 俄罗斯套娃信封问题】
- > 三维接雨水
- > 戳气球 【LC312】
- > 字符匹配
- > 最长上升子序列 【LC300】

话说如果想录制个leetcod e刷题视频，会有人愿意购买嘛，如果视频包含前300道，你愿意花多少钱购买呢，如果视频讲解的很清楚。 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI3NTk0ODgzIiwiaWF0IjoxNjAyMjEzNTUxfQ.P6tBRaTQ1o9kA08eMzmwaDRuweFvaQUOtyJpnIYmVc4

32了，算法数据结构知识都不如大学生，每次狠下心学，学了几天就拉下了，还有救吗，还来得及吗，惭愧 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI3NTIxNjc1IiwiaWF0IjoxNjAyMjE2ODI5fQ.TJkpFR21n_OLzXDtsuoOo5g5Ts-CqVVSdvU3rFnzPLQ
- > 算法4，coursera 或者 b站 搜一下，上下所有作业刷完。

leetcode面试常考题接龙，我先来一个：反转链表。 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI3NDgxODIxIiwiaWF0IjoxNjAxMjY0MjUwfQ.nNlMwAh-BNB1PV3ua07cIN3C-38lccY9ShcNVD7n47s

头条笔试回忆 总体来说很简单，都是常见的题目，没有考传说中的红黑树 面试前刷下leetcode基本满分 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjczMTE1NDIsImlhdCI6MTU5OTc5Nzk2MH0.3D97s9-TopDhCY9XHqnSzlmvE6f7yPN3HV_hy6JlMvU
- > ![](https://i9.taou.com/maimai/p/25449/5990_112_7LJTek4MSdCjzL-t480)

面试腾讯被问了红黑树和tarjan算法，果然还是我太弱。感觉找工作leetcode都已经不够了，得把算法导论拿出来。 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjY4NDIxNjMsImlhdCI6MTU5NjA5MDkxMn0.OzrBEUmVsWxa3KhREQR8r3oMnF2BMt4-6ITSv5enKDM
- > 这个有点难，不背很容易写错。如果只要求强联通分量的话，用kosaruju算法很容易写对，也是On复杂度，应该也可以过

算法菜鸡，问个算法题，知道的老哥回答一下：一个单向链表，要求相邻节点的值如果重复，则进行消除。要求空间复杂度O1，时间复杂度不高于N^2。输入abbcb 返回acb。输入abba 返回null https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjY4NDI1MzAsImlhdCI6MTU5NjA5MTE0OX0.ahzQGndqX3Pf93swgRjOTfZ-Yg_YR2oVRiw5D6tnMDc
- > 一边遍历一边反转链表当一个栈来用 最后再整体反转

今天做了BFS相关的6道medium，实在是有点忙。。明天希望有时间能补上，题目是102/103/279/429/542/863…如果有一起练习的朋友，也一起坚持吧~6/2/2020 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjYzMzY1NDgsImlhdCI6MTU5MTE1ODUxMn0.IwQec7C94WemC_s5AwoA-b-ZrOnbTyBAQ65T8fhHecI

leetcode第85题最大矩形，对着题干瞪眼一晚上，心态要崩 https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU1NzMyNjQsImlhdCI6MTU4NTIxMTQ4Nn0.9fpBl4A5y6yG56Cdbi6-L4X3alNGk5gBl9FD9HgrGwY
- > 老哥先做84题，然后85就明白了
- > 有一道神题，Count of Range Sums，把离散化，uniq，二分查找，树状数组，前缀和都搞进去了，这道题我写了一个月了
- > 那是你没遇到过数论背景下的树形dp
- > 这题我面Amazon被面到了，84 85一起面的

最近面试的算法题，我想了很久还是没想到，求大佬指点。问题：“假设有一个数字类型的数组，量级达到数亿亿别。如何找到最大的第十个数字？” 答：“新建10个元素的数组，循环取出大数组的数据和小数组对比，大的替换到小数组，小的则抛弃” 再问：“如果要找最中间的那个数字，应该怎么找？” https://maimai.cn/web/gossip_detail?encode_id=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU1NDMwMjYsImlhdCI6MTU4NDkzNjAyMX0.eq-ByP2zeWe62KfZbyWpqWl2kLbWaQzek2qk1EtBw58
- > 二进制分治，按最高位是0或者1写入到两个文件，并记录两个文件写了多少个元素，然后就可以知道中间那个数在哪个文件里。接下来对次高位进行同样的操作。。。最后剩下的就是所求。其实就是转换成了求第k个数。
- > 建两个堆，一个大顶堆一个小顶堆。一个个读取数据放入两个堆中，注意需要保持两个堆的数据个数绝对值在1以内。这样两个堆的堆顶即为中间，把这些数据都读完，要找的数据就是两个堆的堆顶数据了。


# general

字符串搜索算法 https://zh.wikipedia.org/wiki/%E5%AD%97%E4%B8%B2%E6%90%9C%E5%B0%8B%E6%BC%94%E7%AE%97%E6%B3%95 || String-searching algorithm https://en.wikipedia.org/wiki/String-searching_algorithm

常见模式匹配（字符串匹配）算法 https://www.jianshu.com/p/8690bd38ea62

## 总结

|算法名称|预处理时间|时间复杂度|空间复杂度|
|--|--|--|--|
| 暴力搜索(Brute Force search) ||||
| KMP (Knuth–Morris–Pratt) ||||
| Boyer-Moore (BM) ||||
|Rabin-Karp||||
|Aho–Corasick||||
|||||
|||||
|||||

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# KMP

克努斯-莫里斯-普拉特算法 https://zh.wikipedia.org/wiki/%E5%85%8B%E5%8A%AA%E6%96%AF-%E8%8E%AB%E9%87%8C%E6%96%AF-%E6%99%AE%E6%8B%89%E7%89%B9%E7%AE%97%E6%B3%95 || Knuth–Morris–Pratt algorithm https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm

字符串匹配的KMP算法 http://www.ruanyifeng.com/blog/2013/05/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm.html
- > 一个基本事实是，当空格与D不匹配时，你其实知道前面六个字符是"ABCDAB"。KMP算法的想法是，设法利用这个已知信息，不要把"搜索位置"移回已经比较过的位置，继续把它向后移，这样就提高了效率。
- > "部分匹配"的实质是，有时候，字符串头部和尾部会有重复。比如，"ABCDAB"之中有两个"AB"，那么它的"部分匹配值"就是2（"AB"的长度）。搜索词移动的时候，第一个"AB"向后移动4位（字符串长度-部分匹配值），就可以来到第二个"AB"的位置。
- 回复：
  * > Robert Sedgewick https://class.coursera.org/algs4partII-001/lecture/40 用自动机解释kmp，感觉更妙，就是实现的时候空间复杂度高点。个人感觉Sedgewick这个老头讲东西确实牛逼，很多看书很难理解的算法，他一讲就明白了，有兴趣的可以去part1看看他讲的红黑树，特别牛逼。
    + > 现在网址是 https://www.coursera.org/learn/algorithms-part2/lecture/n3ZpG/introduction-to-substring-search
  * > `有时候，字符串内部会有重复。比如，"ABCDAB"之中有两个"AB"，那么它的"部分匹配值"就是2（"AB"的长度）` <br> 这个应该说是，字符串头部和尾部有重复？如果是ABCABD这样即使有两个AB也不能部分移动吧
    >> 谢谢指出，我确实没想到这一点，已经更正了。
  * > 那就是说需要搜索的词如果内部完全没有重复，那这个算法就退化成了遍历？
    + > 应该不是的吧，最坏情况下也是o(m+n)的，而遍历是o(m\*n)
    + > 就算是内部没有完全重复，虽然算法退化成了遍历，但是时间复杂度依旧是O(M+N);因为一旦pattern表形成之后，就不需要每次进行遍历制作pattern表。
  * > 我一直以为KMP是string search最优的算法（时间复杂度是O(n+k)）,直到我知道了Boyer–Moore算法……才发现原来还有更加巧妙的方法……
    + > 搜索了一下，Boyer–Moore算法每次从要找的Pattern末尾开始比较，并且一般用两条规则来控制移位（KMP只有一条移位规则），比KMP还好。
  * > kmp算法的难点和关键在于next数组的构建，楼主却完全没有提到，所以价值不大。推荐这个链接：http://wiki.jikexueyuan.com/project/kmp-algorithm/define.html ，分析得深入细致，看了很多链接，这个最好。

七分钟理解什么是 KMP 算法 - 程序员吴师兄的文章 - 知乎 https://zhuanlan.zhihu.com/p/76348091

KMP（上篇） https://www.geekxh.com/1.3.%E5%AD%97%E7%AC%A6%E4%B8%B2%E7%B3%BB%E5%88%97/306.html || https://github.com/geekxh/hello-algorithm/blob/616111986ba9e41618dd2aadd3323033026576ce/website/1.3.%E5%AD%97%E7%AC%A6%E4%B8%B2%E7%B3%BB%E5%88%97/306.md

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Boyer-Moore

Boyer-Moore字符串搜索算法 https://zh.wikipedia.org/wiki/Boyer-Moore%E5%AD%97%E7%AC%A6%E4%B8%B2%E6%90%9C%E7%B4%A2%E7%AE%97%E6%B3%95 || Boyer–Moore string-search algorithm https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_string-search_algorithm

字符串匹配的Boyer-Moore算法 https://www.ruanyifeng.com/blog/2013/05/boyer-moore_string_search_algorithm.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Rabin–Karp

Rabin–Karp算法 https://zh.wikipedia.org/wiki/Rabin%E2%80%93Karp%E7%AE%97%E6%B3%95 || Rabin–Karp algorithm https://en.wikipedia.org/wiki/Rabin%E2%80%93Karp_algorithm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Aho–Corasick

AC自动机算法 https://zh.wikipedia.org/wiki/AC%E8%87%AA%E5%8A%A8%E6%9C%BA%E7%AE%97%E6%B3%95 || Aho–Corasick algorithm https://en.wikipedia.org/wiki/Aho%E2%80%93Corasick_algorithm

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Sunday algorithm

Why choose “BM algorithm” rather than “Sunday algorithm” in text editor's Find function? https://stackoverflow.com/questions/45473334/why-choose-bm-algorithm-rather-than-sunday-algorithm-in-text-editors-find-f

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 回文串 

最长回文子串 https://zh.wikipedia.org/wiki/%E6%9C%80%E9%95%BF%E5%9B%9E%E6%96%87%E5%AD%90%E4%B8%B2 || Longest palindromic substring https://en.wikipedia.org/wiki/Longest_palindromic_substring

## Manacher algorithm

`336. 回文对` https://leetcode-cn.com/problems/palindrome-pairs/solution/hui-wen-dui-by-leetcode-solution/
- 方法二：字典树 + manacher

`647. 回文子串` https://leetcode-cn.com/problems/palindromic-substrings/solution/hui-wen-zi-chuan-by-leetcode-solution/
- 方法二：Manacher 算法
>> //notes：大部分笔记都记到了该题的README部分：【[:star:][`*`]】 https://github.com/BIAOXYZ/variousCodes/blob/master/_CodeTopics/LeetCode/000647/README.md

老司机开车，教会女朋友什么是「马拉车算法」 https://www.cxyxiaowu.com/2665.html

一文让你彻底明白马拉车算法 - windliang的文章 - 知乎 https://zhuanlan.zhihu.com/p/70532099

有什么浅显易懂的Manacher Algorithm讲解？ - 知乎 https://www.zhihu.com/question/37289584

Manacher’s Algorithm – Linear Time Longest Palindromic Substring – Part 1 https://www.geeksforgeeks.org/manachers-algorithm-linear-time-longest-palindromic-substring-part-1/

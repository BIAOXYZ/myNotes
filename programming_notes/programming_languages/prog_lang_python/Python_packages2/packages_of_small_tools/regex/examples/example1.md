
# 1. 一样的规则，用官方自带的 re 库会卡死（主要原因是运行时间是指数递增的），但是 regex 库可以解决

**背景**：一个看起来并不复杂的字符串和规则的匹配，直接卡死了。后来就把那个串从开头的第一个字符开始，逐步增加，最终发现运行时间成指数递增。然后也试过了改正则匹配的规则之类的方法，但是基本没啥效果。最终，用 regex 库替换 re 库解决了问题。

```py
import re
# import regex as re
import datetime

agg_funcs = ['min', 'max', 'count', 'sum', 'avg', 'variance', 'stddev_pop']

# 转义函数名称以安全地在正则表达式模式中使用它们
agg_func_patterns = [re.escape(func) for func in agg_funcs]
print(f"==================== 1.agg_func_patterns: {agg_func_patterns}")

agg_func_regex = '|'.join(agg_func_patterns)
print(f"==================== 2.agg_func_regex: {agg_func_regex}")

# 匹配嵌套的聚合函数的 pattern，可以匹配聚合函数名称之后四重括号，更具体地说：
# sum(x)、sum((x))、sum(((x)))、sum((((x)))) 都能匹配到，但是 sum(((((x))))) 不能匹配
nested_agg_pattern = rf'\b({agg_func_regex})\s*\((?:[^()]*|\((?:[^()]*|\((?:[^()]*|\([^()]*\))*\))*\))*\)'

# 这里有很多匹配模式，但是不改用 regex 库，还是用 Python 自带的 re 库的话，即使是最简单的（最后那行那个模式）也慢到无法接受。
# nested_agg_pattern = rf'\b({agg_func_regex})\s*\((?:[^()]*?|\((?:[^()]*?|\((?:[^()]*?|\([^()]*?\))*?\))*?\))*?\)'
# nested_agg_pattern = rf'\b({agg_func_regex})\s*\((?:[^()]*+|(?R))*+\)'
# nested_agg_pattern = rf'\b({agg_func_regex})\s*\((?:[^()]*|(?R))*\)'
# nested_agg_pattern = rf'\b({agg_func_regex})\s*\((?:[^()]*(?R)?)*\)'
# nested_agg_pattern = rf'\b({agg_func_regex})\s*\((?:[^()]*|\([^()]*\))*\)'
# nested_agg_pattern = rf'\b({agg_func_regex})\s*\((?:[^()]*|(?R))*\)'
# nested_agg_pattern = rf'\b({agg_func_regex})\s*\([^()]*\)'

print(f"==================== 3.nested_agg_pattern: {nested_agg_pattern}")

# 编译正则表达式，用于查找嵌套的聚合函数
nested_agg_re = re.compile(nested_agg_pattern, re.IGNORECASE)
print(f"==================== 4.nested_agg_re: {nested_agg_re}")

# 测试用例，这个字符串也不算特别长
expr = "COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc = 1 AND if(DEFAULT.kmsv2_try_decrypt(req_id, 'csp.data.engine')_shopping = DEFAULT.kmsv2_try_decrypt(req_id, 'csp.data.engine'),1,0) = 1,1,0)) = 1 AND same_session = 1 THEN message_id_shopping ELSE NULL END) + SUM(some_column)"
print(f"==================== 5.expr: {expr}")


# # remove all nested aggregation function matches from the string
# cleaned_string = nested_agg_re.sub("", expr)

# # print the cleaned string for debugging
# print("==================== 6.cleaned_string:", cleaned_string)


# 尝试对测试字符串从开头的第一个字符开始，每次增加一个，并计算每个分片替换的耗时，
# 最终会发现如果用 re 库的话是指数增长；但是如果用 regex 库就秒出结果。
for i in range(1, len(expr)):
    start = datetime.datetime.now()
    cleaned_string = nested_agg_re.sub("", expr[:i])
    end = datetime.datetime.now()
    print(f"==================== 6.cleaned_string: {cleaned_string}")
    print(i)
    print(expr[:i])
    print(end - start)

```
```console
...
...
...
==================== 6.cleaned_string: COUNT(DISTINCT CASE  WHEN MAX(if(rn_a
37
COUNT(DISTINCT CASE  WHEN MAX(if(rn_a
0:00:12.585764
==================== 6.cleaned_string: COUNT(DISTINCT CASE  WHEN MAX(if(rn_as
38
COUNT(DISTINCT CASE  WHEN MAX(if(rn_as
0:00:23.028439
==================== 6.cleaned_string: COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc
39
COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc
0:00:44.537567
==================== 6.cleaned_string: COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc
40
COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc
0:01:26.233976
==================== 6.cleaned_string: COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc =
41
COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc =
0:02:50.060013
==================== 6.cleaned_string: COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc =
42
COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc =
0:05:38.254069
==================== 6.cleaned_string: COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc = 1
43
COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc = 1
0:11:09.525451
==================== 6.cleaned_string: COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc = 1
44
COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc = 1
0:22:17.612424
==================== 6.cleaned_string: COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc = 1 A
45
COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc = 1 A
0:44:34.195610
==================== 6.cleaned_string: COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc = 1 AN
46
COUNT(DISTINCT CASE  WHEN MAX(if(rn_asc = 1 AN
1:28:54.613153
```

**参考链接**：
- 一条正则表达式跑一天，这Bug我服了 https://mp.weixin.qq.com/s/HuPsGHAAY10w28Y8gCl7Rg
  * > 那是什么原因呢？再来细品生成的正则，全篇都是使用的`(.*)`进行统配，我们完全忽略了一个很严重的问题：**正则表达式的回溯陷阱**
  * > 通过网站： https://regex101.com/ 验证了一下想法，果然不出所料，整个匹配过程高达83万个步骤，这能快到哪里去呢；
  * > 既然排查到原因了，下面就来详细说一下什么是正则的回溯，以及如何解决这个问题；

**TODO**：需要结合 https://regex101.com/ 之类的网站再细研究下为什么会这样，以及如何优化。
```console
规则：
\b(min|max|count|sum|avg|variance|stddev_pop)\s*\((?:[^()]*|\((?:[^()]*|\((?:[^()]*|\([^()]*\))*\))*\))*\)

测试用例：
max(DISTINCT CASE  WHEN MAX(if(rn_asc = 1 AND if(DEFAULT.kmsv2_try_decrypt(req_id, 'csp.data.engine')_shopping = DEFAULT.kmsv2_try_decrypt(req_id, 'csp.data.engine'),1,0) = 1,1,0)) = 1 AND same_session = 1 THEN message_id_shopping ELSE NULL END) + SUM(some_column)
```

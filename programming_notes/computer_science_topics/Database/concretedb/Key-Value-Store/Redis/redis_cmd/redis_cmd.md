
# 个人总结

| 操作类型 | 命令 | 描述 | 示例 |
| --- | --- | --- | --- |
| 键操作 | `keys *` | 列出所有键 | `KEYS *` |
| 键操作 | `get <key>` | 获取指定键的值 | `GET myKey` |
| 键操作 | `set <key> <value>` | 设置键值对 | `SET myKey myValue` |
| 键操作 | `del <key>` | 删除指定键 | `DEL myKey` |
| 键操作 | `expire <key> <seconds>` | 设置键的过期时间 | `EXPIRE myKey 60` |
| 字符串操作 | `append <key> <value>` | 追加值到键 | `APPEND myKey additionalValue` |
| 字符串操作 | `incr <key>` | 将键的值递增 1 | `INCR myKey` |
| 字符串操作 | `decr <key>` | 将键的值递减 1 | `DECR myKey` |
| 字符串操作 | `strlen <key>` | 获取键值的长度 | `STRLEN myKey` |
| 列表操作 | `lpush <key> <value>` | 从左侧推入一个值 | `LPUSH myList myValue` |
| 列表操作 | `rpush <key> <value>` | 从右侧推入一个值 | `RPUSH myList myValue` |
| 列表操作 | `lrange <key> <start> <stop>` | 获取列表指定范围内的元素 | `LRANGE myList 0 -1` |
| 列表操作 | `lpop <key>` | 从左侧弹出一个值 | `LPOP myList` |
| 列表操作 | `rpop <key>` | 从右侧弹出一个值 | `RPOP myList` |
| 集合操作 | `sadd <key> <member>` | 向集合中添加成员 | `SADD mySet member1` |
| 集合操作 | `srem <key> <member>` | 从集合中删除成员 | `SREM mySet member1` |
| 集合操作 | `smembers <key>` | 获取集合中的所有成员 | `SMEMBERS mySet` |
| 集合操作 | `scard <key>` | 获取集合中成员的数量 | `SCARD mySet` |
| 哈希操作 | `hset <key> <field> <value>` | 设置哈希表中指定字段的值 | `HSET myHash field1 value1` |
| 哈希操作 | `hget <key> <field>` | 获取哈希表中指定字段的值 | `HGET myHash field1` |
| 哈希操作 | `hgetall <key>` | 获取哈希表中所有的字段和值 | `HGETALL myHash` |
| 哈希操作 | `hdel <key> <field>` | 删除哈希表中的指定字段 | `HDEL myHash field1` |


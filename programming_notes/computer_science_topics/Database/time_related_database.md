
Temporal database https://en.wikipedia.org/wiki/Temporal_database

```
Person(John Doe, Smallville, 3-Apr-1975, ∞).
                    |
                    |
Person(John Doe, Smallville, 3-Apr-1975, 26-Aug-1994).
Person(John Doe, Bigtown, 26-Aug-1994, ∞).
                    |
                    |
Person(John Doe, Smallville, 3-Apr-1975, 26-Aug-1994).
Person(John Doe, Bigtown, 26-Aug-1994, 1-Apr-2001).

----------------------------------------------------------------------------------------------------

Person(John Doe, Smallville, 3-Apr-1975,  ∞,           4-Apr-1975,  ∞∞  -->  27-Dec-1994).
Person(John Doe, Smallville, 3-Apr-1975,  26-Aug-1994, 27-Dec-1994, ∞          ).
Person(John Doe, Bigtown,    26-Aug-1994, ∞,           27-Dec-1994, ∞∞  -->  1-Apr-2001 ).
Person(John Doe, Bigtown,    26-Aug-1994, 1-Apr-2001,  1-Apr-2001, ∞ ).
```



```
Final State：
----------------------------------------------------------------------------------------------------
Person(John Doe, Smallville, 3-Apr-1975,  ∞,           4-Apr-1975,  27-Dec-1994).
Person(John Doe, Smallville, 3-Apr-1975,  26-Aug-1994, 27-Dec-1994, ∞          ).
Person(John Doe, Bigtown,    26-Aug-1994, ∞,           27-Dec-1994, 2-Feb-2001 ).
Person(John Doe, Bigtown,    26-Aug-1994, 1-Jun-1995,  2-Feb-2001,  ∞          ).
Person(John Doe, Beachy,     1-Jun-1995,  3-Sep-2000,  2-Feb-2001,  ∞          ).
Person(John Doe, Bigtown,    3-Sep-2000,  ∞,           2-Feb-2001,  1-Apr-2001 ).
Person(John Doe, Bigtown,    3-Sep-2000,  1-Apr-2001,  1-Apr-2001,  ∞          ).


Step 1.
----------------------------------------------------------------------------------------------------
Person(John Doe, Smallville, 3-Apr-1975,  ∞,           4-Apr-1975,  ∞∞).

Step 2.
----------------------------------------------------------------------------------------------------
Person(John Doe, Smallville, 3-Apr-1975,  ∞,           4-Apr-1975,  27-Dec-1994).
Person(John Doe, Smallville, 3-Apr-1975,  26-Aug-1994, 27-Dec-1994, ∞          ).
Person(John Doe, Bigtown,    26-Aug-1994, ∞,           27-Dec-1994, ∞∞ ).


Step 3.1.
----------------------------------------------------------------------------------------------------
Person(John Doe, Smallville, 3-Apr-1975,  ∞,           4-Apr-1975,  27-Dec-1994).
Person(John Doe, Smallville, 3-Apr-1975,  26-Aug-1994, 27-Dec-1994, ∞          ).
Person(John Doe, Bigtown,    26-Aug-1994, ∞,           27-Dec-1994, 2-Feb-2001 ).
Person(John Doe, Bigtown,    26-Aug-1994, 1-Jun-1995,  2-Feb-2001,  ∞          ).
Person(John Doe, Beachy,     1-Jun-1995,  3-Sep-2000,  2-Feb-2001,  ∞∞∞          ).
Step 3.2.
----------------------------------------------------------------------------------------------------
Person(John Doe, Smallville, 3-Apr-1975,  ∞,           4-Apr-1975,  27-Dec-1994).
Person(John Doe, Smallville, 3-Apr-1975,  26-Aug-1994, 27-Dec-1994, ∞          ).
Person(John Doe, Bigtown,    26-Aug-1994, ∞,           27-Dec-1994, 2-Feb-2001 ).
Person(John Doe, Bigtown,    26-Aug-1994, 1-Jun-1995,  2-Feb-2001,  ∞          ).
Person(John Doe, Beachy,     1-Jun-1995,  3-Sep-2000,  2-Feb-2001,  ∞∞∞          ).
Person(John Doe, Bigtown,    3-Sep-2000,  ∞,           2-Feb-2001,  ∞∞ ).

Step 4.
----------------------------------------------------------------------------------------------------
Person(John Doe, Smallville, 3-Apr-1975,  ∞,           4-Apr-1975,  27-Dec-1994).
Person(John Doe, Smallville, 3-Apr-1975,  26-Aug-1994, 27-Dec-1994, ∞          ).
Person(John Doe, Bigtown,    26-Aug-1994, ∞,           27-Dec-1994, 2-Feb-2001 ).
Person(John Doe, Bigtown,    26-Aug-1994, 1-Jun-1995,  2-Feb-2001,  ∞          ).
Person(John Doe, Beachy,     1-Jun-1995,  3-Sep-2000,  2-Feb-2001,  ∞∞∞          ).
Person(John Doe, Bigtown,    3-Sep-2000,  ∞,           2-Feb-2001,  1-Apr-2001 ).
Person(John Doe, Bigtown,    3-Sep-2000,  1-Apr-2001,  1-Apr-2001,  ∞          ).
```

Time series database https://en.wikipedia.org/wiki/Time_series_database

# InfluxDB

重磅 | DBEngine排名第一时序数据库——阿里云InfluxDB正式商业化 https://mp.weixin.qq.com/s/kVYCEMObm1wF_YUtTVHw_Q
- > 时序数据和企业业务密切相关，不可或缺。任何一家企业都需要一套高效的运维系统保证实时发现应用和业务问题，通过监控，故障告警的手段，进行故障定位，保证在线业务的稳定，减少不可用时常。业务运营人员依赖运营系统，保证有充足的数据进行业务分析判断，便于更准确的做出业务决策。物联网企业和工业企业都需要能够实时掌握设备的运行状态，对生产过程进行监控，实时判故障预警，故障定位，故障回溯以及业务。以上业务场景都需要时序数据作为“数据证据”来表示指标“变化”过程，进而达到告警，诊断，修复和预测的业务目的。
- > 时序数据很简单，构成具有三个要素，主体，时间戳，和指标数据。比如：xxx公司（主体）2019年8月26日上午10时，11时， 12时（时间戳）的股价分别是：160 USD，165 USD，180 USD（指标值）。概括来说，区别于关系数据库关心的是“最终结果”。时序数据表示的是资产或者过程是如何随着时间变化的，体现的是“变化”的过程价值。

# 其他

## 涛思数据

TDengine https://github.com/taosdata/TDengine

TDengine | Time-Series Database for Industrial IoT https://tdengine.com/

## GreptimeDB

GreptimeDB https://github.com/GreptimeTeam/greptimedb

Greptime https://greptime.com/

## CnosDB

CnosDB Cloud https://github.com/cnosdb/cnosdb

CnosDB https://www.cnosdb.com/

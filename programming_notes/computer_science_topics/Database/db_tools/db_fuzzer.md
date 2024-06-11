
# Fuzzers

## more matured

### AFL

American Fuzzy Lop (software) https://en.wikipedia.org/wiki/American_Fuzzy_Lop_(software)

american fuzzy lop - a security-oriented fuzzer https://github.com/google/AFL
- > This repository has been archived by the owner on Mar 22, 2024. It is now read-only. You can check out its forks.

### LibFuzzer

libFuzzer – a library for coverage-guided fuzz testing. https://www.llvm.org/docs/LibFuzzer.html

### SQLsmith

SQLsmith https://github.com/anse1/sqlsmith

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## not matured

SQLFuzz https://github.com/tekaireb/SQLFuzz

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# DB模糊测试实践

Announcing DuckDB 1.0.0 https://duckdb.org/2024/06/03/announcing-duckdb-100.html
- > We’ve observed the frankly staggering growth in the amount and breadth of use of DuckDB in the wild, and have not seen an increase in serious issues being reported. Meanwhile, there are thousands of test cases with millions of test queries being run every night. We run loads of microbenchmarks and standardized benchmark suites to spot performance regressions. DuckDB is constantly being tortured by various `fuzzers` that construct all manners of wild SQL queries to make sure we don’t miss weird corner cases. All told, this has built the necessary confidence in us to release a 1.0.0.

Fuzzing SQLite With AFL https://www.sqlite.org/afl/doc/trunk/README.md

Fuzzing ClickHouse https://clickhouse.com/blog/fuzzing-click-house

Fuzz Testing YottaDB https://yottadb.com/fuzz-testing-yottadb/

fuzzing https://github.com/chaos-mesh/database-testing/blob/master/fuzzing.md
- > Now we start using fuzzing to help us find more bugs. And fuzzing has proven to be a very effective way to find bugs.
- > In PingCAP, we using fuzzing for many years. At first, we start using [go-randgen](https://github.com/pingcap/go-randgen) to generate random SQL to do differential testing.
- > And we also rewrite sqlsmith, the project is in tipocket and the name is [go-sqlsmith](https://github.com/pingcap/tipocket/tree/master/pkg/go-sqlsmith). Both go-randgen and go-sqlsmith is useful to do differential testing.
- > Since TiDB is not 100% compatibility with MySQL. The correctness is still hard to cover, then we use a go version of [sqlancer](https://github.com/sqlancer/sqlancer). The original one has proven to be a very effective way to find correctness bugs in https://www.manuelrigger.at/dbms-bugs/
- > In the TiDB cluster, we have hundreds of configs, we also need to test if each config is work well on common tests and on fuzz tests. So we create a project [matrix](https://github.com/chaos-mesh/matrix) to fuzz configs

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# 其他

DynSQL: Stateful Fuzzing for Database Management Systems with Complex and Valid SQL Query Generation https://www.usenix.org/conference/usenixsecurity23/presentation/jiang-zu-ming

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

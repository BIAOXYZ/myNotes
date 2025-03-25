
# `PrestoDB` 官方

Presto https://github.com/prestodb/presto

Presto https://prestodb.io/

# `PrestoSQL` 官方

~~PrestoSQL https://github.com/prestosql/presto~~  -->  trino https://github.com/trinodb/trino

trino https://trino.io/

# 文章

What’s the difference between PrestoDB and PrestoSQL? https://www.starburst.io/blog/prestodb-vs-prestosql/
- > **`PrestoDB` vs `PrestoSQL` vs `Trino`**
  * > PrestoDB is the former name of the original version of Presto. It was developed by Eric Hwang, Dain Sundstrom, David Phillips, and Martin Traverso at Facebook. In 2018, they left Facebook and founded the Presto Software Foundation to ensure that the project would remain collaborative and independent. They named their new fork PrestoSQL, which was later renamed to Trino at the end of 2020. PrestoDB was renamed to Presto shortly after, ***<ins>so `PrestoDB` is now simply called `Presto`, and `PrestoSQL` is now `Trino`</ins>***.
  * > Presto and Trino share similar features and the same core code. However, ***ongoing development on Presto has been driven by `Facebook`, while development on Trino has been driven by companies like `Starburst` and `AWS` trying to serve a wide audience***. This has made Trino more generally useful, and as explained below, it has benefitted from higher velocity development.
- > **Is `Trino` better than `Presto`?**
  * > Since the fork in `2018`, ***development on `Trino` has gone at roughly three times the velocity of development on `Presto`***. It boasts additional connectors that aren’t in Presto, better performance across the vast majority of connectors, expanded SQL support, and is much better at handling batch ETL/ELT workloads.
  * > **Is Starburst the same as Presto?**
    + > `Starburst Enterprise` and `Starburst Galaxy` both run `Trino`, the fork of Presto that is developed by the co-founders of the project. If you are already familiar with Presto, you could seamlessly use Starburst or Trino in its place without any issues. ***<ins>We believe `Trino` is the better choice between the two similar engines</ins>***, which is why we use Trino.

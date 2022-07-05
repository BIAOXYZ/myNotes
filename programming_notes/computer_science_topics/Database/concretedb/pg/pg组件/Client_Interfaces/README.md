
# 官方

H.1. Client Interfaces https://www.postgresql.org/docs/14/external-interfaces.html
- > There are only two client interfaces included in the base PostgreSQL distribution:
  * > `libpq` is included because it is the primary C language interface, and because many other client interfaces are built on top of it.
  * > `ECPG` is included because it depends on the server-side SQL grammar, and is therefore sensitive to changes in PostgreSQL itself.
- > All other language interfaces are external projects and are distributed separately. `Table H.1` includes a list of some of these projects. Note that some of these packages might not be released under the same license as PostgreSQL.

  `Table H.1. Externally Maintained Client Interfaces`

  | Name | Language | Comments | Website |
  |--|--|--|--|
  | libpqxx | C++ | C++ | interface | https://pqxx.org/ |


```
$ tree -d -L 1 ~/go
/root/go
├── bin
├── pkg
└── src

3 directories
$ tree -d -L 2 ~/go
/root/go
├── bin
├── pkg
│   └── dep
└── src
    └── github.com

5 directories
$ tree -dL 2 ~/go
/root/go
├── bin
├── pkg
│   └── dep
└── src
    └── github.com

5 directories
```

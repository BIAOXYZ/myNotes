

# 本机使用go module时出现rpc问题，通过设置GOPROXY环境变量解决
**// 有的机器GOPROXY环境变量为空照样不会出现如下的rpc问题，但是有的就会出，具体原因暂时不管了**。

```
# 注：/root/go 为GOPATH所在路径；/root/go2 是专门为了在 GO111MODULE=on 的情况下编译go程序新建的，
# 也是为了后面全面使用go module开个头吧，毕竟趋势是难以改变的。

[root@temptest ~]# cd go2
[root@temptest go2]# pwd
/root/go2
[root@temptest go2]# echo $GOPATH
/root/go

[root@temptest go2]# cd sample-controller/
[root@temptest sample-controller]#
[root@temptest sample-controller]# go list -m
go: finding modernc.org/golex v1.0.0
go: finding modernc.org/strutil v1.0.0
go: finding modernc.org/xc v1.0.0
go: finding modernc.org/cc v1.0.0
go: finding modernc.org/mathutil v1.0.0
go: modernc.org/xc@v1.0.0: git fetch -f https://gitlab.com/cznic/xc refs/heads/*:refs/heads/* refs/tags/*:refs/tags/* in /root/go/pkg/mod/cache/vcs/29fc2f846f24ce3630fdd4abfc664927c4ad22f98a3589050facafa0991faada: exit status 128:
        error: RPC failed; result=22, HTTP code = 404
        fatal: The remote end hung up unexpectedly
go: modernc.org/golex@v1.0.0: git fetch -f https://gitlab.com/cznic/golex refs/heads/*:refs/heads/* refs/tags/*:refs/tags/* in /root/go/pkg/mod/cache/vcs/9aae2d4c6ee72eb1c6b65f7a51a0482327c927783dea53d4058803094c9d8039: exit status 128:
        error: RPC failed; result=22, HTTP code = 404
        fatal: The remote end hung up unexpectedly
go: modernc.org/strutil@v1.0.0: git fetch -f https://gitlab.com/cznic/strutil refs/heads/*:refs/heads/* refs/tags/*:refs/tags/* in /root/go/pkg/mod/cache/vcs/f48599000415ab70c2f95dc7528c585820ed37ee15d27040a550487e83a41748: exit status 128:
        error: RPC failed; result=22, HTTP code = 404
        fatal: The remote end hung up unexpectedly
go: modernc.org/cc@v1.0.0: git fetch -f https://gitlab.com/cznic/cc refs/heads/*:refs/heads/* refs/tags/*:refs/tags/* in /root/go/pkg/mod/cache/vcs/3dac616a9d80602010c4792ef9c0e9d9812a1be8e70453e437e9792978075db6: exit status 128:
        error: RPC failed; result=22, HTTP code = 404
        fatal: The remote end hung up unexpectedly
go: modernc.org/mathutil@v1.0.0: git fetch -f https://gitlab.com/cznic/mathutil refs/heads/*:refs/heads/* refs/tags/*:refs/tags/* in /root/go/pkg/mod/cache/vcs/fb72eb2422fda47ac75ca695d44b06b82f3df3c5308e271486fca5e320879130: exit status 128:
        error: RPC failed; result=22, HTTP code = 404
        fatal: The remote end hung up unexpectedly
go: error loading module requirements
[root@temptest sample-controller]#
[root@temptest sample-controller]#
[root@temptest sample-controller]#
[root@temptest sample-controller]# go build -o sample-controller .
go: finding modernc.org/golex v1.0.0
go: finding modernc.org/mathutil v1.0.0
go: finding modernc.org/xc v1.0.0
go: finding modernc.org/cc v1.0.0
go: finding modernc.org/strutil v1.0.0
go: modernc.org/mathutil@v1.0.0: git fetch -f https://gitlab.com/cznic/mathutil refs/heads/*:refs/heads/* refs/tags/*:refs/tags/* in /root/go/pkg/mod/cache/vcs/fb72eb2422fda47ac75ca695d44b06b82f3df3c5308e271486fca5e320879130: exit status 128:
        error: RPC failed; result=22, HTTP code = 404
        fatal: The remote end hung up unexpectedly
go: modernc.org/xc@v1.0.0: git fetch -f https://gitlab.com/cznic/xc refs/heads/*:refs/heads/* refs/tags/*:refs/tags/* in /root/go/pkg/mod/cache/vcs/29fc2f846f24ce3630fdd4abfc664927c4ad22f98a3589050facafa0991faada: exit status 128:
        error: RPC failed; result=22, HTTP code = 404
        fatal: The remote end hung up unexpectedly
go: modernc.org/cc@v1.0.0: git fetch -f https://gitlab.com/cznic/cc refs/heads/*:refs/heads/* refs/tags/*:refs/tags/* in /root/go/pkg/mod/cache/vcs/3dac616a9d80602010c4792ef9c0e9d9812a1be8e70453e437e9792978075db6: exit status 128:
        error: RPC failed; result=22, HTTP code = 404
        fatal: The remote end hung up unexpectedly
go: modernc.org/strutil@v1.0.0: git fetch -f https://gitlab.com/cznic/strutil refs/heads/*:refs/heads/* refs/tags/*:refs/tags/* in /root/go/pkg/mod/cache/vcs/f48599000415ab70c2f95dc7528c585820ed37ee15d27040a550487e83a41748: exit status 128:
        error: RPC failed; result=22, HTTP code = 404
        fatal: The remote end hung up unexpectedly
go: modernc.org/golex@v1.0.0: git fetch -f https://gitlab.com/cznic/golex refs/heads/*:refs/heads/* refs/tags/*:refs/tags/* in /root/go/pkg/mod/cache/vcs/9aae2d4c6ee72eb1c6b65f7a51a0482327c927783dea53d4058803094c9d8039: exit status 128:
        error: RPC failed; result=22, HTTP code = 404
        fatal: The remote end hung up unexpectedly
go: error loading module requirements
[root@temptest sample-controller]#
[root@temptest sample-controller]#
[root@temptest sample-controller]#
[root@temptest sample-controller]# echo $GOPROXY

[root@temptest sample-controller]#
[root@temptest sample-controller]# export GOPROXY=https://goproxy.io
[root@temptest sample-controller]# go list -m
go: finding modernc.org/strutil v1.0.0
go: finding modernc.org/xc v1.0.0
go: finding modernc.org/cc v1.0.0
go: finding modernc.org/mathutil v1.0.0
go: finding modernc.org/golex v1.0.0
k8s.io/sample-controller
[root@temptest sample-controller]#
[root@temptest sample-controller]#
[root@temptest sample-controller]#
[root@temptest sample-controller]# go build -o sample-controller .
go: downloading k8s.io/api v0.0.0-20190831074750-7364b6bdad65
go: downloading k8s.io/client-go v0.0.0-20190831074946-3fe2abece89e
go: downloading k8s.io/apimachinery v0.0.0-20190831074630-461753078381
go: downloading k8s.io/klog v0.4.0
go: extracting k8s.io/klog v0.4.0
go: extracting k8s.io/apimachinery v0.0.0-20190831074630-461753078381
go: extracting k8s.io/client-go v0.0.0-20190831074946-3fe2abece89e
go: downloading golang.org/x/time v0.0.0-20161028155119-f51c12702a4d
go: downloading k8s.io/utils v0.0.0-20190801114015-581e00157fb1
go: extracting golang.org/x/time v0.0.0-20161028155119-f51c12702a4d
go: extracting k8s.io/utils v0.0.0-20190801114015-581e00157fb1
go: extracting k8s.io/api v0.0.0-20190831074750-7364b6bdad65
go: downloading github.com/google/go-cmp v0.3.0
go: downloading github.com/golang/groupcache v0.0.0-20160516000752-02826c3e7903
go: downloading gopkg.in/inf.v0 v0.9.0
go: downloading github.com/hashicorp/golang-lru v0.5.1
go: downloading github.com/gogo/protobuf v1.2.2-0.20190723190241-65acae22fc9d
go: downloading github.com/davecgh/go-spew v1.1.1
go: downloading github.com/google/gofuzz v1.0.0
go: extracting github.com/hashicorp/golang-lru v0.5.1
go: extracting gopkg.in/inf.v0 v0.9.0
go: extracting github.com/golang/groupcache v0.0.0-20160516000752-02826c3e7903
go: extracting github.com/google/go-cmp v0.3.0
go: downloading sigs.k8s.io/yaml v1.1.0
go: downloading github.com/json-iterator/go v1.1.7
go: downloading golang.org/x/net v0.0.0-20190812203447-cdfb69ac37fc
go: downloading golang.org/x/oauth2 v0.0.0-20190402181905-9f3314589c9a
go: extracting github.com/google/gofuzz v1.0.0
go: extracting github.com/davecgh/go-spew v1.1.1
go: downloading github.com/spf13/pflag v1.0.3
go: downloading github.com/googleapis/gnostic v0.0.0-20170729233727-0c5108395e2d
go: extracting sigs.k8s.io/yaml v1.1.0
go: downloading golang.org/x/crypto v0.0.0-20181025213731-e84da0312774
go: extracting github.com/json-iterator/go v1.1.7
go: downloading github.com/modern-go/reflect2 v1.0.1
go: downloading k8s.io/kube-openapi v0.0.0-20190816220812-743ec37842bf
go: extracting golang.org/x/oauth2 v0.0.0-20190402181905-9f3314589c9a
go: downloading github.com/imdario/mergo v0.3.5
go: extracting github.com/gogo/protobuf v1.2.2-0.20190723190241-65acae22fc9d
go: extracting github.com/spf13/pflag v1.0.3
go: extracting golang.org/x/net v0.0.0-20190812203447-cdfb69ac37fc
go: downloading gopkg.in/yaml.v2 v2.2.2
go: extracting github.com/googleapis/gnostic v0.0.0-20170729233727-0c5108395e2d
go: downloading github.com/golang/protobuf v1.3.1
go: downloading github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd
go: downloading golang.org/x/text v0.3.1-0.20181227161524-e6919f6577db
go: extracting github.com/modern-go/reflect2 v1.0.1
go: extracting golang.org/x/crypto v0.0.0-20181025213731-e84da0312774
go: extracting github.com/imdario/mergo v0.3.5
go: extracting gopkg.in/yaml.v2 v2.2.2
go: extracting github.com/golang/protobuf v1.3.1
go: downloading golang.org/x/sys v0.0.0-20190209173611-3b5209105503
go: extracting k8s.io/kube-openapi v0.0.0-20190816220812-743ec37842bf
go: extracting github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd
go: extracting golang.org/x/sys v0.0.0-20190209173611-3b5209105503
go: extracting golang.org/x/text v0.3.1-0.20181227161524-e6919f6577db
[root@temptest sample-controller]# ls
artifacts           CONTRIBUTING.md  controller_test.go  Godeps  go.sum  LICENSE  OWNERS  README.md          SECURITY_CONTACTS
code-of-conduct.md  controller.go    docs                go.mod  hack    main.go  pkg     sample-controller
```

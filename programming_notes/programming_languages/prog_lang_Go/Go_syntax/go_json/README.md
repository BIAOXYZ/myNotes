
# go json

JSON处理 https://www.huweihuang.com/golang-notes/text/json.html

golang json inline用法 https://blog.csdn.net/fjgui/article/details/104063806

理解 Go 中的 JSON https://sanyuesha.com/2018/05/07/go-json/
```go
举例来说，比如下面的 Go struct：

type Message struct {
    Name string
    Body string
    Time int64
}

使用 Marshal 序列化：

m := Message{"Alice", "Hello", 1294706395881547000}
b, err := json.Marshal(m) 
fmt.Println(b) //{"Name":"Alice","Body":"Hello","Time":1294706395881547000}
----------------------------------------------------------------------------------------------------
JSON object 中的 name 一般都是小写，我们可以通过 struct tag 来实现：

type MyStruct struct {
    SomeField string `json:"some_field"`
}
SomeField 序列化之后会变成 some_field。
```

golang中struct成员变量的标签（Tag）说明和获取方式 https://www.cnblogs.com/liujie-php/p/10503436.html

Go Struct超详细讲解 https://juejin.im/post/5ca2f37ce51d4502a27f0539
- > 在定义结构体字段时，除字段名称和数据类型外，还可以使用反引号为结构体字段声明元信息，这种元信息称为Tag，用于编译阶段关联到字段当中，如我们将上面例子中的结构体修改为：
  ```go
  type Member struct {
    Id     int    `json:"id,-"`
    Name   string `json:"name"`
    Email  string `json:"email"`
    Gender int    `json:"gender,"`
    Age    int    `json:"age"`
  }
  ```
  > 上面例子演示的是使用encoding/json包编码或解码结构体时使用的Tag信息。
  >
  > Tag由反引号括起来的一系列用空格分隔的key:"value"键值对组成，如：
  ```go
  Id int `json:"id" gorm:"AUTO_INCREMENT"`
  ```

Go's "omitempty" explained https://www.sohamkamani.com/golang/2018-07-19-golang-omitempty/

【from 人世间】：
- Golang处理JSON（一）--- 编码 https://www.jianshu.com/p/f3c2105bd06b
- Golang处理JSON（二）--- 解码 https://www.jianshu.com/p/31757e530144

Go_14：GoLang中 json、map、struct 之间的相互转化 https://www.cnblogs.com/liang1101/p/6741262.html

### 第二批

How To Use Struct Tags in Go https://www.digitalocean.com/community/tutorials/how-to-use-struct-tags-in-go

Golang中 json tag 标签的作用和用法讲解 https://www.cnblogs.com/FengZeng666/p/14987939.html
- > **参考文章**：
  * > GO--Json tag标签的作用，json用法讲解：https://blog.csdn.net/qq_33679504/article/details/100533703
  * > golang-json使用（json tag）：https://blog.csdn.net/somanlee/article/details/106925278

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# go struct

Go语言中struct的匿名属性特征 https://blog.csdn.net/books1958/article/details/22795203
> Go语言中struct的属性可以没有名字而只有类型，使用时类型即为属性名。（因此，一个struct中同一个类型的匿名属性只能有一个）
```go
//// https://play.golang.org/p/6B99TQTqdjo

package main

import "fmt"

type PersonC struct {
	id      int
	country string
}

//匿名属性
type Worker struct {
	//如果Worker有属性id,则worker.id表示Worker对象的id
	//如果Worker没有属性id,则worker.id表示Worker对象中的PersonC的id
	id   int
	name string
	int
	*PersonC
}

func main() {
	w := &Worker{}
	w.id = 201
	w.name = "Smith"
	w.int = 49
	w.PersonC = &PersonC{100001, "China"}

	fmt.Printf("name:%s,int:%d\n", w.name, w.int)
	fmt.Printf("inner PersonC,id:%d,country:%s\n",
		w.PersonC.id, w.PersonC.country)

	fmt.Printf("worker.id:%d,personC.id:%d\n", w.id, w.PersonC.id)
	fmt.Printf(w.country)
}
--------------------------------------------------
name:Smith,int:49
inner PersonC,id:100001,country:China
worker.id:201,personC.id:100001
China
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

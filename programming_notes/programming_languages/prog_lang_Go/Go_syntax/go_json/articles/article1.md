
# 1

Go的json解析：Marshal与Unmarshal https://blog.csdn.net/zxy_666/article/details/80173288
- > **Json Marshal：将数据编码成json字符串**
  ```go
  package main

  import (
  	"encoding/json"
  	"fmt"
  )

  type Stu struct {
  	Name  string `json:"name"`
  	Age   int
  	HIgh  bool
  	sex   string
  	Class *Class `json:"class"`
  }

  type Class struct {
  	Name  string
  	Grade int
  }

  func main() {
  	//实例化一个数据结构，用于生成json字符串
  	stu := Stu{
  		Name: "张三",
  		Age:  18,
  		HIgh: true,
  		sex:  "男",
  	}

  	//指针变量
  	cla := new(Class)
  	cla.Name = "1班"
  	cla.Grade = 3
  	stu.Class = cla

  	//Marshal失败时err!=nil
  	jsonStu, err := json.Marshal(stu)
  	if err != nil {
  		fmt.Println("生成json字符串错误")
  	}

  	//jsonStu是[]byte类型，转化成string类型便于查看
  	fmt.Println(string(jsonStu))
  }
  ```
  ```console
  {"name":"张三","Age":18,"HIgh":true,"class":{"Name":"1班","Grade":3}}
  ```
  > 从结果中可以看出
  * > 只要是可导出成员（变量首字母大写），都可以转成`json`。***<ins>因成员变量sex是不可导出的，故无法转成`json`</ins>***。
  * > ***<ins>如果变量打上了`json`标签，如Name旁边的 `json:"name"` ，那么转化成的json key就用该标签“name”，否则取变量名作为key，如“Age”，“HIgh”</ins>***。
  * > `bool`类型也是可以直接转换为`json`的value值。Channel， complex 以及函数不能被编码json字符串。当然，***循环的数据结构也不行，它会导致marshal陷入死循环***。
  * > `指针变量`，编码时自动转换为`它所指向的值`，如cla变量。（当然，不传指针，Stu struct的成员Class如果换成Class struct类型，效果也是一模一样的。只不过指针更快，且能节省内存空间。）
  * > 最后，强调一句：`json`编码成字符串后就是**纯粹的**字符串了。 


# 相关命令

# 官方链接

# 已有书籍类链接

# 相关wiki链接

# 其他博客类链接

Shell编程中select用法 https://blog.csdn.net/lxbwolf/article/details/77852853
```sh
select提供了一个构建交互式菜单程序的方式, 语法结构:
select name [ in word ] ; do list ; done

--------------------------------------------------

例:

#!/bin/bash
select i in a b c d
do
    echo $i
done

执行结果

$ ./select.sh 
1) a
2) b
3) c
4) d
#? 

--------------------------------------------------

如果输入的不是菜单描述的范围就会echo一个空行，如果直接输入回车，就会再显示一遍菜单本身。
当然我们会发现这样一个菜单程序似乎没有什么意义，实际程序中，select大多数情况是跟case配合使用的。

#!/bin/bash
select i in a b c d
do
    case $i in 
        a)
            echo "Your choice is a"
        ;;
        b)
            echo "Your choice is b"
        ;;
        c)
            echo "Your choice is c"
        ;;
        d)
            echo "Your choice is d"
        ;;
        *)
            echo "Wrong choice! exit!"
        ;;
    esac
done

执行结果

$ ./select.sh 
1) a
2) b
3) c
4) d
#? 1
Your choice is a
#? 2
Your choice is b
#? 3
Your choice is c
#? 4
Your choice is d
#? 5
Wrong choice! exit!
```


# 个人实战

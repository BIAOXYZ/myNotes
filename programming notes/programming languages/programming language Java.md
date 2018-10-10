

# Java基础

## Java教程系列

w3cschool.cn里Java相关教程
- Java教程 - w3cschool.cn https://www.w3cschool.cn/java/
- Servlet教程 - w3cschool.cn https://www.w3cschool.cn/servlet/
- Java面试问题 - w3cschool.cn https://www.w3cschool.cn/java_interview_question/

易百教程里Java相关教程
- Java教程 - 易百教程 https://www.yiibai.com/java/
  * Java for循环 -- `2. Java for-each循环` https://www.yiibai.com/java/java-for-loop.html
  * Java注释 -- `3)Java文档注释` https://www.yiibai.com/java/java-comments.html 
  * Java static关键字 -- `创建对象示例图如下所示` https://www.yiibai.com/java/static-keyword-in-java.html
- Java9教程 - 易百教程 https://www.yiibai.com/java/java9/

菜鸟教程里Java相关教程
- Java教程 - 菜鸟教程 http://www.runoob.com/java/java-tutorial.html
- Servlet教程 - 菜鸟教程 http://www.runoob.com/servlet/servlet-tutorial.html

Java Tutorial - tutorialspoint https://www.tutorialspoint.com/java/

Java - 极客学院 http://wiki.jikexueyuan.com/list/java/

## Java进阶教程

stackoverflow上Java相关回答整理翻译 https://github.com/giantray/stackoverflow-java-top-qa
- @Component, @Repository, @Service的区别 https://github.com/giantray/stackoverflow-java-top-qa/blob/master/contents/whats-the-difference-between-component-repository-service-annotations-in.md

JavaGuide https://github.com/Snailclimb/JavaGuide

## Java优秀blog

菜鸟-翡青 https://blog.csdn.net/zjf280441589
- Java研发进阶之路 https://blog.csdn.net/column/details/13901.html
- Java基础 https://blog.csdn.net/zjf280441589/article/category/5889187
  * Java 反射 https://blog.csdn.net/zjf280441589/article/details/50453776
  * Java注解实践 https://blog.csdn.net/zjf280441589/article/details/50444343
  
Java by 拭心 https://blog.csdn.net/u011240877/article/category/2704181
- 深入理解 Java 反射：Field （成员变量） https://blog.csdn.net/u011240877/article/details/54604212

## Java语法知识

### Java关键字

【Java关键字-访问范围修饰符】private、protected、public和default的区别 https://blog.csdn.net/claram/article/details/48002833

#### 关键字final

- 深入浅出Java final关键字 - 陈大侠的文章 - 知乎 https://zhuanlan.zhihu.com/p/33083924
- Final of Java，这一篇差不多了 https://juejin.im/entry/58c4811161ff4b005d94fed2
- 深入理解Java中的final关键字 http://www.importnew.com/7553.html
- 浅析Java中的final关键字 https://www.cnblogs.com/dolphin0520/p/3736238.html

### String... (可变长参数)

java 中,方法参数为(string...names)什么意思_百度知道 - https://zhidao.baidu.com/question/500414172336052404.html
> 为字符串类型的可变长参数，意思是，形参可以是1个也可以是多个，处理类似与数组

--------------------------------------------------

### `###` Java注解

- 深入理解Java注解类型(@Annotation) https://blog.csdn.net/javazejian/article/details/71860633
  * 深入理解Java类型信息(Class对象)与反射机制 https://blog.csdn.net/javazejian/article/details/70768369

- 一小时搞明白自定义注解（Annotation） https://blog.csdn.net/u013045971/article/details/53433874
- 深入浅出Java注解 https://www.jianshu.com/p/5cac4cb9be54
- 请问java再方法前加@xxx的是什么意思？ https://bbs.csdn.net/topics/390373674

#### @Autowired注解

- Spring@Autowired注解、@Override注解 https://blog.csdn.net/ljj821061514/article/details/51799672
- Spring@Autowired注解与自动装配 https://blog.csdn.net/HEYUTAO007/article/details/5981555
- @Resource与@Autowired注解的区别 https://blog.csdn.net/wangzuojia001/article/details/54312074

#### @Component注解

Spring @Configuration 和 @Component 区别 https://blog.csdn.net/isea533/article/details/78072133

#### 注解与反射

- 简单谈谈java自定义注解 https://www.jb51.net/article/118643.htm
- Java注解Annotation与自定义注解详解 https://www.jb51.net/article/136853.htm
- Java 自定义注解及利用反射读取注解的实例 https://www.jb51.net/article/122484.htm

--------------------------------------------------

### `###` Java反射

#### class.forname()

- Class.forName()的作用与使用总结 https://blog.csdn.net/fengyuzhengfan/article/details/38086743
- java中Class对象详解和类名.class, class.forName(), getClass()区别 https://www.cnblogs.com/Seachal/p/5371733.html

#### getClass() getInstance()

- java-----instanceof与getClass的区别 https://blog.csdn.net/hzw19920329/article/details/51095413
- java中的instance方法 https://blog.csdn.net/zrds2e/article/details/56958388
> 总结：
getInstance这个方法在单例模式用的甚多，为了避免对内存造成浪费，直到需要实例化该类的时候才将其实例化，所以用getInstance来获取该对象，
至于其他时候，也就是为了简便而已，为了不让程序在实例化对象的时候，不用每次都用new关键字，索性提供一个instance方法，不必一执行这个类就
初始化，这样做到不浪费系统资源！
单例模式 可以防止 数据的冲突，节省内存空间
- JAVA设计模式之单例模式 https://blog.csdn.net/jason0539/article/details/23297037

--------------------------------------------------

### `###` Java泛型

- Java泛型详解：<T>和Class<T>的使用。泛型类，泛型方法的详细使用实例 https://blog.csdn.net/qq_27093465/article/details/73229016
- Java - Generics https://www.tutorialspoint.com/java/java_generics.htm
- Java 泛型 <? super T> 中 super 怎么 理解？与 extends 有何不同？ - 知乎 https://www.zhihu.com/question/20400700
- Java中的泛型<T>类与方法 https://blog.csdn.net/songkai320/article/details/51822497
> 强制类型转换很麻烦，我还要事先知道各个Object具体类型是什么，才能做出正确转换。否则，要是转换的类型不对，比如将“Hello Generics!”字符串强制转换为Double,那么编译的时候不会报错，可是运行的时候就挂了。那有没有不强制转换的办法----有，改用Java5泛型来实现。

JAVA泛型通配符T，E，K，V区别，T以及Class<T>，Class<?>的区别 https://www.jianshu.com/p/95f349258afb

#### Class clazz

https://stackoverflow.com/questions/2529974/why-do-java-programmers-like-to-name-a-variable-clazz

封装篇——获取泛型<T>的Class<T> clazz https://blog.csdn.net/sinat_15877283/article/details/50971262

--------------------------------------------------

### `###` Java接口，类及继承等

- Java接口 - 易百教程 https://www.yiibai.com/java/interface-in-java.html
- java提高篇(五)-----抽象类与接口 https://www.cnblogs.com/chenssy/p/3376708.html
- 深入理解Java的接口和抽象类 http://www.importnew.com/18780.html
- Java 中的接口有什么作用？ - 知乎 https://www.zhihu.com/question/20111251


#### 待命题

- C++的继承和Java继承的比较 https://blog.csdn.net/dawanganban/article/details/41924213
- 为什么Java不支持多重继承? http://www.importnew.com/4604.html
- Java 内部类的意义及应用 https://juejin.im/post/5ad5d8cd6fb9a028c42eb520


## Java零散知识

servlet的本质是什么，它是如何工作的？ - 柳树的回答 - 知乎 https://www.zhihu.com/question/21416727/answer/339012081

### JDK JRE JVM等相关

JRE 和 JDK 的区别是什么？ - 王博的回答 - 知乎 https://www.zhihu.com/question/20317448/answer/14737358

Difference between Java SE/EE/ME https://stackoverflow.com/questions/2857376/difference-between-java-se-ee-me

Java虚拟机（JVM）概述 http://www.importnew.com/29224.html


--------------------------------------------------

### Java bean

Java bean 是个什么概念？ - 知乎 https://www.zhihu.com/question/19773379
- Java bean 是个什么概念？ - 杨博的回答 - 知乎 https://www.zhihu.com/question/19773379/answer/31625054
- Java bean 是个什么概念？ - 刘欣的回答 - 知乎 https://www.zhihu.com/question/19773379/answer/112322794

什么是JavaBean、bean? 什么是POJO、PO、DTO、VO、BO ? 什么是EJB、EntityBean？ https://blog.csdn.net/chenchunlin526/article/details/69939337

#### Spring bean

Spring读书笔记-----Spring的Bean之Bean的基本概念 https://blog.csdn.net/chenssy/article/details/8222744

12.Spring Bean是什么 https://blog.csdn.net/u014590757/article/details/79998914

- 7.5.10: Spring的Bean和JavaBean的比较 https://blog.csdn.net/confirmaname/article/details/9362385
- 传统javabean与spring中的bean的区别 https://blog.csdn.net/haibin_hu/article/details/51793606
- Difference between JavaBean and Spring bean https://stackoverflow.com/questions/21866571/difference-between-javabean-and-spring-bean
- JavaBeans vs Spring beans vs POJOs http://www.importnew.com/14019.html

## Java问题

Eclipse调试的时候提示Source not found。
- 启动debug时Source not found for Class<T>.getDeclaredMethods0(boolean) line: https://blog.csdn.net/leidijava/article/details/8625472
- https://stackoverflow.com/questions/19547535/source-not-found-when-debugging-all-projects
```
我的和第一个帖子里的情况一样，就是多打了个断点，然后这个断点涉及的类或者方法没有源码，eclipse就报这个错。把断点去掉就好了。
第二个帖子那种把相应源码下载下来的方法估计肯定也可以，但是费时间，项目没那么多时间仔细搞这些。
```

为什么一个java文件只能有一个public类?
- 为什么java源文件中只允许一个public类存在 https://blog.csdn.net/y_love_f/article/details/10553929
- https://stackoverflow.com/questions/1318712/why-is-each-public-class-in-a-separate-file
- https://www.quora.com/Why-there-is-only-one-public-class-in-java-source-code

Java中，一个类实现某个接口，必须重写接口中的所有方法吗 https://blog.csdn.net/y505772146/article/details/51046010

IllegalArgumentException: wrong number of arguments
- 解析Java反射java.lang.IllegalArgumentException: wrong number of arguments https://blog.csdn.net/Z0157/article/details/47863253
- Java 反射 不定参数bug http://www.cnblogs.com/france/p/4808577.html

java中，遇到“Unhandled exception type……”怎么处理？ https://blog.csdn.net/magicwizard/article/details/1815725


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:



# Java框架

## Spring

Spring教程 - w3cschool.cn https://www.w3cschool.cn/wkspring/

Spring教程 - 易百教程 https://www.yiibai.com/spring/

### [Spring Boot](https://github.com/spring-projects/spring-boot)

spring-boot-examples https://github.com/ityouknow/spring-boot-examples

Spring Boot教程 - 易百教程 https://www.yiibai.com/spring-boot/

Spring Boot项目使用Eclipse进行断点调试Debug  https://www.cnblogs.com/EasonJim/p/7373345.html

SpringBoot | 番外：使用小技巧合集 http://www.importnew.com/29886.html

#### 知乎 Spring Boot

Spring Boot系列(一)：Spring Boot 入门篇 - 极乐君的文章 - 知乎 https://zhuanlan.zhihu.com/p/24957789
```
下面有人评论：

文章好面熟.....原来是抄程序猿DD的文章，拼拼改改做原创，知乎也沦陷了，哎...
Spring Boot快速入门 https://www.jianshu.com/p/d24bceea7665
Spring Boot工程结构推荐 https://www.jianshu.com/p/8476326ba7b6
```

#### CSDN Spring Boot

方志朋 - SpringBoot非官方教程 | 终章：文章汇总 https://blog.csdn.net/forezp/article/details/70341818

SpringBoot学习系列目录 https://blog.csdn.net/u011961421/article/details/79416510

lxhjh - springboot https://blog.csdn.net/lxhjh/article/category/6277040/
- SpringBoot入门系列：第一篇 Hello World https://blog.csdn.net/lxhjh/article/details/51711148

zhulier1124 - springboot https://blog.csdn.net/zhulier1124/article/category/7965029
- SpringBoot基本操作（一）——环境搭建及项目创建（有demo） https://blog.csdn.net/zhulier1124/article/details/81988471

springboot教程目录 https://blog.csdn.net/qq_31463999/article/details/81627799

随笔分类 - springboot https://www.cnblogs.com/ityouknow/category/914493.html
- 为什么说 Java 程序员到了必须掌握 Spring Boot 的时候 http://www.ityouknow.com/springboot/2018/06/12/spring-boo-java-simple.html

【彻底精通Spring Boot2源码】 SpringApplication.run() 启动流程源码彻底剖析 https://blog.csdn.net/Z0157/article/details/82845022

--------------------------------------------------

Spring Boot干货系列：（一）优雅的入门篇 http://tengj.top/2017/02/26/springboot1/

Spring Boot基础 https://www.ibm.com/developerworks/cn/java/j-spring-boot-basics-perry/index.html

Spring Boot快速开始指南 https://jimmysong.io/posts/spring-boot-quick-start-guide/


### Spring Cloud

方志朋 - 史上最简单的 SpringCloud 教程 | 终章 https://blog.csdn.net/forezp/article/details/70148833


## `##` [Swagger](https://swagger.io/)

- Java项目怎么使用Swagger生成API文档？ - 知乎 https://www.zhihu.com/question/28119576
- Swagger Annotation 详解（建议收藏） https://www.jianshu.com/p/b0b19368e4a8
- RESTful API 利器 Swagger https://juejin.im/entry/580457030bd1d0005812a700
- 使用Swagger生成JAVA Mock Server（Springboot）代码 https://blog.csdn.net/a78270528/article/details/78530702
- Swagger简介 https://blog.csdn.net/wangnan9279/article/details/44541665


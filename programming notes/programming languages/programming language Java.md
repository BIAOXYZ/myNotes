

# Java基础

## Java教程系列

w3cschool.cn里Java相关教程
- Java教程 - w3cschool.cn https://www.w3cschool.cn/java/
- Servlet教程 - w3cschool.cn https://www.w3cschool.cn/servlet/
- Java面试问题 - w3cschool.cn https://www.w3cschool.cn/java_interview_question/

易百教程里Java相关教程
- Java教程 - 易百教程 https://www.yiibai.com/java/
- Java9教程 - 易百教程 https://www.yiibai.com/java/java9/

菜鸟教程里Java相关教程
- Java教程 - 菜鸟教程 http://www.runoob.com/java/java-tutorial.html
- Servlet教程 - 菜鸟教程 http://www.runoob.com/servlet/servlet-tutorial.html

Java Tutorial - tutorialspoint https://www.tutorialspoint.com/java/

Java - 极客学院 http://wiki.jikexueyuan.com/list/java/

## Java进阶教程

JavaGuide https://github.com/Snailclimb/JavaGuide

## Java语法知识

### Java关键字

【Java关键字-访问范围修饰符】private、protected、public和default的区别 https://blog.csdn.net/claram/article/details/48002833

#### 关键字final

- 深入浅出Java final关键字 - 陈大侠的文章 - 知乎 https://zhuanlan.zhihu.com/p/33083924
- Final of Java，这一篇差不多了 https://juejin.im/entry/58c4811161ff4b005d94fed2
- 深入理解Java中的final关键字 http://www.importnew.com/7553.html
- 浅析Java中的final关键字 https://www.cnblogs.com/dolphin0520/p/3736238.html

--------------------------------------------------

### Java注解

- 深入理解Java注解类型(@Annotation) https://blog.csdn.net/javazejian/article/details/71860633
- 深入浅出Java注解 https://www.jianshu.com/p/5cac4cb9be54
- 请问java再方法前加@xxx的是什么意思？ https://bbs.csdn.net/topics/390373674

#### @Autowired注解

- Spring@Autowired注解、@Override注解 https://blog.csdn.net/ljj821061514/article/details/51799672
- Spring@Autowired注解与自动装配 https://blog.csdn.net/HEYUTAO007/article/details/5981555
- @Resource与@Autowired注解的区别 https://blog.csdn.net/wangzuojia001/article/details/54312074

--------------------------------------------------

### Java类型

#### Java String

java 中,方法参数为(string...names)什么意思_百度知道 - https://zhidao.baidu.com/question/500414172336052404.html
> 为字符串类型的可变长参数，意思是，形参可以是1个也可以是多个，处理类似与数组

#### Java泛型

- Java泛型详解：<T>和Class<T>的使用。泛型类，泛型方法的详细使用实例 https://blog.csdn.net/qq_27093465/article/details/73229016
- Java - Generics https://www.tutorialspoint.com/java/java_generics.htm
- Java 泛型 <? super T> 中 super 怎么 理解？与 extends 有何不同？ - 知乎 https://www.zhihu.com/question/20400700

--------------------------------------------------

### Java接口，类及继承等

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


:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:



# Java框架

## Spring

Spring教程 - w3cschool.cn https://www.w3cschool.cn/wkspring/

Spring教程 - 易百教程 https://www.yiibai.com/spring/

### Spring Boot

Spring Boot https://github.com/spring-projects/spring-boot

spring-boot-examples https://github.com/ityouknow/spring-boot-examples

Spring Boot教程 - 易百教程 https://www.yiibai.com/spring-boot/

Spring Boot项目使用Eclipse进行断点调试Debug  https://www.cnblogs.com/EasonJim/p/7373345.html

SpringBoot | 番外：使用小技巧合集 http://www.importnew.com/29886.html

#### CSDN Spring Boot

方志朋 - SpringBoot非官方教程 | 终章：文章汇总 https://blog.csdn.net/forezp/article/details/70341818

SpringBoot学习系列目录 https://blog.csdn.net/u011961421/article/details/79416510

lxhjh - springboot https://blog.csdn.net/lxhjh/article/category/6277040/
- SpringBoot入门系列：第一篇 Hello World https://blog.csdn.net/lxhjh/article/details/51711148

zhulier1124 - springboot https://blog.csdn.net/zhulier1124/article/category/7965029
- SpringBoot基本操作（一）——环境搭建及项目创建（有demo） https://blog.csdn.net/zhulier1124/article/details/81988471

springboot教程目录 https://blog.csdn.net/qq_31463999/article/details/81627799

--------------------------------------------------

Spring Boot干货系列：（一）优雅的入门篇 http://tengj.top/2017/02/26/springboot1/

随笔分类 - springboot https://www.cnblogs.com/ityouknow/category/914493.html

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


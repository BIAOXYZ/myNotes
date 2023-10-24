
# 问题处理

## 1.语言问题，只需要 `export LC_ALL=C` 即可

What is the correct way to fix an assertion in loadlocale.c? https://askubuntu.com/questions/1081901/what-is-the-correct-way-to-fix-an-assertion-in-loadlocale-c

## 2.`hdfsGetPathInfo()`函数的使用要在`hdfsOpenFile()`之后

https://cpp.hotexamples.com/zh/examples/-/-/hdfsGetPathInfo/cpp-hdfsgetpathinfo-function-examples.html
```cpp
// 这个函数返回一个构造好的chunkid和每个chunk的指针
// 这个里面的chunkId肯定是要在blockManager注册然后汇报信息的
// put的话也是会这样的，可以将这个函数中调用put然后统一汇报信息的接口
ChunkInfo BlockManager::loadFromHdfs(string file_name){
	// 由此函数得到的<blockId,指针>
	ChunkInfo ci;
	string file_name_former,file_name_latter;
	unsigned pos=file_name.rfind("$");
	file_name_former=file_name.substr(0,pos);
	file_name_latter=file_name.substr(pos+1,file_name.length());
	int offset=atoi(file_name_latter.c_str());
	hdfsFS fs=hdfsConnect(Config::hdfs_master_ip.c_str(),Config::hdfs_master_port);
	hdfsFile readFile=hdfsOpenFile(fs,file_name_former.c_str(),O_RDONLY,0,0,0);
	hdfsFileInfo *hdfsfile=hdfsGetPathInfo(fs,file_name_former.c_str());
	if(!readFile){
		cout<<"open file error"<<endl;
	}
	unsigned length=0;
	length=length+CHUNK_SIZE*offset;
	if(length<hdfsfile->mSize){
		void *rt=malloc(CHUNK_SIZE);		//newmalloc
		tSize bytes_num=hdfsPread(fs,readFile,length,rt,CHUNK_SIZE);
		ostringstream chunkid;
		chunkid<<file_name.c_str()<<"$"<<offset;
//		ci.chunkId=chunkid.gestr().c_str();
		ci.hook=rt;
	}else{
		ostringstream chunkid;
		chunkid<<file_name.c_str()<<"$"<<offset;
//		ci.chunkId=chunkid.str().c_str();
		ci.hook=0;
	}
	hdfsCloseFile(fs,readFile);
	hdfsDisconnect(fs);
	return ci;
}
```

hdfsGetPathInfo() https://docs.datafabric.hpe.com/62/DevelopmentGuide/hdfsGetPathInfo.html

## 3. 并发读写问题

HDFS在同一时刻只能读或者写同一文件么，能不能并发执行？ - 知乎 https://www.zhihu.com/question/28723376

HDFS多线程追加写数据踩坑 https://blog.csdn.net/weixin_44252761/article/details/89517393

HDFS的读写流程 https://www.cnblogs.com/feiyumo/p/12541296.html

《hadoop权威指南》笔记二： hdfs读写过程剖析 https://cloud.tencent.com/developer/article/1500068

一种hdfs多线程并行下载方法 https://patents.google.com/patent/CN104462324A/zh

## 4. libhdfs内存泄露

Hdfs FileSystem 使用姿势不对导致的内存泄露 https://blog.csdn.net/u013332124/article/details/89302271

HDFS简单介绍及用C语言訪问HDFS接口操作实践 https://www.cnblogs.com/mfmdaoyou/p/7008322.html || https://blog.csdn.net/weixin_34010949/article/details/85903011
- > 3.遇到的主要问题描写叙述与分析
  ```console
  对于LIB HDFS接口的不足之处，在本文第三部分(LIB HDFS接口简单介绍)已有大致描写叙述。
  在实际性能測试过程中。因LIB HDFS接口引起的问题主要包含：lease租约回收异常和程序句柄资源释放异常等两大类。
  
  我们换了多种測试模型，基本确认LIB HDFS接口在某些异常情况下(如频繁对同一个文件运行append操作)会产生上述问题。
  
  所以假设在项目中须要实际应用LIB HDFS接口，就须要我们改进client程序处理流程，尽量规避和降低上述问题的产生。能够採用例如以下方法：
  1)在client程序和HDFS文件系统间添加缓存的方式降低HDFS的读写密度；
  2)降低对HDFS文件系统的更新操作，比如文件写入完毕后就不再运行append操作，仅仅运行read操作。
  ```

# 其他问题

## hdfs的append模式

python 与hadoop之pyhdfs的append https://blog.csdn.net/w894607785/article/details/50245655

libhdfs does not call FileSystem.append when O_APPEND passed to hdfsOpenFile https://issues.apache.org/jira/browse/HADOOP-4494

## hdfs权限问题
>> //notes：起因是如果当前用户没有权限访问hdfs文件，可以通过 `export HADOOP_USER_NAME=<user_name_with_privilege>` 设置用户名来bypass。但是这样可能会造成权限滥用，好像除非服务端开启 Kerberos，不然没有办法。。。

User name handling in Hadoop https://www.opencore.com/blog/2016/5/user-name-handling-in-hadoop/

How to prevent users from modifying HADOOP_USER_NAME ? https://community.cloudera.com/t5/Support-Questions/How-to-prevent-users-from-modifying-HADOOP-USER-NAME/td-p/229320

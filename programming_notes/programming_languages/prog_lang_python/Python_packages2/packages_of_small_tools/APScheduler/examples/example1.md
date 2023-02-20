
# 1

APScheduler配置监听事件，并写入日志 https://blog.csdn.net/time_money/article/details/119825381

**个人实战文章代码**：
```py
# coding:utf-8

from apscheduler.schedulers.blocking import BlockingScheduler
from apscheduler.events import EVENT_JOB_EXECUTED, EVENT_JOB_ERROR, EVENT_JOB_MISSED
import datetime
import logging

logger = logging.getLogger('job')
logging.basicConfig(level=logging.INFO,
                    format = '%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    datefmt = '%Y-%m-%d %H:%M:%S',
                    filename = 'mylog.txt',
                    filemode = 'a')

'''任务1'''
def my_job(x):
    print(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), x)

'''任务2'''
def test_job(x):
    print(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), x)
    print(1 / 0)

def job_listener(Event):
    job = scheduler.get_job(Event.job_id)
    if not Event.exception:
        print('任务正常运行！')
        logger.info("jobname=%s|jobtrigger=%s|jobtime=%s|retval=%s", job.name, job.trigger,
                    Event.scheduled_run_time, Event.retval)

    else:
        print("任务出错了！！！！！")
        logger.error("jobname=%s|jobtrigger=%s|errcode=%s|exception=[%s]|traceback=[%s]|scheduled_time=%s", job.name,
                     job.trigger, Event.code,
                     Event.exception, Event.traceback, Event.scheduled_run_time)

scheduler = BlockingScheduler()
scheduler.add_job(func=test_job, args=('一次性任务,会出错',),
                 next_run_time=datetime.datetime.now() + datetime.timedelta(seconds=15), id='date_task')
scheduler.add_job(func=my_job, args=('循环任务',), trigger='interval', seconds=3, id='interval_task')
scheduler.add_listener(job_listener, EVENT_JOB_ERROR | EVENT_JOB_MISSED | EVENT_JOB_EXECUTED)
scheduler._logger = logging
scheduler.start()
```
```console
2023-02-20 11:50:11 循环任务
任务正常运行！
2023-02-20 11:50:14 循环任务
任务正常运行！
2023-02-20 11:50:17 循环任务
任务正常运行！
2023-02-20 11:50:20 循环任务
任务正常运行！
2023-02-20 11:50:23 一次性任务,会出错
任务出错了！！！！！
2023-02-20 11:50:23 循环任务
任务正常运行！
2023-02-20 11:50:26 循环任务
任务正常运行！
2023-02-20 11:50:29 循环任务
任务正常运行！
2023-02-20 11:50:32 循环任务
任务正常运行！
2023-02-20 11:50:35 循环任务
任务正常运行！
...
...
...
```

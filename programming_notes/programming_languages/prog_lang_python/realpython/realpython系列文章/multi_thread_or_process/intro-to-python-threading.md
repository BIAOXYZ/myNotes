
An Intro to Threading in Python https://realpython.com/intro-to-python-threading/
- > **What Is a Thread?**
  * > Because of the way CPython implementation of Python works, threading may not speed up all tasks. This is due to interactions with the [GIL](https://realpython.com/python-gil/) that essentially limit one Python thread to run at a time.
  * > Tasks that ***spend much of their time waiting for external events*** are generally good candidates for threading. Problems that ***require heavy CPU computation and spend little time waiting for external events*** might not run faster at all.
  * > If you are running a standard Python implementation, writing in only Python, and have a CPU-bound problem, you should check out the `multiprocessing` module instead.
- > **Starting a Thread**
  * > To start a separate thread, you create a Thread instance and then tell it to `.start()`:
    ```py
    import logging
    import threading
    import time

    def thread_function(name):
        logging.info("Thread %s: starting", name)
        time.sleep(2)
        logging.info("Thread %s: finishing", name)

    if __name__ == "__main__":
        format = "%(asctime)s: %(message)s"
        logging.basicConfig(format=format, level=logging.INFO,
                            datefmt="%H:%M:%S")
    
        logging.info("Main    : before creating thread")
        x = threading.Thread(target=thread_function, args=(1,))
        logging.info("Main    : before running thread")
        x.start()
        logging.info("Main    : wait for the thread to finish")
        # x.join()
        logging.info("Main    : all done")
    ```
  * > When you run this program as it is (***with line twenty commented out***), the output will look like this:
    ```console
    $ ./single_thread.py
    Main    : before creating thread
    Main    : before running thread
    Thread 1: starting
    Main    : wait for the thread to finish
    Main    : all done
    Thread 1: finishing
    ```
- > **Daemon Threads**

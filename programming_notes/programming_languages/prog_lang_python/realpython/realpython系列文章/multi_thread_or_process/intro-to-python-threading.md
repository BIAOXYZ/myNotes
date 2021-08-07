
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
  * > Frequently, this behavior is what you want, but there are other options available to us. Let’s first repeat the program with a `daemon` thread. You do that by changing how you construct the Thread, adding the `daemon=True` flag:
    ```py
    x = threading.Thread(target=thread_function, args=(1,), daemon=True)
    ```
  * > When you run the program now, you should see this output:
    ```console
    $ ./daemon_thread.py
    Main    : before creating thread
    Main    : before running thread
    Thread 1: starting
    Main    : wait for the thread to finish
    Main    : all done
    ```
  * > The difference here is that the final line of the output is missing. `thread_function()` did not get a chance to complete. It was a `daemon` thread, so when `__main__` reached the end of its code and the program wanted to finish, the daemon was killed.
- > **`join()` a Thread**
  * > To tell one thread to wait for another thread to finish, you call `.join()`. If you uncomment that line, the main thread will pause and wait for the thread x to complete running.
  * > Did you test this on the code with the `daemon thread` or the `regular thread`? It turns out that it doesn’t matter. ***If you `.join()` a thread, that statement will wait until either kind of thread is finished***.
- > **Working With Many Threads**
  * > Frequently, you’ll want to start a number of threads and have them do interesting work. Let’s start by looking at the harder way of doing that, and then you’ll move on to an easier method.
  * > The harder way of starting multiple threads is the one you already know:
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

        threads = list()
        for index in range(3):
            logging.info("Main    : create and start thread %d.", index)
            x = threading.Thread(target=thread_function, args=(index,))
            threads.append(x)
            x.start()

        for index, thread in enumerate(threads):
            logging.info("Main    : before joining thread %d.", index)
            thread.join()
            logging.info("Main    : thread %d done", index)
    ```
  * > This code uses the same mechanism you saw above to start a thread, create a Thread object, and then call `.start()`. The program keeps a list of Thread objects so that it can then wait for them later using `.join()`.
  * > Running this code multiple times will likely produce some interesting results. Here’s an example output from my machine:
    ```console
    $ ./multiple_threads.py
    Main    : create and start thread 0.
    Thread 0: starting
    Main    : create and start thread 1.
    Thread 1: starting
    Main    : create and start thread 2.
    Thread 2: starting
    Main    : before joining thread 0.
    Thread 2: finishing
    Thread 1: finishing
    Thread 0: finishing
    Main    : thread 0 done
    Main    : before joining thread 1.
    Main    : thread 1 done
    Main    : before joining thread 2.
    Main    : thread 2 done
    ```
  * > If you walk through the output carefully, you’ll see all three threads getting started in the order you might expect, but in this case they finish in the opposite order! ***Multiple runs will produce different orderings***. Look for the ***Thread x: finishing*** message to tell you when each thread is done.
  * > The order in which threads are run is determined by the operating system and can be quite hard to predict. It may (and likely will) vary from run to run, so you need to be aware of that when you design algorithms that use threading.
  * > Fortunately, Python gives you several primitives that you’ll look at later to help coordinate threads and get them running together. Before that, let’s look at how to make managing a group of threads a bit easier.
- > **Using a ThreadPoolExecutor**

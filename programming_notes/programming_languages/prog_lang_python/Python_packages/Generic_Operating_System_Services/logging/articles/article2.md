
# 1

【[:star:][`*`]】 Stop Using “Print” and Start Using “Logging” https://towardsdatascience.com/stop-using-print-and-start-using-logging-a3f50bc8ab0
- > The logging library provides you ***`five`*** tools to accomplish the logging tasks.
  * > 1.Debug (`logging.debug()`): Providing information to diagnosing problems.
  * > 2.Info (`logging.info()`): Tracking the normal operation of a program.
  * > 3.Warning (`logging.warning()`): Although the code is still working as expected, something unexpected happened.
  * > 4.Error (`logging.error()`): The code was unable to run some parts.
  * > 5.Critical (`logging.critical()`): The code cannot run.
- > Before using these tools, let’s understand different levels of logging in Python.
- > **Logging Levels in Python**
  * > There are ***`six`*** logging levels in Python. ***The highest level is `CRITICAL`. <ins>If you set your logging level to `CRITICAL`, only logging messages of the `CRITICAL` level will be shown</ins>***. To set your logging level to `CRITICAL`, you can use `logging.basicConfig()`.
    ```py
    logging.basicConfig(level=logging.CRITICAL)
    ```
    or
    ```py
    logging.basicConfig(level=50)
    ```
  * > As you see the `level` argument in `logging.basicConfig()` takes an integer number (i.e. `50` or constant `logging.CRITICAL`) and sets the logging level. The levels of logging from the lowest to the highest are ***<ins>`NOTSET=0, DEBUG=10, INFO=20, WARNING=30, ERROR=40, and CRITICAL=50`</ins>***.
  * > ***The default level is `WARNING` (i.e. `30`)*** which means, ***the logging module only displays/logs events with `warning`, `error`, or `critical` severity***. Again, remember that you can set your logging level using `logging.basicConfig()`.
    >> 【[:star:][`*`]】 //notes：也就是只会显示级别 ***大于等于*** 你设定级别的信息。
  * > Here is an example code to display different levels of logging messages. ***Note, I set the logging level to the lowest (`logging.NOTSET`) to displays all messages***.
    ```py
    import logging
    logging.basicConfig(level=logging.NOTSET)

    logging.debug('Here you have some information for debugging.')
    logging.info('Everything is normal. Relax!')
    logging.warning('Something unexpected but not important happend.')
    logging.error('Something unexpected and important happened.')
    logging.critical('OMG!!! A critical error happend and the code cannot run!')
    ```
  * > The output is something like this:
    ```console
    DEBUG:root:Here you have some information for debugging.
    INFO:root:Everything is normal. Relax!
    WARNING:root:Something unexpected but not important happend.
    ERROR:root:Something unexpected and important happened.
    CRITICAL:root:OMG!!! A critical error happend and the code cannot run!
    ```
  * > Let’s change the logging level to `WARNING`.
    ```py
    import logging
    logging.basicConfig(level=logging.WARNING)

    logging.debug('Here you have some information for debugging.')
    logging.info('Everything is normal. Relax!')
    logging.warning('Something unexpected but not important happend.')
    logging.error('Something unexpected and important happened.')
    logging.critical('OMG!!! A critical error happend and the code cannot run!')
    ```
  * > In this case, the output is:
    ```console
    WARNING:root:Something unexpected but not important happend.
    ERROR:root:Something unexpected and important happened.
    CRITICAL:root:OMG!!! A critical error happend and the code cannot run!
    ```
  * > As you see, because I set my logging level to `WARNING` (using `logging.WARNING` constant value), ***only messages with a severity of `WARNING` or higher are shown***.
  * > OK, it is good to use logging tools to display appropriate messages, but can I format my messages better that help me do betting logging of my code? The answer is YES. Let’s read the next section to format our logging messages better (and in a more meaningful way).
- > **Formatting Logging Messages**

Logging in Python: A Developer’s Guide https://blog.sentry.io/2022/07/19/logging-in-python-a-developers-guide/
- > **Getting Started with Logging in Python**
  * > The following code snippet shows how you can use all the five logging levels with the syntax:
    ```py
    logging.debug("A DEBUG Message")
    logging.info("An INFO")
    logging.warning("A WARNING")
    logging.error("An ERROR")
    logging.critical("A message of CRITICAL severity")
    ```
  * > You’ll see that the messages corresponding to `warning`, `error`, and `critical` are logged onto the console, whereas `debug` and `info` are not.
    ```console
    WARNING:root:A WARNING
    ERROR:root:An ERROR
    CRITICAL:root:A message of CRITICAL severity
    ```
    > This is because, by default, only messages corresponding to a logging level of `warning` and above are logged onto the console. However, you can modify this by configuring the logger to start logging from a specific level of your choosing.
  * > Note: In the example explained in this tutorial, all code is in the `main.py` file and when we refactor existing code or add new modules, we explicitly state `<module-name>.py` to help you follow along.
- > **How to Log to a File in Python**
  * > To set up basic logging onto a file, you can use the `basicConfig()` constructor, as shown below.
    ```py
    logging.basicConfig(level=logging.INFO, filename="py_log.log",filemode="w")

    logging.debug("A DEBUG Message")
    logging.info("An INFO")
    logging.warning("A WARNING")
    logging.error("An ERROR")
    logging.critical("A message of CRITICAL severity")
    ```
  * > Next, let’s parse the above syntax for configuring ***the `root` logger***.
    + > `level`: This is the level you’d like to start logging at. ***If this is set to `info`, then all messages corresponding to `debug` are ignored***.
    + > `filename`: The parameter filename denotes the file handler object. You can specify the name of the file to log onto.
    + > `filemode`: This is an optional parameter specifying the mode in which you’d like to work with the log file specified by the parameter `filename`. Setting the `filemode` to it write (`w`) will overwrite the logs every time the module is run. The default `filemode` is append (`a`) which means you’ll have a log record of events across all runs of the program.
  * > After running the `main` module, you’ll see that the log file `py_log.log` has been created in the current working directory. <br> ![](https://images.ctfassets.net/em6l9zw4tzag/7sfKpSWxY3M1naUcXnUISi/b25557aa7d2bc00796c6d9e48a8b03e4/logging-in-python-image3.png)
  * > Since we set the logging level to `info`, the log record now contains the message corresponding to `INFO`. <br> ![](https://images.ctfassets.net/em6l9zw4tzag/5Grtb1S0BFPgyut4T3nTd7/e7ffad26b8fa052e0b797079026347b9/logging-in-python-image1.png)
  * > The logs in the log file are of the format: `<logging-level>:<name-of-the-logger>:<message>`. The `<name-of-the-logger>` is by default ***the `root` logger***, as we haven’t yet configured custom loggers. <br> ![](https://images.ctfassets.net/em6l9zw4tzag/5Qgo39czWWL1c1yd2wkAKA/c5a6a61024a3443af3aed34cadc825dd/logging-in-python-image2.png)
  * > In addition to the above basic info, you may also want to record the timestamp at which a particular message was logged to make it easier when examining the logs. You can do this by specifying the `format` parameter in the constructor, as shown below.
    ```py
    logging.basicConfig(level=logging.INFO, filename="py_log.log",filemode="w",
                        format="%(asctime)s %(levelname)s %(message)s")
    logging.debug("A DEBUG Message")
    logging.info("An INFO")
    logging.warning("A WARNING")
    logging.error("An ERROR")
    logging.critical("A message of CRITICAL severity")
    ```
    > ![](https://images.ctfassets.net/em6l9zw4tzag/5oI11PNdFgUvltVuZP5hY0/65c21a1019c4e222616efcc1e18e28cf/logging-in-python-image6.png)
  * > There are many other [log record attributes](https://docs.python.org/3/library/logging.html#logrecord-attributes) you can use to customize the way the messages appear in the log file. While setting up the `root` logger as explained above, ***please be sure to run `logging.basicConfig()` only once*** — typically at the beginning of the program before logging. Subsequent calls do not change anything unless you set the parameter `force` to `True`.
- > **Logging Variables and Exceptions in Python**
  * > Now, let’s modify the `main.py` file. Say, there are two variables x and y, and we’d like to compute the value of x/y. We know that we’ll run into `ZeroDivisionError` when y = 0. We can handle this as an exception using the `try` and `except` blocks.

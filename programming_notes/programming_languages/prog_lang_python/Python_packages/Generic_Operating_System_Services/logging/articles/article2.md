
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
  * > ***The default level is `WARNING` (i.e. `30`)*** which means, ***the logging module only displays/logs events with warning, error, or critical severity***. Again, remember that you can set your logging level using `logging.basicConfig()`.
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

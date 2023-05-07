
# 1

Share data between C and Python with this messaging library https://opensource.com/article/20/3/zeromq-c-python

## 文章个人实战

***`libfancyhw.h`***
```c
#ifndef LIBFANCYHW_H
#define LIBFANCYHW_H

#include <stdlib.h>
#include <stdint.h>
// This is the fictitious hardware interfacing library
void fancyhw_init(unsigned int init_param)
{
    srand(init_param);
}
int16_t fancyhw_read_val(void)
{
    return (int16_t)rand();
}
#endif
```

***`hw_interface.c`***
```c
// For printf()
#include <stdio.h>
// For EXIT_*
#include <stdlib.h>
// For memcpy()
#include <string.h>
// For sleep()
#include <unistd.h>

#include <zmq.h>
#include "libfancyhw.h"

int main(void)
{
    const unsigned int INIT_PARAM = 12345;
    const unsigned int REPETITIONS = 10;
    const unsigned int PACKET_SIZE = 16;
    const char *TOPIC = "fancyhw_data";

    fancyhw_init(INIT_PARAM);

    void *context = zmq_ctx_new();

    if (!context)
    {
        printf("ERROR: ZeroMQ error occurred during zmq_ctx_new(): %s\n", zmq_strerror(errno));
        return EXIT_FAILURE;
    }

    void *data_socket = zmq_socket(context, ZMQ_PUB);
    const int rb = zmq_bind(data_socket, "tcp://*:5555");

    if (rb != 0)
    {
        printf("ERROR: ZeroMQ error occurred during zmq_ctx_new(): %s\n", zmq_strerror(errno));
        return EXIT_FAILURE;
    }

    const size_t topic_size = strlen(TOPIC);
    const size_t envelope_size = topic_size + 1 + PACKET_SIZE * sizeof(int16_t);
    printf("Topic: %s; topic size: %zu; Envelope size: %zu\n", TOPIC, topic_size, envelope_size);

    for (unsigned int i = 0; i < REPETITIONS; i++)
    {
        int16_t buffer[PACKET_SIZE];
        for (unsigned int j = 0; j < PACKET_SIZE; j++)
        {
            buffer[j] = fancyhw_read_val();
        }
        printf("Read %u data values\n", PACKET_SIZE);

        zmq_msg_t envelope;
        const int rmi = zmq_msg_init_size(&envelope, envelope_size);
        if (rmi != 0)
        {
            printf("ERROR: ZeroMQ error occurred during zmq_msg_init_size(): %s\n", zmq_strerror(errno));
            zmq_msg_close(&envelope);
            break;
        }
        
        memcpy(zmq_msg_data(&envelope), TOPIC, topic_size);
        memcpy((void*)((char*)zmq_msg_data(&envelope) + topic_size), " ", 1);
        memcpy((void*)((char*)zmq_msg_data(&envelope) + 1 + topic_size), buffer, PACKET_SIZE * sizeof(int16_t));
    
        const size_t rs = zmq_msg_send(&envelope, data_socket, 0);
        if (rs != envelope_size)
        {
            printf("ERROR: ZeroMQ error occurred during zmq_msg_send(): %s\n", zmq_strerror(errno));
            zmq_msg_close(&envelope);
            break;
        }
    
        zmq_msg_close(&envelope);
        printf("Message sent; i: %u, topic: %s\n", i, TOPIC);
        sleep(1);
    }

    const int rc = zmq_close(data_socket);
    if (rc != 0)
    {
        printf("ERROR: ZeroMQ error occurred during zmq_close(): %s\n", zmq_strerror(errno));
        return EXIT_FAILURE;
    }

    const int rd = zmq_ctx_destroy(context);
    if (rd != 0)
    {
        printf("Error occurred during zmq_ctx_destroy(): %s\n", zmq_strerror(errno));
        return EXIT_FAILURE;
    }
    return EXIT_SUCCESS;
}
```

***`online_analysis.py`***
```py
#!/usr/bin/env python3

import zmq
import struct

topic = "fancyhw_data".encode('ascii')
print("Reading messages with topic: {}".format(topic))

with zmq.Context() as context:
    socket = context.socket(zmq.SUB)
    socket.connect("tcp://127.0.0.1:5555")
    socket.setsockopt(zmq.SUBSCRIBE, topic)

    i = 0
    try:
        while True:
            binary_topic, data_buffer = socket.recv().split(b' ', 1)

            topic = binary_topic.decode(encoding = 'ascii')
            print("Message {:d}:".format(i))
            print("\ttopic: '{}'".format(topic))

            packet_size = len(data_buffer) // struct.calcsize("h")
            print("\tpacket size: {:d}".format(packet_size))

            struct_format = "{:d}h".format(packet_size)
            data = struct.unpack(struct_format, data_buffer)
            print("\tdata: {}".format(data))

            i += 1

    except KeyboardInterrupt:
        socket.close()
    except Exception as error:
        print("ERROR: {}".format(error))
        socket.close()
```

```sh
apt update
apt install -y clang libzmq5 libzmq3-dev python3 python3-zmq

apt install -y python3-pip
python3 -m pip install zmq

$ ls
hw_interface.c  libfancyhw.h  online_analysis.py
$
$ clang -std=c99 -I. hw_interface.c -lzmq -o hw_interface
$ ls
hw_interface  hw_interface.c  libfancyhw.h  online_analysis.py
$
$ chmod +x online_analysis.py
```

```sh
# 窗口2
$ ./online_analysis.py
Reading messages with topic: b'fancyhw_data'


# 窗口1
$ ./hw_interface
Topic: fancyhw_data; topic size: 12; Envelope size: 45
Read 16 data values
Message sent; i: 0, topic: fancyhw_data
Read 16 data values
Message sent; i: 1, topic: fancyhw_data
Read 16 data values
Message sent; i: 2, topic: fancyhw_data
Read 16 data values
Message sent; i: 3, topic: fancyhw_data
Read 16 data values
Message sent; i: 4, topic: fancyhw_data
Read 16 data values
Message sent; i: 5, topic: fancyhw_data
Read 16 data values
Message sent; i: 6, topic: fancyhw_data
Read 16 data values
Message sent; i: 7, topic: fancyhw_data
Read 16 data values
Message sent; i: 8, topic: fancyhw_data
Read 16 data values
Message sent; i: 9, topic: fancyhw_data
$


# 窗口2
Message 0:
	topic: 'fancyhw_data'
	packet size: 16
	data: (20946, -23616, 9865, 31416, -15911, -10845, -5332, 25662, 10955, -32501, -18717, -24490, -16511, -28861, 24205, 26568)
Message 1:
	topic: 'fancyhw_data'
	packet size: 16
	data: (12505, 31355, 14083, -19654, -9141, 14532, -25591, 31203, 10428, -25564, -732, -7979, 9529, -27982, 29610, 30475)
Message 2:
	topic: 'fancyhw_data'
	packet size: 16
	data: (13938, -26061, -3645, -1973, 28630, -8977, 23689, -25951, 24059, 4972, 15095, 7548, -23888, -26235, -31420, -11383)
Message 3:
	topic: 'fancyhw_data'
	packet size: 16
	data: (5120, -17337, -31037, -4021, -2805, 8908, 27182, 7623, -16656, 26450, -356, -7127, -1532, 29254, 23348, 12406)
Message 4:
	topic: 'fancyhw_data'
	packet size: 16
	data: (3193, 19704, 10434, 31824, 10727, -31413, 5873, -30750, -26440, 20969, -23202, 15208, -5266, 10914, 3825, -146)
Message 5:
	topic: 'fancyhw_data'
	packet size: 16
	data: (-6423, -27212, -4167, -9228, -18303, 23015, -1605, 30577, -16071, -1961, 23451, -17603, 27293, -18737, -5197, 30487)
Message 6:
	topic: 'fancyhw_data'
	packet size: 16
	data: (967, 5237, -3225, 11695, -26175, 2648, -19055, 12921, 23617, 23280, 28129, 18351, -31342, 31954, 18205, 27772)
Message 7:
	topic: 'fancyhw_data'
	packet size: 16
	data: (4742, 14038, 18544, -13561, -28483, 16940, 17017, 20982, 14979, -25068, 3379, -23263, 21731, -1817, 7224, 22699)
Message 8:
	topic: 'fancyhw_data'
	packet size: 16
	data: (3420, 3999, -31142, -22755, 6647, 15339, -9834, 30265, -26917, 18295, -16920, 7278, -15287, 1286, -30486, -10544)

```

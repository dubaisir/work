import threading
from queue import Queue

queue = Queue()


class Producer(threading.Thread):

    def __init__(self, name):
        threading.Thread.__init__(self, name=name)
        self.data = queue

    def run(self):
        for i in range(6):
            self.data.put(i)
            print("%s is producing %d" % (self.getName(), i))
        print("thread %s has done " % (self.getName()))


class Consumer(threading.Thread):
    def __init__(self, name):
        threading.Thread.__init__(self, name=name)
        self.data = queue

    def run(self):
        for i in range(6):
            abc = self.data.get(timeout=1)
            print(" %s is consume queue %s" % (self.getName(), abc))
        print("thread %s has done" % (self.getName()))


def main():
    a = Producer("producer")
    b = Consumer("consumer")
    b.start()
    a.start()


if __name__ == '__main__':
    main()






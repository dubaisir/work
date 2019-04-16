# coding=utf-8
from ftplib import FTP
import json
import sys
import re
import os
import threading
import ftplib
import shutil
import Queue
# import queue #python3
import datetime

queue = Queue.Queue()


# queue = queue() #python3

# created by profee
# python2 this.py  config
# 如果使用Python3 需要修改队列模块


class Conf:
    ip = ""
    port = ""
    user = ""
    passwd = ""
    path = ""
    localpath = ""
    remotepath = ""
    size = ""
    firstmatch = ""
    config = sys.argv[1]
    sign = ""
    limitsign = ""
    # 取当前时间的上一分钟
    date_date = (datetime.datetime.now() - datetime.timedelta(minutes=1)).strftime("%Y%m%d%H%M")
    date_date3 = (datetime.datetime.now() - datetime.timedelta(days=3)).strftime("%Y%m%d")
    uploadpath = ""
    type = ""

    @staticmethod
    def conf():
        with open(Conf.config, "r") as Js:
            conf = json.load(Js)  # 读取json
            Conf.ip = conf.get("ip")
            Conf.port = conf.get("port")
            Conf.user = conf.get("user")
            Conf.passwd = conf.get("passwd")
            Conf.localpath = conf.get("localpath")
            Conf.remotepath = conf.get("remotepath")
            Conf.first = conf.get("first")
            Conf.type = conf.get("type")
            Conf.uploadpath = os.path.join(conf.get("localpath"), conf.get("type") + "_upload")


class Ftp:
    splitfilename = None
    remotefile1 = None
    locfilename = None
    date_date = None
    checkfile = None
    rownum = 0

    def connect(self):  # 连接ftp
        try:
            self.ftp = FTP()
            self.ftp.connect(Conf.ip, Conf.port)
            self.ftp.login(Conf.user, Conf.passwd)
            self.ftp.getwelcome()
        except:
            print("ftp连接告警")
            msg = "ftp连接失败"
            os.system("sh /app/common/script/power/vgop_sjzx_chk_alarm.sh %s " % msg)
            self.ftp.connect(Conf.ip, Conf.port)
            self.ftp.login(Conf.user, Conf.passwd)
            self.ftp.getwelcome()

    def uploadfile(self, filepath, type):
        busize = 1024
        for filename in os.listdir(filepath):
            if re.match(".*%s$" % type, filename):  # 匹配文件名
                # 设置远程文件名
                remotefile = os.path.join(Conf.remotepath, Conf.date_date[0:8], filename + ".tmp")
                remotefile1 = os.path.join(Conf.remotepath, Conf.date_date[0:8], filename)
                with open(os.path.join(filepath, filename), "r") as fp:
                    try:
                        # 创建远程文件夹
                        self.ftp.mkd(os.path.join(Conf.remotepath, Conf.date_date[0:8]))
                        try:
                            # 删除远程文件以及文件夹
                            for delnamelist in self.ftp.nlst(os.path.join(Conf.remotepath, Conf.date_date3)):
                                print("删除%s" % delnamelist)
                                self.ftp.delete(delnamelist)
                            print("删除文件夹")
                            self.ftp.rmd(os.path.join(Conf.remotepath, Conf.date_date3))
                        except ftplib.error_perm as e:
                            print(e.args)
                    except ftplib.error_perm:
                        pass
                    # FTP数据文件到远程
                    self.ftp.storbinary('STOR ' + remotefile, fp, busize)
                    self.ftp.rename(remotefile, remotefile1)

    def rmfile(self):
        # 删除本地文件夹
        shutil.rmtree(os.path.join(Conf.uploadpath, Conf.date_date))


class Gzfile:

    def gzfile(self, fn_in):
        # 使用gzip 命令压缩
        os.system("gzip %s" % fn_in)
        # 队列启到阻塞作用
        queue.put(1)

    def gzthread(self):
        i = 0
        count = 0
        gz_path = os.path.join(Conf.uploadpath, Conf.date_date)
        if not os.path.exists(gz_path):
            # 创建压缩目录
            os.makedirs(gz_path)
        for filename in os.listdir(Conf.localpath):
            if re.match("^%s.%s.*csv$" % (Conf.type, Conf.date_date), filename):
                # 将本地文件移动到压缩目录（分钟目录）
                shutil.move(Conf.localpath + filename, gz_path)
                i += 1
                gz_file = Gzfile()
                # 每个文件对应一个线程，线程负责发送gzip命令
                thread_name = threading.Thread(target=gz_file.gzfile, args=(os.path.join(gz_path, filename),))
                thread_name.start()
        print("文件数量为%s个" % i)
        while count < i:
            count += 1
            # 有多少文件就从队列里面get多少次  以此判断线程执行结束
            queue.get()
        # 不足10个文件 则告警
        if i >= 5:
            pass
        else:
            print("文件数量不足告警")
            msg = "%s文件数量不足" % Conf.type
            os.system("sh /app/common/script/power/vgop_sjzx_chk_alarm.sh %s" % msg)

    def checkfile(self, filepath):
        sizecount = 0
        # 设置check文件文件名
        checkfile = os.path.join(filepath, Conf.type + "_" + Conf.date_date + ".chk")
        with open(checkfile, 'a+') as check:
            for filename in os.listdir(filepath):
                if re.match(".*gz", filename):
                    # 获取每个压缩文件的大小，并累加当前批次
                    size = os.path.getsize(os.path.join(filepath, filename))
                    sizecount = sizecount + size
                    # 生成check文件
                    check.write(filename + "," + str(size) + "\n")
        print("当前时间为:  " + Conf.date_date)
        print("数据总量 ： " + str(sizecount))
        if sizecount < 500:
            print("文件全部为空文件告警")
            msg = " %s文件全部为空文件" % Conf.type
            os.system("sh /app/common/script/power/vgop_sjzx_chk_alarm.sh %s " % msg)


if __name__ == '__main__':
    conff = Conf()
    conff.conf()  # 解析配置文件
    gz = Gzfile()
    gz.gzthread()  # 启动线程
    gz.checkfile(os.path.join(Conf.uploadpath, Conf.date_date))  # 生成check文件
    load = Ftp()
    load.connect()  # 连接FTP
    load.uploadfile(os.path.join(Conf.uploadpath, Conf.date_date), "gz")  # 先上传压缩数据文件
    load.uploadfile(os.path.join(Conf.uploadpath, Conf.date_date), "chk")  # 后上传核查文件
    load.rmfile()  # 删除本地文件

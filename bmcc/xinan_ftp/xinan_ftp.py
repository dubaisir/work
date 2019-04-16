# coding=utf-8
from ftplib import FTP
import json
import sys
import re
import os
import socket
import datetime
import time
import shutil


class Conf:
    ip = ""
    port = ""
    user = ""
    passwd = ""
    hdfspath = ""
    localpath = ""
    rollsize = ""
    rolltime = ""
    prefix = ""
    suffix = ""
    config = sys.argv[1]
    hostname = []
    localhostname = ""

    @staticmethod
    def conf():
        with open(Conf.config, "r") as Js:
            conf = json.load(Js)  # 读取json
            Conf.ip = conf.get("ip")
            if Conf.ip == "localhost":
                Conf.ip = socket.gethostbyname(socket.gethostname())
            Conf.port = conf.get("port")
            Conf.user = conf.get("user")
            Conf.passwd = conf.get("passwd")
            Conf.localpath = conf.get("localpath")
            Conf.hdfspath = conf.get("hdfspath")
            Conf.rollsize = conf.get("rollsize")
            Conf.rolltime = conf.get("rolltime")
            Conf.prefix = conf.get("prefix")
            Conf.suffix = conf.get("suffix")
            Conf.hostname = conf.get("hostname")
            Conf.localhostname = socket.gethostname()


class Ftp:
    remotefile1 = None
    locfilename = None
    date_date = None

    def connect(self):  # 连接ftp
        self.ftp = FTP()
        self.ftp.connect(Conf.ip, Conf.port)
        self.ftp.login(Conf.user, Conf.passwd)
        print(self.ftp.getwelcome())

    @staticmethod
    def get_new_filename():
        filename_time = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
        file_new_name = os.path.join(Conf.hdfspath,Conf.localhostname + "_" + Conf.prefix + "_" + filename_time + "_" + Conf.suffix)
        return file_new_name

    def get_size(self, path):
        ftp=Ftp()
        list1 = []
        fileList = os.listdir(path)  # 获取path目录下所有文件
        for filename in fileList:
            pathTmp = os.path.join(path, filename)  # 获取path与filename组合后的路径
            if os.path.isdir(pathTmp):  # 判断是否为目录
                ftp.get_size(pathTmp)  # 是目录就继续递归查找
            elif os.path.isfile(pathTmp):  # 判断是否为文件
                filesize = os.path.getsize(pathTmp)  # 如果是文件，则获取相应文件的大小
                list1.append(filesize)  # 将文件的大小添加到列表
        return sum(list1)

    def mv_file(self):
        ftp=Ftp()
        mv_path = os.path.join(Conf.localpath, ftp.get_min_size())
        try:
            for filename in os.listdir(Conf.localpath):
                if os.path.isdir(os.path.join(Conf.localpath,filename)):
                    pass
                else:
                    shutil.move(os.path.join(Conf.localpath, filename), mv_path)
        except:
            print(datetime.datetime.now().strftime("%Y-%m-%d %H:%M") + "Mv error")

    def get_min_size(self):
        ftp=Ftp()
        dict1 = {}
        for hostname in Conf.hostname:
            dirsize = ftp.get_size(os.path.join(Conf.localpath, hostname))
            dict1[hostname] = dirsize
        return min(dict1, key=dict1.get)

    def uploadfile(self, localpath, prefix, suffix):
        ftp=Ftp()
        busize = 1024
        start_time = time.time()
        size = 0
        remotefilename = ftp.get_new_filename()
        for filename in os.listdir(os.path.join(localpath,Conf.localhostname)):
            print(filename)
            if re.match("%s.*%s" % (prefix, suffix), filename):  # 匹配文件名
                file_size = os.path.getsize(os.path.join(localpath,Conf.localhostname, filename))
                size += file_size
                print(size)
                print(Conf.rollsize)
                size_sign = size - Conf.rollsize >= 0
                task_time = time.time()
                time_sign = task_time - start_time >= Conf.rolltime
                print(filename + "uploading")
                with open(os.path.join(localpath,Conf.localhostname, filename), "r") as fp:
                    try:
                        self.ftp.storbinary('APPE ' + remotefilename , fp, busize)
                        os.remove(os.path.join(localpath,Conf.localhostname, filename))
                        if size_sign or time_sign:
                            start_time = time.time()
                            size = 0
                            remotefilename = ftp.get_new_filename()
                    except IOError:
                        print("IOError,Maybe no enough space or network anormaly")



if __name__ == '__main__':
    conff = Conf()
    conff.conf()  # 解析配置文件
    on = Ftp()
    on.mv_file()
    on.connect()
    on.uploadfile(Conf.localpath, Conf.prefix, Conf.suffix)
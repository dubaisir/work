# coding=utf-8
import os, datetime

day = (datetime.datetime.now() - datetime.timedelta(days=-1)).strftime("%Y-%m-%d")
month = (datetime.datetime.now() - datetime.timedelta(days=-1)).strftime("%Y-%m")
print(day)
try:
    if 0 < (datetime.datetime.now() - datetime.timedelta(days=-1)).isoweekday() < 7:
        os.mkdir('C:\\Users\\Administrator\\Desktop\\work_record\\%s\\%s' % (month, day))
        # print('C:\\Users\\Administrator\\Desktop\\work_record\\%s\\%s' %(month,day))
        print('ok')
    else:
        print('非工作日')
except:
    pass

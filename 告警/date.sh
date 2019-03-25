#!/bin/bash
\
#昨日
yesterday=`date -d '1 days ago' +%Y%m%d`
yesterday2=`date -d yesterday +%Y%m%d`

#今日
today=`date +%Y-%m-%d`

year=`date +%Y`
month=`date +%m`
day=`date +%d`

#当前周的第几天
whichday=$(date -d $today +%w)

#当周的周一
monday=`date -d "$today -$[${whichday}-1] days" +%Y-%m-%d`

#上周的周一
last_monday=`date -d "$monday-7days"  +%Y-%m-%d `

#当周的周日
sunday=`date -d "$monday+6 days" +%Y-%m-%d`

#当月第一天(这里取巧用了01直接代替当月第一天的日期)
firstdate=`date +%Y%m01`

#当月最后一天(当月第一天的后一个月第一天的前一天就是当月最后一天，有点绕)
lastdate=`date -d"$(date -d"1 month" +%Y%m01) -1 day" +%Y%m%d`


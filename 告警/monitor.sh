#!/bin/bash

    workdir=$(cd `dirname $0`; pwd)
    #导入工具包
    source ${workdir}/conf.sh
    #导入日期包
    source ${workdir}/date.sh


    #取字符串日期
    last_monday=\'${last_monday}\'
    monday=\'${monday}\'
    
    #遍历tablelist 取分区数据条数
      cat ${workdir}/tables |while read table person
   do
      #取HIVE结果
      countstring=$( beeline -u jdbc:hive2://10.240.4.221:10000/default -n zhangpan1 -p hdjd2015 -e "
                          select * from (select count(*) from ${table} where load_date=${last_monday}) a 
                                       left join (select count(*) from ${table} where load_date=${monday}) b on 1=1")
         if [ $? -eq 0 ]; then
          
            #处理结果
            last_count=$(echo ${countstring} |awk -F\| '{print $5}')
            curr_count=$(echo ${countstring} |awk -F\| '{print $6}')
          
            #取差值
            ((D_V=${curr_count}-${last_count}))
            #取UUID
            uuid=$(cat /proc/sys/kernel/random/uuid)
            #根据表名取前缀hv_e0  hv_e1  hv_e2  hv_app
            dbname=$(echo $table |awk -F\. '{print $1}' |awk -F_ '{print $1}'|tr [a-z] [A-Z])
            if   [ $dbname == 'ODS' ];then
                  pre=hv_e0
            elif [ $dbname == 'DWD' ];then
                  pre=hv_e1
            elif [ $dbname == 'DWS' -o $dbname == 'DIM' ];then
                  pre=hv_e2
            elif [ $dbname == 'APP' ];then
                  pre=hv_app
            fi
            #取任务名称
            task_name=$(echo $table → ${pre}_$table |sed s/\\./_/2)
         echo ${uuid}\|${person}\|${table}周分区增加数据条数：${D_V}\|${day}\|${task_name} >> monitor_${today}.dat

         else

           echow  HIVE-failed 
           exit 1
         fi
   done

 echoo  OK

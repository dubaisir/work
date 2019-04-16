#!/bin/bash
basedir=$(dirname $0)
source ${basedir}/common.sh

hive_calc(){
  source ${tmp_hive_task_file}
  if [ $? -ne 0 ];then
      err "HIVE failed"
      # show_log
      exit ${EXE_FAILED}
  fi
  echo "HQL: ""${sql}"
  
  log_path=$LOG_PATH/${hive_task_name}_${second_str}_${RANDOM}.log
  echo "Log path: "${log_path}
  
  if [ x"${sql}" == "xdo_nothing" ];then
    err "HIVE DO_NOTHING"
  else
#    hive -e "set mapred.reduce.slowstart.completed.maps=0.6;set dfs.namenode.fs-limits.max-component-length=500;set hive.support.sql11.reserved.keywords=false;set mapreduce.job.name=${hive_task_name}_${second_str}_${RANDOM};${sql}" > ${log_path} 2>&1
#    hive -e "set mapreduce.job.name=${hive_task_name}_${second_str}_${RANDOM};${sql}" > ${log_path} 2>&1
     beeline -u "${HIVE_BEELINE_URL}" -n "${HADOOP_USER_NAME}" -p "${HIVE_BEELINE_PASSWORD}" -e "set mapreduce.job.name=${hive_task_name}_${second_str}_${RANDOM};${sql}" > ${log_path} 2>&1

    if [ $? -ne 0 ];then
      err "HIVE failed"
      #	show_log   
      exit ${EXE_FAILED}
    fi
  fi
  if [ $? -ne 0 ];then
    err "HIVE failed"
    exit ${EXE_FAILED}
  fi
    #remove distrube cache file
    #lzo index
}
main(){
  hive_task_path="$1"
  hive_task_name="$2"
  hive_task_file=${hive_task_path}/${hive_task_name}.conf
  param_read "$@";
  param_init;
 
  tmp_hive_task_file=${TASK_HOME}/tmp/hive/${hive_task_name}.conf
  
  sed 's/\r//g' ${hive_task_file} > ${tmp_hive_task_file}
  if [ $? -ne 0 ];then
      err "HIVE failed"
      # show_log
      exit ${EXE_FAILED}
  fi 
  source ${tmp_hive_task_file}
  if [ $? -ne 0 ];then
      err "HIVE failed"
      # show_log
      exit ${EXE_FAILED}
  fi 
  
  echo x"$task_incre_type"
  if [ "x$task_incre_type" == "xmulti-day" ];
    then
      echo "multi"
      hive_calc
  else
    echo "one-day"
    n=0;
    if [ "x$prune_day" == "x" ];
      then prune_day=0
    fi
    n=$[$n-$prune_day]
    while :;
    do
      datekey=$(date +%Y-%m-%d -d"${START_DATEKEY} +$n day");
      shortdatekey=`echo $datekey|sed s/-//g`
      if [[ $datekey > ${END_DATEKEY} || $datekey == ${END_DATEKEY} ]];
        then
          break
      else
        echo ${shortdatekey}
        echo ${datekey};
        hive_calc
      fi
      ((n++));
    done
  fi
}
main "$@"

#!/bin/bash
source /etc/profile
source ~/.bash_profile
USER_HOME=/home/kaifa
DATA_ROOT_PATH=$USER_HOME
#export HADOOP_USER_NAME=leiyifei
#HADOOP_STREAMING_JAR="$HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-2.7.1.jar"

#COURIER_HOME="${USER_HOME}/app/courier"
KYLINJOB_HOME="${USER_HOME}/app/kylin"
DATAX_HOME="${USER_HOME}/datax"
#EXCEL_EXPORTER_HOME="${USER_HOME}/app/excel"
#FTP_HOME="${USER_HOME}/app/ftp"

TASK_HOME="${USER_HOME}/task_bak"
TEMP_TASK_DIR="${USER_HOME}/task_bak/tmp"
DATA_PATH="${DATA_ROOT_PATH}/data"
LOG_PATH="${USER_HOME}/logs"

AZKABAN_AGENT_HOME="${USER_HOME}/app/azkabanagent"

HDFS_FILE_USER="hdfs"
#HDFS_CONF_FILE='{"config-resources":[{"resource":"/software/conf/sre/hadoop_conf/hdfs-site.xml"},{"resource":"/software/conf/sre/hadoop_conf/core-site.xml"},{"resource":"/software/conf/sre/hadoop_conf/mapred-site.xml"},{"resource":"/software/conf/sre/hadoop_conf/yarn-site.xml"},{"resource":"/software/conf/sre/hadoop_conf/fair-scheduler.xml"},{"resource":"/software/conf/sre/hadoop_conf/tez-site.xml"},{"resource":"/software/conf/sre/hadoop_conf/capacity-scheduler.xml"}]}'
#HIVE_CONF_FILE='{"config-resources":[{"resource":"/software/conf/sre/hive_conf/hive-site.xml"}]}'
cm1_nn_status=`export HADOOP_USER_NAME=hdfs && hdfs haadmin -getServiceState namenode270`
HDFS_ROOT_URI="hdfs://10.240.4.30:8020"
if [ x"${cm1_nn_status}" == "xstandby" ]
  then
    HDFS_ROOT_URI="hdfs://10.240.4.31:8020"
fi
HDFS_HV_INNERTB_ROOT="/user/hive/warehouse/"
HDFS_HV_EXTTB_ROOT="/user/kaifa/"
#HIVE_BEELINE_URL="jdbc:hive2://10.240.4.221:10000/default"
export HIVE_BEELINE_URL="jdbc:hive2://10.240.4.221:10000/default"

source /etc/profile
source ~/.bash_profile
source ${AZKABAN_AGENT_HOME}/connection.sh
source ${AZKABAN_AGENT_HOME}/hive_db.sh

yestoday=`date +%Y-%m-%d -d "1 days ago"`
today=`date +%Y-%m-%d`
EXE_FAILED=1
second_str=`date +'%Y%m%d%H%M%S'`
err(){
        echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

param_read(){
  for param in "$@";do
    echo $param
    if [ `echo $param | grep -E '^-param:'` ];
      then
        export `echo $param| sed s/-param://g`
    fi
  done
}

param_init(){

  if [ x"${EXECUTION_ID}" == "x" ];
    then
      EXECUTION_ID=0
  fi
  if [ x"${LAST_EXTRACT_DAY}" == "x" ]
    then
      LAST_EXTRACT_DAY=${yestoday}
  fi
  if [ x"${CURRENT_FLOW_START_DAY}" == "x" ]
    then
      CURRENT_FLOW_START_DAY=${today}
  fi

  SHORT_LAST_EXTRACT_DAY=`echo $LAST_EXTRACT_DAY|sed s/-//g`
  SHORT_CURRENT_FLOW_START_DAY=`echo $CURRENT_FLOW_START_DAY|sed s/-//g`
  SHORT_START_DATEKEY=`echo $START_DATEKEY|sed s/-//g`
  SHORT_END_DATEKEY=`echo $END_DATEKEY|sed s/-//g`
  
  LAST_EXTRACT_MONTH=${LAST_EXTRACT_DAY:0:7}
  CURRENT_FLOW_START_MONTH=${CURRENT_FLOW_START_DAY:0:7}
  START_MONTHKEY=${START_DATEKEY:0:7}
  END_MONTHKEY=${END_DATEKEY:0:7}
  
  SHORT_LAST_EXTRACT_MONTH=${SHORT_LAST_EXTRACT_DAY:0:6}
  SHORT_CURRENT_FLOW_START_MONTH=${SHORT_CURRENT_FLOW_START_DAY:0:6}
  SHORT_START_MONTHKEY=${SHORT_START_DATEKEY:0:6}
  SHORT_END_MONTHKEY=${SHORT_END_DATEKEY:0:6}
  SHORT_CURRENT_FLOW_START_MONTH=${SHORT_CURRENT_FLOW_START_DAY:0:6}
}

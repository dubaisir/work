use ${HIVE_DB_ODS_DIM};
CREATE EXTERNAL TABLE `traffic_flow`(
  `id` int comment '',
  `project_id` string comment '',
  `traffice_flow` int comment '',
  `user_code` string comment '',
  `remark` string comment '',
  `biz_date` string comment '',
  `create_time` string comment '',
  `update_time` string comment '',
  `op_time` string comment 'op_time',
  `execution_id` string comment '执行批次')
PARTITIONED BY (
  `load_date` string)
STORED AS ORC
LOCATION
  '${HDFS_HV_EXTTB_ROOT}/${HIVE_DB_ODS_DIM}/traffic_flow';

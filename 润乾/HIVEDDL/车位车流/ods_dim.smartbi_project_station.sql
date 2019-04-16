use ${HIVE_DB_ODS_DIM};
CREATE EXTERNAL TABLE `smartbi_project_station`(
  `projectname` string comment '项目名称',
  `stationnum` int comment '车位数量',
  `create_time` string comment '创建时间',
  `update_time` string comment '更新时间',
  `op_time` string comment 'op_time',
  `execution_id` string comment '执行批次')
PARTITIONED BY (
  `load_date` string)
STORED AS ORC
LOCATION
  '${HDFS_HV_EXTTB_ROOT}/${HIVE_DB_ODS_DIM}/smartbi_project_station';

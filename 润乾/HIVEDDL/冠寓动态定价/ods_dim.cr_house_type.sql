use ${HIVE_DB_ODS_DIM};
CREATE EXTERNAL TABLE `cr_house_type`(
  `housetype`          string        comment '房型名称',
  `house_type_desc`    string        comment '房型代码',
  `create_time`        string        comment '创建时间',
  `update_time`        string        comment '更新时间',
  `op_time`            string        comment 'op_time',
  `execution_id`       string        comment '执行批次')
PARTITIONED BY (
  `load_date` string)
STORED AS ORC
LOCATION
  '${HDFS_HV_EXTTB_ROOT}/${HIVE_DB_ODS_DIM}/cr_house_type';

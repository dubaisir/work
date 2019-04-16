use ${HIVE_DB_DWD_DIM};
CREATE TABLE `dim_traffic_flow`(
  `id` int comment '',
  `project_id` string comment '',
  `traffice_flow` int comment '',
  `user_code` string comment '',
  `remark` string comment '',
  `biz_date` string comment '',
  `create_time` string comment '',
  `update_time` string comment '',
  `op_time` string comment 'op_time',
  `execution_id` string comment '执行批次',
  `load_date` string comment '入库时间')
STORED AS PARQUET;

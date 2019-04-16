use ${HIVE_DB_ODS_DIM};
CREATE EXTERNAL TABLE `smartbi_project_weight`(
  `the_year` string comment '年份',
  `the_month` string comment '年月',
  `projectname` string comment '项目名称',
  `stage` string comment '项目成熟阶段',
  `quotaname` string comment '指标名称',
  `weight` string comment '权重',
  `score100` string comment '100分',
  `score90` string comment '90分',
  `score80` string comment '80分',
  `score70` string comment '70分',
  `score0` string comment '0分',
  `type` string comment '类型（项目、集团）',
  `create_time` string comment '创建时间',
  `update_time` string comment '更新时间',
  `op_time` string comment 'op_time',
  `execution_id` string comment '执行批次')
PARTITIONED BY (
  `load_date` string)
STORED AS ORC
LOCATION
  '${HDFS_HV_EXTTB_ROOT}/${HIVE_DB_ODS_DIM}/smartbi_project_weight';

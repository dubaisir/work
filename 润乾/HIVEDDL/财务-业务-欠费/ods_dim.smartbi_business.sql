use ${HIVE_DB_ODS_DIM};
CREATE EXTERNAL TABLE `smartbi_business`(
  `projectname` string comment '项目名称',
  `quotaname` string comment '指标名称',
  `january` double comment '1月',
  `february` double comment '2月',
  `march` double comment '3月',
  `april` double comment '4月',
  `may` double comment '5月',
  `june` double comment '6月',
  `july` double comment '7月',
  `august` double comment '8月',
  `september` double comment '9月',
  `october` double comment '10月',
  `november` double comment '11月',
  `december` double comment '12月',
  `create_time` string comment '创建时间',
  `update_time` string comment '更新时间',
  `op_time` string comment 'op_time',
  `execution_id` string comment '执行批次')
PARTITIONED BY (
  `load_date` string)
STORED AS ORC
LOCATION
  '${HDFS_HV_EXTTB_ROOT}/${HIVE_DB_ODS_DIM}/smartbi_business';

use ${HIVE_DB_ODS_DIM};
CREATE EXTERNAL TABLE `smartbi_arrearage`(
  `the_month` string comment '月份',
  `projectname` string comment '项目',
  `contractno` string comment '合同编号',
  `expenditurename` string comment '费项',
  `pay_time` string comment '应缴时间',
  `pay_amt` double comment '欠费金额',
  `accepted_amt` double comment '已收保证金',
  `create_time` string comment '创建时间',
  `update_time` string comment '更新时间',
  `op_time` string comment 'op_time',
  `execution_id` string comment '执行批次')
PARTITIONED BY (
  `load_date` string)
STORED AS ORC
LOCATION
  '${HDFS_HV_EXTTB_ROOT}/${HIVE_DB_ODS_DIM}/smartbi_arrearage';

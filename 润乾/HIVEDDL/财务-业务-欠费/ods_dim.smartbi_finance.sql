use ${HIVE_DB_ODS_DIM};
CREATE EXTERNAL TABLE `smartbi_finance`(
  `the_year` string comment '年',
  `the_month` string comment '年月',
  `regionname` string comment '地区名称',
  `projectname` string comment '项目名称',
  `expenditureid` string comment '费项id',
  `expenditurename` string comment '费项名称',
  `last_month` double comment '上月实际',
  `cur_month` double comment '当月实际',
  `year_bud_app` double comment '年初预算审批版',
  `bud_dev` double comment '预算偏差',
  `bud_fin` double comment '预算达成率',
  `last_y_curmonth` double comment '去年当月实际',
  `fac_inc_amt` double comment '实际增长额',
  `fac_inc_rate` double comment '实际增长率',
  `cur_y_sum` double comment '本年实际累计',
  `year_bud_sum` double comment '累计年初预算',
  `bud_dev_sum` double comment '预算累计偏差(实际累计-累计年初预算)',
  `bud_sum_rate` double comment '预算累计达成率',
  `last_y_sum` double comment '去年实际累计',
  `fac_inc_amt_sum` double comment '累计实际增长额(实际累计-去年累计)',
  `fac_inc_rate_sum` double comment '累计实际增长率（累计实际增长额/实际累计）',
  `all_y_bud` double comment '全年预估',
  `all_y_bud_app` double comment '全年年初预算审批',
  `all_y_bud_dev` double comment '全年预估偏差(全年预估-全年年初预算审批)',
  `all_y_bud_rate` double comment '全年预估达成率(全年预估偏差/全年年初预算审批)',
  `last_y_fac` double comment '去年全年实际',
  `all_y_bud_inc_amt` double comment '全年预估增长额(全年预估-去年全年实际)',
  `all_y_bud_inc_rate` double comment '全年预估增长率',
  `version` string comment '版本',
  `type` string comment '类型',
  `create_time` string comment '创建时间',
  `update_time` string comment '更新时间',
  `op_time` string comment 'op_time',
  `execution_id` string comment '执行批次')
PARTITIONED BY (
  `load_date` string)
STORED AS ORC
LOCATION
  '${HDFS_HV_EXTTB_ROOT}/${HIVE_DB_ODS_DIM}/smartbi_finance';

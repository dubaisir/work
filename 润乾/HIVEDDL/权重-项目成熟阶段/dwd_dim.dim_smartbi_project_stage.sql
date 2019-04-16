use ${HIVE_DB_DWD_DIM};
CREATE TABLE `dim_smartbi_project_stage`(
  `the_month` string comment '年份',
  `projectname` string comment '项目名称',
  `stage` string comment '项目成熟阶段',
  `create_time` string comment '创建时间',
  `update_time` string comment '更新时间',
  `op_time` string comment 'op_time',
  `execution_id` string comment '执行批次',
  `load_date` string comment '入库时间')
STORED AS PARQUET;

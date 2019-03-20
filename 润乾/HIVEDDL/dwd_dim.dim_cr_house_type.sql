use ${HIVE_DB_DWD_DIM};
CREATE TABLE `dim_cr_house_type`(
  `housetype`       string     comment '房型名称',
  `house_type_desc` string     comment '房型代码',
  `create_time`     string     comment '创建时间',
  `update_time`     string     comment '更新时间',
  `op_time`         string     comment 'op_time',
  `execution_id`    string     comment '执行批次',
  `load_date`       string     comment '入库时间')
STORED AS PARQUET;

use ${HIVE_DB_ODS_DIM};
CREATE EXTERNAL TABLE `location_info`(
   `id`             bigint        comment ''
  ,`sourcetable`    string        comment ''
  ,`sourcetabledsr` string        comment ''
  ,`location_type`  string        comment '坐标类型'
  ,`query_lng`      double        comment '查询经度'
  ,`query_lat`      double        comment '查询纬度'
  ,`channel`        string        comment '航道代码'
  ,`year`           string        comment '查询年'
  ,`haspolyline`    string        comment '是否包含边界'
  ,`name`           string        comment '板块名称'
  ,`code`           string        comment '板块的编码信息'
  ,`longitude`      double        comment '板块经度信息'
  ,`latitude`       double        comment '板块纬度信息'
  ,`citycode`       string        comment '板块所在的城市code'
  ,`polyline`       string        comment '板块边界'
  ,`datetime`       string        comment '板块数据时间'
  ,`plateattr`      string        comment '板块分级C1:U1、U2、C1、O1、T1、T2等C2:优先进入(A)、次优进入(B)、谨慎进入(C)、观察进入(D)'
  ,`is_finished`    string        comment '任务完成标志'
  ,`updatetime`     string        comment '更新时间'
  ,`createtime`     string        comment '创建时间'
  ,`op_time`        string        comment 'op_time'
  ,`execution_id`   string        comment '执行批次')
PARTITIONED BY (
  `load_date` string)
STORED AS ORC
LOCATION
  '${HDFS_HV_EXTTB_ROOT}/${HIVE_DB_ODS_DIM}/location_info';

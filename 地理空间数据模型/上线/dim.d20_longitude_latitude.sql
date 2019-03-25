use ${HIVE_DB_DIM};
create table  d20_longitude_latitude  (
   sourcetable                  string           comment '来源表'
  ,sourcetabledsr               string           comment '来源表描述'
  ,channel                      string           comment '航道代码'
  ,location_type                string           comment '坐标类型'
  ,lng                          double           comment '查询经度'
  ,lat                          double           comment '查询纬度'
  ,year                         string           comment '查询年'
  ,haspolyline                  boolean          comment '是否包含边界'

  ,op_time                        string           comment 'op_time'
  ,execution_id                   string           comment '执行批次'

) comment '经纬度维度表'
partitioned by (
	  load_date string comment '入库时间' )
stored as parquet;

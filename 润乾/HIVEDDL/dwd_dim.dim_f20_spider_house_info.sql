use ${HIVE_DB_DWD_DIM};
CREATE TABLE `dim_f20_spider_house_info`(
  `room_id`              string        comment '房屋id',
  `village_id`           string        comment '小区/公寓项目id',
  `village`              string        comment '小区/公寓项目名称',
  `city`                 string        comment '城市',
  `location_region`      string        comment '地区',
  `location_center`      string        comment '板块',
  `min_area`             double        comment '最小建筑面积',
  `max_area`             double        comment '最大建筑面积',
  `towards`              string        comment '朝向',
  `model`                string        comment '居室',
  `lon`                  string        comment '小区经度',
  `lat`                  string        comment '小区纬度',
  `create_time`          string        comment '创建时间',
  `update_time`          string        comment '更新时间',
  `op_time`              string        comment 'op_time',
  `execution_id`         string        comment '执行批次',
  `load_date`            string        comment '入库时间')
STORED AS PARQUET;

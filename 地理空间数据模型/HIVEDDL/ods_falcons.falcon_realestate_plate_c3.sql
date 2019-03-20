use ${HIVE_DB_ODS_FALCONS};
CREATE EXTERNAL TABLE `falcon_realestate_plate_c3`(
  `id`                   bigint          comment '主键信息'
 ,`name`                 string          comment '地产板块的名称'
 ,`code`                 string          comment '地产板块编码区县编码+板块类型+板块顺序编码其中地产板块类型01'
 ,`spell`                string          comment '板块拼音'
 ,`city_code`            string          comment '所在城市编码项目一般查询时依据城市和区县冗余存储'
 ,`city_name`            string          comment '城市名称'
 ,`center`               string          comment '板块的中心点坐标'
 ,`longitude`            double          comment '经度信息为了便于以后位置查询冗余存储'
 ,`latitude`             double          comment '纬度信息为了便于以后位置查询冗余存储'
 ,`polyline`             string          comment '行政区边界坐标点坐标串以 | 分隔 '
 ,`date_time`            string          comment '数据时间记录板块变迁每份数据都会带上时间标签，精确到年YYYY'
 ,`level`                int             comment '板块级别，分为4级：1. 战略布局； 2. 重点拓展； 3. 机会进入； 4.暂缓进入；5:其他（不同年份，数值可能不同）'
 ,`level_changed`        string          comment '板块级别是否调整，1.无变化，2.升级，3.降级'
 ,`level_changed_reason` string          comment '板块级别调整原因字符串'
 ,`composite_score`      float           comment '值域0~5保留2位小数'
 ,`plate_attr`           string          comment '板块的属性标签，客研自行配置和选择'
 ,`create_user`          string          comment '数据创建人关联我们从OA/UC同步的用户'
 ,`update_user`          string          comment '数据维护人关联我们从OA/UC同步的用户可能有多个'
 ,`create_time`          string          comment '创建时间'
 ,`update_time`          string          comment '更新时间'
 ,`del_flag`             string          comment '删除标志位，1: 删除0: 未删除'
 ,`op_time`              string          comment 'op_time'
 ,`execution_id`         string          comment '执行批次')
PARTITIONED BY (
  `load_date` string)
STORED AS ORC
LOCATION
  '${HDFS_HV_EXTTB_ROOT}/${HIVE_DB_ODS_FALCONS}/falcon_realestate_plate_c3';

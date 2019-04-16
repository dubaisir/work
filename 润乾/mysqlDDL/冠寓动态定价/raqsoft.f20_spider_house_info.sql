CREATE TABLE    raqsoft.f20_spider_house_info(
 room_id          varchar(50)      comment'房屋id'
,village_id       varchar(50)      comment'小区/公寓项目id'
,village          varchar(50)      comment'小区/公寓项目名称'
,city             varchar(50)      comment'城市'
,location_region  varchar(50)      comment'地区'
,location_center  varchar(50)      comment'板块'
,min_area         decimal(26,10)   comment'最小建筑面积'
,max_area         decimal(26,10)   comment'最大建筑面积'
,towards          varchar(50)      comment'朝向'
,model            varchar(50)      comment'居室'
,lon              varchar(50)      comment'小区经度'
,lat              varchar(50)      comment'小区纬度'

,create_time timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
,update_time timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='爬虫抓取的小区房间信息表_全量快照 '
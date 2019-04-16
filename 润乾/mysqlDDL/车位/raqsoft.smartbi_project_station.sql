CREATE TABLE raqsoft.smartbi_project_station(
   projectname         varchar(50)     comment'项目名称'
  ,stationnum          varchar(50)     comment'车位数量'

  ,create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
  ,update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
  , primary key (projectname) 
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='项目车位维度表'
  ;
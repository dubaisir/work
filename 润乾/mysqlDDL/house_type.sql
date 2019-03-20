CREATE TABLE raqsoft.cr_house_type(
   housetype        varchar(50)  default  null   comment'房型名称'
  ,house_type_desc  varchar(50)  default  null   comment'房型代码'

  ,create_time timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
  ,update_time timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='房型名称'
  ;
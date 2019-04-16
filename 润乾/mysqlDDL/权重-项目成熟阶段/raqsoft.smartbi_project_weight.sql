CREATE TABLE raqsoft.smartbi_project_weight(
   the_year          varchar(50)    comment'年份'
  ,the_month         varchar(50)    comment'年月'
  ,projectname       varchar(50)    comment'项目名称'
  ,stage             varchar(50)    comment'项目成熟阶段'
  ,quotaname         varchar(50)    comment'指标名称'
  ,weight            varchar(50)    comment'权重'
  ,score100          varchar(50)  default  null   comment'100分'
  ,score90           varchar(50)  default  null   comment'90分'
  ,score80           varchar(50)  default  null   comment'80分'
  ,score70           varchar(50)  default  null   comment'70分'
  ,score0            varchar(50)  default  null   comment'0分'
  ,type              varchar(50)  default  null   comment'类型（项目、集团）'
  ,primary key (the_year,the_month,projectname,stage,quotaname,weight)

  ,create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
  ,update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='项目阶段指标权重表'
  ;
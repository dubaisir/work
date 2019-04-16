CREATE TABLE raqsoft.smartbi_arrearage(
      the_month            varchar(20)     comment'月份'
     ,projectname          varchar(50)     comment'项目'
     ,contractno           varchar(50)     comment'合同编号'
     ,expenditurename      varchar(50)     comment'费项'
     ,pay_time             varchar(50)     comment'应缴时间'
     ,pay_amt              decimal(18,6)   comment'欠费金额'
     ,accepted_amt         decimal(18,6)   comment'已收保证金'
     
  ,create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
  ,update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
  , primary key (the_month,projectname,contractno,expenditurename) 
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='项目欠费表'
  ;
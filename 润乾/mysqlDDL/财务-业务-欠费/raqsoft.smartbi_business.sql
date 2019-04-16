CREATE TABLE raqsoft.smartbi_business(
      projectname          varchar(20)     comment'项目名称'
     ,quotaname            varchar(50)     comment'指标名称'
     ,january              decimal(18,6)   comment'1月'
     ,february             decimal(18,6)   comment'2月'
     ,march                decimal(18,6)   comment'3月'
     ,april                decimal(18,6)   comment'4月'
     ,may                  decimal(18,6)   comment'5月'
     ,june                 decimal(18,6)   comment'6月'
     ,july                 decimal(18,6)   comment'7月'
     ,august               decimal(18,6)   comment'8月'
     ,september            decimal(18,6)   comment'9月'
     ,october              decimal(18,6)   comment'10月'
     ,november             decimal(18,6)   comment'11月'
     ,december             decimal(18,6)   comment'12月'
     
  ,create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
  ,update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
  , primary key (projectname,quotaname) 
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='项目业务表'
  ;
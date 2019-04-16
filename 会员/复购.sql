select                                       
'月度项目'                                       as `表名`
,a.year                                           as `年份`
,a.the_month                                   as `年月`
,null                                            as     `日期`
,a.projectguid                                   as `项目guid`
,a.projectname                                   as `项目名称`
,a.kpi_projectguid                               as `合并项目guid`
,a.kpi_projectname                               as `合并项目名称`
,a.kpi_project_stage                           as `合并项目成熟阶段`
,a.companyguid                                    as `公司guid`
,a.companyname                                    as `公司名称`
,null                                          as `业态id`
,a.city                                          as `城市`
,a.province                                       as `省份`
,a.district_name                               as `片区名称`
,null                                          as `地区id`
,null                                         as `地区guid`
,null                                          as `地区名称`
,a.project_stage                                as `项目成熟阶段`
,a.projectopen_date                               as `项目开业日期`
,a.is_open                                       as `是否筹备期`
,a.is_save                                       as `是否存量项目`
,a.project_building_area                       as `项目建筑建筑面积(不含车库)`
,a.last_month_day                               as `当月最后一天`
,a.monthdays                                    as `当月天数`
,a.last_days                                    as `去年当月天数`
,a.total_days                                    as `当年累计天数`
,a.calculatetraffic                               as `当月客流总数`
,a.last_year_calculatetraffic                   as `去年当月客流总数`
,a.last_month_calculatetraffic                   as `上月客流总数`
,a.total_calculatetraffic                       as `当年累计当月客流总数`
,a.last_total_calculatetraffic                   as `去年同期累计当月客流总数`
,a.last_customer                               as `去年年日均客流`
,a.increase_membernum                           as `当月新增会员数`
,a.last_year_increase_membernum                   as `去年当月新增会员数`
,a.last_month_increase_membernum                  as `上月新增会员数`
,a.total_increase_membernum                       as `当年累计当月新增会员数`
,a.last_total_increase_membernum               as `去年同期累计当月新增会员数`
,a.total_membernum                               as `当前累计会员数`
,a.last_year_total_membernum                   as `去年当月当前累计会员数`
,a.last_month_total_membernum                   as `上月当前累计会员数`
,a.total_total_membernum                       as `当年累计当前累计会员数`
,a.last_total_membernum                           as `去年同期累计当前累计会员数`
,a.member_sale_amt                               as `会员营业额`
,a.last_year_member_sale_amt                   as `去年当月会员营业额`
,a.last_month_member_sale_amt                   as `上月会员营业额`
,a.total_member_sale_amt                       as `当年累计会员营业额`
,a.last_total_member_sale_amt                   as `去年同期累计会员营业额`
,a.sale_count                                   as `当月会员消费次数`
,a.last_year_sale_count                           as `去年当月会员消费次数`
,a.last_month_sale_count                       as `上月会员消费次数`
,a.total_member_sale_count                       as `当年累计会员消费次数`
,a.last_total_sale_count                       as `去年同期累计会员消费次数`
,a.is_active                                   as `6个月活跃度`
,a.is_dead                                       as `死卡人数`
,a.is_consum                                   as `6个月消费人数`
,a.last_total_member                           as `年初累计会员数`
,a.saleamt                                     as `营业额`
,a.last_year_saleamt                           as `去年当月营业额`
,a.last_month_saleamt                           as `上月营业额`
,a.total_saleamt                               as `当年累计营业额`
,a.last_total_saleamt                           as `去年同期累计营业额`
,null                                           as `上月累计营业额`
,a.salenum                                       as `营业笔数`
,a.last_year_salenum                           as `去年营业笔数`
,a.last_month_salenum                           as `上月营业笔数`
,a.total_salenum                               as `当年累计营业笔数`
,a.last_total_salenum                           as `去年同期累计营业笔数`
,a.member_sale_amt_nb                             as `不含超市百货营业额`
,a.member_sale_count_nb                           as `不含超市百货消费总次数`              

from     app.a05_month_project_tableau a
 where a.projectname is not null and a.projectname<>'-'
 union all
select                                                                                           
 '月度项目2'                                                          as `表名`                         
,null                                                                 as `年份`                     
,a.the_month                                                          as  `年月`                    
,null                                                                as  `日期`                    
,a.projectguid                                                       as  `项目guid`                
,a.projectname                                                       as  `项目名称`                  
,a.kpi_projectguid                                                   as  `合并项目guid`              
,a.kpi_projectname                                                   as  `合并项目名称`                
,a.kpi_projectstage                                                  as  `合并项目成熟阶段`              
,a.companyguid                                                       as  `公司guid`                
,a.companyname                                                       as  `公司名称`                  
,null                                                                as  `业态id`                  
,a.city                                                              as  `城市`                    
,a.province                                                          as  `省份`                    
,a.district_name                                                     as  `片区名称`                  
,null                                                                as  `地区id`                  
,null                                                                as  `地区guid`                
,null                                                                as  `地区名称`                  
,a.kpi_projectstage                                                  as  `项目成熟阶段`                
,a.projectopen_date                                                  as  `项目开业日期`                
,a.preparesign                                                  as  `是否筹备期`                 
,a.stor                                                         as  `是否存量项目`                
,a.project_building_area                                             as  `项目建筑建筑面积(不含车库)` 
,null                                                                as `当月最后一天`         
,a.cur_m_days                                                    as  `当月天数`  
,null                                                                       as `去年当月天数`    
,null                                                                      as `当年累计天数`                  
,a.calculatetraffic                                            as `当月客流总数` 
,null                                                                     as `去年当月客流总数`      
,null                                                                     as `上月客流总数`       
,null                                                                     as `当年累计当月客流总数`    
,null                                                                     as `去年同期累计当月客流总数`                 
,a.last_customer                                                as       `去年年日均客流`          
,a.increase_membernum                                            as       `当月新增会员数`
,null                                                                      as `去年当月新增会员数`   
,null                                                                      as `上月新增会员数`     
,null                                                                      as `当年累计当月新增会员数` 
,null                                                                      as `去年同期累计当月新增会员数`          
,a.total_membernum                                               as       `当前累计会员数`
,null                                                                      as `去年当月当前累计会员数`      
,null                                                                      as `上月当前累计会员数`       
,null                                                                      as `当年累计当前累计会员数`      
,null                                                                      as `去年同期累计当前累计会员数`          
,a.member_sale_amt                                              as       `会员营业额` 
,null                                                                      as `去年当月会员营业额`      
,null                                                                       as `上月会员营业额`       
,null                                                                      as `当年累计会员营业额`      
,null                                                                       as `去年同期累计会员营业额`        
,a.sale_count                                                  as   `当月会员消费次数`              
,null                                                                          as `去年当月会员消费次数` 
,null                                                                       as `上月会员消费次数`      
,null                                                                         as `当年累计会员消费次数`  
,null                                                                       as `去年同期累计会员消费次数`                              
,a.is_active                                                       as       `6个月活跃度`        
,a.is_dead                                                         as       `死卡人数`          
,a.is_consum                                                       as       `6个月消费人数`       
,a.last_total_member                                               as       `年初累计会员数`       
,a.saleamt                                                           as       `营业额`
,null                                                                         as `去年当月营业额`      
,null                                                                          as `上月营业额`       
,null                                                                         as `当年累计营业额`      
,null                                                                          as `去年同期累计营业额`     
,null                                                                     as       `上月累计营业额`     
,a.salenum                                                            as      `营业笔数` 
 ,null                                                                          as `去年营业笔数`       
 ,null                                                                           as `上月营业笔数`      
,null                                                                           as `当年累计营业笔数`     
,null                                                                            as `去年同期累计营业笔数`         
,a.saleamt_n                                                           as       `不含超市百货营业额` 
,a.salenum_n                                                         as       `不含超市百货消费总次数`
from 
(select
 substr(a.the_month,1,4)             as  year                     
,a.the_month                                               
,a.projectguid                                              
,d.projectname                                                
,d.kpi_projectname                                          
,d.kpi_projectguid                                          
,d.kpi_projectstage                                                                                     
,d.companyname  
,d.companyguid                                                                                            
,d.city                                                     
,d.province                                                 
,d.district_name                                                                                                                                  
,a.projectopen_date     
,case when substr(d.projectopen_date,1,10) > a.the_month 
            and datediff(substr(d.projectopen_date,1,10),a.the_month) <365  
            then 1  else 0 end                                      as       preparesign       
,case when add_months(d.projectopen_date,12) <= a.the_month 
             then  1 else 0  END                                   as        stor       
,d.project_building_area                             
,a.calculatetraffic        
,a.last_customer                                              
,a.increase_membernum        
,a.total_membernum  
,a.member_sale_amt    
,a.sale_count    
,b.is_active          
,b.is_dead            
,b.is_consum          
,a.last_total_member  
,c.saleamt
,c.salenum   
,c.saleamt_n                                                      
,c.salenum_n 
,datediff(last_day(concat(a.the_month,'-01')),concat(a.the_month,'-01')) +1    as cur_m_days
from
dws.f05_month_project a
left  join (select
 the_month
 ,project_guid
 ,sum(case when 180d_active_sign='180天内活跃' then 1 else 0 end  ) as is_active
 ,sum(case when business_life_cycle='死亡阶段'  then  1 else 0 end ) as is_dead
 ,sum(case when  180d_consum_active_sign='180天内消费活跃'  then  1 else 0 end ) as is_consum
 from dws.f05_month_member_dmp
 group by
    the_month 
   ,project_guid
 ) b
 on a.the_month=b.the_month
 and a.projectguid=b.project_guid
 left  join  (select
 substr(a.the_date,1,7)     as the_month
 ,a.projectguid
 ,sum(saleamt) as saleamt
 ,sum(salenum)  as salenum
 ,sum(case when  b.mainformatid  not in (
 'FCC7C6AD-D2D2-9475-4933-59126BAEF919'
,'28D897EA-AC99-1488-5A53-3D97E139C820'
,'EC45EF90-0C6A-D45B-EAA7-48A0C8784DED'
,'00E9FFE2-29C0-F414-990A-E99E4FD014B4'
,'CF3C476C-CC71-041F-5AB2-FD8F106E1432'
,'391A0CCF-F361-84CE-BBA5-831CD1C9DE13'
,'016A993F-F06D-646F-F943-DD6DD8D54567'
,'4E99132D-D663-E4AE-590C-77654E3DD7B4'
,'EB2CF3D9-9F3E-4447-5BD0-EE4A63D691AB')  then  saleamt  else 0 end ) as saleamt_n
 ,sum(case when  b.mainformatid  not in (
 'FCC7C6AD-D2D2-9475-4933-59126BAEF919'
,'28D897EA-AC99-1488-5A53-3D97E139C820'
,'EC45EF90-0C6A-D45B-EAA7-48A0C8784DED'
,'00E9FFE2-29C0-F414-990A-E99E4FD014B4'
,'CF3C476C-CC71-041F-5AB2-FD8F106E1432'
,'391A0CCF-F361-84CE-BBA5-831CD1C9DE13'
,'016A993F-F06D-646F-F943-DD6DD8D54567'
,'4E99132D-D663-E4AE-590C-77654E3DD7B4'
,'EB2CF3D9-9F3E-4447-5BD0-EE4A63D691AB')  then  salenum  else 0 end )  as salenum_n

 from  dws.f05_longfor_saledata  a
 left  join  dws.f05_month_contract  b
 on  substr(a.the_date,1,7)=b.the_month
 and a.contractno=b.contractno  and a.projectguid=b.projectguid
 where   b.rentaltype  in  ('Main','SingleCabinet','Site','SubAnchor','Exclusive')
 group by 
   substr(a.the_date,1,7)    
  ,a.projectguid 
  )      c
  on   a.the_month=c.the_month  
  and a.projectguid=c.projectguid
 left join  dim.pub_longfor_project_temp_sysmartbi  d
  on a.projectguid=d.projectguid                  
) a
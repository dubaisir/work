select 
 a.tablename                                       as `表名`             
,substr(t1.the_month,1,4)                          as `年份`         
,t1.the_month                                      as  `年月`        
,null                                              as  `日期`        
,a.projectguid                                     as  `项目guid`    
,a.projectname                                     as  `项目名称`      
,a.kpi_projectguid                                 as  `合并项目guid`  
,max(a.kpi_projectname)                            as  `合并项目名称`    
,max(a.kpi_project_stage)                          as  `合并项目成熟阶段`  
,a.companyguid                                     as  `公司guid`    
,a.companyname                                     as  `公司名称`      
,null                                              as  `业态id`      
,a.city                                            as  `城市`        
,a.province                                        as  `省份`        
,a.district_name                                   as  `片区名称`      
,null                                              as  `地区id`      
,null                                              as  `地区guid`    
,null                                              as  `地区名称`      
,null                                              as  `项目成熟阶段`    
,a.projectopen_date                                 as  `项目开业日期`    
,sum(case when t1.the_month=a.the_month                                                 
           then a.is_open else 0 end )                          as  `是否筹备期`         
,sum(case when t1.the_month=a.the_month                                                 
           then a.is_save   else 0 end )                               as  `是否存量项目` 
,sum(case when t1.the_month=a.the_month 
           then a.project_building_area else 0 end )              as  `项目建筑建筑面积(不含车库)`           
,t1.last_day_of_month                                                as  `当月最后一天`                   
,sum(case when t1.the_month=a.the_month   
          then a.cur_m_days else 0 end )                           as  `当月天数` 
,sum(case when t1.the_month=concat(int(substring(
           a.the_month,1,4))+1,'-',substring(
           a.the_month,6,2)) 
           then a.cur_m_days else 0 end )                           as  `去年当月天数`
,sum(case when a.the_month>= concat(substring(
           t1.the_month,1,4),'-','01') 
           and  a.the_month <= t1.the_month 
           then a.cur_m_days else 0 end )                           as  `当年累计天数`           
,sum(case when t1.the_month=a.the_month 
          then a.calculatetraffic else 0 end)                       as `当月客流总数`            
,sum(case when t1.the_month=concat(int(substring(
           a.the_month,1,4))+1,'-',substring(
           a.the_month,6,2)) 
           then a.calculatetraffic else 0 end )                     as       `去年当月客流总数`          
,sum(case when t1.the_month=substring(add_months(
           concat(a.the_month,'-01'),1),1,7)
           then a.calculatetraffic else 0 end )                     as       `上月客流总数`                                                
,sum(case when a.the_month>= concat(substring(
           t1.the_month,1,4),'-','01') 
           and  a.the_month <= t1.the_month 
           then a.calculatetraffic else 0 end )                      as       `当年累计当月客流总数`        
,sum(case when a.the_month>=concat(int(substring(
           t1.the_month,1,4))-1,'-','01')
           and a.the_month<=concat(int(substring(
           t1.the_month,1,4))-1,'-',substring(
           t1.the_month,6,2))
           then a.calculatetraffic else 0 end )
                                                                      as       `去年同期累计当月客流总数`      
,sum(case when a.the_month=t1.the_month then a.last_customer  else 0 end )      as       `去年年日均客流`           
,sum(case when a.the_month=t1.the_month 
           then a.increase_membernum  else 0 end )                   as       `当月新增会员数`           
,sum(case when t1.the_month=concat(int(substring(            
           a.the_month,1,4))+1,'-',substring(
           a.the_month,6,2))
           then a.increase_membernum else 0 end )
                                                                      as       `去年当月新增会员数`         
,sum(case when t1.the_month=substring(add_months(
            concat(a.the_month,'-01'),1),1,7)
           then a.increase_membernum else 0 end )                    as       `上月新增会员数`           
,sum(case when a.the_month>=concat(substring(
           t1.the_month,1,4),'-','01')
           and a.the_month<=concat(substring(
           t1.the_month,1,4),'-',substring(t1.the_month,6,2))
           then a.increase_membernum else 0 end)                     as       `当年累计当月新增会员数`       
,sum(case when a.the_month>=concat(int(substring(
           t1.the_month,1,4))-1,'-','01')
           and a.the_month<=concat(int(substring(
           t1.the_month,1,4))-1,'-',substring(t1.the_month,6,2))
           then a.increase_membernum else 0 end)                     as       `去年同期累计当月新增会员数`     
,sum(case when a.the_month=t1.the_month 
           then a.total_membernum else 0 end )                       as       `当前累计会员数`           
,sum(case when t1.the_month=concat(int(substring(
           a.the_month,1,4))+1,'-',substring(a.the_month,6,2))
           then a.total_membernum else 0 end  )                      as       `去年当月当前累计会员数`       
,sum(case when t1.the_month=substring(add_months(
           concat(a.the_month,'-01'),1),1,7)
           then a.total_membernum else 0 end )                       as       `上月当前累计会员数`         
,sum(case when a.the_month=t1.the_month 
          then a.total_membernum else 0 end)                         as       `当年累计当前累计会员数`       
,sum(case when a.the_month>=concat(int(substring(
           t1.the_month,1,4))-1,'-','01')
           and a.the_month<=concat(int(substring(
           t1.the_month,1,4))-1,'-',substring(t1.the_month,6,2)  )
           then a.total_membernum else 0 end )                       as       `去年同期累计当前累计会员数`     
,sum(case when a.the_month=t1.the_month
           then a.member_sale_amt else 0 end )                       as       `会员营业额`             
,sum( case when t1.the_month=concat(int(substring(
            a.the_month,1,4))+1,'-',substring(a.the_month,6,2))
            then a.member_sale_amt else 0 end )                      as       `去年当月会员营业额`         
,sum(case when t1.the_month=substring(add_months(
           concat(a.the_month,'-01'),1),1,7)
           then a.member_sale_amt else 0 end )                       as       `上月会员营业额`           
,sum(case when a.the_month>=concat(substring(
           t1.the_month,1,4),'-','01')
           and a.the_month<=concat(substring(
           t1.the_month,1,4),'-',substring(t1.the_month,6,2))
                then a.member_sale_amt else 0 end )                  as       `当年累计会员营业额`         
,sum(case when a.the_month>=concat(int(substring(
           t1.the_month,1,4))-1,'-','01')
           and a.the_month<=concat(int(substring(
           t1.the_month,1,4))-1,'-',substring(t1.the_month,6,2))
           then a.member_sale_amt else 0 end)                        as       `去年同期累计会员营业额`       
,sum(case when a.the_month=t1.the_month 
          then a.sale_count else 0 end )                             as   `当月会员消费次数`          
,sum(case when t1.the_month=concat(int(substring(
            a.the_month,1,4))+1,'-',substring(a.the_month,6,2))
            then a.sale_count else 0 end )                           as       `去年当月会员消费次数`        
,sum(case when t1.the_month=substring(add_months(
           concat(a.the_month,'-01'),1),1,7)
           then a.sale_count else 0 end )                            as       `上月会员消费次数`          
,sum(case when a.the_month>=concat(substring(
           t1.the_month,1,4),'-','01')
           and a.the_month<=concat(substring(
           t1.the_month,1,4),'-',substring(t1.the_month,6,2))
                then a.sale_count else 0 end )                       as       `当年累计会员消费次数`        
,sum(case when a.the_month>=concat(int(substring(
           t1.the_month,1,4))-1,'-','01')
           and a.the_month<=concat(int(substring(
           t1.the_month,1,4))-1,'-',substring(t1.the_month,6,2))           
           then a.sale_count else 0 end )                             as       `去年同期累计会员消费次数`      
,sum(case when t1.the_month=a.the_month then a.is_active else 0 end )                as       `6个月活跃度`            
,sum(case when t1.the_month=a.the_month then a.is_dead else 0 end)                as       `死卡人数`              
,sum(case when t1.the_month=a.the_month then a.is_consum else 0 end)                as       `6个月消费人数`           
,sum(case when t1.the_month=a.the_month then a.last_total_member else 0 end)        as       `年初累计会员数`           
,sum(case when t1.the_month=a.the_month 
          then a.saleamt else 0 end)                                   as       `营业额`               
,sum(case when t1.the_month=concat(int(substring(
            a.the_month,1,4))+1,'-',substring(a.the_month,6,2))
            then a.saleamt else 0 end )                                 as       `去年当月营业额`           
,sum(case when t1.the_month=substring(add_months(
            concat(a.the_month,'-01'),1),1,7)
           then a.saleamt else 0 end )                                  as       `上月营业额`             
,sum(case when a.the_month>=concat(substring(
           t1.the_month,1,4),'-','01')
           and a.the_month<=concat(substring(
           t1.the_month,1,4),'-',substring(t1.the_month,6,2))
                then a.saleamt else 0 end )                             as       `当年累计营业额`           
,sum(case when a.the_month>=concat(int(substring(
           t1.the_month,1,4))-1,'-','01')
           and a.the_month<=concat(int(substring(
           t1.the_month,1,4))-1,'-',substring(t1.the_month,6,2))
           then a.saleamt else 0 end )                                  as       `去年同期累计营业额`         
,cast(null as  double)                                                  as       `上月累计营业额`           
,sum(case when t1.the_month=a.the_month then a.salenum else 0 end )    as      `营业笔数`              
,sum(case when t1.the_month=concat(int(substring(                           
           a.the_month,1,4))+1,'-',substring(a.the_month,6,2))
            then a.salenum else 0 end )                                 as       `去年营业笔数`            
,sum(case when t1.the_month=substring(add_months(
             concat(a.the_month,'-01'),1),1,7)
           then a.salenum else 0 end )                                as       `上月营业笔数`            
,sum(case when a.the_month>=concat(substring(
           t1.the_month,1,4),'-','01')
           and a.the_month<=concat(substring(
           t1.the_month,1,4),'-',substring(t1.the_month,6,2))
                then a.salenum else 0 end )                           as       `当年累计营业笔数`          
,sum(case when a.the_month>=concat(int(substring(
           t1.the_month,1,4))-1,'-','01')
           and a.the_month<=concat(int(substring(
           t1.the_month,1,4))-1,'-',substring(t1.the_month,6,2) )
           then a.salenum else 0 end )                                    as       `去年同期累计营业笔数`        
,sum(case when t1.the_month=a.the_month then a.saleamt_n else 0 end )     as       `不含超市百货营业额`
,sum(case when t1.the_month=substring(add_months(
             concat(a.the_month,'-01'),1),1,7)
           then a.saleamt_n else 0 end )                                  as  `上月不含超市百货营业额`
,sum(case when t1.the_month=concat(int(substring(                           
           a.the_month,1,4))+1,'-',substring(a.the_month,6,2))
           then a.saleamt_n else 0 end )             as   `去年当月不含超市百货营业额`
,sum(case when a.the_month>=concat(substring(
           t1.the_month,1,4),'-','01')
           and a.the_month<=concat(substring(
           t1.the_month,1,4),'-',substring(t1.the_month,6,2))
                then a.saleamt_n else 0 end )                            as      `当年累计不含超市百货营业额`
,sum(case when a.the_month>=concat(int(substring(
           t1.the_month,1,4))-1,'-','01')
           and a.the_month<=concat(int(substring(
           t1.the_month,1,4))-1,'-',substring(t1.the_month,6,2))
           then a.saleamt_n else 0 end )                                    as   `去年同期累计不含超市百货营业额` 
,sum(case when a.the_month>=concat(substring(
           t1.the_month,1,4),'-','01')
           and substring(add_months(
             concat(a.the_month,'-01'),1),1,7)<=t1.the_month 
             then a.saleamt_n else 0 end )                                as    `上月累计不含超市百货营业额` 
                      
,sum(case when t1.the_month=a.the_month then a.salenum_n else 0 end )      as    `不含超市百货消费总次数`
,sum(case when t1.the_month=substring(add_months(                             
             concat(a.the_month,'-01'),1),1,7)                                   
           then a.salenum_n else 0 end )                                       as    `上月不含超市百货消费总次数`            
,sum(case when t1.the_month=concat(int(substring(                           
           a.the_month,1,4))+1,'-',substring(a.the_month,6,2))
           then a.salenum_n else 0 end )                                      as    `去年当月不含超市百货消费总次数`
,sum(case when a.the_month>=concat(substring(                          
           t1.the_month,1,4),'-','01')                                 
           and a.the_month<=concat(substring(                          
           t1.the_month,1,4),'-',substring(t1.the_month,6,2))          
                then a.salenum_n else 0 end )                         as    `当年累计不含超市百货消费总次数`         
,sum(case when a.the_month>=concat(int(substring(                      
           t1.the_month,1,4))-1,'-','01')                              
           and a.the_month<=concat(int(substring(                      
           t1.the_month,1,4))-1,'-',substring(t1.the_month,6,2))       
           then a.salenum_n else 0 end )                                as    `去年同期累计不含超市百货消费总次数`  
,sum(case when a.the_month>=concat(substring(                      
           t1.the_month,1,4),'-','01')                              
           and substring(add_months(                                   
             concat(a.the_month,'-01'),1),1,7)<=t1.the_month
             then a.salenum_n else 0 end )                                         as    `上月累计不含超市百货消费总次数`     
 ,null                       as `平均互动频次_30天`                            
 ,null                       as `平均互动间隔_30天`                            
 ,null                       as `平均消费频次_30天`                            
 ,null                       as `平均消费间隔_30天`                            
 ,null                       as `复购率_人数_30天`                            
 ,null                       as `复购率_频次_30天`                            
 ,null                       as `平均互动频次_90天`                            
 ,null                       as `平均互动间隔_90天`                            
 ,null                       as `平均消费频次_90天`                            
 ,null                       as `平均消费间隔_90天`                            
 ,null                       as `复购率_人数_90天`                            
 ,null                       as `复购率_频次_90天`                            
 ,null                       as `平均互动频次_180天`                           
 ,null                       as `平均互动间隔_180天`                           
 ,null                       as `平均消费频次_180天`                           
 ,null                       as `平均消费间隔_180天`                           
 ,null                       as `复购率_人数_180天`                           
 ,null                       as `复购率_频次_180天`                           
 ,null                       as `平均互动频次_360天`                           
 ,null                       as `平均互动间隔_360天`                           
 ,null                       as `平均消费频次_360天`                           
 ,null                       as `平均消费间隔_360天`                           
 ,null                       as `复购率_人数_360天`                           
 ,null                       as `复购率_频次_360天`                           
 ,null                       as `平均互动频次_720天`                           
 ,null                       as `平均互动间隔_720天`                           
 ,null                       as `平均消费频次_720天`                           
 ,null                       as `平均消费间隔_720天`                           
 ,null                       as `复购率_人数_720天`                           
 ,null                       as `复购率_频次_720天`   
 ,cast(null as  double)                      as `当前积分余量分档`                                        
 ,cast(null as  double)                      as  `客流人数`                                  
 ,cast(null as  double)                      as  `当前积分余量`                                
 ,cast(null as  double)                      as  `当月会员销售占比`                              
 ,cast(null as  double)                      as  `当月会员活跃度`                               
 ,cast(null as  double)                      as  `年度新增会员数`                               
 ,cast(null as  double)                      as  `年度会员销售占比`                              
 ,cast(null as  double)                      as  `年度会员活跃度`                               
 ,null                      as  `会员数`    
from 
(select 
 the_month
 ,last_day_of_month
from dim.pub_longfor_date
where  the_month <= substring(current_date,1,7) 
        and the_month >='2017-01'
group by         
 the_month
 ,last_day_of_month
) t1

left join 
(select                                       
'月度项目'                                       as  tablename
,a.year                                          as  year
,a.the_month                                      as the_month
,null                                            as  datetime
,a.projectguid                                   as   projectguid
,a.projectname                                   as   projectname
,a.kpi_projectguid                               as   kpi_projectguid   
,a.kpi_projectname                               as   kpi_projectname   
,a.kpi_project_stage                             as   kpi_project_stage 
,a.companyguid                                   as   companyguid       
,a.companyname                                   as   companyname       
,null                                          as  formatid
,a.city                                         as city           
,a.province                                     as province       
,a.district_name                                as district_name  
,null                                          as areaid
,null                                         as  areaguid
,null                                          as areaname
,a.project_stage                               as   project_stage                     
,a.projectopen_date                            as   projectopen_date                  
,a.is_open                                     as   is_open                           
,a.is_save                                     as   is_save                           
,a.project_building_area                       as   project_building_area             
,a.last_month_day                              as   last_month_day                    
,a.monthdays                                   as   monthdays                         
,a.last_days                                   as   last_days                         
,a.total_days                                  as   total_days                        
,a.calculatetraffic                            as   calculatetraffic                        
,a.last_customer                               as   last_customer                     
,a.increase_membernum                          as   increase_membernum                    
,a.total_membernum                             as   total_membernum                               
,a.member_sale_amt                             as   member_sale_amt                         
,a.sale_count                                  as   sale_count                                    
,a.is_active                                   as   is_active                         
,a.is_dead                                     as   is_dead                           
,a.is_consum                                   as   is_consum                         
,a.last_total_member                           as   last_total_member                 
,a.saleamt                                     as   saleamt                                         
,null                                          as   sylj                               
,a.salenum                                     as   salenum                                         
,a.sale_amt_n                                  as   saleamt_n                
,a.sale_num_n                                  as   salenum_n  
,datediff(last_day(concat(a.the_month,'-01')),concat(a.the_month,'-01')) +1    as cur_m_days         

from     app.a05_month_project_tableau a
 where a.projectname is not null and a.projectname<>'-'
         and ((a.the_month < substr(add_months(current_date,-1),1,7)
               and int(substr(current_date,9,2)) < 11
               )  or (int(substr(current_date,9,2)) >= 11
                      and a.the_month < substr(current_date,1,7)
                      )
               )
               
 union all
select                                                                                           
 '月度项目'                                            as  tablename                              
,null                                                   as  year                               
,a.the_month                                             as the_month                          
,null                                                   as  datetime                           
,a.projectguid                                          as   projectguid                       
,a.projectname                                          as   projectname                       
,a.kpi_projectguid                                      as   kpi_projectguid                   
,a.kpi_projectname                                      as   kpi_projectname                   
,a.kpi_projectstage                                     as   kpi_project_stage                 
,a.companyguid                                          as   companyguid                       
,a.companyname                                          as   companyname                       
,null                                                 as  formatid                             
,a.city                                                as city                                 
,a.province                                            as province                             
,a.district_name                                       as district_name                        
,null                                                 as areaid                                
,null                                                as  areaguid                              
,null                                                 as areaname                              
,a.kpi_projectstage                                   as   project_stage                       
,a.projectopen_date                                   as   projectopen_date                    
,a.preparesign                                        as   is_open                             
,a.stor                                               as   is_save                             
,a.project_building_area                              as   project_building_area               
,null                                                 as   last_month_day                      
,null                                                 as   monthdays                           
,null                                                 as   last_days                           
,null                                                 as   total_days                          
,a.calculatetraffic                                   as   calculatetraffic                          
,a.last_customer                                      as   last_customer                       
,a.increase_membernum                                 as   increase_membernum                       
,a.total_membernum                                    as   total_membernum                                   
,a.member_sale_amt                                    as   member_sale_amt                              
,a.sale_count                                         as   sale_count                                                      
,a.is_active                                          as   is_active                           
,a.is_dead                                            as   is_dead                             
,a.is_consum                                          as   is_consum                           
,a.last_total_member                                  as   last_total_member                   
,a.saleamt                                            as   saleamt                                               
,null                                                 as   sylj                                
,a.salenum                                            as   salenum                                             
,a.saleamt_n                                          as   saleamt_n                  
,a.salenum_n                                          as   salenum_n 
,datediff(last_day(concat(a.the_month,'-01')),concat(a.the_month,'-01')) +1    as cur_m_days  
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
             then  1 else 0  end                                   as        stor       
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
 left  join  (select mainformatid,the_month,contractno,rentaltype,projectguid,is_jprent 
                      from dws.f05_month_contract
                      group by 
                      mainformatid,the_month,contractno,rentaltype,projectguid,is_jprent
                        )b
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
  where 
       (a.the_month <= substr(current_date,1,7)
        and a.the_month >= substr(add_months(current_date,-1),1,7)
        and int(substr(current_date,9,2)) < 11 ) 
        or
        (int(substr(current_date,9,2)) >= 11 
         and a.the_month =substr(current_date,1,7) )                 
) a
) a
on 1=1 
  where t1.the_month>= a.the_month
  
group by                   
          a.tablename                 
         ,t1.the_month                              
         ,a.projectguid              
         ,a.projectname              
         ,a.kpi_projectguid                                              
         ,a.companyguid              
         ,a.companyname                                                                                                       
         ,a.city                         
         ,a.province   
         ,a.district_name              
         ,t1.last_day_of_month 
         ,a.projectopen_date          

union  all
                                                                                      
   select 
   '复购'                        as  `表名`
   ,null                        as  `年份`                                   
   ,null                        as  `年月`
   ,null                        as  `日期`  
   ,a.projectid                 as  `项目guid`                                                    
   ,a.projectname               as  `项目名称`                                                 
   ,a.kpi_projectguid           as `合并项目guid`                                                
   ,a.kpi_projectname           as `合并项目名称`  
   ,null                       as `合并项目成熟阶段`                           
   ,null                       as `公司guid`                             
   ,null                       as `公司名称`                               
   ,null                       as `业态id`                               
   ,a.city                      as `城市`                                 
   ,a.province                  as `省份`                                 
   ,a.district_name             as `片区名称`  
   ,null                      as  `地区id`                               
  ,null                        as `地区guid`                             
  ,null                        as `地区名称`                               
  ,null                        as `项目成熟阶段`                             
  ,null                        as `项目开业日期`                             
  ,null                        as `是否筹备期`                              
  ,null                        as `是否存量项目`                             
  ,null                        as `项目建筑建筑面积(不含车库)`                     
  ,null                        as `当月最后一天`                             
  ,null                        as `当月天数`                               
  ,null                        as `去年当月天数`                             
  ,null                        as `当年累计天数`                             
  ,null                        as `当月客流总数`                             
  ,null                        as `去年当月客流总数`                           
  ,null                        as `上月客流总数`                             
  ,null                        as `当年累计当月客流总数`                         
  ,null                        as `去年同期累计当月客流总数`                       
  ,null                        as `去年年日均客流`                            
  ,null                        as `当月新增会员数`                            
  ,null                        as `去年当月新增会员数`                          
  ,null                        as `上月新增会员数`                            
  ,null                        as `当年累计当月新增会员数`  
  ,null                        as `去年同期累计当月新增会员数`                      
  ,null                        as `当前累计会员数`                            
  ,null                        as `去年当月当前累计会员数`                        
  ,null                        as `上月当前累计会员数`                          
  ,null                        as `当年累计当前累计会员数`                        
  ,null                        as `去年同期累计当前累计会员数`                      
  ,null                        as `会员营业额`                              
  ,null                        as `去年当月会员营业额`                          
  ,null                        as `上月会员营业额`                            
  ,null                        as `当年累计会员营业额`                          
  ,null                        as `去年同期累计会员营业额`                        
  ,null                        as `当月会员消费次数`                           
  ,null                        as `去年当月会员消费次数`                         
  ,null                        as `上月会员消费次数`                           
  ,null                        as `当年累计会员消费次数`                         
  ,null                        as `去年同期累计会员消费次数`                       
  ,null                        as `6个月活跃度`                             
  ,null                        as `死卡人数`                               
  ,null                        as `6个月消费人数`                            
  ,null                        as `年初累计会员数`                            
  ,null                        as `营业额`                                
  ,null                        as `去年当月营业额`                            
  ,null                        as `上月营业额`                              
  ,null                        as `当年累计营业额`                            
  ,null                        as `去年同期累计营业额`                          
  ,null                        as `上月累计营业额`                            
  ,null                        as `营业笔数`                               
  ,null                        as `去年营业笔数`                             
  ,null                        as `上月营业笔数`                             
  ,null                        as `当年累计营业笔数`                           
  ,null                        as `去年同期累计营业笔数`                         
  ,null                        as `不含超市百货营业额`
  ,null                                    as        `上月不含超市百货营业额`        
,null                                    as        `去年当月不含超市百货营业额`      
,null                                   as         `当年累计不含超市百货营业额`      
,null                                   as         `去年同期累计不含超市百货营业额`    
,null                                   as         `上月累计不含超市百货营业额`        
  ,null                        as `不含超市百货消费总次数` 
   ,null                                 as       `上月不含超市百货消费总次数`        
,null                                 as        `去年当月不含超市百货消费总次数`     
,null                                 as        `当年累计不含超市百货消费总次数`     
,null                                 as        `去年同期累计不含超市百货消费总次数`   
,null                                 as        `上月累计不含超市百货消费总次数`                           
  ,a.d30                       as  `平均互动频次_30天`                            
  ,nvl(a.df30,0)               as  `平均互动间隔_30天`                            
  ,a.c30                       as  `平均消费频次_30天`                            
   ,nvl(a.cf30,0)              as  `平均消费间隔_30天`                            
   ,a.ba30_p                   as  `复购率_人数_30天`                            
   ,a.ba30_f                   as  `复购率_频次_30天`                            
   ,a.d90                      as  `平均互动频次_90天`                            
   ,nvl(a.df90,0)              as  `平均互动间隔_90天`                            
   ,a.c90                      as  `平均消费频次_90天`                            
   ,nvl(a.cf90,0)              as  `平均消费间隔_90天`                            
   ,a.ba90_p                   as  `复购率_人数_90天`                            
   ,a.ba90_f                   as  `复购率_频次_90天`                            
   ,a.d180                     as  `平均互动频次_180天`                           
   ,nvl(a.df180,0)             as  `平均互动间隔_180天`                           
   ,a.c180                     as  `平均消费频次_180天`                           
   ,nvl(a.cf180,0)             as  `平均消费间隔_180天`                           
   ,a.ba180_p                  as  `复购率_人数_180天`                           
   ,a.ba180_f                  as  `复购率_频次_180天`                           
   ,a.d360                     as  `平均互动频次_360天`                           
   ,nvl(a.df360,0)             as  `平均互动间隔_360天`                           
   ,a.c360                     as  `平均消费频次_360天`                           
   ,nvl(a.cf360,0)             as  `平均消费间隔_360天`                           
   ,a.ba360_p                  as  `复购率_人数_360天`                           
   ,a.ba360_f                  as  `复购率_频次_360天`                           
   ,a.d720                     as  `平均互动频次_720天`                           
   ,nvl(a.df720,0)             as  `平均互动间隔_720天`                           
   ,a.c720                     as  `平均消费频次_720天`                           
   ,nvl(a.cf720,0)             as  `平均消费间隔_720天`                           
   ,a.ba720_p                  as  `复购率_人数_720天`                           
   ,a.ba720_f                  as  `复购率_频次_720天`  
   ,null                      as  `当前积分余量分档`                              
   ,null                      as  `客流人数`                                  
   ,null                      as  `当前积分余量`                                
   ,null                      as  `当月会员销售占比`                              
   ,null                      as  `当月会员活跃度`                               
   ,null                      as  `年度新增会员数`                               
   ,null                      as  `年度会员销售占比`                              
   ,null                      as  `年度会员活跃度`                               
   ,null                      as  `会员数`                                               
  
from 
(

select  a.the_month                                                            datetime                 
       ,a.projectname                                                          projectname
       ,a.projectid                                                            projectid         
       ,a.kpi_projectname                                                      kpi_projectname                      
       ,a.kpi_projectguid                                                      kpi_projectguid
       ,a.city                                                                 city                                 
       ,a.province                                                             province                             
       ,a.district_name                                                        district_name                 
       ,sum(a.d30)/a.totalmember                                               d30
       ,30/(sum(a.d30)/a.totalmember)                                          df30
       ,sum(a.consume30)/a.totalmember                                         c30
       ,30/(sum(a.consume30)/a.totalmember)                                    cf30
       ,sum(case when consume30>1 then 1 else 0 end )/a.totalmember            ba30_p
       ,sum(case when buy130<=0 then  0 else buy130 end )/sum(consume30)       ba30_f
       ,sum(a.d90)/a.totalmember                                               d90     
       ,90/(sum(a.d90)/a.totalmember)                                          df90    
       ,sum(a.consume90)/a.totalmember                                         c90     
       ,90/(sum(a.consume90)/a.totalmember)                                    cf90    
       ,sum(case when consume90>1 then 1 else 0 end )/a.totalmember            ba90_p  
       ,sum(case when buy190<=0 then 0 else buy190 end )/sum(consume90)        ba90_f  
       ,sum(a.d180)/a.totalmember                                              d180     
       ,180/(sum(a.d180)/a.totalmember)                                        df180    
       ,sum(a.consume180)/a.totalmember                                        c180     
       ,180/(sum(a.consume180)/a.totalmember)                                  cf180    
       ,sum(case when consume180>1 then 1 else 0 end)/a.totalmember            ba180_p  
       ,sum(case when buy1180<=0 then 0 else buy1180 end)/sum(consume180)      ba180_f  
       ,sum(a.d360)/a.totalmember                                              d360     
       ,360/(sum(a.d360)/a.totalmember)                                        df360    
       ,sum(a.consume360)/a.totalmember                                        c360     
       ,360/(sum(a.consume360)/a.totalmember)                                  cf360    
       ,sum(case when consume360>1 then 1 else 0 end)/a.totalmember            ba360_p  
       ,sum(case when buy1360<=0 then 0 else buy1360 end)/sum(consume360)      ba360_f  
       ,sum(a.d720)/a.totalmember                                              d720     
       ,720/(sum(a.d720)/a.totalmember)                                        df720    
       ,sum(a.consume720)/a.totalmember                                        c720     
       ,720/(sum(a.consume720)/a.totalmember)                                  cf720    
       ,sum(case when consume720>1 then 1 else 0 end)/a.totalmember            ba720_p  
       ,sum(case when buy1720<=0 then 0 else buy1720 end)/sum(consume720)      ba720_f        


from        
(
select  b.projectname
       ,b.projectid
       ,a.kpi_projectname                                   
       ,a.kpi_projectguid 
       ,a.city                                                         
       ,a.province                                                 
       ,a.district_name 
       ,b.memb_id
       ,a.the_month
       ,a.totalmember       
       ,sum(case when datediff(a.last_day_of_month,b.datetime) <=30  and  b.tradetype='C2_消费' then  b.buynum else 0 end)            consume30           
       ,sum(case when datediff(a.last_day_of_month,b.datetime) <=90  and  b.tradetype='C2_消费' then  b.buynum else 0 end)            consume90       
       ,sum(case when datediff(a.last_day_of_month,b.datetime) <=180 and  b.tradetype='C2_消费'then  b.buynum else 0 end)             consume180       
       ,sum(case when datediff(a.last_day_of_month,b.datetime) <=360 and  b.tradetype='C2_消费' then  b.buynum else 0 end)            consume360       
       ,sum(case when datediff(a.last_day_of_month,b.datetime) <=720 and  b.tradetype='C2_消费' then  b.buynum else 0 end)            consume720
       ,sum(case when datediff(a.last_day_of_month,b.datetime) <=30  then b.buynum else 0 end)                                        d30
       ,sum(case when datediff(a.last_day_of_month,b.datetime) <=90  then b.buynum else 0 end)                                        d90
       ,sum(case when datediff(a.last_day_of_month,b.datetime) <=180 then b.buynum else 0 end)                                        d180
       ,sum(case when datediff(a.last_day_of_month,b.datetime) <=360 then b.buynum else 0 end)                                        d360
       ,sum(case when datediff(a.last_day_of_month,b.datetime) <=720 then b.buynum else 0 end)                                        d720 
       ,sum(case when datediff(a.last_day_of_month,b.datetime) <=30  and  b.tradetype='C2_消费' then b.buynum   else 0 end) -1        buy130
       ,sum(case when datediff(a.last_day_of_month,b.datetime) <=90  and  b.tradetype='C2_消费' then b.buynum   else 0 end) -1        buy190
       ,sum(case when datediff(a.last_day_of_month,b.datetime) <=180 and  b.tradetype='C2_消费' then b.buynum   else 0 end) -1        buy1180
       ,sum(case when datediff(a.last_day_of_month,b.datetime) <=360 and  b.tradetype='C2_消费' then b.buynum   else 0 end) -1        buy1360
       ,sum(case when datediff(a.last_day_of_month,b.datetime) <=720 and  b.tradetype='C2_消费' then b.buynum   else 0 end) -1        buy1720
       from
(
select 
a.the_month
,a.last_day_of_month
,c.project_guid_s05_cus_info  as projectguid 
,count(1)  as totalmember
,b.kpi_projectname                                   
,b.kpi_projectguid 
,b.city                                                         
,b.province                                                 
,b.district_name 
from(select
            the_month
          ,case  when  substr(from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss'),1,10)=the_date then  cast(the_date  as string)  else  last_day_of_month end as last_day_of_month
          from dim.pub_longfor_date
          where the_date=from_unixtime(unix_timestamp(),'yyyy-MM-dd')
              
                 group by the_month,case  when  substr(from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss'),1,10)=the_date then  cast(the_date  as string)  else  last_day_of_month end
                 )a 
left join dmp_user_information.s05_customer_information c
on 1=1  and c.take_effect='1'

left join dim.pub_longfor_project_temp_sysmartbi b
      on b.projectguid=c.project_guid_s05_cus_info
  
 where a.last_day_of_month>=c.member_createtime 
 group by a.the_month
,a.last_day_of_month
,c.project_guid_s05_cus_info 
  ,b.kpi_projectname                                   
,b.kpi_projectguid 
,b.city                                                         
,b.province                                                 
,b.district_name 
                 ) a
left join (select 
 substr(a.datetime,1,10) datetime
,a.projectname
,a.projectid
,a.memb_id
,a.tradetype
,count(a.memb_id) buynum
from
dmp_user_information.s05_customer_trade a
where a.tradetype!='C2_停车消费'
 group by 
          a.datetime
         ,a.projectname
         ,a.projectid
         ,a.memb_id 
         ,a.tradetype
)     b on a.projectguid=b.projectid

where a.last_day_of_month >= substr(b.datetime,1,10) 

group by 
        b.projectname
       ,b.projectid
       ,a.kpi_projectname                                   
       ,a.kpi_projectguid 
       ,a.city                                                         
       ,a.province                                                 
       ,a.district_name 
       ,b.memb_id
       ,a.the_month
       ,a.totalmember
) a

group by 
               a.the_month 
              ,a.projectname 
              ,a.projectid   
              ,a.kpi_projectname
              ,a.kpi_projectguid
              ,a.city         
              ,a.province     
              ,a.district_name
              ,a.totalmember
) a
                             
union all
  select
'会员积分'                as `表名`
,substring(the_month,1,4) as `年份`
,the_month               as `年月`
,null                    as `日期`
,null                    as `项目guid`   
,null                    as `项目名称`      
,b.kpi_projectguid       as `合并项目guid`
,b.kpi_projectname       as `合并项目名称`
,null                    as `合并项目成熟阶段`                           
,null                    as `公司guid`                             
,null                    as `公司名称`                               
,null                    as `业态id`                               
,null                    as `城市`                                 
,null                    as `省份`               
,null                   as   `片区名称`
,null                   as `地区id`                               
,null                   as `地区guid`                             
,null                   as `地区名称`                               
,null                   as `项目成熟阶段`                             
,null                   as `项目开业日期`                             
,null                   as `是否筹备期`                              
,null                   as `是否存量项目`                             
,null                   as `项目建筑建筑面积(不含车库)`                     
,null                   as `当月最后一天`                             
,null                   as `当月天数`                               
,null                   as `去年当月天数`                             
,null                   as `当年累计天数`                             
,null                   as `当月客流总数`                             
,null                   as `去年当月客流总数`                           
,null                   as `上月客流总数`                             
,null                   as `当年累计当月客流总数`                         
,null                   as `去年同期累计当月客流总数`                       
,null                   as `去年年日均客流`                            
,null                   as `当月新增会员数`                            
,null                   as `去年当月新增会员数`                          
,null                   as `上月新增会员数`                            
,null                   as `当年累计当月新增会员数`                        
,null                as `去年同期累计当月新增会员数`                      
,null                   as `当前累计会员数`                            
,null                   as `去年当月当前累计会员数`                        
,null                   as `上月当前累计会员数`                          
,null                   as `当年累计当前累计会员数`                        
,null                   as `去年同期累计当前累计会员数`                      
,null                   as `会员营业额`                              
,null                   as `去年当月会员营业额`                          
,null                   as `上月会员营业额`                            
,null                   as `当年累计会员营业额`                          
,null                   as `去年同期累计会员营业额`                        
,null                   as `当月会员消费次数`                           
,null                   as `去年当月会员消费次数`                         
,null                   as `上月会员消费次数`                           
,null                   as `当年累计会员消费次数`                         
,null                   as `去年同期累计会员消费次数`                       
,null                   as `6个月活跃度`                             
,null                   as `死卡人数`                               
,null                   as `6个月消费人数`                            
,null                   as `年初累计会员数`                            
,null                   as `营业额`                                
,null                   as `去年当月营业额`                            
,null                   as `上月营业额`                              
,null                   as `当年累计营业额`                            
,null                   as `去年同期累计营业额`                          
,null                   as `上月累计营业额`                            
,null                   as `营业笔数`                               
,null                   as `去年营业笔数`                             
,null                   as `上月营业笔数`                             
,null                   as `当年累计营业笔数`                           
,null                   as `去年同期累计营业笔数`                         
,null                   as `不含超市百货营业额`  
,null                                    as        `上月不含超市百货营业额`        
,null                                    as        `去年当月不含超市百货营业额`      
,null                                   as         `当年累计不含超市百货营业额`      
,null                                   as         `去年同期累计不含超市百货营业额`    
,null                                   as         `上月累计不含超市百货营业额`                                 
,null                   as `不含超市百货消费总次数`     
,null                                 as       `上月不含超市百货消费总次数`        
,null                                 as        `去年当月不含超市百货消费总次数`     
,null                                 as        `当年累计不含超市百货消费总次数`     
,null                                 as        `去年同期累计不含超市百货消费总次数`   
,null                                 as        `上月累计不含超市百货消费总次数`                           
,null                   as `平均互动频次_30天`                            
,null                   as `平均互动间隔_30天`                            
,null                   as `平均消费频次_30天`                            
,null                   as `平均消费间隔_30天`                            
,null                   as `复购率_人数_30天`                            
,null                   as `复购率_频次_30天`                            
,null                   as `平均互动频次_90天`                            
,null                   as `平均互动间隔_90天`                            
,null                   as `平均消费频次_90天`                            
,null                   as `平均消费间隔_90天`                            
,null                   as `复购率_人数_90天`                            
,null                   as `复购率_频次_90天`                            
,null                   as `平均互动频次_180天`                           
,null                   as `平均互动间隔_180天`                           
,null                   as `平均消费频次_180天`                           
,null                   as `平均消费间隔_180天`                           
,null                   as `复购率_人数_180天`                           
,null                   as `复购率_频次_180天`                           
,null                   as `平均互动频次_360天`                           
,null                   as `平均互动间隔_360天`                           
,null                   as `平均消费频次_360天`                           
,null                   as `平均消费间隔_360天`                           
,null                   as `复购率_人数_360天`                           
,null                   as `复购率_频次_360天`                           
,null                   as `平均互动频次_720天`                           
,null                   as `平均互动间隔_720天`                           
,null                   as `平均消费频次_720天`                           
,null                   as `平均消费间隔_720天`                           
,null                   as `复购率_人数_720天`                           
,null                   as `复购率_频次_720天`                           
,null                   as `当前积分余量分档`                              
,null                   as `客流人数`                   
,sum(current_bonuscurr) as `当前积分余量`
,null as `当月会员销售占比`
,null as `当月会员活跃度`
,null as `年度新增会员数`
,null as `年度会员销售占比`
,null as `年度会员活跃度`
,null as  `会员数`

from   dws.f05_month_project a
left join dim.pub_longfor_project_temp_sysmartbi b
on a.projectguid=b.projectguid
group by  b.kpi_projectguid
,b.kpi_projectname
,the_month



 union all

 select
'会员项目'  as  `表名`
,substring(a.the_month,1,4) as `年份`
,a.the_month  as  `年月`
,null as  `日期`
,a.projectguid  as  `项目guid`
,b.projectname  as  `项目名称`  
,null      as  `合并项目guid`
,null      as  `合并项目名称`
,null      as `合并项目成熟阶段`                           
,null      as `公司guid`                             
,null      as `公司名称`                               
,null      as `业态id`                               
,null      as `城市`                                 
,null      as `省份`      
,b.district_name  as  `片区名称`
,null      as `地区id`                               
,null      as `地区guid`
,null      as `地区名称`                               
,null      as `项目成熟阶段`                             
,null      as `项目开业日期`                             
,null      as `是否筹备期`                              
,null      as `是否存量项目`                             
,null      as `项目建筑建筑面积(不含车库)`                     
,null      as `当月最后一天`                             
,null      as `当月天数`                               
,null      as `去年当月天数`                             
,null      as `当年累计天数`                             
,null      as `当月客流总数`                             
,null      as `去年当月客流总数`                           
,null      as `上月客流总数`                             
,null      as `当年累计当月客流总数`                         
,null      as `去年同期累计当月客流总数`                       
,null      as `去年年日均客流`                            
,null      as `当月新增会员数`                            
,null      as `去年当月新增会员数`                          
,null      as `上月新增会员数`                            
,null      as `当年累计当月新增会员数`                        
,null   as `去年同期累计当月新增会员数`                      
,a.total_membernum     as `当前累计会员数`                            
,null      as `去年当月当前累计会员数`                        
,null      as `上月当前累计会员数`                          
,null      as `当年累计当前累计会员数`                        
,null      as `去年同期累计当前累计会员数`                      
,null      as `会员营业额`                              
,null      as `去年当月会员营业额`                          
,null      as `上月会员营业额`                            
,null      as `当年累计会员营业额`                          
,null      as `去年同期累计会员营业额`                        
,null      as `当月会员消费次数`                           
,null      as `去年当月会员消费次数`                         
,null      as `上月会员消费次数`                           
,null      as `当年累计会员消费次数`                         
,null      as `去年同期累计会员消费次数`                       
,null      as `6个月活跃度`                             
,null      as `死卡人数`                               
,null      as `6个月消费人数`                            
,null      as `年初累计会员数`                            
,c.saleamt  as  `营业额`                                
,null      as `去年当月营业额`                            
,null      as `上月营业额`                              
,null      as `当年累计营业额`                            
,null      as `去年同期累计营业额`                          
,null      as `上月累计营业额`                            
,null      as `营业笔数`                               
,null      as `去年营业笔数`                             
,null      as `上月营业笔数`                             
,null      as `当年累计营业笔数`                           
,null      as `去年同期累计营业笔数`                         
,null      as `不含超市百货营业额`
,null                                    as        `上月不含超市百货营业额`        
,null                                    as        `去年当月不含超市百货营业额`      
,null                                   as         `当年累计不含超市百货营业额`      
,null                                   as         `去年同期累计不含超市百货营业额`    
,null                                   as         `上月累计不含超市百货营业额`                              
,null      as `不含超市百货消费总次数` 
,null                                 as       `上月不含超市百货消费总次数`        
,null                                 as        `去年当月不含超市百货消费总次数`     
,null                                 as        `当年累计不含超市百货消费总次数`     
,null                                 as        `去年同期累计不含超市百货消费总次数`   
,null                                 as        `上月累计不含超市百货消费总次数`                           
,null      as `平均互动频次_30天`                            
,null      as `平均互动间隔_30天`                            
,null      as `平均消费频次_30天`                            
,null      as `平均消费间隔_30天`                            
,null      as `复购率_人数_30天`                            
,null      as `复购率_频次_30天`                            
,null      as `平均互动频次_90天`                            
,null      as `平均互动间隔_90天`                            
,null      as `平均消费频次_90天`                            
,null      as `平均消费间隔_90天`                            
,null      as `复购率_人数_90天`                            
,null      as `复购率_频次_90天`                            
,null      as `平均互动频次_180天`                           
,null      as `平均互动间隔_180天`                           
,null      as `平均消费频次_180天`                           
,null      as `平均消费间隔_180天`                           
,null      as `复购率_人数_180天`                           
,null      as `复购率_频次_180天`                           
,null      as `平均互动频次_360天`                           
,null      as `平均互动间隔_360天`                           
,null      as `平均消费频次_360天`                           
,null      as `平均消费间隔_360天`                           
,null      as `复购率_人数_360天`                           
,null      as `复购率_频次_360天`                           
,null      as `平均互动频次_720天`                           
,null      as `平均互动间隔_720天`                           
,null      as `平均消费频次_720天`                           
,null      as `平均消费间隔_720天`                           
,null      as `复购率_人数_720天`                           
,null      as `复购率_频次_720天`    
,null   as `当前积分余量分档`
,null as  `客流人数`
,null as  `当前积分余量`
,null as  `当月会员销售占比`
,null as  `当月会员活跃度`
,null as  `年度新增会员数`
,null as  `年度会员销售占比`
,null as  `年度会员活跃度`
,null as  `会员数`

from dws.f05_month_project a
left join dim.pub_longfor_project_temp_sysmartbi b
on a.projectguid=b.projectguid
left join (select
substr(the_date,1,7) as the_month
,projectguid
,sum(saleamt) as saleamt
from dws.f05_longfor_saledata
where formatid not in ('FCC7C6AD-D2D2-9475-4933-59126BAEF919'
,'28D897EA-AC99-1488-5A53-3D97E139C820'
,'EC45EF90-0C6A-D45B-EAA7-48A0C8784DED'
,'00E9FFE2-29C0-F414-990A-E99E4FD014B4'
,'CF3C476C-CC71-041F-5AB2-FD8F106E1432'
,'391A0CCF-F361-84CE-BBA5-831CD1C9DE13'
,'016A993F-F06D-646F-F943-DD6DD8D54567'
,'4E99132D-D663-E4AE-590C-77654E3DD7B4'
,'EB2CF3D9-9F3E-4447-5BD0-EE4A63D691AB')
group by substr(the_date,1,7)
,projectguid)c
on a.the_month=c.the_month
and a.projectguid=c.projectguid
where a.the_month in  (select  max(the_month)  from  dws.f05_month_project )
union all
select
'天会员积分'  as  `表名`
,substring(a.the_month,1,4)  `年份` 
, a.the_month        as `年月`
,null as  `日期`
,null  as  `项目guid`
,null  as  `项目名称`  
,d1.kpi_projectguid   as `合并项目guid`
,d1.kpi_projectname   as `合并项目名称`
,null                as `合并项目成熟阶段`                           
,null                as `公司guid`                             
,null                as `公司名称`                               
,null                as `业态id`                               
,null                as `城市`                                 
,null                as `省份`         
,d1.district_name     as `片区名称`
,null                as `地区id`                               
,null                as `地区guid`                             
,null                as `地区名称`                               
,null                as `项目成熟阶段`                             
,null                as `项目开业日期`                             
,null                as `是否筹备期`                              
,null                as `是否存量项目`                             
,null                as `项目建筑建筑面积(不含车库)`                     
,null                as `当月最后一天`                             
,null                as `当月天数`                               
,null                as `去年当月天数`                             
,null                as `当年累计天数`                             
,null                as `当月客流总数`                             
,null                as `去年当月客流总数`                           
,null                as `上月客流总数`                             
,null                as `当年累计当月客流总数`                         
,null                as `去年同期累计当月客流总数`                       
,null                as `去年年日均客流`                            
,null                as `当月新增会员数`                            
,null                as `去年当月新增会员数`                          
,null                as `上月新增会员数`                            
,null                as `当年累计当月新增会员数`                        
,null                as `去年同期累计当月新增会员数`                      
,null                as `当前累计会员数`                            
,null                as `去年当月当前累计会员数`                        
,null                as `上月当前累计会员数`                          
,null                as `当年累计当前累计会员数`                        
,null                as `去年同期累计当前累计会员数`                      
,null                as `会员营业额`                              
,null                as `去年当月会员营业额`                          
,null                as `上月会员营业额`                            
,null                as `当年累计会员营业额`                          
,null                as `去年同期累计会员营业额`                        
,null                as `当月会员消费次数`                           
,null                as `去年当月会员消费次数`                         
,null                as `上月会员消费次数`                           
,null                as `当年累计会员消费次数`                         
,null                as `去年同期累计会员消费次数`                       
,null                as `6个月活跃度`                             
,null                as `死卡人数`                               
,null                as `6个月消费人数`                            
,null                as `年初累计会员数`                            
,null                as `营业额`                                
,null                as `去年当月营业额`                            
,null                as `上月营业额`                              
,null                as `当年累计营业额`                            
,null                as `去年同期累计营业额`                          
,null                as `上月累计营业额`                            
,null                as `营业笔数`                               
,null                as `去年营业笔数`                             
,null                as `上月营业笔数`                             
,null                as `当年累计营业笔数`                           
,null                as `去年同期累计营业笔数`                         
,null                as `不含超市百货营业额`  
,null                                    as        `上月不含超市百货营业额`        
,null                                    as        `去年当月不含超市百货营业额`      
,null                                   as         `当年累计不含超市百货营业额`      
,null                                   as         `去年同期累计不含超市百货营业额`    
,null                                   as         `上月累计不含超市百货营业额`                            
,null                as `不含超市百货消费总次数`
 ,null                                 as       `上月不含超市百货消费总次数`        
,null                                 as        `去年当月不含超市百货消费总次数`     
,null                                 as        `当年累计不含超市百货消费总次数`     
,null                                 as        `去年同期累计不含超市百货消费总次数`   
,null                                 as        `上月累计不含超市百货消费总次数`                            
,null                as `平均互动频次_30天`                            
,null                as `平均互动间隔_30天`                            
,null                as `平均消费频次_30天`                            
,null                as `平均消费间隔_30天`                            
,null                as `复购率_人数_30天`                            
,null                as `复购率_频次_30天`                            
,null                as `平均互动频次_90天`                            
,null                as `平均互动间隔_90天`                            
,null                as `平均消费频次_90天`                            
,null                as `平均消费间隔_90天`                            
,null                as `复购率_人数_90天`                            
,null                as `复购率_频次_90天`                            
,null                as `平均互动频次_180天`                           
,null                as `平均互动间隔_180天`                           
,null                as `平均消费频次_180天`                           
,null                as `平均消费间隔_180天`                           
,null                as `复购率_人数_180天`                           
,null                as `复购率_频次_180天`                           
,null                as `平均互动频次_360天`                           
,null                as `平均互动间隔_360天`                           
,null                as `平均消费频次_360天`                           
,null                as `平均消费间隔_360天`                           
,null                as `复购率_人数_360天`                           
,null                as `复购率_频次_360天`                           
,null                as `平均互动频次_720天`                           
,null                as `平均互动间隔_720天`                           
,null                as `平均消费频次_720天`                           
,null                as `平均消费间隔_720天`                           
,null                as `复购率_人数_720天`                           
,null                as `复购率_频次_720天`   
,case  when  a.bonus>=0 and a.bonus<5000
then '5000以下'
when a.bonus>=5000 and a.bonus<=10000
then '5000至10000'
when a.bonus>=10001 and a.bonus<=20000
then '10001至20000'
when a.bonus>=20001 and a.bonus<=30000
then '20001至30000'
when a.bonus>=30001 and a.bonus<=50000
then '30001至50000'
when a.bonus>=50001 and a.bonus<100000
then '50001至100000'
when a.bonus>=100001
then '100001以上'
ELSE '其他'
END  as  `当前积分余量分档`
,null as  `客流人数`
,null as `当前积分余量`
,null as  `当月会员销售占比`
,null as  `当月会员活跃度`
,null as  `年度新增会员数`
,null as  `年度会员销售占比`
,null as  `年度会员活跃度`
,count(a.member_id) as `会员数`
from  dws.f05_month_member_dmp a
 left join dim.pub_longfor_project_temp_sysmartbi d1
 on  a.project_guid=d1.projectguid
 where d1.projectguid is not null
 group by  a.the_month
,d1.kpi_projectguid
,d1.kpi_projectname
,d1.district_name
,case  when  a.bonus>=0 and a.bonus<5000
then '5000以下'
when a.bonus>=5000 and a.bonus<=10000
then '5000至10000'
when a.bonus>=10001 and a.bonus<=20000
then '10001至20000'
when a.bonus>=20001 and a.bonus<=30000
then '20001至30000'
when a.bonus>=30001 and a.bonus<=50000
then '30001至50000'
when a.bonus>=50001 and a.bonus<100000
then '50001至100000'
when a.bonus>=100001
then '100001以上'
ELSE '其他'
END                                                      

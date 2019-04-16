SELECT
 a.the_date                             as `日期`
,substr(last_day(a.the_date),9,2)         as `当月天数`
, weekday                            as `周几`
, a.companyguid                         as `地区guid`
, a.companyname                         as `地区名称`
, a.projectguid                         as `项目guid`
, a.projectname                         as `项目名称`
, a.city                                as `城市`
, a.province                            as `省份`
, a.district_name                        as `片区名称`
, case when  a.the_date>=substr(b.projectopen_date,1,10)  then  0
        when  add_months(a.the_date,12)>= substr(b.projectopen_date,1,10) and  a.the_date<substr(b.projectopen_date,1,10)   then 1
               else  2  end as `是否筹备期`
,substr(b.projectopen_date,1,10)                                     as `项目开业时间`
,case  when   substr(b.projectopen_date,1,7) <substr(a.the_date,1,7)  then  datediff(a.the_date,concat(substr(a.the_date,1,7),'-01'))
       when  substr(b.projectopen_date,1,7)=substr(a.the_date,1,7)  and substr(b.projectopen_date,1,10)<=substr(a.the_date,1,10)      then  datediff(a.the_date,substr(b.projectopen_date,1,10))
        else   0  end  as `经营天数`
, amt_sum                            as `当日交易金额`
, month_amt_sum                      as  `月累交易金额`
, relative_month_amt_sum             as  `环比月累交易金额`
, last_year_month_amt_sum            as `同比月累交易金额`
, relative_amt_sum                   as `环比交易金额`
, last_year_amt_sum                  as `同比交易金额`
, year_amt_sum                       as `年累交易金额`
, num_sum                            as `当日交易次数`
,0                                   as `环比交易次数`
, month_num_sum                       as `月累交易次数`
, year_num_sum                        as `年累交易次数`
, customer                             as `当日客流`
, month_customer                       as  `月累客流`
,last_year_month_customer              as `同比月累客流`
, relative_customer                      as `当日环比客流`
, last_year_customer                   as `当日同比客流`
, customer_density                     as `客流密度`
, last_year_customer_density           as `同比客流密度`
, a.project_building_area                as `不含车库建筑面积`
, a.is_ziguan                            as `是否资管统计项目`
, a.is_finance                           as `是否财务统计项目`
,'-'                                  as `合同编号`
,'-'                                   `合同id`
,'-'                                 as `合同是否开业`
,'-'                                 as  `合同开业时间`
,'-'                                 as `合同开业天数`
,'-'                                 as  `合同出租类型`
,'-'                                 as `一级业态id`
,'-'                                 as `一级业态名称`
,'-'                                 as  `二级业态id`
,'-'                                 as `二级业态名称`
,'-'                                 as `三级业态id`
,'-'                                 as `三级业态名称`
,'-'                                 as `品牌名称`
,0                                   as `合同面积`
, '-'                    as `资源id`
,'-'                 as `资源出租类型`
,'-'                 as `楼栋id`
,'-'                 as `楼栋编号`
,'-'                 as  `楼栋名称`
,'-'                 as  `楼层id`
,'-'                 as `楼层编号`
,'-'                 as  `楼层名称`
, crent_area                          as `可出租面积`
, relative_crent_area                as `环比可出租面积`
, last_year_crent_area                as `同比可出租面积`
, rentarea                            as `已出租面积`
, relative_rentarea                   as `环比已出租面积`
, last_year_rentarea                 as `同比已出租面积`
, openarea                            as `开业面积`
, relative_openarea                   as `环比开业面积`
, last_year_openarea                  as `同比开业面积`
, jparea                              as `接铺面积`
, relative_jparea                       as `环比接铺面积`
, last_year_jparea                      as `同比接铺面积`
, m_level_ground_effect                 as `月累坪效`
, last_year_m_level_ground_effect       as `同比月累坪效`
, rent_area_bd_budget                   as `月预算可租面积`
, sale_amt_budget                       as `月预算交易金额`
, level_ground_effect_budget            as `月预算坪效`
, average_passenger_flow_bd_budget      as `预算日均客流`
, month_insum_budget                      as `月预算客流`
, 0                  as `是否已出租`
, 0                  as `是否已接铺`
, 0                as `是否已开业`
,0            as  `不含税租赁收入`
, 0            as `含税租赁收入`
,'project'                         as `类型`
,0                                 as `环比不含税租赁收入（面积均摊）` 
,0                                 as `环比含税租赁收入（面积均摊）`  
,a.jfmoney                         as `缴费金额`            
,a.month_jfmoney                   as `月累缴费金额`          
,a.year_jfmoney                    as `年累缴费金额`          
,a.gxmoney                         as `共享金额`            
,a.month_gxmoney                   as `月累共享金额`          
,a.year_gxmoney                    as `年累共享金额`          
,a.jfcount                         as `缴费次数`            
,a.month_jfcount                   as `月累缴费次数`          
,a.year_jfcount                    as `年累缴费次数`          
,a.gxcount                         as `共享次数`            
,a.month_gxcount                   as `月累共享次数`          
,a.year_gxcount                    as `年累共享次数`          
,a.bonus_asc                       as `积分兑换`            
,a.bonus_inc                       as `会员消费（新增积分）`      
,a.member_saleamt                  as `会员消费金额`          
,a.member_salenum                  as `会员消费次数`          
FROM app.a05_receipt_sale_amt  a
left  join  dim.pub_longfor_project_temp_sysmartbi  b
on a.projectguid=b.projectguid
union all
select
 a.the_date                               as `日期`
 ,substr(last_day(a.the_date),9,2)         as `当月天数`
 ,'-'                                  as `周几`
 , a.companyguid                          as `地区guid`
, a.companyname                           as `地区名称`
, a.projectguid                           as `项目guid`
, a.projectname                           as `项目名称`
, a.city                                  as `城市`
, a.province                              as `省份`
, a.district_name                         as  `片区名称`
, a.preparatory_period                    as  `是否筹备期`
,'-'                                    as `项目开业时间`
,null   as                     `经营天数`
, a.saleamt                               as  `当日交易金额`
,0                                      as  `月累交易金额`
,0                                      as `环比月累交易金额`
,0                                      as `同比月累交易金额`
,a.last_week_sale_amt                     as  `环比交易金额`
,0                                      as `同比交易金额`
,0                                      as `年累交易金额`
,a.salenum                                      as `当日交易次数`
,a.last_week_salenum                       as `环比交易次数`
,0                                       as `月累交易次数`
,0                                      as `年累交易次数`
,c.customer                                        as `当日客流`
, 0                                       as  `月累客流`
,0             as `同比月累客流`
, 0                                       as `当日环比客流`
, 0                                       as `当日同比客流`
, 0                                       as `客流密度`
, 0                                       as `同比客流密度`
, 0                                       as `不含车库建筑面积`
, a.is_ziguan                             as `是否资管统计项目`
, a.is_finance                            as `是否财务统计项目`
, a.contractno                            as `合同编号`
, a.contractid                            as `合同id`
, a.is_open                                as `合同是否开业`
, a.open_date                             as  `合同开业时间`
, a.open_days                                    as `合同开业天数`
, a.rentaltype                            as  `合同出租类型`
, a.formatid_level1                       as `一级业态id`
, a.formatname_level                      as `一级业态名称`
, a.formatid_level2                       as  `二级业态id`
, a.formatname_level2                     as `二级业态名称`
, a.formatid_level3                       as `三级业态id`
, a.formatname_level3                     as `三级业态名称`
, a.branddesc                             as `品牌名称`
, a.totalarea                             as `合同面积`
, '-'                    as `资源id`
,'-'                 as `资源出租类型`
,'-'                 as `楼栋id`
,'-'                 as `楼栋编号`
,'-'                 as  `楼栋名称`
,'-'                 as  `楼层id`
,'-'                 as `楼层编号`
,'-'                 as  `楼层名称`



,a.totalarea                                       as `可出租面积`
, 0                                      as `环比可出租面积`
, 0                                      as `同比可出租面积`
, case when    b.is_yrent='1' then    a.totalarea else 0 end    as `已出租面积`
, 0                                       as `环比已出租面积`
, 0                                       as `同比已出租面积`
, case when    b.is_openrent='1' then    a.totalarea else 0 end                                       as `开业面积`
, 0                                        as `环比开业面积`
, 0                                        as `同比开业面积`
, case when    b.is_jprent='1' then    a.totalarea else 0 end                                           as `接铺面积`
, 0                                         as `环比接铺面积`
, 0                                         as `同比接铺面积`
, 0                                         as `月累坪效`
, 0                                         as `同比月累坪效`
, 0                                         as `月预算可租面积`
, 0                                         as `月预算交易金额`
, 0                                         as `月预算坪效`
, 0                                          as `预算日均客流`
, 0                                          as `月预算客流`
, b.is_yrent                  as `是否已出租`
, b.is_jprent                  as `是否已接铺`
, b.is_openrent                as `是否已开业`
,0            as  `不含税租赁收入`
, 0            as `含税租赁收入`
,'contract'                         as `类型`
,0                                  as `环比不含税租赁收入（面积均摊）`  
,0                                  as `环比含税租赁收入（面积均摊）`   
,0                                  as `缴费金额`             
,0                                  as `月累缴费金额`           
,0                                  as `年累缴费金额`           
,0                                  as `共享金额`             
,0                                  as `月累共享金额`           
,0                                  as `年累共享金额`           
,0                                  as `缴费次数`             
,0                                  as `月累缴费次数`           
,0                                  as `年累缴费次数`           
,0                                  as `共享次数`             
,0                                  as `月累共享次数`           
,0                                  as `年累共享次数`           
,0                                  as `积分兑换`             
,0                                  as `会员消费（新增积分）`       
,0                                  as `会员消费金额`           
,0                                  as `会员消费次数`           
FROM      app.a05_contract_tableau a
left  join   dws.f05_contract  b
on a.the_date=b.the_date  and a.contractid=b.contractid
left  join  (select substr(biz_date,1,10) as the_date
, contract_no
,sum(insum) as customer
,project_id
 from   dws.f05_day_statistics group by substr(biz_date,1,10) , contract_no,project_id )c
 on  a.the_date=c.the_date  and a.contractno=c.contract_no  and a.projectguid=c.project_id
union  all
SELECT
  a.the_date                           as `日期`
,substr(last_day(a.the_date),9,2)      as `当月天数`
,'-'                                   as   `周几`
, a.companyguid                        as `地区guid`
, a.companyname                        as `地区名称`
, a.projectguid                        as `项目guid`
, a.projectname                        as `项目名称`
,b.city                                as `城市`
,b.province                            as `省份`
,b.district_name                       as `片区名称`
, a.preparatory_period                 as  `是否筹备期`
, a.projectopen_date                   as  `项目开业时间`
,null                                  as   `经营天数`
, a.sale_area_amt                      as  `当日交易金额`
,0                                     as `月累交易金额`
,0                                     as `环比月累交易金额`
,0                                     as `同比月累交易金额`
,a.last_week_sale_area_amt             as `环比交易金额`
,0                                     as `同比交易金额`
,0                                     as   `年累交易金额`
,a. sale_area_num                      as `当日交易次数`
,a.last_week_sale_area_num             as `环比交易次数`
,0                                     as `月累交易次数`
,0                                     as `年累交易次数`
, 0                                    as `当日客流`
, 0                                    as  `月累客流`
,0                                     as `同比月累客流`
, 0                                    as `当日环比客流`
, 0                                    as `当日同比客流`
, 0                                    as `客流密度`
, 0                                    as `同比客流密度`
, 0                                    as `不含车库建筑面积`
, a.is_ziguan                          as `是否资管统计项目`
,a.is_finance                          as `是否财务统计项目`
, a.contractno                         as `合同编号`
, a.contractid                         as `合同id`
,'-'                                   as `合同是否开业`
 ,'-'                                  as  `合同开业时间`
, '-'                                  as `合同开业天数`
, '-'                                  as  `合同出租类型`
, '-'                                  as `一级业态id`
, '-'                                  as `一级业态名称`
, '-'                                  as  `二级业态id`
, '-'                                  as `二级业态名称`
, '-'                                  as `三级业态id`
, '-'                                  as `三级业态名称`
, '-'                                  as `品牌名称`
, '-'                                  as `合同面积`
, a.unitid                             as `资源id`
, a.unittype                           as `资源出租类型`
, a.build_id                           as `楼栋id`
, a.build_no                           as `楼栋编号`
, a.build_name                         as  `楼栋名称`
, a.floor_id                           as  `楼层id`
, a.floor_no                           as `楼层编号`
, a.floor_name                         as  `楼层名称`
, a.crent_area                         as `可出租面积`
, a.crent_area                         as `环比可出租面积`
, 0                                    as `同比可出租面积`
, a.rentarea                           as `已出租面积`
, a.last_week_rentarea                 as `环比已出租面积`
, 0                                    as `同比已出租面积`
, a.openarea                           as  `开业面积`
, a.last_week_openarea                 as `环比开业面积`
, 0                                    as `同比开业面积`
, a.jparea                             as  `接铺面积`
,a.last_week_jparea                    as `环比接铺面积`
, 0                                    as `同比接铺面积`
, 0                                    as `月累坪效`
, 0                                    as `同比月累坪效`
, 0                                    as `月预算可租面积`
, 0                                    as `月预算交易金额`
, 0                                    as `月预算坪效`
, 0                                    as `预算日均客流`
, 0                                    as `月预算客流`
, a.is_yrent                           as `是否已出租`
, a.is_jprent                          as `是否已接铺`
, a.is_openrent                        as `是否已开业`
, a.rental_income_n                    as  `不含税租赁收入`
, a.rental_income_y                    as `含税租赁收入`
,'unit'                                as `类型`
,a.last_week_rental_income_n           as `环比不含税租赁收入（面积均摊）` 
,a.last_week_rental_income_y           as `环比含税租赁收入（面积均摊）`  
,0                                     as `缴费金额`            
,0                                     as `月累缴费金额`          
,0                                     as `年累缴费金额`          
,0                                     as `共享金额`            
,0                                     as `月累共享金额`          
,0                                     as `年累共享金额`          
,0                                     as `缴费次数`            
,0                                     as `月累缴费次数`          
,0                                     as `年累缴费次数`          
,0                                     as `共享次数`            
,0                                     as `月累共享次数`          
,0                                     as `年累共享次数`          
,0                                     as `积分兑换`            
,0                                     as `会员消费（新增积分）`      
,0                                     as `会员消费金额`          
,0                                     as `会员消费次数`          
FROM app.a05_unit_tableau a
left  join dim.pub_longfor_project_temp_sysmartbi b
on a.projectguid=b.projectguid
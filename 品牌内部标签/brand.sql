select 

case when b.is_jprent='1' then '在执行'
     when b.is_jprent='0' and b.is_yrent='1' then '待执行'
     else '其它' end     as `合同状态`
     ,a.contract_type      as `合同类型`
     ,a.contracttypedesc  as `合同类型c`
     ,a.unitdesc          as `资源名称`  
     ,d.brand_name        as `品牌名称`
     ,a.overlay_date      as `接铺日期`
     ,a.open_date         as `开业日期`
     ,a.contract_no       as `合同编号`
     ,e.projectname       as `项目名称`
     ,case when b.sign_type='新签'   and    substr(a.filing_date,1,4)='2018'
     then a.contract_no else null end  as is_2018_f    
     
from dim.d05_longfor_contract a
left join (select * from dws.f05_contract
           WHERE
           the_date ='2019-02-27' 

)  b
     on a.project_guid=b.projectguid
     and a.contract_no=b.contractno

 left join  (select   a.*,b.brand_name,b.format_id    from 
                     (select DISTINCT 
                      t.contractid
                     ,case when t2.newbrandid='-' then t2.brand_id else t2.newbrandid end    as brandid
                     FROM DWD_SYSMARTBI.sysmartbi_rt_contract t
                     left join DWD_SYSMARTBI.sysmartbi_rt_contractbrand t1 on t1.contractid = t.contractid
                     left join DIM.d05_longfor_brand t2 
                     on  t2.brand_id = t1.brandid 
                     where t1.status = 'ACTIVE'
                     and t2.status <> 'INACTIVE')a
            left join DIM.d05_longfor_brand b on a.brandid=b.brand_id
             ) d
             on a.contract_id=d.contractid
 left join dim.pub_longfor_project_temp_sysmartbi  e
  on a.project_guid=e.projectguid
 
 where   a.rental_type  in  ('Main','SingleCabinet','Site','SubAnchor','Exclusive')      
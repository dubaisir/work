create view  app.a05_month_member_sale_detail_view as
select
 a.the_date                        as     the_date                                   --   as `交易日期`
,a.date_time                       as     date_time                                  --   as `交易时间`
,a.purhist_id                      as     purhist_id                                 --   as `交易id`
,a.memb_id                         as     memb_id                                    --   as `会员id`
,h.datejoint_s05_cus_info          as     datejoint_s05_cus_info                     --   as `会员创建时间`
,h.card_level_s05_cus_info         as     card_level_s05_cus_info                    --   as `会员卡等级`
,a.contractno                      as     contractno                                 --   as `合同编号`
,a.contract_id                     as     contract_id                                --   as `合同id`
,a.rentaltype                      as     rentaltype                                 --   as `合同类型`
,a.brandid                         as     brandid                                    --   as `品牌id`
,nvl(d.brand_name,'其他')          as     brand_name             -- as `品牌名称`
,e.formatid_level1                 as   formatid_level1                    --   as `一级业态id`
,nvl(e.formatname_level,'其他')    as   formatname_level             -- as `一级业态名称`
,e.formatid_level2                 as   formatid_level2          --   as `二级业态id`
,nvl(e.formatname_level2,'其他')   as   formatname_level2             -- as `二级业态名称`
,e.formatid_level3                 as   formatid_level3           --   as `三级业态id`
,nvl(e.formatname_level3,'其他')   as   formatname_level3             -- as `三级业态名称`
,a.blockid                         as   blockid                    --   as `楼栋id`
,a.blockname                       as   blockname                  --   as `楼栋名称`
,a.floorid                         as   floorid                    --   as `楼层id`
,a.floor                           as   floor                      --   as `楼层名称`
,a.project_guid                    as   project_guid               --   as `项目guid`
,b.projectname                     as   projectname                --   as `项目名称`
,b.kpi_projectguid                 as   kpi_projectguid            --   as `合并项目guid`
,b.kpi_projectname                 as   kpi_projectname            --   as   `合并项目名称`
,b.companyguid                     as   companyguid                --   as `地区guid`
,b.companyname                     as   companyname                --   as `地区名称`
,b.projectopen_date                as   projectopen_date           --   as `开业时间`
,case when  a.the_date>=b.projectopen_date then '0' else '1' end                                    as is_project_open   --as `是否筹备期`
,case when  substr(b.projectopen_date,1,7)<=concat(substr(a.the_date,1,4)-1,substr(a.the_date,6,2))
  then '1'
  else 0 end                                                                                           as is_project_save  --as `是否存量项目`
,b.city                            as  city                                                                             -- as `城市名称`
,b.province                        as  province                                                                         -- as `省份`
,b.district_name                   as  district_name                                                                    -- as `片区名称`
,a.sale_amt                        as  sale_amt                                                                         -- as `消费_交易额`
,case when a.adjustdesc is not null and   a.entryby like '%WeChat%' and a.sale_amt=0 and a.bonus_amt<0  then  0 else
   a.bonus_amt   end                                                                                   as  sale_bouns    -- as `消费_交易积分`
,'-'                                                                                                   as  redeem_giftid  -- as  `积分兑换_礼物id`
,'-'                                                                                                   as  redeem_giftname   -- as `积分兑换_礼品名称`
,0                                                                                                      as  redeem_pro_bouns   --  as `积分兑换_以前积分`
,case when a.adjustdesc is not null and   a.entryby like '%WeChat%' and a.sale_amt=0 and a.bonus_amt<0  then a.bonus_amt else 0 end         as redeem_sale_bouns      -- as `积分兑换_本次消耗积分`
,0                                                                                                                                                 as  redeem_curr_bouns   --as `积分兑换_当前积分`
,case when a.adjustdesc is not null and   a.entryby like '%WeChat%' and a.sale_amt=0 and a.bonus_amt<0  and  adjustdesc like '%停车%' then '积分停车' else '其他'
      end                                                                                                                                         as    redeem_type       -- as `积分兑换_类型`
,case when a.adjustdesc is not null and   a.entryby like '%WeChat%' and a.sale_amt=0 and a.bonus_amt<0 then '微信减少(包含停车)'
     else '其他'  end                                                                                                                            as  yigao_redeem_type                        --as `亿高积分兑换_类型`
, case when a.adjustDesc is not null and a.entryby like '%WeChat%' and a.sale_amt<>0  then '扫码'
        when   a.adjustDesc is not null and a.entryby like '%WeChat%' and a.sale_amt=0 and a.bonus_amt>0 then '微信赠送'
        when  a.entryby not like 'WeChat%' and a.sale_amt<>0   and f.userid is not null then '手工补登'
          WHEN  a.adjustDesc is  null and a.entryby =0  and a.sale_amt<>0 then 'POS'
        ELSE '其他' END                                                                                                                        as increase_type     --  as `产生积分_类型`
,0                                                                                                                                              as project_sale_amt                   --   as `项目_营业额`
,0                                                                                                                                              as project_sale_num                       --as `项目_交易次数`
,case when a.adjustdesc is not null and   a.entryby like '%WeChat%' and a.sale_amt=0 and a.bonus_amt<0  then '积分兑换'
 else '会员消费' end                                                                                                                           as sale_type                          -- as `消费类型`
from dws.f05_longfor_member_sale  a
left join dim.pub_longfor_project_temp_sysmartbi b
on a.project_guid=b.projectguid
left join dmp_user_information.s05_customer_information  h
on a.memb_id=h.customer_id_s05_cus_info
left join dim.d05_longfor_brand d
on a.brandid=d.brand_id
left join dim.d05_longfor_format e
on a.formatid=e.format_id
left join dwd_sysmartbi.sysmartbi_users f
on a.entryby=f.userid
union all
select
 a.the_date                              as     the_date                                                                       --as `交易日期`
,a.date_time                             as     date_time                                                                      --as `交易时间`
,a.redeem_id                             as     purhist_id                                                                     --as `交易id`
,a.member_id                             as     memb_id                                                                        --as `会员id`
,d.datejoint_s05_cus_info                as     datejoint_s05_cus_info                                                         -- as `会员创建时间`
,d.card_level_s05_cus_info               as     card_level_s05_cus_info                                                        --as `会员卡等级`
,'-'                                     as     contractno                                                                     --  as `合同编号`
,'-'                                     as     contract_id                                                                    --  as `合同id`
,'-'                                     as     rentaltype                                                                     --  as `合同类型`
,'-'                                     as     brandid                                                                        --  as `品牌id`
,'-'                                     as     brand_name                                                 --  as `品牌名称`
,'-'                                     as   formatid_level1                                                        --  as  `一级业态id`
,'-'                                     as   formatname_level                                                 -- as `一级业态名称`
,'-'                                     as   formatid_level2                                              -- as `二级业态id`
,'-'                                     as   formatname_level2                                                 -- as `二级业态名称`
,'-'                                     as   formatid_level3                                               -- as `三级业态id`
,'-'                                     as   formatname_level3                                                 -- as `三级业态名称`
,'-'                                     as   blockid                                                        -- as `楼栋id`
,'-'                                     as   blockname                                                      --  as `楼栋名称`
,'-'                                     as   floorid                                                        --  as `楼层id`
,'-'                                     as   floor                                                          --  as `楼层名称`
,a.project_guid                          as   project_guid                                                   --  as `项目guid`
,b.projectname                           as   projectname                                                    --  as `项目名称`
,b.kpi_projectguid                       as   kpi_projectguid                                                 --  as `合并项目guid`
,b.kpi_projectname                       as   kpi_projectname                                                 --  as   `合并项目名称`
,b.companyguid                           as   companyguid                                                     --  as `地区guid`
,b.companyname                           as   companyname                                                     --  as `地区名称`
,b.projectopen_date                      as   projectopen_date                                         --   as `开业时间`
,case when  a.the_date>=b.projectopen_date 
then '0' else '1' end                   as is_project_open                                     --as `是否筹备期`
,case when  substr(b.projectopen_date,1,7)<=concat(
substr(a.the_date,1,4)-1,substr(a.the_date,6,2))
  then '1'
  else 0 end                                             as is_project_save                     -- as `是否存量项目`
,b.city                                                  as  city                                                                                                --  as `城市名称`
,b.province                                              as  province                                                                                            --  as `省份`
,b.district_name                                         as  district_name                                                                                       --  as `片区名称`
,0                                                       as  sale_amt                                                                                            --  as `消费_交易额`
,0                                                       as  sale_bouns                       --  as `消费_交易积分`
,a.gift_id                                               as  redeem_giftid                     --  as `积分兑换_礼物id`
,c.giftdesc                                              as  redeem_giftname                      --  as `积分兑换_礼品名称`
,a.bonus_previous                                        as  redeem_pro_bouns                      --  as `积分兑换_以前积分`
,a.redeem_amt                                            as redeem_sale_bouns                         --    as `积分兑换_本次消耗积分`
,a.bonuscurr                                             as  redeem_curr_bouns                    --  as `积分兑换_当前积分`
,case when  c.giftdesc like '%停车%'  
then '积分停车' else '积分换礼'
   end                                                   as    redeem_type                        --   as `积分兑换_类型`
, '兑换礼品'                                                 as  yigao_redeem_type                                     --   as `亿高积分兑换_类型`
,'-'                                                     as increase_type                       --  as `产生积分_类型`
,0                                                       as project_sale_amt                                     --  as `项目_营业额`
,0                                                       as project_sale_num                                         --  as `项目_交易次数`
,'积分兑换'                                                  as sale_type                   --  as `消费类型`
from DWS.f05_longfor_member_redeem a
left join dim.pub_longfor_project_temp_sysmartbi b
on a.project_guid=b.projectguid
left join dim.d05_longfor_member_gift c
on a.gift_id=c.giftid
left join dmp_user_information.s05_customer_information d
on a.member_id=d.customer_id_s05_cus_info
union ALL
select
 b.the_date                                      as     the_date                                                              --    as `交易日期`
, '-'                                            as     date_time                                                             --    as `交易时间`
, '-'                                            as     purhist_id                                                            --    as `交易id`
, '-'                                            as     memb_id                                                               --    as `会员id`
,  '-'                                           as     datejoint_s05_cus_info                                                --    as `会员创建时间`
,  '-'                                           as     card_level_s05_cus_info                                               --    as `会员卡等级`
,  '-'                                           as     contractno                                                            --    as `合同编号`
,'-'                                             as     contract_id                                                           --    as `合同id`
, '-'                                            as     rentaltype                                                            --     as `合同类型`
, b.brandid                                      as     brandid                                                               --  as `品牌id`
, c.brand_name                                   as     brand_name                                        --  as `品牌名称`
, d.formatid_level1                              as   formatid_level1                                               --   as `一级业态id`
, d.formatname_level                             as   formatname_level                                        --  as `一级业态名称`
, d.formatid_level2                              as   formatid_level2                                     --   as `二级业态id`
, d.formatname_level2                            as   formatname_level2                                        --     as `二级业态名称`
,d.formatid_level3                               as   formatid_level3                                      --  as `三级业态id`
, d.formatname_level3                            as   formatname_level3                                        --     as `三级业态名称`
,'-'                                             as   blockid                                                -- as `楼栋id`
,'-'                                             as   blockname                                              -- as `楼栋名称`
,'-'                                             as   floorid                                                --  as `楼层id`
, '-'                                            as   floor                                                  --  as `楼层名称`
, a.projectguid                                  as   project_guid                                           --  as `项目guid`
,a.projectname                                   as   projectname                                            --  as `项目名称`
,a.kpi_projectguid                               as   kpi_projectguid                                        --   as `合并项目guid`
,a.kpi_projectname                               as   kpi_projectname                                        --   as   `合并项目名称`
,a.companyguid                                   as   companyguid                                            --   as `地区guid`
,a.companyname                                   as   companyname                                            --  as `地区名称`
,a.projectopen_date                              as   projectopen_date                                --   as `开业时间`
,case when  b.the_date>=a.projectopen_date                               
then '0' else '1' end                            as is_project_open                           -- as `是否筹备期`
,case when  substr(a.projectopen_date,1,7                                
)<=concat(substr(b.the_date,1,4)-1,substr(                               
b.the_date,6,2))                                                         
  then '1'                                                               
  else 0 end                                    as is_project_save                                --   as `是否存量项目`
,a.city                                         as  city                                                                                                           --    as `城市名称`
,a.province                                     as  province                                                                                                       --    as `省份`
,a.district_name                                as  district_name                                                                                                  --    as    `片区名称`
,0                                              as  sale_amt                                                                                                       --    as `消费_交易额`
,0                                              as  sale_bouns                                  --    as `消费_交易积分`
,'-'                                            as  redeem_giftid                                --    as  `积分兑换_礼物id`
,'-'                                            as  redeem_giftname                                 --    as `积分兑换_礼品名称`
,0                                              as  redeem_pro_bouns                                 --    as `积分兑换_以前积分`
,0                                              as redeem_sale_bouns                                    --    as `积分兑换_本次消耗积分`
,0                                              as  redeem_curr_bouns                                 --    as `积分兑换_当前积分`
,'-'                                            as    redeem_type                                     --    as `积分兑换_类型`
,'-'                                            as  yigao_redeem_type                                                      --    as `亿高积分兑换_类型`
,'-'                                            as increase_type                                   --    as `产生积分_类型`
,b.saleamt                                      as project_sale_amt                                                 --    as `项目_营业额`
,b.salenum                                      as project_sale_num                                                     --    as `项目_交易次数`
,'项目消费'                                         as sale_type                                                --as `消费类型`
from(
 select
concat(substr(the_date,1,7),'-01') as the_date
,projectguid
,brandid
,formatid
,sum(saleamt)  as saleamt
,sum(salenum)  as salenum
from dws.f05_longfor_saledata
group by concat(substr(the_date,1,7),'-01')
,projectguid
,brandid
,formatid)b
left join   dim.pub_longfor_project_temp_sysmartbi a
on  a.projectguid=b.projectguid
 left join dim.d05_longfor_brand c
on b.brandid=c.brand_id
left join dim.d05_longfor_format d
on b.formatid=d.format_id
union  all
select
 substr(a.the_date,1,10)                           as     the_date                                                                  -- as `交易日期`
, a.the_date                                       as     date_time                                                                 --  as `交易时间`
, a.memberbonuspayid                               as     purhist_id                                                                --  as `交易id`
, a.membid                                         as     memb_id                                                                   --   as `会员id`
,d.datejoint_s05_cus_info                          as     datejoint_s05_cus_info                                                    --    as `会员创建时间`
,d.card_level_s05_cus_info                         as     card_level_s05_cus_info                                                   --  as `会员卡等级`
,  '-'                                             as     contractno                                                                --  as `合同编号`
,'-'                                               as     contract_id                                                               --  as `合同id`
, '-'                                              as     rentaltype                                                                --   as `合同类型`
, '-'                                              as     brandid                                                                   --   as `品牌id`
, '-'                                              as     brand_name                                            --  as `品牌名称`
, '-'                                              as   formatid_level1                                                   --   as `一级业态id`
, '-'                                              as   formatname_level                                            -- as `一级业态名称`
, '-'                                              as   formatid_level2                                         -- as `二级业态id`
,'-'                                               as   formatname_level2                                            --as `二级业态名称`
,'-'                                               as   formatid_level3                                          --as `三级业态id`
,'-'                                               as   formatname_level3                                            --as `三级业态名称`
,'-'                                               as   blockid                                                   -- as `楼栋id`
,'-'                                               as   blockname                                                 -- as `楼栋名称`
,'-'                                               as   floorid                                                   --  as `楼层id`
,'-'                                               as   floor                                                     -- as `楼层名称`
,a.projectguid                                     as   project_guid                                              -- as `项目guid`
,b.projectname                                     as   projectname                                               -- as `项目名称`
,b.kpi_projectguid                                 as   kpi_projectguid                                           -- as `合并项目guid`
,b.kpi_projectname                                 as   kpi_projectname                                           -- as   `合并项目名称`
,b.companyguid                                     as   companyguid                                               -- as `地区guid`
,b.companyname                                     as   companyname                                               -- as `地区名称`
,b.projectopen_date                                as   projectopen_date                                -- as `开业时间`
,case when  a.the_date>=b.projectopen_date 
then '0' else '1' end                             as is_project_open                                -- as `是否筹备期`
,case when  substr(b.projectopen_date,1,7
)<=concat(substr(a.the_date,1,4)-1,substr(
a.the_date,6,2))
  then '1'
  else '0' end                                     as is_project_save                                 -- as `是否存量项目`
,b.city                                            as  city                                                                                                            --  as `城市名称`
,b.province                                        as  province                                                                                                        --  as `省份`
,b.district_name                                   as  district_name                                                                                                   --  as    `片区名称`
,0                                                 as  sale_amt                                                                                                        --  as `消费_交易额`
,0                                                 as  sale_bouns                                   --  as `消费_交易积分`
,'-'                                               as  redeem_giftid                                 --  as  `积分兑换_礼物id`
,'-'                                               as  redeem_giftname                                  --  as `积分兑换_礼品名称`
,a.bonusprev                                       as  redeem_pro_bouns                                  --  as `积分兑换_以前积分`
,a.exchangebonus                                   as redeem_sale_bouns                                     --  as `积分兑换_本次消耗积分`
,a.bonuscurr                                       as  redeem_curr_bouns                               --  as `积分兑换_当前积分`
,case when a.remark='停车支付' then '积分停车'
      else '积分抵现' end                         as    redeem_type                                      -- as `积分兑换_类型`
,'积分抵现'                                       as  yigao_redeem_type                                                       --  as `亿高积分兑换_类型`
,'-'                                              as increase_type                                        -- as `产生积分_类型`
,0                                                as project_sale_amt                                                      -- as `项目_营业额`
,0                                                as project_sale_num                                                          -- as `项目_交易次数`
,'积分兑换'                                       as sale_type                                 -- as `消费类型`
from  dws.f05_bonus_pay     a
left join   dim.pub_longfor_project_temp_sysmartbi b
on  a.projectguid=b.projectguid
left join dmp_user_information.s05_customer_information d
on a.membid=d.customer_id_s05_cus_info
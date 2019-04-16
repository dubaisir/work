use dws;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions=100000;
set hive.exec.max.dynamic.partitions.pernode=100000;
set hive.exec.parallel=true;
set hive.exec.parallel.thread.number=8;
with date as (
select
year
,cast(the_date as string) as the_date
,the_month
,first_day_of_month
,last_day_of_month
from ${HIVE_DB_DIM}.pub_longfor_date
where the_date<'${END_DATEKEY}'
and (( the_date>=date_sub('${START_DATEKEY}',2) and  cast(substr('${END_DATEKEY}',9,2)  as int)<>3) or  ( substr(the_date,1,7)>=substr(add_months('${START_DATEKEY}',-1),1,7) and  cast(substr('${END_DATEKEY}',9,2)  as int)=3)  )
)
insert overwrite table ${HIVE_DB_DWS}.f05_month_contract  partition (datekey)
select
 a.the_month
,a.projectguid
,a.companyguid
,a.contractid
,a.contractno
,a.mainformatid
,a.branddesc
,a.accountid
,a.accountname
,a.contracttype
,a.contracttypedesc
,a.rentaltype
,a.topparentid
,a.parentid
,a.sign_type
,a.is_start
,a.is_end
,a.issk
,a.is_yrent
,a.is_openrent
,a.is_jprent
,a.is_confilling
,a.is_confilling_receipt
,a.is_runtime
,a.totalarea
,a.lqtotalarea
,a.bdamt_y
,a.ccamt_y
,a.wgamt_y
,a.tgamt_y
,a.syamt_y
,a.bdamt_n
,a.ccamt_n
,a.wgamt_n
,a.tgamt_n
,a.syamt_n
,a.lqbdamt_y
,a.lqccamt_y
,a.lqwgamt_y
,a.lqtgamt_y
,a.lqsyamt_y
,a.lqbdamt_n
,a.lqccamt_n
,a.lqwgamt_n
,a.lqtgamt_n
,a.lqsyamt_n

,a.bd_income_y
,a.taking_income_y
,a.mng_income_y
,a.tg_income_y
,a.bd_income_n
,a.taking_income_n
,a.mng_income_n
,a.tg_income_n
,a.m_ccblmode
,a.revenueratemin
,a.revenueratemax
,a.bg_jparea
,b.bgrent_amt
,b.bgmng_amt
,b.bgpromotion_amt
,b.bgfmr_amt
,b.bgrevenue_amt
,b.rentamt
,b.takingamt
,b.mngamt
,b.promotionamt
,b.fmramt
,b.unit_fmr
,b.unit_num
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as op_time
,'${EXECUTION_ID}' as execution_id
,'${CURRENT_FLOW_START_DAY}' as load_date
,substr(a.the_month,1,7)  as datekey
from(

select
a.the_month
 ,a.projectguid
 ,a.companyguid
 ,a.contractid
 ,a.contractno
 ,a.mainformatid
 ,a.branddesc
 ,a.accountid
 ,a.accountname
 ,a.contracttype
 ,a.contracttypedesc
 ,a.rentaltype
 ,a.topparentid
 ,a.parentid
 ,a.sign_type
 ,a.is_start
 ,a.is_end
 ,a.issk
 ,a.is_yrent
 ,a.is_openrent
 ,a.is_jprent
 ,a.is_confilling
 ,a.is_confilling_receipt
 ,a.is_run as is_runtime
 ,a.totalarea
 ,a.lqtotalarea
 ,a.lqbdamt_y
 ,a.lqccamt_y
 ,a.lqwgamt_y
 ,a.lqtgamt_y
 ,a.lqsyamt_y
 ,a.lqbdamt_n
 ,a.lqccamt_n
 ,a.lqwgamt_n
 ,a.lqtgamt_n
 ,a.lqsyamt_n
 ,a.m_ccblmode
 ,a.revenueratemin
 ,a.revenueratemax
 ,a.bg_jparea
  ,b.bdamt_y
  ,b.ccamt_y
  ,b.wgamt_y
  ,b.tgamt_y
  ,b.syamt_y
  ,b.bdamt_n
  ,b.ccamt_n
  ,b.wgamt_n
  ,b.tgamt_n
  ,b.syamt_n
 ,b.bd_income_y
 ,b.taking_income_y
 ,b.mng_income_y
 ,b.tg_income_y
 ,b.bd_income_n
 ,b.taking_income_n
 ,b.mng_income_n
 ,b.tg_income_n

from(
select
   substr(the_date,1,7) as the_month
  ,a.projectguid
  ,a.companyguid
  ,a.contractid
  ,a.contractno
  ,a.mainformatid
  ,a.branddesc
  ,a.accountid
  ,a.accountname
  ,a.contracttype
  ,a.contracttypedesc
  ,a.rentaltype
  ,a.topparentid
  ,a.parentid
  ,a.sign_type
  ,a.is_start
  ,a.is_end
  ,a.issk
  ,a.is_yrent
  ,a.is_openrent
  ,a.is_jprent
  ,a.is_confilling
  ,a.is_confilling_receipt
  ,a.is_run
  ,a.totalarea
  ,a.lqtotalarea
  ,a.lqbdamt_y
  ,a.lqccamt_y
  ,a.lqwgamt_y
  ,a.lqtgamt_y
  ,a.lqsyamt_y
  ,a.lqbdamt_n
  ,a.lqccamt_n
  ,a.lqwgamt_n
  ,a.lqtgamt_n
  ,a.lqsyamt_n
  ,a.m_ccblmode
  ,a.revenueratemin
  ,a.revenueratemax
  ,a.bg_jparea
from   ${HIVE_DB_DWS}.f05_contract a
inner join  date b
on a.the_date=b.last_day_of_month
)a
left join (select
 a.the_month
,bill.projectguid
,bill.contractno

,sum(case
when bill.billitemname = '保底租金' and substr(bill.startdate,1,10) = substr(a.the_date,1,10) then
bill.documentamt
else
0
end) bdamt_y
,sum(case
when bill.billitemname = '抽成租金' and substr(bill.startdate,1,10) = substr(a.the_date,1,10) then
bill.documentamt
else
0
end) ccamt_y
,sum(case when bill.billitemname = '物业管理服务费' and substr(bill.startdate ,1,10) = substr(a.the_date,1,10) then
bill.documentamt
else
0
end) wgamt_y
,sum(case when bill.billitemname = '推广服务费' and substr(bill.startdate ,1 ,10) = substr(a.the_date,1 ,10) then
bill.documentamt
else
0
end) tgamt_y
,sum(case when bill.billitemname = '收银机租金' and substr(bill.startdate ,1,10) = substr(a.the_date ,1 ,10) then
bill.documentamt
else
0
end ) as syamt_y
,sum(case
when bill.billitemname = '保底租金' and substr(bill.startdate,1,10) = substr(a.the_date,1,10) then
bill.baseamt
else
0
end) bdamt_n
,sum(case
when bill.billitemname = '抽成租金' and substr(bill.startdate,1,10) = substr(a.the_date,1,10) then
bill.baseamt
else
0
end) ccamt_n
,sum(case when bill.billitemname = '物业管理服务费' and substr(bill.startdate ,1,10) = substr(a.the_date,1,10) then
bill.baseamt
else
0
end) wgamt_n
,sum(case when bill.billitemname = '推广服务费' and substr(bill.startdate ,1 ,10) = substr(a.the_date,1 ,10) then
bill.baseamt
else
0
end) tgamt_n
,sum(case when bill.billitemname = '收银机租金' and substr(bill.startdate ,1,10) = substr(a.the_date ,1 ,10) then
bill.baseamt
else
0
end ) as syamt_n
,sum(case
when bill.billitemname = '保底租金' then
bill.documentamt
else
0
end) lqbdamt_y
,sum(case
when bill.billitemname = '抽成租金' then
bill.documentamt
else
0
end) lqccamt_y
,sum(case when bill.billitemname = '物业管理服务费' then
bill.documentamt
else
0
end) lqwgamt_y
,sum(case when bill.billitemname = '推广服务费'  then
bill.documentamt
else
0
end) lqtgamt_y
,sum(case when bill.billitemname = '收银机租金' then
bill.documentamt
else
0
end ) as lqsyamt_y
,sum(case
when bill.billitemname = '保底租金'  then
bill.baseamt
else
0
end) lqbdamt_n
,sum(case
when bill.billitemname = '抽成租金'  then
bill.baseamt
else
0
end) lqccamt_n
,sum(case when bill.billitemname = '物业管理服务费'  then
bill.baseamt
else
0
end) lqwgamt_n
,sum(case when bill.billitemname = '推广服务费'  then
bill.baseamt
else
0
end) lqtgamt_n
,sum(case when bill.billitemname = '收银机租金'  then
bill.baseamt
else
0
end ) as lqsyamt_n



                        --   ,sum(a.bd_income_y) AS      bd_income_y
                        --   ,sum(a.taking_income_y) AS  taking_income_y
                        --   ,sum(a.mng_income_y)    AS  mng_income_y
                        --   ,sum(a.tg_income_y)     AS  tg_income_y
                        --   ,sum(a.bd_income_n)      AS bd_income_n
                        --   ,sum(a.taking_income_n) AS  taking_income_n
                        --   ,sum(a.mng_income_n)     AS mng_income_n
                        --   ,sum(a.tg_income_n)      AS tg_income_n


,min(bill.startdate)  as startdate
,max(bill.enddate)    as enddate
from date a
left join ${HIVE_DB_DWS}.f05_longfor_billschedule_detail bill
on 1 = 1
join ${HIVE_DB_DWS}.f05_longfor_contract rc
on bill.contractid = rc.contractid
left join (select a.year
,a.the_date
,nvl(bill.projectguid
,'-') as projectguid
,nvl(bill.CONTRACTNO
,'-') as CONTRACTNO
,sum(case when bill.documentamt is not null and  bill.feename='保底租金' then bill.documentamt else 0 end) as bd_income_y          --含税保底收入
,SUM(case when bill.documentamt is not null and  bill.feename='抽成租金' then bill.documentamt else 0 end ) as taking_income_y      --含税抽成收入
,SUM(case when bill.documentamt is not null and  bill.feename='物业管理服务费' then bill.documentamt else 0 end) as mng_income_y   --含税物业收入
,SUM(case when bill.documentamt is not null and  bill.feename='推广服务费' then bill.documentamt else 0 end) as tg_income_y        --含税推广收入
,SUM(case when bill.baseamt is not null and  bill.feename='保底租金' then bill.baseamt else 0 end) as bd_income_n                  --不含税保底
,SUM(case when bill.baseamt is not null and  bill.feename='抽成租金' then bill.baseamt else 0 end) as taking_income_n              --不含税抽成
,SUM(case when bill.baseamt is not null and  bill.feename='物业管理服务费' then bill.baseamt else 0 end) as mng_income_n           --不含税物业
,SUM(case when bill.baseamt is not null and  bill.feename='推广服务费' then bill.baseamt else 0 end) as tg_income_n                --不含税推广
from date a
left join ${HIVE_DB_DWS}.f05_longfor_rent_income bill
on 1 = 1
where bill.feename in ('保底租金'
,'抽成租金'
,'物业管理服务费'
,'推广服务费')
--and bill.RENTALTYPE in ('Main'
--                       ,'Exclusive'
--                       ,'SubAnchor'
--                       ,'Site'
--                       ,'SingleCabinet')
and bill.isexport = 'Y' --已成功签订

and substr(income_date
,1
,10) = a.the_date
group by bill.projectguid
,a.year
,a.the_date
,bill.CONTRACTNO) rc2
on

where  rc.status not in ('INACTIVE'
,'ACTIVE'
,'SUBMITTED')0
and bill.billitemname in ('保底租金'
,'抽成租金'
,'物业管理服务费'
,'推广服务费'
,'收银机租金')
group by rc.contractno
,a.the_date
,rc.projectguid



)a
  left join(select
   the_month
  ,contractno
  ,projectguid
,SUM(bgrent_amt)  as bgrent_amt
,SUM(bgmng_amt)    as bgmng_amt
,SUM(bgpromotion_amt)  as bgpromotion_amt
,SUM(bgfmr_amt)   as bgfmr_amt
,SUM(bgrevenue_amt)  as bgrevenue_amt
,SUM(rentamt)      as rentamt
,SUM(takingamt)    as takingamt
,SUM(mngamt)        as mngamt
,SUM(promotionamt)  as promotionamt
,SUM(fmramt)    as fmramt
,SUM(unit_fmr)  as unit_fmr
,count(1) as unit_num
from  ${HIVE_DB_DWS}.f05_month_unit
where the_month<=substr('${END_DATEKEY}',1,7)
and the_month>=substr(add_months('${START_DATEKEY}',-1),1,7)
group by the_month
,contractno
,projectguid
) b
  on a.the_month=b.the_month
and a.contractno=b.contractno
and a.projectguid=b.projectguid



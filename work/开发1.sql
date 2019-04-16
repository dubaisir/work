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

(select a.the_date
,rc.contractno
,rc.projectguid
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
,min(bill.startdate)  as startdate
,max(bill.enddate)    as enddate
from date a
left join ${HIVE_DB_DWS}.f05_longfor_billschedule_detail bill
on 1 = 1
join ${HIVE_DB_DWS}.f05_longfor_contract rc
on bill.contractid = rc.contractid
where  rc.status not in ('INACTIVE'
,'ACTIVE'
,'SUBMITTED')
and bill.billitemname in ('保底租金'
,'抽成租金'
,'物业管理服务费'
,'推广服务费'
,'收银机租金')
group by rc.contractno
,a.the_date
,rc.projectguid
)


















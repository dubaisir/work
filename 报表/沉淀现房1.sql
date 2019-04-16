 
select CASE WHEN t1.region IS NULL THEN  '集团' ELSE t1.region END    region
,CASE WHEN t1.region IS NOT NULL AND  t1.projectname IS NULL THEN '地区合计'
      WHEN t1.region IS NULL AND  t1.projectname IS NULL THEN  '集团合计' 
      ELSE t1.projectname END projectname
,t1.bud_account
,case when t1.bud_account = '是否按照签约划分' then '货值' else t1.bud_account end as zhibiao --指标名
,case when t1.bud_account = '是否按照签约划分' and t1.is_cotracted = '未签约' then t1.BUD_VAL_HZ 
	  when t1.bud_account = '成本' then 0
	  when t1.bud_account = '权益后利润' then 0
	  else 0 END AS weiqianyue
,case when t1.bud_account = '是否按照签约划分' and t1.is_cotracted = '已签约款未齐' then t1.BUD_VAL_HZ
      when t1.bud_account = '成本' then t1.BUD_VAL_CB
      when t1.bud_account = '权益后利润' then t1.BUD_VAL_QYHLR 
      else 0 END as yiqianyue 
,t1.y
,t1.m
,t1.ym
,t1.is_cotracted
,t1.BUD_VAL_HZ	  AS  BUD_VAL_HZ
,t1.BUD_VAL_CB	   AS  BUD_VAL_CB
,t1.BUD_VAL_QYHLR  AS BUD_VAL_QYHLR
,t2.syz            AS  syz
from 

          (
           SELECT
                   regexp_replace(REGEXP_SUBSTR(b.dim_full_name,'[^/]+',1,3),'龙湖','') as  region
                  ,REGEXP_SUBSTR(b.dim_full_name,'[^/]+',1,4) as  projectname
                  ,a.bud_account
                  ,a.bud_entity
                  ,a.bud_property    --业态
                  ,CONCAT(20,substr(a.bud_year,3,2))     AS  y   --年
                  ,lpad(REPLACE(a.bud_period,'月',''),2,0)  AS  m    --月
                  ,CONCAT(CONCAT(20,substr(a.bud_year,3,2)),lpad(REPLACE(a.bud_period,'月',''),2,0) )  AS  ym
                  ,a.bud_type        --操盘非操盘等
                  ,a.bud_c5          --单位
                  ,case when a.bud_account    = '是否按照签约划分'  then  a.bud_c1 else null  end              as is_cotracted
                  ,sum(case when a.BUD_ACCOUNT = '是否按照签约划分' then a.BUD_VAL else 0 end) as  BUD_VAL_HZ
                  ,sum(case when a.BUD_ACCOUNT = '成本' 
                                AND  a.BUD_C1='—' then a.BUD_VAL else  0 end) as  BUD_VAL_CB
                  ,sum(case when a.BUD_ACCOUNT = '权益后利润' then a.BUD_VAL else  0 end)  as BUD_VAL_QYHLR
                  
           from (
                 select
                 *
                 from pln_inter_2_jfh.exp_data_jfh_d
                 where
                 bud_type = '表内项目' and
                 bud_period not in ('上半年','下半年','全年') and
                 BUD_ACCOUNT in ('成本','货值','权益后利润','是否按照签约划分') 
                 and substr(BUD_ENTITY,1,2) not in ('C1','C2','C3','D1','D2','D3')
                 )a
           left join (
                 select
                 DISTINCT dim_name,dim_full_name from
                 pln_inter.v_bud_dim_view
                 where dim = 'Entity')    b
                 on a.bud_entity = b.dim_name
           LEFT JOIN  EXP_DATA_JFH_F_YS c
                  ON a.bud_entity=c.bud_entity
                  and c.BUD_ACCOUNT = '运营交付时间'
                  
            group by
                  regexp_replace(REGEXP_SUBSTR(b.dim_full_name,'[^/]+',1,3),'龙湖','')
                 ,REGEXP_SUBSTR(b.dim_full_name,'[^/]+',1,4)
                 ,a.bud_account
                 ,a.bud_entity
                 ,a.bud_property    --业态
                 ,a.bud_year        --年
                 ,a.bud_period      --月
                 ,a.bud_type        --操盘非操盘等
                 ,a.bud_c5          --单位
                 ,a.bud_c1
                ) t1
LEFT JOIN (select  CONCAT(CONCAT(20,substr(a.bud_year,3,2)),lpad(REPLACE(a.bud_period,'月',''),2,0) ) as ym
         ,'货值' AS TYPE
         ,sum(case when a.bud_account    = '货值'          then  nvl(a.bud_val,0) else 0       end )  as syz
                  
                   from pln_inter_2_jfh.exp_data_jfh_d  a
                   where
                   bud_period not in ('上半年','下半年','全年') and
                   BUD_ACCOUNT in ('成本','货值','权益后利润') AND
                   bud_entity = '龙湖集团项目合计' and bud_type = '表内项目'
                    group by    CONCAT(CONCAT(20,substr(a.bud_year,3,2)),lpad(REPLACE(a.bud_period,'月',''),2,0) )
          UNION ALL    
select  CONCAT(CONCAT(20,substr(a.bud_year,3,2)),lpad(REPLACE(a.bud_period,'月',''),2,0) ) as ym
                    ,'成本' AS TYPE
                     ,sum(case when a.bud_account    = '成本' 
                               AND  a.BUD_C1='—'  then  nvl(a.bud_val,0) else 0       end )  as syz
                     
                   from pln_inter_2_jfh.exp_data_jfh_d  a
                   where
                   bud_period not in ('上半年','下半年','全年') and
                   BUD_ACCOUNT in ('成本','货值','权益后利润') AND
                   bud_entity = '龙湖集团项目合计' and bud_type = '表内项目'
                    group by    CONCAT(CONCAT(20,substr(a.bud_year,3,2)),lpad(REPLACE(a.bud_period,'月',''),2,0) )
UNION ALL
select  CONCAT(CONCAT(20,substr(a.bud_year,3,2)),lpad(REPLACE(a.bud_period,'月',''),2,0) ) as ym
                     ,'权益后利润' AS TYPE 
                     ,sum(case when a.bud_account    = '权益后利润'      then  nvl(a.bud_val,0) else 0 end )        as bud_val_qyhlr --权益后利润
                   from pln_inter_2_jfh.exp_data_jfh_d  a
                   where
                   bud_period not in ('上半年','下半年','全年') and
                   BUD_ACCOUNT in ('成本','货值','权益后利润') AND
                   bud_entity = '龙湖集团项目合计' and bud_type = '表内项目'
                    group by    CONCAT(CONCAT(20,substr(a.bud_year,3,2)),lpad(REPLACE(a.bud_period,'月',''),2,0) )
                   ) t2
ON  t1.region IS NULL
AND t1.ym=t2.ym 
AND case when t1.bud_account = '是否按照签约划分' then '货值' else t1.bud_account END = t2.TYPE
AND t1.ym=to_char(ADD_MONTHS(TO_DATE(t2.ym,'yyyymm'),1),'yyyymm')

where 
t1.bud_account != '货值'

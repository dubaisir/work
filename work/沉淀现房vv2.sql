SELECT  a.*
    ,CASE WHEN a.BUD_PROPERTY = '地产-配套' THEN '地产-车库' ELSE a.BUD_PROPERTY END AS PROPERTY
       --,REGEXP_SUBSTR(f.BUD_PROPERTY,'[^-]+',1,1) as PROPERTY
       ,CASE WHEN a.days<180 THEN '一般压力'
             WHEN a.days<=365 AND a.days >= 180 THEN '压力'
             WHEN a.days>365 THEN '强压力'                   END     as type_yl

FROM
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
                  ,a.bud_group
                  ,sum(case when  a.BUD_ACCOUNT = '成本' then nvl(a.bud_val,0) else 0 END ) as  bud_val
                  ,sysdate-TO_DATE(c.bud_val,'yyyymmdd')  AS days
           from (
                 select
                 *
                 from pln_inter_2_jfh.exp_data_jfh_f
                 where
                 bud_group!='组团合计' AND
                 bud_period not in ('上半年','下半年','全年') and
                 BUD_ACCOUNT = '成本'  AND

                  SUBSTR(bud_entity,1,2) IN('C1','C2','C3','D1','D2','D3')
                 )a
           left join (
                SELECT
                 dim_name,
                 dim_full_name from
                 pln_inter.v_bud_dim_view
                 where dim = 'Entity'
                 GROUP  BY dim_full_name,dim_name)    b
                 on a.bud_entity = b.dim_name

            LEFT join EXP_DATA_JFH_F_YS e
            on a.bud_entity=e.bud_entity
            and e.BUD_ACCOUNT = '操盘并表类型'
            AND e.BUD_VAL in (1, 2, 3)

           LEFT JOIN  EXP_DATA_JFH_F_YS c
                  ON a.bud_entity=c.bud_entity
                  AND a.BUD_GROUP=c.BUD_GROUP
                  and c.BUD_ACCOUNT = '运营交付时间'


           WHERE c.bud_val IS NOT NULL
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
                 ,c.bud_val
                 ,a.bud_group
) a

where a.bud_property like '地产-%'



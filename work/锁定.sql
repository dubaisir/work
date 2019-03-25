select  a.region
        ,a.projname
        ,a.YEAR
        ,a.MONTH
        ,a.bud_property
        ,a.ys_sr
        ,case when a.bud_property='JCE公司' then  0  else a.ys_lr end as ys_lr
        ,a.yk_sr
        ,case when a.bud_property='JCE公司' then  0  else a.yk_lr end as yk_lr
        ,case when a.bud_property in ('商业','费用及其他')    then a.ys_sr else a.ysd_sr end  as ysd_sr

        ,case when a.bud_property in ('商业','费用及其他')    then a.ys_lr
              when  a.bud_property='JCE公司' then  0  else a.ysd_lr  end  as ysd_lr
        ,a.wsd_sr
        ,case when a.bud_property='JCE公司' then  0  else a.wsd_lr   end as wsd_lr
from ( SELECT
         a.region
        ,a.projname
        ,a.YEAR
        ,a.month
        ,a.BUD_PROPERTY
        ,sum(CASE WHEN a.bud_c1 ='预算'  AND a.bud_account ='收入' THEN nvl(a.bud_val,0)  ELSE 0 END )                          as  ys_sr
        ,sum(CASE WHEN a.bud_c1 ='预算' AND a.bud_account ='利润' THEN nvl(a.bud_val,0)  ELSE 0 END )                          as  ys_lr
        ,sum(CASE WHEN a.bud_c1='其中：异客金额' AND a.bud_account='收入' THEN nvl(a.bud_val,0)  ELSE 0 END )                          AS yk_sr
        ,sum(CASE WHEN a.bud_c1='其中：异客金额' AND a.bud_account='利润' THEN nvl(a.bud_val,0)  ELSE 0 END )                          AS yk_lr
        ,sum(CASE WHEN a.bud_c1='累计锁定金额（签约、剔除异客）' AND a.bud_account='收入' THEN nvl(a.bud_val,0)  ELSE 0 END )  as   ysd_sr
        ,sum(CASE WHEN a.bud_c1='累计锁定金额（签约、剔除异客）' AND a.bud_account='利润' THEN nvl(a.bud_val,0)  ELSE 0 END )  as   ysd_lr
        ,sum(CASE WHEN a.bud_c1='累计未锁定（签约、剔除异客）' AND a.bud_account='收入' THEN nvl(a.bud_val,0)  ELSE 0 END )  as   wsd_sr
        ,sum(CASE WHEN a.bud_c1='累计未锁定（签约、剔除异客）' AND a.bud_account='利润' THEN nvl(a.bud_val,0)  ELSE 0 END )  as   wsd_lr
from
        (SELECT
         a.BUD_ENTITY
        ,a.BUD_ACCOUNT
        ,a.year
        ,a.month
        ,a.BUD_PERIOD
        ,a.BUD_GROUP
        ,a.BUD_PROPERTY
        ,a.BUD_C1
        ,a.BUD_C3
        ,b.dim_id
        ,b.dim_full_name
        ,regexp_replace(REGEXP_SUBSTR(b.dim_full_name,'[^/]+',1,3),'龙湖','') AS region --地区公司
        ,REGEXP_SUBSTR(b.dim_full_name,'[^/]+',1,4) AS projname --项目
        ,sum(a.BUD_VAL) as BUD_VAL
        FROM
                (select
                 d.BUD_ENTITY
                ,d.BUD_ACCOUNT
                ,CONCAT(20,substr(d.bud_year,3,2)) AS year
                ,REPLACE(d.BUD_C3,'月锁定','') AS month
                ,d.BUD_PERIOD
                ,d.BUD_GROUP
                ,d.BUD_VAL
                ,case when d.BUD_PROPERTY  in ('物业','创新及产城','冠寓','养老')  then  '费用及其他'
                       WHEN d.BUD_PROPERTY='地产业态合计' and substr(d.BUD_TYPE,1,2)='表外' THEN 'JCE公司'
                       else d.BUD_PROPERTY  end   as   BUD_PROPERTY
                ,d.BUD_C1
                ,d.BUD_C3
                FROM PLN_INTER_2_JFH.EXP_DATA_JFH_D d
                where
                 d.BUD_PERIOD in ('上半年数', '全年数')
                 AND d.BUD_PROPERTY != '地产'

                 ) a
                LEFT JOIN PLN_INTER.V_BUD_DIM_VIEW b ON a.bud_entity = b.DIM_NAME
                GROUP BY
                 a.BUD_ENTITY
                ,a.BUD_ACCOUNT
                ,a.year
                ,a.month
                ,a.BUD_PERIOD
                ,a.BUD_GROUP
                ,a.BUD_PROPERTY
                ,a.BUD_C1
                ,a.BUD_C3
                ,b.dim_id
                ,b.dim_full_name
        ) a
GROUP BY
 a.region
,a.projname
,a.YEAR
,a.month
,a.BUD_PROPERTY
) a

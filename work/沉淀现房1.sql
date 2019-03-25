SELECT  a.*
       ,CASE WHEN a.days<180 THEN '一般压力'
             WHEN a.days<=365 AND a.days >= 180 THEN '压力'
             WHEN a.days>365 THEN '强压力'                   END     as type_yl
       ,DECODE(b.bud_val_hz,0,0,(a.bud_val_hz/b.bud_val_hz)-1)        AS  bud_val_hz_hb
       ,DECODE(b.bud_val_cb,0,0,(a.bud_val_cb/b.bud_val_cb)-1)        AS  bud_val_cb_hb
       ,DECODE(b.bud_val_qyhlr,0,0,(a.bud_val_qyhlr/b.bud_val_qyhlr)-1)  AS  bud_val_qyhlr_hb
FROM
          (
           SELECT
                   regexp_replace(REGEXP_SUBSTR(b.dim_full_name,'[^/]+',1,3),'龙湖','') as  region
                  ,REGEXP_SUBSTR(b.dim_full_name,'[^/]+',1,4) as  projectname
                  ,a.bud_entity
                  ,a.bud_property    --业态
                  ,CONCAT(20,substr(a.bud_year,3,2))     AS  y   --年
                  ,lpad(REPLACE(a.bud_period,'月',''),2,0)  AS  m    --月
                  ,CONCAT(CONCAT(20,substr(a.bud_year,3,2)),lpad(REPLACE(a.bud_period,'月',''),2,0) )  AS  ym
                  ,a.bud_type        --操盘非操盘等
                  ,a.bud_c5          --单位
                  ,max(case when a.bud_account    = '是否按照签约划分'  then  a.bud_c1 else null  end )              as is_cotracted
                  ,d.bud_val_hz
                  ,d.bud_val_cb
                  ,d.bud_val_qyhlr
                  ,sysdate-TO_DATE(c.bud_val,'yyyymmdd')  AS days
           from (
                 select
                 *
                 from pln_inter_2_jfh.exp_data_jfh_d
                 where
                 --bud_type = '表内项目' and
                 bud_period not in ('上半年','下半年','全年') and
                 BUD_ACCOUNT in ('成本','货值','权益后利润','是否按照签约划分') AND
                  SUBSTR(bud_entity,1,2) IN('C1','C2','C3','D1','D2','D3')
                 )a
           left join (
                 select
                 * from
                 pln_inter.v_bud_dim_view
                 where dim = 'Entity')    b
                 on a.bud_entity = b.dim_name
           LEFT JOIN  EXP_DATA_JFH_F_YS c
                  ON a.bud_entity=c.bud_entity and c.BUD_ACCOUNT = '运营交付时间'
           left join  (select  CONCAT(CONCAT(20,substr(a.bud_year,3,2)),lpad(REPLACE(a.bud_period,'月',''),2,0) ) as ym
                     ,sum(case when a.bud_account    = '货值'          then  nvl(a.bud_val,0) else 0       end )  as bud_val_hz --货值
                     ,sum(case when a.bud_account    = '成本'          then  nvl(a.bud_val,0) else 0       end )  as bud_val_cb --成本
                     ,sum(case when a.bud_account    = '权益后利润'      then  nvl(a.bud_val,0) else 0 end )        as bud_val_qyhlr --权益后利润
                   from pln_inter_2_jfh.exp_data_jfh_d  a
                   where
                   bud_period not in ('上半年','下半年','全年') and
                   BUD_ACCOUNT in ('成本','货值','权益后利润') AND
                    SUBSTR(bud_entity,1,2) IN('C1','C2','C3','D1','D2','D3')
                    group by    CONCAT(CONCAT(20,substr(a.bud_year,3,2)),lpad(REPLACE(a.bud_period,'月',''),2,0) )
                   ) d
                    on d.ym=CONCAT(CONCAT(20,substr(a.bud_year,3,2)),lpad(REPLACE(a.bud_period,'月',''),2,0) )
           group by
                  regexp_replace(REGEXP_SUBSTR(b.dim_full_name,'[^/]+',1,3),'龙湖','')
                 ,REGEXP_SUBSTR(b.dim_full_name,'[^/]+',1,4)
                 ,a.bud_entity
                 ,a.bud_property    --业态
                 ,a.bud_year        --年
                 ,a.bud_period      --月
                 ,a.bud_type        --操盘非操盘等
                 ,a.bud_c5          --单位
                 ,c.bud_val
                 ,d.bud_val_hz
                 ,d.bud_val_cb
                 ,d.bud_val_qyhlr ) a
LEFT JOIN (
           select  CONCAT(CONCAT(20,substr(a.bud_year,3,2)),lpad(REPLACE(a.bud_period,'月',''),2,0) ) as ym
                     ,sum(case when a.bud_account    = '货值'          then  nvl(a.bud_val,0) else 0       end )  as bud_val_hz --货值
                     ,sum(case when a.bud_account    = '成本'          then  nvl(a.bud_val,0) else 0       end )  as bud_val_cb --成本
                     ,sum(case when a.bud_account    = '权益后利润'      then  nvl(a.bud_val,0) else 0 end )        as bud_val_qyhlr --权益后利润
                   from pln_inter_2_jfh.exp_data_jfh_d  a
                   where
                   bud_period not in ('上半年','下半年','全年') and
                   BUD_ACCOUNT in ('成本','货值','权益后利润') AND
                    SUBSTR(bud_entity,1,2) IN('C1','C2','C3','D1','D2','D3')
                    group by    CONCAT(CONCAT(20,substr(a.bud_year,3,2)),lpad(REPLACE(a.bud_period,'月',''),2,0) )
                   ) b
           ON a.ym=to_char(ADD_MONTHS(TO_DATE(b.ym,'yyyymm'),1),'yyyymm')
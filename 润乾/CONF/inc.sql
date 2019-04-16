sql="
use ${HIVE_DB_DWD_DIM};
with inc_table as (
select

      ,
      ,
      from ${HIVE_DB_ODS_DIM}
      where load_date = '${CURRENT_FLOW_START_DAY}'
      
)
insert overwrite table  ${HIVE_DB_DWD_DIM}.
select
      a.
      a.
      ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss')     as op_time
      ,'${EXECUTION_ID}'                                          as execution_id
      ,'${CURRENT_FLOW_START_DAY}'                                as load_date
from (
      select

            ,
            ,
            from  inc_table
       union all
       select
             fulldata.
             fulldata.
             from ${HIVE_DB_DWD_DIM}.     fulldata
             left join inc_table inc
             on fulldata.  = inc.
             where inc. is null
)a;

"
task_incre_type=multi-day
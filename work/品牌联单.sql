 create view  app.a05_month_member_brand_relation_view as


select
 a.project_guid             as     project_guid                     -- as   `项目guid`
,a.projectname              as     projectname                     -- as `项目名称`
,a.companyguid              as     companyguid                            -- as `公司guid`
,a.companyname              as     companyname                            -- as `公司名称`
,a.city                     as     city                                   -- as `城市名称`
,a.province                 as     province                               -- as `省份`
,a.district_name            as     district_name                          -- as `片区名称`
,a.cur_brandid              as     cur_brandid                            -- as `品牌id`
,a.brand_name               as     brand_name                             -- as `品牌名称`
,a.formatname_level         as     formatname_level                       -- as `一级业态名称`
,a.rela_brandid             as     rela_brandid                           -- as `关联品牌id`
,a.c_brand_name             as     c_brand_name                           --   as `关联品牌名称`
,a.c_formatname_level       as     c_formatname_level                     --   as `关联一级业态名称`
,a.min_sale_num             as     min_sale_num                           -- as `联单次数`
,a.link                     as     link                                   --      as `link`
from(
 SELECT
 a.project_guid       as   project_guid
,b.projectname        as projectname
,b.companyguid        as companyguid
,b.companyname        as companyname
,b.city               as city
,b.province           as province
,b.district_name      as district_name
,a.cur_brandid        as cur_brandid
,c.brand_name         as brand_name
,d.formatname_level   as formatname_level
,a.rela_brandid       as rela_brandid
,e.brand_name         as c_brand_name
,f.formatname_level   as c_formatname_level
,a.min_sale_num       as min_sale_num
,1                    as link
,row_number() over(partition by project_guid order by min_sale_num desc ) as rn
from dws.f05_brand_relation_cd a
left join dim.pub_longfor_project_temp_sysmartbi b
on a.project_guid=b.projectguid
left join dim.d05_longfor_brand c
on a.cur_brandid=c.brand_id
left join dim.d05_longfor_format d
on c.format_id=d.format_id
left join dim.d05_longfor_brand e
on a.rela_brandid=e.brand_id
left join dim.d05_longfor_format f
on e.format_id=f.format_id
where  a.cur_brandid is not null and a.cur_brandid<>'-'
and a.rela_brandid is not null and a.rela_brandid<>'-'
and c.brand_name   is not null and c.brand_name <>'-'
and e.brand_name is not null and  e.brand_name<>'-'
)a
union all
SELECT
 a.project_guid                     as     project_guid                                -- as   `项目guid`
,a.projectname                      as     projectname                                 -- as `项目名称`
,a.companyguid                      as     companyguid                                 -- as `公司guid`
,a.companyname                      as     companyname                                 -- as `公司名称`
,a.city                             as     city                                        -- as `城市名称`
,a.province                         as     province                                    -- as `省份`
,a.district_name                    as     district_name                               -- as `片区名称`
,a.cur_brandid                      as     cur_brandid                                 -- as `品牌id`
,a.brand_name                       as     brand_name                                  -- as `品牌名称`
,a.formatname_level                 as     formatname_level                            -- as `一级业态名称`
,a.rela_brandid                     as     rela_brandid                                -- as `关联品牌id`
,a.c_brand_name                     as     c_brand_name                                --   as `关联品牌名称`
,a.c_formatname_level               as     c_formatname_level                          --   as `关联一级业态名称`
,a.min_sale_num                     as     min_sale_num                                -- as `联单次数`
,a.link                             as     link                                        --      as `link`
from(
 SELECT
 a.project_guid       as   project_guid
,b.projectname        as projectname
,b.companyguid        as companyguid
,b.companyname        as companyname
,b.city               as city
,b.province           as province
,b.district_name      as district_name
,a.cur_brandid        as cur_brandid
,c.brand_name         as brand_name
,d.formatname_level   as formatname_level
,a.rela_brandid       as rela_brandid
,e.brand_name         as c_brand_name
,f.formatname_level   as c_formatname_level
,a.min_sale_num       as min_sale_num
,2                    as link
,row_number() over(partition by project_guid order by min_sale_num desc ) as rn
from dws.f05_brand_relation_cd a
left join dim.pub_longfor_project_temp_sysmartbi b
on a.project_guid=b.projectguid
left join dim.d05_longfor_brand c
on a.cur_brandid=c.brand_id
left join dim.d05_longfor_format d
on c.format_id=d.format_id
left join dim.d05_longfor_brand e
on a.rela_brandid=e.brand_id
left join dim.d05_longfor_format f
on e.format_id=f.format_id
where  a.cur_brandid is not null and a.cur_brandid<>'-'
and a.rela_brandid is not null and a.rela_brandid<>'-'
and c.brand_name   is not null and c.brand_name <>'-'
and e.brand_name is not null and e.brand_name<>'-'
)a
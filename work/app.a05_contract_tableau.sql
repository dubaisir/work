use ${HIVE_DB_APP};
create  table a05_contract_tableau (
the_date              string    comment'日期'
,projectguid          string    comment'项目id'
,projectname          string    comment'项目名称'
,companyguid          string    comment'公司guid'
,companyname          string    comment'公司名称'
,city                 string    comment'城市'
,province             string    comment'省份'
,district_name        string    comment'街道'
,preparatory_period   string    comment'筹备期'
,is_ziguan            string    comment'是否资管统计项目'
,is_finance           string    comment'是否财务统计项目'
,contractno           string    comment'合同编号'
,contractid           string    comment'合同ID'
,is_open              string    comment'是否开业'
,open_date            string    comment'开业时间'
,open_days            int       comment'开业天数'
,rentaltype           string    comment'出租类型'
,formatid_level1      string    comment'一级业态'
,formatname_level     string    comment'一级业态名称'
,formatid_level2      string    comment'二级业态'
,formatname_level2    string    comment'二级业态名称'
,formatid_level3      string    comment'三级业态'
,formatname_level3    string    comment'三级业态名称'
,branddesc            string    comment'品牌名称'
,saleamt              decimal(18,6)    comment'交易金额'
,last_week_sale_amt   decimal(18,6)    comment'环比交易金额'
,saleamt_m_sum        decimal(18,6)    comment'月累计交易金额'
,salenum              decimal(18,6)    comment'交易次数'
,last_week_salenum    decimal(18,6)    comment'环比交易次数'
,salenum_m_sum        decimal(18,6)    comment'月累计环比交易次数'
,totalarea            decimal(18,6)    comment'合同总面积'
,op_time              string    comment'op_time'
,execution_id         string    comment'执行批次'
,load_date            string    comment'入库时间'
)comment '天粒度合同表'
partitioned by (
date_key         string
 )
STORED AS PARQUET ;

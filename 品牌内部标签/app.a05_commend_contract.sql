create table app.a05_commend_contract (
          the_month              string   comment '日期'   
         ,contractno             string   comment '合同编号' 
         ,contractid             string   comment '合同ID'  
         ,district_name          string   comment '片区名称'   
         ,province               string   comment '省份'   
         ,city                   string   comment '城市'   
         ,projectguid            string   comment '项目guid'   
         ,projectname            string   comment '项目名称'   
         ,companyguid            string   comment '地区guid'   
         ,companyname            string   comment '地区名称'   
         ,defaultstartdate       string   comment '约定接铺时间'   
         ,willopendate           string   comment '约定开业时间'   
         ,defaultexpirydate      string   comment '约定收铺时间'   
         ,overlay_date           string   comment '实际接铺时间'   
         ,open_date              string   comment '实际开业时间'   
         ,close_date             string   comment '实际收铺时间'   
         ,filing_date            string   comment '归档时间'   
         ,is_confilling          string   comment '是否已归档'   
         ,is_yrent               string   comment '是否已出租'   
         ,is_jprent              string   comment '是否已接铺'   
         ,is_openrent            string   comment '是否已开业'   
         ,is_end                 string   comment '是否已收铺'   
         ,ys_renamt_n            string   comment '已收抽成租金次数'   
         ,build_id               string   comment '楼栋'
         ,build_name             string   comment '楼栋名称'
         ,floor_id               string   comment '楼层编号'
         ,floor_name             string   comment '楼层'  
         ,turnoverregulation     string   comment 'POS使用'   
         ,signtype               string   comment '合同条款'   
         ,rentcal_mode           string   comment '租金模式'   
         ,m_ccblmode             string   comment '抽成方式'   
         ,totalarea              string   comment '合同面积'   
         ,is_grbrand             string   comment '是否集团品牌' 
         ,workt_mode             string   comment  '合作模式'   
         ,op_days_y              string   comment '近一年经营天数'   
         ,customer_days_y        string   comment '近一年有客流天数'   
         ,amt_sum_y              string   comment '近一年营业额'   
         ,customer_y             string   comment '近一年客流总人数'   
         ,bd_income              string   comment '近一年含税保底租金'   
         ,taking_income          string   comment '近一年含税抽成租金'   
         ,mng_income_y           string   comment '近一年含税物业管理费'   
         ,tg_income              string   comment '近一年含税推广服务费'
         ,bd_income_n            string   comment '近一年不含税保底租金' 
         ,taking_income_n        string   comment '近一年不含税抽成租金' 
         ,mng_income_n_y         string   comment '近一年不含税物业管理费'
         ,tg_income_n            string   comment '近一年不含税推广服务费'   
         ,mng_income             string   comment '当月含税物业费'
         ,mng_income_n           string   comment '当月不含税物业费'   
         ,revenueratemin         string   comment '最低扣率'   
         ,revenueratemax         string   comment '最高扣率'  
         ,op_time                string   comment '时间戳'
         ,execution_id           string   comment '批次号'
         ,load_date              string   comment '入库时间'
)
partitioned by
 (datekey string comment '年月分区')
STORED AS PARQUET;
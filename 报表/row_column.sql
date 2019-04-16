select distinct
 ys_mon   as  年月
,sum(case when subject_code= 'NC01189'   then    index_val  else  0  end  )                                            as     经营性现金流
,sum(case when subject_code= 'NC01191'   then    index_val  else  0  end  )                                            as     融资性现金流
,sum(case when subject_code= 'NC01187'   then    index_val  else  0  end  )                                            as     境内可用头寸
,sum(case when subject_code= 'NC01194'   then    index_val  else  0  end  )                                            as     期末有息负债余额
,sum(case when subject_code= 'NC01196'   then    index_val  else  0  end  )                                            as     供应链期末余额
,sum(case when subject_code= 'NC01198'   then    index_val  else  0  end  )                                            as     净负债率
,sum(case when subject_code= 'NC01140'   then    index_val  else  0  end  )                                            as     开发成本
，0                                                                                                                    as     面积
，0                                                                                                                    as     单方开发成本支付
，0                                                                                                                    as     单方开发成本支付环比变动
,1000                                                                                                                  as     单方开发成本支付目标
,sum(case when subject_code= 'NC01160'   then    index_val  else  0  end  )                                            as     期初已获取
,sum(case when subject_code= 'NC01161'   then    index_val  else  0  end  )                                            as     当年获取项目
,sum(case when subject_code= 'NC01051'   then    index_val  else  0  end  )                                            as     期初余额
,sum(case when subject_code= 'NC01163'   then    index_val  else  0  end  )                                            as     其中_已谈妥待签约
,sum(case when subject_code='NC01160' or subject_code='NC01161' or subject_code='NC01051' then index_val  else 0  end) as  上半年_全年拿地额度
,sum(case when subject_code= 'NC01001'   then    index_val  else  0  end  )                                            as     销售回款
,sum(case when subject_code= 'NC01031'   then    index_val  else  0  end  )                                            as     商票
,sum(case when subject_code= 'NC01151'   then    index_val  else  0  end  )                                            as     保理
,0 -  sum(case when subject_code= 'NC01140' or subject_code='NC01031' or subject_code= 'NC01151' then index_val  else  0  end  )   as 工程款_现金
,sum(case when subject_code= 'NC01062'   then    index_val  else  0  end  )                                            as     税金
,sum(case when subject_code= 'NC01030'   then    index_val  else  0  end  )                                            as     下贷
,sum(case when subject_code= 'NC01174'   then    index_val  else  0  end  )                                            as     合作委贷_表内分出
,sum(case when subject_code= 'NC01175'   then    index_val  else  0  end  )                                            as     合作委贷_表外分回
,0 -   sum(case when subject_code= 'NC01174'   then    index_val  else  0  end  )  +  sum(case when subject_code= 'NC01175'   then    index_val  else  0  end  )  as  委贷分配

from        FINANCE.V_FUNDMONEY_POSITION
group by      ys_mon
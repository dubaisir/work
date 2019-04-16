select distinct
 ys_mon   as  年月
,sum(case when subject_code= 'NC01034'   then    index_val  else  0  end  )       as     还贷
,sum(case when subject_code= 'NC01170'   then    index_val  else  0  end  )       as     境外分红
,sum(case when subject_code= 'NC01152'   then    index_val  else  0  end  )       as     保理到期
,sum(case when subject_code= 'NC01179'   then    index_val  else  0  end  )       as     税金延付
,sum(case when subject_code= 'NC01187'   then    index_val  else  0  end  )       as     境内可用头寸
,sum(case when subject_code= 'NC01163'   then    index_val  else  0  end  )       as     其中_已谈妥待签约
,sum(case when subject_code= 'NC01175'   then    index_val  else  0  end  )       as     合作委贷_表外分回
,sum(case when subject_code= 'NC01171'   then    index_val  else  0  end  )       as     股票回购除以员工行权
,sum(case when subject_code= 'NC01198'   then    index_val  else  0  end  )       as     净负债率
,sum(case when subject_code= 'NC01151'   then    index_val  else  0  end  )       as     保理
,sum(case when subject_code= 'NC01183'   then    index_val  else  0  end  )       as     合作公司余额
,sum(case when subject_code= 'NC01164'   then    index_val  else  0  end  )       as     费用
,sum(case when subject_code= 'NC01030'   then    index_val  else  0  end  )       as     下贷
,sum(case when subject_code= 'NC01181'   then    index_val  else  0  end  )       as     创新预估支出
,sum(case when subject_code= 'NC01176'   then    index_val  else  0  end  )       as     回款风险除以增量
,sum(case when subject_code= 'NC01186'   then    index_val  else  0  end  )       as     其他不可用预售监管
,sum(case when subject_code= 'NC01189'   then    index_val  else  0  end  )       as     经营性现金流
,sum(case when subject_code= 'NC01180'   then    index_val  else  0  end  )       as     融资调整
,sum(case when subject_code= 'NC01051'   then    index_val  else  0  end  )       as     期初余额
,sum(case when subject_code= 'NC01173'   then    index_val  else  0  end  )       as     重庆兴业ABS
,sum(case when subject_code= 'NC01162'   then    index_val  else  0  end  )       as     剩余额度
,sum(case when subject_code= 'NC01168'   then    index_val  else  0  end  )       as     创新净额
,sum(case when subject_code= 'NC01182'   then    index_val  else  0  end  )       as     境外可用头寸
,sum(case when subject_code= 'NC01166'   then    index_val  else  0  end  )       as     商业净额
,sum(case when subject_code= 'NC01172'   then    index_val  else  0  end  )       as     协同投资
,sum(case when subject_code= 'NC01140'   then    index_val  else  0  end  )       as     开发成本
,sum(case when subject_code= 'NC01167'   then    index_val  else  0  end  )       as     物业净额
,sum(case when subject_code= 'NC01165'   then    index_val  else  0  end  )       as     利息
,sum(case when subject_code= 'NC01184'   then    index_val  else  0  end  )       as     票据保证金
,sum(case when subject_code= 'NC01161'   then    index_val  else  0  end  )       as     当年获取项目
,sum(case when subject_code= 'NC01173'   then    index_val  else  0  end  )       as     平安借款合作方
,sum(case when subject_code= 'NC01191'   then    index_val  else  0  end  )       as     融资性现金流
,sum(case when subject_code= 'NC01062'   then    index_val  else  0  end  )       as     税金
,sum(case when subject_code= 'NC01001'   then    index_val  else  0  end  )       as     销售回款
,sum(case when subject_code= 'NC01169'   then    index_val  else  0  end  )       as     其他
,sum(case when subject_code= 'NC01194'   then    index_val  else  0  end  )       as     期末有息负债余额
,sum(case when subject_code= 'NC01185'   then    index_val  else  0  end  )       as     物业商业余额
,sum(case when subject_code= 'NC01178'   then    index_val  else  0  end  )       as     开发成本延付
,sum(case when subject_code= 'NC01177'   then    index_val  else  0  end  )       as     土地款延付
,sum(case when subject_code= 'NC01036'   then    index_val  else  0  end  )       as     承兑到期
,sum(case when subject_code= 'NC01196'   then    index_val  else  0  end  )       as     供应链期末余额
,sum(case when subject_code= 'NC01031'   then    index_val  else  0  end  )       as     商票
,sum(case when subject_code= 'NC01174'   then    index_val  else  0  end  )       as     合作委贷_表内分出
,sum(case when subject_code= 'NC01160'   then    index_val  else  0  end  )       as     期初已获取
from        FINANCE.V_FUNDMONEY_POSITION
group by      ys_mon
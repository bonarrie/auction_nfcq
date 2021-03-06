#language: zh-CN

功能:报价人报价

	报价人通过登陆报价人页面，对项目进行报价。报价人所报价格必须符合所报项目的特定条件，才能成功提交。
	报价人报价时，需要通过以下验证，报价才能成功提交
	1、报价金额验证
		- 除反向报价外，其他报价类型的项目要求所报金额必须大于或等于项目底价。反向报价则要求所报金额小于或等于项目底价;
		- 对于限次报价，除第一次报价外，剩余次数所报金额必须大于等于“自身上一次所报价格“与”最小加价额”之和，但应小于等于“自身所报金额”与“最小加价额×最大加价倍数”之和；
		- 对于多次、双向、开放报价，所报金额必须大于等于“当前最新报价”与“最小加价额”之和，但应小于等于“当前最新报价”与“最小加价额×最大加价倍数”之和；
		- 对于反向报价，所报金额必须小于“当前最新报价”与“最小加价额”之和，但应大于等于“当前最新报价”与“最小加价额×最大加价倍数”之和，且大于0；
		- 对于有受让优先权的报价人，可以当前最新报价数值报价。
	2、报价条件验证
		- 剩余报价次数为0时，报价不能提交。
		- 在限次、多次、开放、反向报价中，当前为最新报价者的报价人不能继续加价（需等另一报价人报出最新报价后，才能继续报价）。

	背景:主持人建立项目、关联报价人并确认项目
		假如主持人登陆到系统，
		而且建立并保存了一个项目参数如下的报价项目
			* 项目底价：'1000'万元人民币；
			* 最小加价额：'10'万元人民币（反向报价则是'-10'，一次报价则无此配置）；
			* 最大加价倍数：'5'倍（一次报价无此配置）
		而且为该项目添加了如下报价人
		|登陆名			|报价代理人|报价人|
		|agt1{时间戳}	|陈一　　　|陈小明|
		|agt2{时间戳}	|梁二　　　|梁小丽|
		而且确认了该项目

		场景大纲:1、报价提交验证
			假如背景中的项目是某一<报价类型>项目
			假如报价人"agt1"登陆到系统 
			而且进入到该项目的报价页面
			假如报价项目处于如下状态：
				* 当前状态："报价中"
				* 当前价：<当前最新报价>
				* 最新报价人：<当前最新报价人>
				* 剩余报价次数:<剩余次数>
			而且agt1的报价记录显示了最近一次报价的金额为<上次报价>
			当报价人"agt1"提交了<本次报价>
			那么agt1应当看到提示<结果>
			而且应当看到报价页面的如下字段有变化
				* 当前价：<报价后最新报价>
				* 最新报价人：<报价后最新报价人>
				* 剩余报价次数:<报价后剩余次数> 

			例子:提交报价成功
			|报价类型　　　 |当前最新报价|当前最新报价人|剩余次数 |上次报价|本次报价 |结果   |报价后最新报价|报价后最新报价人|报价后剩余次数|
			|一次报价　　　 |不显示　　　|不显示　　　　|1　　　　|－－　　|1000　　|报价成功|不显示       |不显示　　　　  |0　　    　 |
			|限次报价（3次）|不显示　　　|暂无　　　　　|3　　　　|－－　　|1005　　|报价成功|不显示       |agt1          |2　　　     |
			|限次报价（3次）|不显示　　　|agt2　　　　 |2　　　　|1000　 |1010　　|报价成功|不显示       |agt1          |2　　　     |
			|多次/双向/开放 |暂无　　　　|暂无　　　   |无限次　 |－－　　|1000　　|报价成功|1000        |agt1          |无限次      |
			|多次/开放     |1010　　　 |agt2　　　　 |无限次　 |－－　　|1022　　|报价成功|1022        |agt1          |无限次      |
			|双向报价      |1010　　　 |agt1　　　　 |无限次　 |－－　　|1022　　|报价成功|1022        |agt1          |无限次      |
			|反向报价　　　 |暂无　　　　|暂无　　　　　|无限次　 |－－　　|1000　　|报价成功|1000        |agt1          |无限次      |
			|反向报价　　　 |990  　　　|agt2　　　　 |无限次　 |－－　　|880 　　|报价成功|880         |agt1          |无限次      |


			例子:剩余报价次数为0,不能提交报价
			-失败提示1：剩余报价次数为0,不能提交报价
			|报价类型　　　 |当前最新报价|当前最新报价人|剩余次数 |上次报价|本次报价|结果　　 |报价后最新报价|报价后最新报价人|报价后剩余次数|
			|一次报价　　　 |不显示　　　|不显示　　　　|0　　　　|1000　 |1010   |失败提示1|--          |--           |--          |
			|限次报价（3次）|不显示　　　|agt2／暂无　 |0　　　　|1035　 |1045   |失败提示1|--          |--           |--          |
			#”--“表示为空值或无变化

			例子:报价低于项目底价，报价提交失败
			- 失败提示2：报价不能低于项目底价
			|报价类型　　　 |当前最新报价|当前最新报价人|剩余次数 |上次报价|本次报价|结果　　 |报价后最新报价|报价后最新报价人|报价后剩余次数|
			|一次报价　　　 |不显示　　　|不显示　　　　|1　　　　|－－　　|999.99 |失败提示2|--          |--           |--          |
			|限次报价（3次）|不显示　　　|暂无　  　   |3　　　　|－－　　|999.99 |失败提示2|--          |--           |--          |
			|多次/双向/开放 |暂无　     |暂无　　　   |无限次　 |－－　　|999.99 |失败提示2|--          |--           |--          |

			例子:加价幅度不符合规定的最小加价额
			- 失败提示3：您的报价不能低于“自身上一次报价”与“最小加价额”之和
			- 失败提示4：您的报价不能低于“当前最新报价”与“最小加价额”之和
			- 失败提示5：您的报价不能高于“当前最新报价”与“最小加价额”之和
			|报价类型　　　 |当前最新报价|当前最新报价人|剩余次数 |上次报价|本次报价|结果　　 |报价后最新报价|报价后最新报价人|报价后剩余次数|
			|限次报价（3次）|不显示　　　|agt2　　　　 |2　　　　|1000　 |1009.9 |失败提示3|--          |--           |--          |
			|多次/双向/开放 |暂无　　　　|暂无　　　   |无限次　 |－－　　|1009.9 |失败提示4|--          |--           |--          |
			|反向报价　　　 |暂无　　　　|暂无　　　　　|无限次　 |－－　　|991.9  |失败提示5|--          |--           |--          |

			例子:加价倍数大于最大加价倍数
			-失败提示7：您的报价加价倍数大于最大加价倍数
			|报价类型　　　 |当前最新报价|当前最新报价人|剩余次数 |上次报价|本次报价|结果　　 |报价后最新报价|报价后最新报价人|报价后剩余次数|
			|限次报价（3次）|不显示　　　|agt2　　　　 |2　　　　|1000　 |1060   |失败提示7|--          |--           |--          |
			|多次/双向/开放 |暂无　　　　|暂无　　　   |无限次　 |－－　　|1051   |失败提示7|--          |--           |--          |
			|反向报价　　　 |暂无　　　　|暂无　　　　　|无限次　 |－－　　|949.9  |失败提示7|--          |--           |--          |

			例子:报价人连续报价
			-失败提示8：您是最新报价人，不能连续报价
			|报价类型　　　 |当前最新报价|当前最新报价人|剩余次数 |上次报价|本次报价|结果　　 |报价后最新报价|报价后最新报价人|报价后剩余次数|
			|限次报价（3次）|不显示　　　|agt1　　　　 |2　　　　|1000　 |1010   |失败提示8|--          |--           |--          |
			|多次/开放     |1010 　   |agt1 　　  　|无限次　 |1010 　|1030   |失败提示8|--          |--           |--          |
			|反向报价　　　 |990　　　　|agt1 　　  　|无限次　 |990 　 |950    |失败提示8|--          |--           |--          |



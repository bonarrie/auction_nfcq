#language: zh-CN

功能:主持人主持界面信息
	项目确认后，主持人便可进入到“主持报价”页面。
	在主持人界面能看到三大信息板块，分别是“报价记录”、“报价人登陆情况”及“项目详情”。
	其中，“报价人登陆情况”实时记录报价人离在线情况、登陆时间、报价操作状态等信息。
	”报价记录“实时记录报价人的所有报价记录情况。
	“项目详情”则记录了报价项目与报价有关的详细信息。
	现在我们需要对这些界面信息进行校验。

	背景:主持人建立项目、关联报价人并确认项目进入主持界面
		假如zcr1登陆到系统
		而且建立一个一次报价项目，并按照如下数据输入
		
		|项目编号　 |项目名称　　　　		|项目类型|项目主持人|项目底价|是否设置保证金|定时约定开始时间|定时约定结束时间|
		|YC{时间戳}|一次报价测试项目{时间戳}|物权	|主持人1  |100    |否          |{t}	 		 |{t}+1小时     |
		#t为当前系统时间

		而且zcr1保存了该项目并在项目的报价人页面关联了如下报价人

		|登陆名			|报价代理人|报价人|
		|agt1{时间戳}	|陈一　　　|陈小明|
		|agt2{时间戳}	|梁二　　　|梁小丽|

		而且返回项目信息页面确认了该项目
		当zcr1在项目信息页面点击”主持项目“按钮
		那么应当进入主持人主持界面

		场景:1、主持界面的”项目信息“表单信息校验
			当主持人进入到主持界面
			那么应当看到”项目详情“信息与下表中的信息一致

			|项目名称　　　　|一次报价测试项目{时间戳}|
			|项目编号　　　　|YC{时间戳}			|
			|底价	　　　　|100					|
			|报价模式　　　　|一次报价　			|
			|报价规则　　　　|定时报价				|
			|开始报价时间　　|{t}					|
			|结束报价时间　　|{t}+1小时			|
			|加价方式	　　　　|总价　				|
			|限制报价次数　　|1　					|
			|可低于最新报价　|是　					|
			|显示最新价格　　|是　					|
			|最新报价继续加价|否　					|
			|取消最新报价　　|否　					|

		场景:2、主持界面的”报价人登陆情况“信息校验
			当agt1在"t2{系统当前时间}"登陆到报价系统
			但是agt2没有登陆系统
			那么”报价人登陆情况“应该如下表
			|在线|代码				|报价人|优先级	|登陆时间|操作	|
			|在线|agt1{时间戳}@testorg|陈小明|0		|t2		|禁止报价|
			|离线|agt2{时间戳}@testorg|梁小丽|0		|  --   |禁止报价|

		场景:3、主持界面的”报价记录“校验
			当agt1登陆到系统
			而且进入到"一次报价测试项目{时间戳}"的报价页面
			而且在"t3{系统当前时间}"报价102万元
			那么在主持人页面应看到一条如下的报价记录
			|序号	|报价时间	|总金额	|增值率	|报价人|状态|
			|1　　	|t3		|--		|２％	|陈小明|正常|







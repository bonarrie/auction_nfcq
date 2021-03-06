#language: zh-CN

功能:给报价项目关联报价人
	报价项目建立后，需要把参与该项目竞价的报价人关联到项目的报价人列表，项目才能正常开展竞价。
背景: 
	假如 主持人（管理员）登陆到系统
	而且 在“未开始项目”列表中有一个“未确认”的报价项目
	而且 点击该项目链接打开了项目
	而且 主持人（管理员）选择了该项目信息页面的“报价人”页签
	而且 点击“新增报价人”按钮，打开了“新增项目报价人”页面
	场景大纲:
		当 主持人（管理员）输入如下报价人信息
		* 登录名是否系统生成:<登录名是否系统生成>
		* 登录名　　　　　　:<登录名>　　　　　　
		* 登陆密码　　　　　:<登陆密码>　　　　　
		* 报价代理人　　　　:<报价代理人>　　　　
		* 报价人　　　　　　:<报价人>　　　　　　
		* 报价优先级别　　　:<报价优先级别>　　　
		而且 点击“提交”按钮
		那么 应当看到页面提示“<结果>”
		而且 项目的报价人列表中<是否增加>了该报价人


		例子:报价人成功关联到项目
			新增的报价人并未存在于该项目的报价人列表中
		|登录名是否系统生成|登录名　　　|登陆密码  |　报价代理人　　　 |报价人        |报价优先级别 |结果　　　　　　　　　|是否增加|
		|否　　　　　　　　|agt{时间戳}|123      |代理人{时间戳}    |报价人{时间戳} |0　　　　　　|保存成功　　　　　　　|增加　　|
		|是　　　　　　　　|————      |123      |代理人{时间戳}    |报价人{时间戳} |0　　　　　　|保存成功　　　　　　　|增加　　|


		例子:成功关联一个已存在于系统中的报价人
			新增的报价人已存在于系统的报价人列表中
		|登录名是否系统生成|登录名　　　|登陆密码  |　报价代理人　　　 |报价人        |报价优先级别 |结果　　　　　　　　　|是否增加|
		|否　　　　　　　　|bjr3      |123      | ————           |报价人{时间戳} |0　　　　　　|保存成功　　　　　　　|增加　　|


		例子:报价人关联项目失败
			假如bjr3已存在于该项目的报价人列表中
		|登录名是否系统生成|登录名　　　|登陆密码  |　报价代理人　　　 |报价人        |报价优先级别 |结果　　　　　　　　　|是否增加|
		|否　　　　　　　　|bjr3      |123      | ————           |报价人{时间戳} |0　　　　　　|保存成功　　　　　　　|增加　　|


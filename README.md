### 在线投票项目 servlet + mysql
[TOC]

需求见需求文档

#### 接口设计

方便使用拦截器进行权限控制，对需要拦截的页面和servlet添加前缀

- 未注册用户
|  页面  |     url      | 渲染模式 |
| :----: | :----------: | :------: |
| 登陆页 |  login.jsp   | Cookie |
| 注册页 | register.jsp | Ajax请求 |
|  首页  |  index.jsp   | El/jstl/ajax/json |
| 投票页 |  vote.jsp   | jsp |
|错误页|error.jsp|jsp|

|  功能  |     url      | Servlet |参数|输出|
|:----:|:----------:|:------:|:------:|:------:|
|注册|sign/register?|signServlet|注册参数 |登陆页/注册页|
|登陆|sign/login?|SignServlet|登陆参数|登陆页/首页|
|注册参数重复检查|Check/{type}/{arg0}|CheckServlet|检查类型和参数|json|
|请求注册验证码|Sign/verify?|SignServlet||验证码图片|
|进入投票页面|Vote/view?|VoteServlet|投票id|投票页|
|获取投票列表|Vote/list?|voteServlet|分页参数|投票列表json|
|搜索投票|Vote/search？|VoteServlet|查询参数，分页参数|投票列表json|

- 注册用户

|  页面  |     url      | 渲染模式 |
| :----: | :----------: | :------: |
|投票结果页|Voted/result.jsp|Jsp|
|个人中心页|user/my.jsp|Jsp|
||||
|添加投票页|VoteManage/add.jsp||
|我的投票页面|VoteManage/myvote.jsp|ajax|

|功能|url|servlet	|参数	|输出|
|:----:|:----------:|:------:|:------:|:------:|
|查看个人信息	|User/my?|	userServlet|	用户id|	个人中心页面|
|修改个人信息	|User/info/update?	|userServlet	|用户id，修改内容|	Ajax请求，返回修改后的个人信息|
|参与投票|Voted/vote?|VotedServlet|投票参数|投票结果/投票展示|
|查看我的投票|Voted/myvote?|VotedServlet|用户id|我的投票列表Json|
|查看投票结果	|Voted/result?	|VotedServlet|	投票id|	投票结果页|
|添加投票	|Voted/add?	|VotedServlet|	投票数据|	投票列表Json|
|修改投票	|Voted/update?	|VotedServlet	|投票id，投票数据	|投票列表Json|
|删除投票	|Voted/delete?	|VotedServlet	|投票id	|投票列表Json|
|导出结果	|Voted/export?	|VotedServlet	|投票id组	|文件|

- > 管理员

|页面	|url	|渲染模式|
| :----: | :----------: | :------: |
|用户管理	|Admin/user.jsp|	Ajax|

|功能	|url	|servlet	|参数	|输出|
|:----:|:----------:|:------:|:------:|:------:|
|添加用户	|Admin/user/add?	|UserManageServlet	|用户参数	|用户列表Json|
|删除用户	|Admin/user/del?	|UserManageServlet	|用户id	|用户列表|
|修改用户	|Admin/user/update?	|UserManageServlet	|用户参数	|用户列表|
|查看用户	|Admin/user/list？|	UserManageServlet		|分页参数|用户列表|



####  6/30 投票模块之 新增投票

##### 1. 提交数据

新增投票功能，前端使用表单post提交路径如下：

```
Voted/add
```

提交数据如下
```
voteTitle=title&voteType=type&voteEnd=endTime&option=optiontitle

不支持图片

voteTitle=title&
voteType=type&
voteEnd=endTime&
option=optiontitle&
img=url

```

分别表示

|参数	|说明	|
| :----: | :----------: |
|voteTitle|投票的标题|
|voteType|投票的类型，单选/多选|
|voteEnd|投票截止时间|
|option|投票选项，可有多个参数|
|img|投票选项图片，可有多个参数|
#####  2.后端处理
- VotedServlet

根据后缀url分发到subject方法处理，从session中获取当前用户id作为投票发起人id。取出请求数据封装成VoteSubject 类调用SubjectService处理添加投票业务逻辑，如果产生异常，定向到错误页面，成功则返回到投票列表。

- SubjectService

因为数据库中投票表和选项表是分开的，因此需要分开插入，且需要获取插入后的subjectId，再插入option。而且需要添加事务，保证投票和选项能同时提交到数据库。

- Dao

为了避免一个类的方法过于臃肿，即使option类聚合在object类中，也添加两个数据库持久类，分别对应数据库中的两个表，另一方面也方便Service层进行事务控制。如果产生异常均抛到Servlet处理。
在MySql中，有一条语句是获取最新插入自增长的ID值，为了线程安全，需要使用同一个Connecttion才能保证ID与option对应。

```
SELECT LAST_INSERT_ID()
```

####  7/1  投票模块之 投票管理 与 投票查询

投票查询是获取现有的 投票列表，进入投票详情，进行模糊搜索
投票管理是在新增投票之后对现有投票信息的 删除和修改

##### 获取投票列表
投票列表是网页中的一个模块，因此返回json格式，使用jquery插入到网页中。

post地址：
```
vote/list
```
提交参数
```
分页参数 page=0&row=10
某用户的投票 my=true?
模糊查询 word=?
```
返回结果：
投票列表json

- 后台处理 voteServlet
1.处理请求地址进行分发。
2.获取分页参数，如果未提交设置默认值
3.获取‘my’参数
4.获取‘模糊查询‘参数'

- Service
因为有不同的查询方式，可以在service中决定查询的sql语句

- dao
只需要提供一个查询接口，返回投票列表

##### 删除投票
也就是置投票状态为删除值
采用ajax

##### 更新投票
用户可以修改的内容包括
（投票标题，类型，截止时间，投票选项）
使用add.jsp 做投票修改参数提交页面。
采用jstl标签绑定投票数据。

servie中控制dao层事务，先删除原有选项，添加现在选项。


#### 用户模块之 登陆注册

##### 注册模块 数据检查
使用ajax对输入数据进行重复性检查

1.	用户名检查：check/username/{arg}  调用service检查该用户名是否可用且符合格式,用户名格式为: 字母开头，包含数字字母下划线的 字符串
返回： {“result” : “true”,”data”:”该账号可用”}  {“result” : “false”,”data”:”该账号不可用”}
2.	手机号注册：check/phone/{arg} 调用service检查手机号是否已经注册，未注册发送验证码。注册返回已注册
返回: {“result” : “true”,”data”:”url”}  /   {“result” : “false”,”data”:”该手机已注册”}

3.	请求注册码：Sign/verify 调用 注册码 模块生成注册码返回
	注册码类
4.	注册 Sign/register?  ， 先将请求参数手动封装成user类，然后使用user的自检函数（查看参数是否正确）。 调用service 插入数据到数据库，如果插入失败则注册失败。
注册成功返回登陆页面，注册失败返回注册页面



7/2

今日任务，登陆/投票

#####  用户模块の登陆
1.数据校验
servlet 将 前台页面提交数据 作为 数据库检索参数 ，调用service进行查找封装成User类，且返回。

2.记录状态 
servlet将 service返回的user类，存储入session中，保证用户会话权限访问正常。

3.保存cookie
servlet将用户提交的数据，存入cookie。

4.退出
sign/logout
将session失效，重定向到登陆页。


#####  投票模块の参与投票

|进入投票页面|Vote/view?|VoteServlet|投票id|投票页|

1.获取传递参数 投票id
2.根据投票id获取 投票信息
3.渲染  voting.jsp

4.前台提交 投票数据
5.接收投票数据  从 session 读取用户id
6.插入数据
7.展示结果

#####  投票模块の投票结果
统计每个选项的投票人数，计算比值。
voted/result?	|VotedServlet|	投票id|	投票结果页

根据投票id，获取item表中对应的选项与统计其数量

##### 前台页面の首页

### 7/3 继续前台 

### 7/4 前台

#### 个人中心
个人投票
异步请求数据加载
展示信息 投票标题，是否待图片投票，当前状态（进行中，已结束），查看详情，维护（下拉菜单）

密码修改

#### 投票维护页面

#### 展示时间

//管理员用户管理

### 7/5 分页和搜索

投票列表分页
//简单の切换上页和下页（分页数据采用pojo类存储）

用户选了什么 要展示




搜索

用户列表分页 ok
普通用户不可发起投票 ok







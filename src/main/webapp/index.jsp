<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<link rel="stylesheet" href="class/1.css">
<link rel="stylesheet" href="css/buttons.css">
<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- <script src="js/jquery-3.2.1.min.js"></script> -->
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script src="js/login.js"></script>
<link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/login.css">
<link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

<style>

			body{
			
		}
		
		.header{
			//height: 150px;
			background-color: #F7F7F7;
			position: fixed;
			top: 0px;
			width: 100%;
			box-shadow: #CCCCCC 10px 10px 20px;
		}
		
		
		
		.middle{
			margin-top: 100px;
			padding-top: 30px;
			//background-color: #F3F3F3;
			height: 1000px;
		}
		
		.option{
			height: 80px;
			line-height: 80px;
			background-color: #F3F3F3;;
			padding-left: 5%;
			
		}
		
		.option label{
			width: 70%;
		}
		
		.None{
			display: none;
		}
		
	</style>
</body>
</head>
	<div class="header">
		<nav class="navbar navbar-default">
			<div class="container-fluid">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					 aria-expanded="false">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#">在线投票</a>
				</div>

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li class="active"><a href="#">首页 <span class="sr-only">(current)</span></a></li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">其他
								<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="#">Action</a></li>
								<li><a href="#">Another action</a></li>
								<li><a href="#">Something else here</a></li>
								<li role="separator" class="divider"></li>
								<li><a href="#">Separated link</a></li>
								<li role="separator" class="divider"></li>
								<li><a href="#">One more separated link</a></li>
							</ul>
						</li>
					</ul>

					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">我的
								<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="#">个人中心</a></li>
								<li><a href="#">登陆</a></li>

							</ul>
						</li>
					</ul>

					<form class="navbar-form navbar-right">
						<div class="form-group">
							<input type="text" class="form-control" placeholder="Search">
						</div>
						<button type="submit" class="btn btn-default">搜索</button>
					</form>

				</div><!-- /.navbar-collapse -->
			</div><!-- /.container-fluid -->
		</nav>
		<div>广告位招租</div>

	</div>
	<div class="container middle">
		<div id="voteList">
			

		</div>
		
		
		<div class="col-lg-3 " id="voteDef" >
			<img class="img-circle" src="" alt="Generic placeholder image" width="140" height="140">
			<h2>投票标题</h2>
			<p class="desc">投票描述，投票人数，截止时间</p>
			<p><a class="btn btn-default" href="#" role="button">点我参与 »</a></p>
		</div><!-- /.col-lg-4 -->
		
		<hr>

	</div>



	</body>
	<script type="text/javascript">
		var voteList;
		var page = 1,
			row = 12;

		//初始准备,加载列表
		$(document).ready(function() {
			voteList = $("#voteList");
			console.log(voteList);
			getVoteListuser("page=" + page + "&row=" + row);
		});

		function test(data) {
			var n = 0;
			//var dataObj = eval("("+data+")"); //这里要加上加好括号和双引号的原因我也不知道，就当是json语法，只能死记硬背了
			var newVote = $("<div class='row'>");
			$.each(data, function(idx, item) {
				//添加投票到一列
				var col = $("#voteDef").clone(true);
				col.attr("id","addDiv"+idx); 
				//设置图片
				var img=col.find("img");
				img.attr("src","img/vote.jpg");
				//设置描述
				var desc= col.find(".desc");
				desc.html(item.endDay);
				//设置标题
				var title= col.find("h2");
				title.html(item.titile);
				//设置链接
				var a= col.find("a");
				a.attr("href","vote/view?id=" + item.id );
				
				newVote.append(col);
				n++;
				if(n%4 ==0){
					voteList.append(newVote);
					//新建一列
					newVote = $("<div class='row'>");
				}
				 //
				console.log(voteList);
				newVote.appendTo(voteList);

		
			})
			$("#voteDef").hide();
		}

		//用户获取投票
		function getVoteListuser(data) {
			
			voteList.html(""); // 清空
			//转换json
			//console.log(jsoData);
			$.ajax({
				type: "GET",
				url: "http://localhost:8080/VoteOnline/vote/list",
				dataType: "jsonp", //数据类型为jsonp  
				jsonp: "Callback", //服务端用于接收callback调用的function名的参数  
				jsonpCallback: "test",
				success: function(data) {},
				error: function() {
					alert("fail");
				}
			});

		}

		//获取投票列表
		function getVoteList(data) {
			voteList = $("#voteList");
			voteList.html(""); // 清空
			//转换json
			var jsoData = Ajax("http://localhost:8080/VoteOnline/vote/list", data);
			//console.log(jsoData);

			var dataObj = eval("(" + jsoData + ")"); //这里要加上加好括号和双引号的原因我也不知道，就当是json语法，只能死记硬背了
			$.each(dataObj, function(idx, item) {

				var div = "<div id='" + item.id + "'> " + item.titile +
					"<a href='voted/update?id=" + item.id + "'> 修改 </a>" +
					"<button onclick=del(" + item.id + ")> 删除 </button>" +
					" </div>"
				voteList.append(div);
				//console.log(item);   
			})

		}

		//删除
		function del(subjectid) {
			var r = Ajax("voted/delete", "id=" + subjectid);
			console.log(r);
			if (r == "true") {
				//重新获取list
				getVoteList("page=" + page + "&row=" + row);
			} else {
				alert("删除失败，请重试");
			}
		}


		function Ajax(url, da) {
			var returnData;
			console.log(da);
			$.ajax({
				type: "post",
				data: da,
				url: url,
				processData: false,
				async: false,
				success: function(data) {
					returnData = data;
				},
				error: function() { // 这个用的比较少
					alert("error");
				}
			})
			return returnData;
		}
	</script>
</html>

</html>

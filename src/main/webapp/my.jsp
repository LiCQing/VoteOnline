<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="component/header.jsp" %>


<style type="text/css">
		* {
			margin: 0;
			padding: 0;
		}

		#mobile-menu {
			box-shadow: #999999 10px 10px 20px;
			position: fixed;
			top: 100px;
			left: 10%;
			width: 10%;
			height: 500px;
			background-color: #EAEFF3;
			z-index: 9999;
			padding-top:100px;
			
		}
		
		#mobile-menu ul{
			list-style: none;
		}

		a:hover,
		a:focus {
			text-decoration: none
		}

		.mobile-nav ul li a {
			color: gray;
			display: block;
			padding: 1em 5%;
			border-top: 1px solid #DDE4FF;
			border-bottom: 1px solid #DDE4FF;
			text-align: center;
			cursor: pointer;

		}

		.mobile-nav ul li a:hover {
			background-color: #ccc;
			color: #000;
		}
		
		.selected{
			background-color: #ccc;
			color: #000;
		}

		.blank {
			margin-left: 15%;
		}
		
		
	</style>
	
		<div class="container">
		
		<div id="app" class="middle"> 
					<div id="mobile-menu" class="mobile-nav">
						<ul>
							<li> <a class="btn btn-default" data-toggle="tab" href="#home" role="button">我发起的投票</a></li>
							<li> <a class="btn btn-default" data-toggle="tab" href="#join"  role="button">我参与的投票</a></li>
							<c:if test="${currentUser.vervion==2 }">
								<li> <a class="btn btn-default" data-toggle="tab"  href="#usermanage"  role="button">用户管理</a></li>
								<li> <a class="btn btn-default" data-toggle="tab"  href="#allvote"  role="button">所有投票</a></li>
							</c:if>
							<li>   <a class="btn btn-default" data-toggle="tab" href="#userInfo" role="button">个人信息</a></li>
							<li>   <a class="btn btn-default" data-toggle="tab" href="#updatePass" role="button">修改密码</a></li>
							
						
						</ul>
					</div>
					<div class="blank">
						<div id="myTabContent" class="tab-content">
							<div class="tab-pane fade in active" id="home">
									<div class="row">
										<div class="col-md-9"  >
											<h2>我发起的投票</h2>
												
										</div>
										<div class="col-md-3" style="height: 63px;position: relative;" >
											<c:if test="${currentUser.vervion==0 }">
												<c:if test="${currentUser.freeTimes==0}">
												  <a href="filluserinfo.jsp" style="position: absolute;bottom: 0">
												</c:if>
												<c:if test="${currentUser.freeTimes!=0}">
												  <a href="add.jsp" style="position: absolute;bottom: 0">
												</c:if>
												        剩余免费发起投票次数：${currentUser.freeTimes} </a>
											</c:if>
											<c:if test="${currentUser.vervion!=0 }">
												<a href="add.jsp" style="position: absolute;bottom: 0"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>发起投票</a>
											</c:if>
											
										</div>
									</div>
									
									<hr>
									<div id="myvoteList">
											<table class="table table-striped table-hover">
															<thead>
														        <tr>
														          <th>#</th>
														          <th>状态</th>
														          <th>标题</th>
														          <th>热度</th>
														          <th class="center">操作</th>
														        </tr>
														      </thead>
														      <tbody>
															  </tbody>
														</table>
									</div>
									<nav id="myPage" aria-label="">
										  <ul class="pager">
										    <li class="previous"><a role="button"><span aria-hidden="true">&larr;</span>上一页</a></li>
										    <li class="next"><a role="button">下一页<span aria-hidden="true">&rarr;</span></a></li>
										  </ul>
									</nav>
							</div>
							<div class="tab-pane fade" id="join">
										<div class="row">
													<div class="col-md-10"  >
														<h2>我参与的投票</h2>
													</div>
												</div>
												
												<hr>
												<div id="myjoinvote">
													<table class="table table-striped table-hover">
															<thead>
														        <tr>
														          <th>#</th>
														          <th>状态</th>
														          <th>标题</th>
														          <th>热度</th>
														          <th class="center">操作</th>
														        </tr>
														      </thead>
														      <tbody>
															  </tbody>
														</table>
												</div>
												<nav id="joinPage" aria-label="">
													  <ul class="pager">
													    <li class="previous"><a role="button"><span aria-hidden="true">&larr;</span>上一页</a></li>
													    <li class="next"><a role="button">下一页<span aria-hidden="true">&rarr;</span></a></li>
													  </ul>
												</nav>
							</div>
							
							
							<div class="tab-pane fade" id="allvote">
										<div class="row">
													<div class="col-md-10"  >
														<h2>所有用户投票</h2>
													</div>
												</div>
												
												<hr>
												<div id="myjoinvote">
													<table class="table table-striped table-hover">
															<thead>
														        <tr>
														          <th>#</th>
														          <th>状态</th>
														          <th>标题</th>
														          <th>热度</th>
														          <th class="center">操作</th>
														        </tr>
														      </thead>
														      <tbody>
															  </tbody>
														</table>
												</div>
												<nav id="joinPage" aria-label="">
													  <ul class="pager">
													    <li class="previous"><a role="button"><span aria-hidden="true">&larr;</span>上一页</a></li>
													    <li class="next"><a role="button">下一页<span aria-hidden="true">&rarr;</span></a></li>
													  </ul>
												</nav>
							</div>
							
							
							<div class="tab-pane fade" id="userInfo">
												<hr>
										 <div class="userInfo">
												
										 <div id="baseInfo" class="panel panel-info"> 
										 	<div class="panel-heading"> <h4 class="center">个人信息</h4></div>
											 <div class="panel-body">
											    <com-info :title="'用户名'" :text="myinfo.name"></com-info>
											    <com-info :title="'昵称'" :text="myinfo.nick"></com-info>
											    <com-info :title="'手机号'" :text="myinfo.phone"></com-info>
											    <com-info :title="'性别'" :text="getSex"></com-info>
											    <com-info :title="'生日'" :text="getbirthDay"></com-info>
											    <com-info :title="'职业'" :text="getcareer"></com-info>
											    <com-info :title="'所在地'" :text="getaddr"></com-info>
											    <com-info :title="'爱好'" :text="getHobby"></com-info>
											    <com-info :title="'加入网站'" :text="getInnerDay + '天'"></com-info>
											  </div>
											  <c:if test="${currentUser.vervion == 0}">
											  <div class="panel-footer"> <a href="filluserinfo.jsp">补全个人信息可获得额外发布投票机会</a></div>
												 
											  </c:if>
										 </div>
										 
										 
										 </div>
												
							</div>
							
							<div class="tab-pane fade" style="height: 500px" id="updatePass">
								<form>
									  <div class="form-group">
									    <label for="exampleInputPassword1">原始密码</label>
									    <input type="password" class="form-control" id="oldPass" placeholder="Password">
									  </div>
									  <div class="form-group">
									    <label for="exampleInputPassword1">新密码</label>
									    <input type="password" class="form-control" id="newPass" placeholder="Password">
									  </div>
									  <div class="form-group">
									    <label for="exampleInputPassword1">确认新密码</label><span id="np_s"></span>
									    <input type="password" class="form-control" id="newPass2" placeholder="Password">
									  </div>
									  <button type="button" id="changePass" class="btn btn-default">修改</button>
									</form>
							</div>
							
							<c:if test="${currentUser.vervion==2 }">
										<div class="tab-pane fade" id="usermanage">
											<div class="row">
														<div class="col-md-10"  >
															<h2>用户管理</h2>
														</div>
											</div>
													
											<hr>
											<div id="userlist">
												<table class="table table-striped table-hover">
														<thead>
													        <tr>
													          <th>#</th>
													          <th>用户名</th>
													          <th>手机</th>
													          <th>资格</th>
													          <th>状态(点击切换)</th>
													        </tr>
													      </thead>
													      <tbody>
														  </tbody>
												</table>
										<hr>
										<nav id="userPage" aria-label="">
										  <ul class="pager">
										    <li class="previous"><a role="button"><span aria-hidden="true">&larr;</span>上一页</a></li>
										    <li class="next"><a role="button">下一页<span aria-hidden="true">&rarr;</span></a></li>
										  </ul>
										</nav>
											</div>
										</div>
									
							</c:if>
						</div>
					</div>
					
			</div>
			<div id="btndef" class="btn-group None">
				  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				    测试<span class="caret"></span>
				  </button>
				  <ul class="dropdown-menu">
				    <li><a role="button" onclick="changeVersion(this)">正常</a></li>
				  </ul>
			</div>
			
												
		
			
			
			<div class="swith ">
					  
			</div>
			
		</div>
		
													<div id ="userinfoDef" class="None">
													    <com-info :title="'用户名'" :text="myinfo.name"></com-info>
													    <com-info :title="'昵称'" :text="myinfo.nick"></com-info>
													    <com-info :title="'手机号'" :text="myinfo.phone"></com-info>
													    <com-info :title="'性别'" :text="getSex"></com-info>
													    <com-info :title="'生日'" :text="getbirthDay"></com-info>
													    <com-info :title="'职业'" :text="getcareer"></com-info>
													    <com-info :title="'所在地'" :text="getaddr"></com-info>
													    <com-info :title="'爱好'" :text="getHobby"></com-info>
													    <com-info :title="'加入网站'" :text="getInnerDay + '天'"></com-info>
													  </div>
		
		<div class="footer">
		</div>
	</body>

	<script>
	//全局变量
	var userPage=1;
	var myvotePage=1;
	var myjoinPage=1;
	var allVotePage = 1;
	
	//管理员模块
	function getVersionClass(type){
		if(type==0){return "";}
		if(type==1){return "info";}
		if(type==2){return "warning";}
	}
	
	function getTypeName(type){
		if(type==0){return "普通";}
		if(type==1){return "高级";}
		if(type==2){return "管理员";}
	}

	function getVersionType(type){
		var btn = $("#btndef").clone();
		btn.removeClass("None");
		btn.find("button").html(getTypeName(type));
		if(type==0){
			btn.find("a").html("高级");
		}
		if(type==1){
			btn.find("a").html("普通");
		}
		if(type==2){
			btn.find("ul").remove();
		}
		return btn;
		console.log(btn.get(0));
		
		
	}
	
	function changeVersion(btn){
		var userid = $(btn).closest("td").siblings("input").val();
		var content = $(btn).html()=="高级"?"普通":"高级";
		//console.log($(btn).html()+":"+content)
		
		
		if(content=="高级"){
			var re= Ajax("admini/updateuser", "id=" + userid + "&type=0")
			if(re!="true"){
				alert("修改失败");
				return ;
			}
		}else{
			var re= Ajax("admini/updateuser", "id=" + userid + "&type=1")
			if(re!="true"){
				alert("修改失败");
				return ;
			}
		}
		
		$(btn).html(content);
		$(btn).append();
		
		
		//转换btn 展示的
		var a = $(btn).closest("ul").prev("button");
		a.html(content=="高级"?"普通":"高级");
		
		var tr = $(btn).closest("tr");
		tr.removeClass();
		if(content=="普通"){
			tr.addClass("info");
		}
		//console.log(userid);
	}
	
	function changeUserPre(){
		userPage--;
		getUserList();
	}
	
	function changeUserNext(){
		userPage++;
		getUserList();
	}
	var shoudShowtr;
	function showit(){
		var div = $(userinfoDef).clone();
		div.attr("id","13548");
		
		div.removeClass("None");
		var td=$("<td colspan='5'></td>");
		td.append(div);
		
		$("#userinfotr").remove();
		
		var addtr =$("<tr id='userinfotr'></tr>")
		addtr.append(td);
		
		$(shoudShowtr).after(addtr);
	}
	
	function lookUserInfo(userId,tr){
		shoudShowtr = tr;
		$.get("admini/userinfo","id="+userId,function(data){
			console.log(data);
			someOne.myinfo=eval("("+data+")");
			
			//setTimeout("showit()",3000,tr);
			
			
		});
	}
	
	function getUserList(){
		var jsoData = Ajax("admini/userlist", "page="+userPage+"&row=6");
		var page = eval("(" + jsoData + ")");
		console.log(page);
		var pageNav = $("#userPage");
		if(!page.hasPre){
			pageNav.find(".previous").addClass("disabled");
			pageNav.find(".previous").unbind();
		}else{
			pageNav.find(".previous").removeClass("disabled");
			pageNav.find(".previous").attr("onclick","changeUserPre()");
		}
		if(!page.hasNext){
			pageNav.find(".next").addClass("disabled");
			pageNav.find(".next").unbind();
		}else{
			pageNav.find(".next").removeClass("disabled");
			pageNav.find(".next").attr("onclick","changeUserNext()");
		}
		
		var userList =page.list;
		var body = $("#userlist").find("tbody");
		body.html("");
		for(i in userList){
			//console.log(i);
			//console.log(userList[i]);
			//var tr ="<tr class='"+ getVersionClass(userList[i].vervion) +"'>";
			var tr = $("<tr onclick=lookUserInfo("+userList[i].id+",this)></tr>")
			tr.addClass(getVersionClass(userList[i].vervion));
			var index  =(userPage-1)*6 + Number(i)+1;
			tr.append("<th scope='row'>" +index+ "</th>");
			tr.append("<td>"+userList[i].name+"</td>");
			tr.append("<td>"+userList[i].phone+"</td>");
			var visonBtn = $("<td></td>")
			visonBtn.append(getVersionType(userList[i].vervion));
			tr.append(visonBtn);
			var statu=userList[i].status; //==0?"正常":"停用";
			/*
				设置按钮
				<div> <input type='checkbox' id='simple_3'> <label for='simple_3' class='green'></label> </div>
			*/
			
			var switc= "<div>正常</div>";
			if(userList[i].status == -1){
				switc= "<div>  <span class='glyphicon glyphicon-remove red' aria-hidden='true'></span> 不可用 </div>";
			}
			var td;
			
			if(userList[i].vervion==2){
				td=$("<td>无权修改</td>");
			}else{
				td=$("<td onclick='changeStatus(this,"+userList[i].id+")'></td>");
				td.append(switc);
			}
			
			tr.append(td);
			tr.append("<input type='hidden' value='"+userList[i].id+"'>");
			body.append(tr)
	
		}
		
	}
	function changeStatus(td,id){
		var span = $(td).find("div").find("span");;
	 	var doit;
	 	
	 	var status;
	 	
	 	console.log(td);
	 	
	 	if(span.length==0){
	 		doit =confirm("确认禁用该账户？")
	 		status = -1;
	 	}else{
	 		doit =confirm("确认启用该账户？")
	 		status = 0;
	 	}
	 	
	 	if(doit==true){
	 		$.post("admini/updateuser","id="+id+"&type=status&status="+status,function(data){
	 			if(data!="true"){
		 			alert(data);
		 		}else{
		 			if(status == 0){
		 				$(td).html("<div>正常</div>");
		 			}else{
		 				$(td).html("<div>  <span class='glyphicon glyphicon-remove red' aria-hidden='true'></span> 不可用 </div>");
		 			}
		 			//console.log(status);
		 		}
	 		});
	 		
	 	}
	 	
	}
	
	
	/*左边导航标签点击*/
		var alist;
		$(function(){
			alist = $("#mobile-menu").find("a");
			alist.each(function(i,item){
				$(item).click(function(){
					allUnSelect();
					$(this).addClass("selected");
				});
			});
		})
		
		function allUnSelect(){
			alist.each(function(i,item){
					$(item).removeClass("selected");
			});
		}
		/*投票列表加载*/
		var voteList;
		var joinList;
		var imgF="<i class='fa fa-file-image-o'></i>";
		var page=1;row=10;
		$(function(){ 
			
			
			joinList=$("#myjoinvote");
			getVote();
			getJoin();
			getUserList();
			getAllVote();
			
			$("#changePass").click(function(){
				var old = $("#oldPass").val();
				var np = $("#newPass").val();
				var np2 = $("#newPass2").val();
				if(np != np2){
					//$("#np_s").html("两次新密码不同");
					alert("两次新密码不同");
					return ;
				}
				if(!checkOldPass(old,np)){
					return ;
				}
				
				//console.log(old+ " " + np + " " + np2);
				//console.log(11);
			});
		});
		
		function changePass(pass){
			$.get("sign/changePass","pass="+pass,function(data){
				alert(data);
			});
		}
		
		function checkOldPass(pass,np){
			$.get("sign/checkPass","pass="+pass,function(data){
				if(data!="true")
				  alert(data);
				else{
					changePass(np);
				}
			});
		}
		
		//载入投票列表
		function isEnd(time){
			var timestamp=new Date().getTime();
			return time < timestamp;
		}
		
		function getVote(){ //我的投票
			voteList=$("#myvoteList");
			
			var  mylistbody= voteList.find("tbody");
			mylistbody.html("");	
			
			var jsoData = Ajax("vote/list", "my=true&row=6&page="+myvotePage);
		
			var pagedata = eval("(" + jsoData + ")");
			
			console.log("------我的投票------")
			
			console.log(pagedata)
			var pageNav = $("#myPage");
			if(!pagedata.hasPre){
				pageNav.find(".previous").addClass("disabled");
				pageNav.find(".previous").unbind();
			}else{
				pageNav.find(".previous").removeClass("disabled");
				pageNav.find(".previous").click(function(){
					myvotePage--;
					getVote();
				});
			}
			if(!pagedata.hasNext){
				pageNav.find(".next").addClass("disabled");
				pageNav.find(".next").unbind();
			}else{
				pageNav.find(".next").removeClass("disabled");
				pageNav.find(".next").click(function(){
					myvotePage++;
					getVote();
				});
			}
			
			var dataObj=pagedata.list;
			if(dataObj.length==0){
				voteList.append("暂未发起投票");
			}else{
				
				
				//loadList(voteList,dataObj);
				for(i in dataObj){
					
						var tr = $("<tr></tr>")  //一行
						var index  =(myvotePage-1)*6 + Number(i)+1;
						tr.append("<th scope='row'>" +index+ "</th>");  //行号
						//状态
						var status = "";
						if(isEnd(dataObj[i].end)){
							status ="<span class=''> 已结束 </sapn>"
						}else{
							status ="<span class=''> 进行中 </sapn>"
						}
					
						tr.append("<td>"+status+"</td>");  
						
						tr.append("<td>"+dataObj[i].titile+"</td>");  //标题
					
						//参与人数
						var str = "暂无人参与";
						if(dataObj[i].count > 0){
							str = "已有"+dataObj[i].count+"人参与";
						}
						
						tr.append("<td >"+str+"</td>");
						
						//维护
						var str = "";
						if(dataObj[i].count == 0){
							str = str + "<a  href='voted/update?id=" + dataObj[i].id +"' class='btn btn-default' > 修改 </a>";
						}else{
							str = str + "<a href='#' class='btn btn-default disabled' > 不可修改 </a>";
						}
						str = str + "<a  class='btn btn-default' href='voted/delete?id=" + dataObj[i].id +"'> 删除 </a>";
						str = str + "<a  class='btn btn-default' href='voted/result?id=" + dataObj[i].id +"'> 查看结果 </a>";
						
						tr.append("<td class='Right'> "+str+"  </td>");
						 
						mylistbody.append(tr)
						
					}
			}
		}
		
		function getJoin(){
			var jsoData = Ajax("voted/myvote", "row=6&page="+myjoinPage);
			var pagedata = eval("(" + jsoData + ")");
			
			
			var pageNav = $("#joinPage");
			if(!pagedata.hasPre){
				pageNav.find(".previous").addClass("disabled");
				pageNav.find(".previous").unbind();
			}else{
				pageNav.find(".previous").removeClass("disabled");
				pageNav.find(".previous").click(function(){
					myjoinPage--;
					getJoin();
				});
			}
			if(!pagedata.hasNext){
				pageNav.find(".next").addClass("disabled");
				pageNav.find(".next").unbind();
			}else{
				pageNav.find(".next").removeClass("disabled");
				pageNav.find(".next").click(function(){
					myjoinPage++;
					getJoin();
				});
			}
			var joinTable=joinList.find("tbody");
			joinTable.html("");
			var dataObj = pagedata.list;			
			if(dataObj.length==0){
				joinList.append("暂未参与投票，点此参与~");
			}else{
				for(i in dataObj){
					
					var tr = $("<tr></tr>")  //一行
					var index  =(myjoinPage-1)*6 + Number(i)+1;
					tr.append("<th scope='row'>" +index+ "</th>");  //行号
					//状态
					var status = "";
					if(isEnd(dataObj[i].end)){
						status ="<span class=''> 已结束 </sapn>"
					}else{
						status ="<span class=''> 进行中 </sapn>"
					}
				
					tr.append("<td>"+status+"</td>");  
					
					tr.append("<td>"+dataObj[i].titile+"</td>");  //标题
				
					//参与人数
					var str = "暂无人参与";
					if(dataObj[i].count > 0){
						str = "已有"+dataObj[i].count+"人参与";
					}
					
					tr.append("<td >"+str+"</td>");
					
					//查看
					 var str = "<a  class='btn btn-default' href='voted/result?id=" + dataObj[i].id +"'> 查看结果 </a>";
					
					tr.append("<td class='center'> "+str+"  </td>");
					 
					joinTable.append(tr)
					
				
					}
			}
		}
		
		//获取所有投票
		function nextPageVote(){
			allVotePage--;
			getAllVote();
		}
		
		function prePageVote(){
			allVotePage++;
			getAllVote();
		}
		function getAllVote(){
			var jsoData = Ajax("admini/allvote", "row=6&page="+allVotePage);
			var pagedata = eval("(" + jsoData + ")");
			console.log("------所有投票---------");
			console.log(pagedata);
			var pageNav = $("#allvote");
			if(!pagedata.hasPre){
				pageNav.find(".previous").addClass("disabled");
				pageNav.find(".previous").unbind();
			}else{
				pageNav.find(".previous").removeClass("disabled");
				pageNav.find(".previous").attr("onclick","nextPageVote()");
			}
			if(!pagedata.hasNext){
				pageNav.find(".next").addClass("disabled");
				pageNav.find(".next").unbind();
			}else{
				pageNav.find(".next").removeClass("disabled");
				pageNav.find(".next").attr("onclick","prePageVote()"); 
			}
			var joinTable=$("#allvote").find("tbody");
			joinTable.html("");
			var dataObj = pagedata.list;			
			if(dataObj.length==0){
			}else{
				for(i in dataObj){
					console.log(dataObj[i]);
					var tr = $("<tr></tr>")  //一行
					var index  =(allVotePage-1)*6 + Number(i)+1;
					tr.append("<th scope='row'>" +index+ "</th>");  //行号
					//状态
					var status = "";
					if(isEnd(dataObj[i].end)){
						status ="<span class=''> 已结束 </sapn>"
					}else{
						status ="<span class=''> 进行中 </sapn>"
					}
				
					tr.append("<td>"+status+"</td>");  
					
					tr.append("<td>"+dataObj[i].titile+"</td>");  //标题
				
					//参与人数
					var str = "暂无人参与";
					if(dataObj[i].count > 0){
						str = "已有"+dataObj[i].count+"人参与";
					}
					
					tr.append("<td >"+str+"</td>");
					
					//查看
					 var str = "<a  class='btn btn-default' href='voted/result?id=" + dataObj[i].id +"'> 查看 </a><a  class='btn btn-default' onclick='AdmiDel("+dataObj[i].id+")' > 删除 </a>";
					
					tr.append("<td class='center'> "+str+"  </td>");
					 
					joinTable.append(tr)
					
				
					}
			}
		}
		
		function AdmiDel(id){
			var r = confirm("确认删除该投票？")
			if(!r ) return ;
			$.post("admini/delete","id="+id,function(data){
				if(data=='true'){
					getAllVote();
				}else{
					layer.msg("删除失败");
				}
			});
		}
		
		//Vue扩展
		Vue.component('com-info',{
			props: ['title','text'],
			template:"<div class='row'> <label class='col-md-2 control-label text-right'>{{title}}:</label>" + 
			  "<label class='col-md-10 control-label'>{{text}}</label> </div>"	
		}
		);
		
		var arrpro=[{id:'0',value:"请选择省份"},
		            {id:'1',value:"河北省"},
		            {id:'2',value:"湖南省"}];
		
		var arrcit=[[{id:'0',value:"请选择城市"}],
		            [{id:'1',value:"石家庄"},{id:'2',value:"邯郸"},{id:'3',value:"唐山"}],
		            [{id:'4',value:"长沙"},{id:'5',value:"张家界"},{id:'6',value:"吉首"}]];
		
		var arrhobby=[{id:'0',value:"运动"},
		              {id:'1',value:"娱乐"},
			          {id:'2',value:"冒险"},
		              {id:'3',value:"收藏"},
			          {id:'4',value:"乐器"},
		              {id:'5',value:"文艺"},
			          {id:'6',value:"游戏"},
		              {id:'7',value:"手工"},
			          {id:'8',value:"学习"}];
		
		var arrCcate=[{id:'0',value:"请选择职业类别"},
					{id:'0',value:"IT业"},
					{id:'0',value:"教育业"},
					{id:'0',value:"其他行业"}];
		
		var arrCdetail=[[{id:'0',value:"请选择职业"}],
		                [{id:'1',value:"程序员"},{id:'2',value:"系统分析员"},{id:'3',value:"产品经理"},{id:'4',value:"测试工程师"}],
		                [{id:'5',value:"任课教师"},{id:'6',value:"教导主任"}],[{id:'7',value:"自由职业者"}]]
		
		var vm = new Vue({
			el:'#userInfo',
			data:{
				userInfo:'',
				myinfo:'',
			},
			computed:{
				getSex:function(){
					if(this.myinfo.sex == null){
						return '未填写';
					}
					return this.myinfo.sex==1?'男':'女';
				},
				getInnerDay :function(){
					var nowTime = ((new Date()).valueOf())/1000;
					console.log(nowTime);
					console.log(this.myinfo.createTime);
					var days = parseInt((nowTime - this.myinfo.createTime)/(24*3600));
					
					return days;
				},
				getbirthDay : function(){
					var date = new Date(this.myinfo.birthDay);
					console.log(date);
					var y = date.getFullYear()+'-';
					var m = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
					var d = D = date.getDate() + ' ';
					return y+m+d;
				},
				getHobby:function(){
					var h = this.myinfo.hobby;
					if(h==null){return '未填写'};
					var hs = h.split(',');
					var str ='';
					for(var i in hs){
						str += arrhobby[i].value+" ";
					}
					return str;
				},
				getaddr:function(){
					if(this.myinfo.addr == 0){return '未填写';}
					for(var i =0 ; i<arrcit.length;i++ ){
						var city = arrcit[i];
						for(var j = 0 ; j < city.length;j++){
							if(this.myinfo.addr ==city[j].id ){return city[j].value;}
						}
					}
					return '未知';
				},
				getcareer:function(){
					if(this.myinfo.addr == 0){return '未填写';}
					for(var i =0 ; i<arrCdetail.length;i++ ){
						var city = arrCdetail[i];
						for(var j = 0 ; j < city.length;j++){
							if(this.myinfo.addr ==city[j].id ){return city[j].value;}
						}
					}
					return '未知';
				}
			},
			methods:{
				
			}
		});
		
		var someOne = new Vue({
			el:'#userinfoDef',
			data:{
				myinfo:'',
			},
			computed:{
				getSex:function(){
					if(this.myinfo.sex == null){
						return '未填写';
					}
					return this.myinfo.sex==1?'男':'女';
				},
				getInnerDay :function(){
					var nowTime = ((new Date()).valueOf())/1000;
					console.log(nowTime);
					console.log(this.myinfo.createTime);
					var days = parseInt((nowTime - this.myinfo.createTime)/(24*3600));
					
					return days;
				},
				getbirthDay : function(){
					var date = new Date(this.myinfo.birthDay);
					console.log(date);
					var y = date.getFullYear()+'-';
					var m = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
					var d = D = date.getDate() + ' ';
					return y+m+d;
				},
				getHobby:function(){
					var h = this.myinfo.hobby;
					if(h==null){return '未填写'};
					var hs = h.split(',');
					var str ='';
					for(var i in hs){
						str += arrhobby[i].value+" ";
					}
					return str;
				},
				getaddr:function(){
					if(this.myinfo.addr == 0){return '未填写';}
					for(var i =0 ; i<arrcit.length;i++ ){
						var city = arrcit[i];
						for(var j = 0 ; j < city.length;j++){
							if(this.myinfo.addr ==city[j].id ){return city[j].value;}
						}
					}
					return '未知';
				},
				getcareer:function(){
					if(this.myinfo.addr == 0){return '未填写';}
					for(var i =0 ; i<arrCdetail.length;i++ ){
						var city = arrCdetail[i];
						for(var j = 0 ; j < city.length;j++){
							if(this.myinfo.addr ==city[j].id ){return city[j].value;}
						}
					}
					return '未知';
				}
			},
			methods:{
				
			},
			updated(){
				console.log("更新好了");
				showit();
			}
		});
		
		//
		$.post('user/myinfo',"",function(data){
			vm.myinfo=eval("(" + data +")");
			
			console.log(data);
			console.log(vm.myinfo);
			
		});
		

		
	</script>
</html>

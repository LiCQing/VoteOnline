<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="component/header.jsp" %>


<style type="text/css">
		* {
			margin: 0;
			padding: 0;
		}

		#mobile-menu {
			position: fixed;
			top: 100px;
			left: 20%;
			width: 10%;
			height: 100%;
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
			margin-left: 30%;
			height: 500px;
		}
	</style>
	
		<div class="container">
		<div class="middle"> 
					<div id="mobile-menu" class="mobile-nav">
						<ul>
							<li><a href="#home" data-toggle="tab">我发起的投票</a></li>
							<li><a href="#join" data-toggle="tab">我参与的投票</a></li>
							<li><a href="#updatePass" data-toggle="tab">修改密码</a></li>
						</ul>
					</div>
					<div class="blank">
						<div id="myTabContent" class="tab-content">
							<div class="tab-pane fade in active" id="home">
									<div class="row">
										<div class="col-md-10"  >
											<h2>我发起的投票</h2>
										</div>
										<div class="col-md-2" style="height: 63px;position: relative;" >
											<a href="add.jsp" style="position: absolute;bottom: 0">发起投票</a>
										</div>
									</div>
									
									<hr>
									<div id="myvoteList">
									</div>
							</div>
							<div class="tab-pane fade" id="join">
										<div class="row">
													<div class="col-md-10"  >
														<h2>我参与的投票</h2>
													</div>
												</div>
												
												<hr>
												<div id="myjoinvote">
													
												</div>
							</div>
							<div class="tab-pane fade" id="updatePass">
								<form>
									  <div class="form-group">
									    <label for="exampleInputPassword1">原始密码</label>
									    <input type="password" class="form-control" id="" placeholder="Password">
									  </div>
									  <div class="form-group">
									    <label for="exampleInputPassword1">新密码</label>
									    <input type="password" class="form-control" id="" placeholder="Password">
									  </div>
									  <div class="form-group">
									    <label for="exampleInputPassword1">确认新密码</label>
									    <input type="password" class="form-control" id="" placeholder="Password">
									  </div>
									  <button type="submit" class="btn btn-default">修改</button>
									</form>
							</div>
						</div>
					</div>
			</div>
		</div>
		<div class="footer">
		</div>
	</body>

	<script>
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
		var page=1;row=10;
		$(function(){
			voteList=$("#myvoteList");
			joinList=$("#myjoinvote");
			getVote();
			getJoin();
		});
		
		function getVote(){
			var jsoData = Ajax("vote/list", "my=true");
			var dataObj = eval("(" + jsoData + ")");
			if(dataObj.length==0){
				voteList.append("暂未发起投票");
			}else{
				for(i in dataObj){
					//	console.log(dataObj[i]);
						var vote =$("<div class='vote'> </div>");
						vote.append(dataObj[i].titile);
						
						voteList.append(vote);
					}
			}
		}
		
		function getJoin(){
			var jsoData = Ajax("voted/myvote", "");
			var dataObj = eval("(" + jsoData + ")");
			//console.log(dataObj);
			
			if(dataObj.length==0){
				joinList.append("暂未参与投票，点此参与~");
			}else{
				for(i in dataObj){
				//	console.log(dataObj[i]);
					var vote =$("<div class='vote'> </div>");
					vote.append(dataObj[i].titile);
					
					joinList.append(vote);
				}
				/*$().each(dataObj,function(i,item){
					console.lgo(item);
					
				});*/
			}
		}
		
	</script>
</html>

<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="js/jquery.min.js"></script>
<link rel="stylesheet" href="css/buttons.css">
<script type="text/javascript" src="js/common.js"></script>
<link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- <script src="js/jquery-3.2.1.min.js"></script> -->
<link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<script src="tool/layer/layer.js"></script>
<style>

			body{
				 background-image:url(img/back.jpg); 
				 background-attachment:fixed;
				 background-size: cover;
			}
		
		.header{
			//height: 150px;
			background-color: #F7F7F7;
			position: fixed;
			top: 0px;
			width: 100%;
			z-index:999999;
			box-shadow: #CCCCCC 10px 10px 20px;
		}
		
		.time{
			float: right;
		}
		
		.middle{
			margin-top: 100px;
			padding-top: 30px;
			background-color: #F9F9F9;
			box-shadow: #999999 10px 10px 20px;
			padding-left: 50px;
			padding-right: 50px;
			padding-bottom: 50px;
			position: relative;
		}
		
		.selected{
			background: #888;
		
		}
		
		.None{
			display: none;
		}
		
		.Right{
			text-align: right;
		}
		
		.center{
			text-align: center;
		}
		
		.bottomBorder{
			border-bottom: solid 1px #999999;
		}
		
		.topBorder{
			border-top: solid 1px #999999;
		}
		
		.footer{
			height: 200px;
			margin-top: 30px;
		}
		
		.breath{
			animation: breath 3s ease-in-out 0s infinite alternate;
		}
		
		@keyframes breath{
		  0% {  box-shadow:0 0 0px #FFF,0 0 10px #FFF inset;}
		  50%{  box-shadow: 0 0 30px rgba(222,222,254,0.9),0 0 30px rgba(222,222,254,0.9) inset;}
		 100% {  box-shadow:0 0 0px #FFF ,0 0 10px #FFF  inset;}
		}
		
		.death{
			 width: 50px;                                    /* 宽度 */
			    height: 20px;                                    /* 高度 */
			    background: #CCC; 
		}
		
		.alive {
			    width: 50px;                                    /* 宽度 */
			    height: 20px;                                    /* 高度 */
			    opacity: 0.1;                                   /* 不透明度 */
			    overflow: hidden;                               /* 溢出隐藏 */
			    color: #99dd33;                            /* 背景色 */
			  
			    /* IE10、Firefox and Opera，IE9以及更早的版本不支持 */
			    animation-name: breath;                         /* 动画名称 */
			    animation-duration: 3s;                         /* 动画时长3秒 */
			    animation-timing-function: ease-in-out;         /* 动画速度曲线：以低速开始和结束 */
			    animation-iteration-count: infinite;            /* 播放次数：无限 */
			 
			    /* Safari and Chrome */
			    -webkit-animation-name: breath;                 /* 动画名称 */
			    -webkit-animation-duration: 3s;                 /* 动画时长3秒 */
			    -webkit-animation-timing-function: ease-in-out; /* 动画速度曲线：以低速开始和结束 */
			    -webkit-animation-iteration-count: infinite;    /* 播放次数：无限 */
			}
			 
			@keyframes breath {
			    from { opacity: 0.1; }                          /* 动画开始时的不透明度 */
			    50%  { opacity:   1; }                          /* 动画50% 时的不透明度 */
			    to   { opacity: 0.1; }                          /* 动画结束时的不透明度 */    
			}
			 
			@-webkit-keyframes breath {
			    from { opacity: 0.1; }                          /* 动画开始时的不透明度 */
			    50%  { opacity:   1; }                          /* 动画50% 时的不透明度 */
			    to   { opacity: 0.1; }                          /* 动画结束时的不透明度 */
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
					<a class="navbar-brand" href="index.jsp">FOLLOW YOUR HEART</a>
				</div>

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li class=""><a href="#">首页 <span class="sr-only">(current)</span></a></li>
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
						 <c:if test="${sessionScope.currentUser==null }">
						
							<a href="sign.jsp"       >登陆
							</a>
						 </c:if>
						  <c:if test="${sessionScope.currentUser!=null }">
						
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">我的
								<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="my.jsp">个人中心</a></li>
								<li><a href="sign/logout">安全退出</a></li>
							</ul>
						 </c:if>
						</li>
					</ul>

				</div><!-- /.navbar-collapse -->
			</div><!-- /.container-fluid -->
		</nav>
		<div>广告位招租</div>

	</div>
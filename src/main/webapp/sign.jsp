<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<link
	href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet">

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script
	src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- <script src="js/jquery-3.2.1.min.js"></script> -->
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script src="js/login.js"></script>
<link
	href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="css/login.css">
<link
	href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="container bodyImg" style="">
		<hr>
		<ul id="myTab" class="nav nav-tabs" style="margin-left: 300px;">
			<li class="${regError == null?'active':''}"><a href="#login"    data-toggle="tab"> 用户登陆</a></li>
			<li class="${regError == null?'':'active'}"><a href="#regist"  data-toggle="tab">用户注册</a></li>
		</ul>
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade in active" id="login">
				<div class="login_div">
				 ${loginError}
					<form action="sign/login" method="post"
						onsubmit="return check_right()" style="position: relative;">
						<i class="fa fa-user  fa-lg"
							style="position: absolute; top: 15px; left: 7px; opacity: 0.65"></i>
						<input class="input_ac" style="margin-left: 2px" name="name"
							id="name_l" type="text" placeholder="输入用户名" value="${cookie.username.value}" maxlength="12"
							onfocus="one('l_u_s')"> <span id="l_u_s">*</span><br />
						<i class="fa fa-lock  fa-lg"
							style="position: absolute; top: 67px; left: 7px; opacity: 0.65"></i>
						<!--<label>密码:</label> -->
						<input class="input_ac" style="margin-left: 2px" name="pass"
							id="pass_l" type="password" placeholder="输入密码" value="${cookie.userpass.value }" maxlength="12"
							onfocus="one('l_p_s')"> <span>*</span>
						<div style="line-height: 30px;">
							<input class="c_submit" type="submit" value="登陆"> <a
								style="margin-left: 50px">忘记密码</a>
						</div>
					</form>
				</div>
			</div>
			<div class="tab-pane fade" id="regist">
				<div class="register_div">
					<h6>创建您的账户，享受专属优惠与个性化服务</h6>
					<form onsubmit="return check_re()" action="sign/register" method="post">
						<label>用户名&nbsp;</label> <span id="nspan">*</span><br /> <input
							class="input_acc" name="nick" id="nickid" type="text"
							oninput="checNike()" maxlength="12"><br /> <label>用户密码&nbsp;</label>
						<span id="pspan">*</span><br /> <input class="input_acc"
							name="pass" id="pass" type="password" maxlength="12"
							oninput="checkPass1()"><br /> <label>确认密码&nbsp;</label>
						<span id="repspan">*</span><br /> <input class="input_acc"
							name="pass2" id="pass2" type="password" maxlength="12"
							onblur="checkPass()"><br /> 
							<label> 手机号&nbsp;</label><span id="phonepspan">*</span> <br /> 
							<input class="input_acc" oninput="checkPhone()" name="phone" id="phone" type="text"><br /> <label>
							验证码&nbsp;</label><span id="phonepspan">*</span> <br /> <img src=""
							class="img_verify" /> <input class="input_verify" name="verify"
							type="text"> <br /> <br /> <br /> <input name="agree"
							type="checkbox" id="agree">
						<div class="input_agree">
							同意 本网站 的 <a href="#"> 隐私政策 </a> 和 <a href="#"> 使用条款</a>
						</div>
						<br /> <span id="sel"></span>
						<!--按钮-->
						<div style="padding-left: 50px">
							<input type="submit" class="regiser_btn" value="注册">&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="reset" class="regiser_btn" value="重置"
								onclick="resetContent()">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
		
		$(function() {
			$('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
				// 获取已激活的标签页的名称
				var activeTab = $(e.target).text();
				// 获取前一个激活的标签页的名称
				var previousTab = $(e.relatedTarget).text();
				$(".active-tab span").html(activeTab);
				$(".previous-tab span").html(previousTab);
			});
		});
	</script>
</body>

</html>
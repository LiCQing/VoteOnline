/*表单验证*/
function check_right() {
	var f = true;
	var name = document.getElementById("name_l").value;
	var pass = document.getElementById("pass_l").value;
	if (name == null || name.length < 6) {
		document.getElementById("l_u_s").innerHTML = "用户名不能为空或少于6位！";
		f = false;
	}

	if (pass == null || pass.length < 6) {
		document.getElementById("l_p_s").innerHTML = "密码不能为空或少于6位！";
		f = false;
	}
	return f;
}

function one(id) {
	document.getElementById(id).innerHTML = '';
}


function checNike() {
	var f = true;
	var nike = document.getElementById('nickid').value;
	if (nike.length < 6) {
		document.getElementById("nspan").innerHTML = "用户名不能少于六个字符！";
		f = false;
	}
	var re = /\s/;
	if (re.test(nike)) {
		document.getElementById("nspan").innerHTML = "用户名不能有特殊字符";
		f = false;
	}
	if (f) {
		document.getElementById("nspan").innerHTML = "";
	}
	return f;
}


function checkPass1() {
	var f = true;
	var nike = document.getElementById('pass').value;
	if (nike.length < 6) {
		document.getElementById("pspan").innerHTML = "密码不能少于六个字符！";
		f = false;
	}else{
		document.getElementById("pspan").innerHTML = "";
	}
	return f;
}

function check_re() {
	
    var data = Ajax("sign/checkCode", "verify=" + $(".input_verify").val());
    var json = eval("("+data+")");
    if(!json.result){
    	alert("验证码输入错误");
    	console.log(data);
    	return json.result;
    }
	f = true;
	f = checName() && f;
	f = checNike() && f;
	f = checkPass() && f;
	f = checkPass1() && f;

	var aggre = document.getElementById('agree').checked;
	if (!aggre) {
		document.getElementById("sel").innerHTML = "请同意相关政策！";
		f = false;
	}
	return f;
}

function checkPass() {
	var pass = document.getElementById('pass').value;
	var pass2 = document.getElementById('pass2').value;
	if (pass2 != pass) {
		document.getElementById("repspan").innerHTML = "两次输入密码不同！";
	}else{
		document.getElementById("repspan").innerHTML = "";
	}
}

function resetContent(){
	document.getElementById("sel").innerHTML = "";
	document.getElementById("uspan").innerHTML = "";
	document.getElementById("pspan").innerHTML = "";
	document.getElementById("nspan").innerHTML = "";
	document.getElementById("repspan").innerHTML = "";
}

var TEL_REGEXP = /^1\d{2}$/;

function validateTel(tel){
      if(TEL_REGEXP.test(tel)){
        return true;
      }
      return false;
}
function checkPhone(){
	if(validateTel($("#phone").val())){
		$("#phonepspan").html("");
	}else{
		$("#phonepspan").html("请输入11位手机号,以便接收验证码");
	}
}
$(document).ready(function() {
	$("#nickid").blur(function(){
		if(!checNike()){
			return;
		}
		$.get("check/username/" +$("#nickid").val() , function(data){
			var dataObj = eval("("+data+")"); //这里要加上加好括号和双引号的原因我也不知道，就当是json语法，只能死记硬背了
			 $("#nspan").html(dataObj.data);
			 if(dataObj.result){
				 $("#nspan").css("color","#0035ff");
			 }else{
			 }
		});
	});
	
	$("#phone").blur(function(){
			$.get("check/phone/" +$("#phone").val() , function(data){
				var json = eval("("+data+")");
				if(json.result){
					$("#phonepspan").html(" 手机号可用，点击获取验证码 <input id='getverify' type='button'  onclick='getVerify();return false;' value='获取' /> ");
					$("#phonepspan").css("color","#0035ff");
				}else{
					$("#phonepspan").html(json.data);
				}
				console.log(data);
			});
		});
});

function getVerify(){
	$(".img_verify").attr('src',"sign/verify?t=" + new Date().getTime());
	$("#getverify").val("重新获取");
}
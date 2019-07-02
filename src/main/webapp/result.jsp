<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<script type="text/javascript" src="js/jquery.min.js" > </script>
<link rel="stylesheet" href="class/*.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
 投票结果展示
 <div id="subjec">
	投票主题：${subject.titile } <br>
	截止时间： ${subject.endDay } 00:00:00 <br>
	
		<c:forEach items="${subject.optionList }" var ="option" varStatus="i">
			<div id="option${option.id }">
				
					${option.title }
					${option.image }
					投票人数：<span id="${option.id }"  class="countClass"> ${option.count }</span>人
					<span id="pasent${option.id }" > ${option.count }</span>
			</div>
		</c:forEach>
</div>
上一个/下一个
</body>
<script type="text/javascript">
	$(document).ready(function(){
		calCount();
	});
	
	function calCount(){
		var all=0;
		var count = $(".countClass");
		count.each(function(){
			all =all + Number($(this).text());
		});
		count.each(function(i){
			point = Number($(this).text())/all;
			//all =all + Number($(this).text());

            var str=Number(point*100).toFixed();
            str +="%";
			$("#pasent"+$(this).attr('id')).html(str);	
		});
		//console.log(all);
	}
</script>
</html>
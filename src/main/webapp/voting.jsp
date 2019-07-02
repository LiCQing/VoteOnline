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
<script type="text/javascript" src="js/*.js" > </script>
<link rel="stylesheet" href="class/*.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
${Vote_ERR }
<div id="subjec">
	投票主题：${subject.titile } <br>
	截止时间： ${subject.endDay } 00:00:00 <br>
	
	<form action="voted/vote" method="post">
	<input type="hidden" name="subjectId" value="${subject.id }">
		<c:forEach items="${subject.optionList }" var ="option" varStatus="i">
			<div id="option${option.id }">
				
				<c:if test="${subject.type == 1 }">
					<input type="radio" name="option" value="${option.id }" />
				</c:if>
				<c:if test="${subject.type == 2 }">
					<input type="checkbox" name="option"  value="${option.id }" />
				</c:if>
					${option.title }
					
					${option.image }
			</div>
		</c:forEach>
		<input type="submit" value="提交">
	</form>
</div>
</body>

</html>
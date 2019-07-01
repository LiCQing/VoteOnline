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
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<link rel="stylesheet" href="class/1.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<body>

<div id="voteList">
asdfaf

 </div>

</body>
<script type="text/javascript"> 
    var voteList;
    var page=1,row=15;
    
    //初始准备,加载列表
    $(document).ready(function () {
    	getVoteList("page="+ page +"&row=" +row);
    });
    
    //获取投票列表
    function getVoteList(data){
    	voteList = $("#voteList");
       	voteList.html(""); // 清空
    	//转换json
    	var jsoData = Ajax("vote/list",data);
       	//console.log(jsoData);
       	
    	var dataObj = eval("("+jsoData+")"); //这里要加上加好括号和双引号的原因我也不知道，就当是json语法，只能死记硬背了
			$.each(dataObj,function(idx,item){   
				
				var div = "<div id='"+item.id+"'> "+item.titile
				+"<a href='voted/update?id="+item.id+"'> 修改 </a>"
				+"<button onclick=del("+item.id+")> 删除 </button>"
				+" </div>"
				voteList.append(div);
			//console.log(item);   
		})
    	
    }
    
    //删除
    function del(subjectid){
    	var r = Ajax("voted/delete","id="+subjectid);
    	console.log(r);
    	if(r=="true"){
    		//重新获取list
    		getVoteList("page="+ page +"&row=" +row);
    	}else{
    		alert("删除失败，请重试");
    	}
    }
    
     
</script>

</html>

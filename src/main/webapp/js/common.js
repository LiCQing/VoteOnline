//ajax请求,返回结果数据
function Ajax(url, da) {
	var returnData;
	console.log(da);
	$.ajax({
		type : "post",
		data : da,
		url : url,
		processData : false,
		async : false,
		success : function(data) {
			returnData = data;
		},
		error : function() { // 这个用的比较少
			alert("error");
		}
	})
	return returnData;
}

function AjaxGet(url) {
	var returnData;
	$.ajax({
		type : "get",
		url : url,
		processData : false,
		async : false,
		success : function(data) {
			console.log(data);
			returnData = data;
		},
		error : function() { // 这个用的比较少
			alert("error");
		}
	})
	return returnData;
}
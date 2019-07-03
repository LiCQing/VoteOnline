<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@include file="component/header.jsp" %>


	<div class="container middle">
		<div id="voteList">
			
		</div>
		
		
		<div class="col-lg-3 " id="voteDef" class="None" >
			<img class="img-circle" src="" alt="Generic placeholder image" width="140" height="140">
			<h2>投票标题</h2>
			<p class="desc">投票描述，投票人数，截止时间</p>
			
			<p><a class="btn btn-default" href="#" role="button">点我参与 »</a></p>
			
			
		</div><!-- /.col-lg-4 -->
		
		<hr>

	</div>


<%@ include file="component/footer.jsp" %>

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
		
		//渲染数据
		function test(data) {
			var n = 0;
			
			var newVote = $("<div class='row'>");
			$.each(data, function(idx, item) {
				newVote.css("z-index","0");
				//添加投票到一列
				var col = $("#voteDef").clone(true);
				col.removeClass("None");
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
				console.log(item);
				
				if(item.voted){
					a.html("查看结果");
					a.attr("href","voted/result?id=" + item.id );
				}else{
					a.addClass("breath");
					a.attr("href","vote/view?id=" + item.id );
				}
				
				
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
					voteList.append("<h6>加载失败</h6>");
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

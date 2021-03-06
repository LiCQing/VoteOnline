<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script src="http://cdn.highcharts.com.cn/highcharts/highcharts.js"></script>
<script src="js/exporting.js"></script>
<title>投票结果</title>
<%@include file="component/header.jsp"%>


<style> 
	img{
		height: 100px;
	}
	.red{
		color: #EF002A;
	}
	#container{
		margin: auto;
	}


</style>
<div class="container middle">
	<div class=row>
			<div class="col-md-12 title"><h3>${subject.titile }</h3></div>
			<div class="col-md-12 bottomBorder"> 
				<span>
					${subject.type==1?'单选':'多选' }
				</span>
				<span class="time">${subject.endDay } 00:00:00 截止 </span>
				
			</div>
		</div>

	
	<div id="subjec">

		<c:forEach items="${subject.optionList }" var="option" varStatus="i">
		<hr>
			<div id="option${option.id }" class = "row">
					
					<c:if test="${!fn:contains(option.image, 'null')}">
							<div class="col-md-2">
									<img src="${option.image }" />
							</div>
					</c:if>
					
				
				<div class="col-md-4">
					${option.title}
				</div>
				
				<div class="col-md-2">
					 投票人数：<span id="${option.id }"
					class="countClass"> ${option.count }</span>人 
				</div>
			
				<div class="col-md-3">
					<span id="pasent${option.id }"> ${option.count }</span>
				</div>
				
				<div class="col-md-1  red">
				<c:if test="${option.voted==true }">
					<span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
				</c:if>
				</div>
				
			</div>
			
		</c:forEach>

	</div>
	<hr>
	<div class="Center">
		<c:if test="${subject.optionNum<5}">
			<div id="container" style="width: 600px;height:400px;"></div>
		</c:if>
		<c:if test="${subject.optionNum>5}">
			<div id="container" style="width: 800px;height:400px;"></div>
		</c:if>
	</div>
</div>

<%@ include file="component/footer.jsp" %>

</body>
<script type="text/javascript">
	
	
	

	$(document).ready(function() {
		calCount();
		
	});
	
	//获取图表数据
	$(function(){
			var id = ${subject.id };
			$.ajax({
			type: "GET",
			data:"subjectId=" + id,
			url: "http://localhost:8080/VoteOnline/vote/charts",
			dataType: "jsonp", //数据类型为jsonp  
			jsonp: "Callback", //服务端用于接收callback调用的function名的参数  
			jsonpCallback: "loadCharts",
			success: function(data) {},
			error: function() {
				voteList.append("<h6>加载失败</h6>");
			}
		});
	});
	
	//加载图表数据
	function loadCharts(data){
		console.log(data);
		//console.log(typeof data);
		Highcharts.chart('container', data);
	}
	
	// 计算百分比
	function calCount() {
		var all = 0;
		var count = $(".countClass");
		count.each(function() {
			all = all + Number($(this).text());
		});
		count.each(function(i) {
			point = Number($(this).text()) / all;
			//all =all + Number($(this).text());

			var str = Number(point * 100).toFixed();
			//str += "%";
			
			var bar = "<div class='progress'> " +
			"<div class='progress-bar' role='progressbar' aria-valuenow='"+str+"' "+
			"aria-valuemin='0' aria-valuemax='100' style='width: "+str+"%;'>" +
			+str + "% </div> </div>"
			
			$("#pasent" + $(this).attr('id')).html(bar);
		});
		//console.log(all);
	}
</script>
</html>
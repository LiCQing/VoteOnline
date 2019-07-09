<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@include file="component/header.jsp" %>

 <style>
 .subject{
	text-align: center; 
 }
 
 .voteList{
 	
 }
 
 .allVote{
 	position: relative;
 }
 
 .leftButton{
 	position: absolute;
 	top:42%;
 }
 
 .hotVote{
 height:325px;
 }
 
 .rightButton{
 	position: absolute;
 	top:42%;
 }
 
 
 .title{
 	height: 80px;
 }
 
 .rock_left{
   animation-name: rock_l;                         /* 动画名称 */
   animation-duration: 3s;                         /* 动画时长3秒 */
   animation-timing-function: ease-in-out;         /* 动画速度曲线：以低速开始和结束 */
	 animation-iteration-count: infinite;            /* 播放次数：无限 */
 }
 
  .rock_right{
   animation-name: rock_r;                         /* 动画名称 */
   animation-duration: 3s;                         /* 动画时长3秒 */
   animation-timing-function: ease-in-out;         /* 动画速度曲线：以低速开始和结束 */
	 animation-iteration-count: infinite;            /* 播放次数：无限 */
 }
 
 	@keyframes rock_l {
			    from { opacity: 0.1; left:0%; }                          /* 动画开始时的不透明度 */
			    50%  { opacity:   1; left:-5%; }                          /* 动画50% 时的不透明度 */
			    to   { opacity: 0.1; left:0%; }                          /* 动画结束时的不透明度 */    
			}
	@keyframes rock_r {
			    from { opacity: 0.1; right:0%; }                          /* 动画开始时的不透明度 */
			    50%  { opacity:   1; right:-5%; }                          /* 动画50% 时的不透明度 */
			    to   { opacity: 0.1; right:0%; }                          /* 动画结束时的不透明度 */    
			}
 
 
 </style>
 
	<div class="container middle"  >
	<div class="row">
		<div class="col-md-6">
		    <div class="input-group">
		      <input type="text" id="keyword" class="form-control" placeholder="Search for...">
		      <span class="input-group-btn">
		        <button class="btn btn-default" onclick="searchVote()" type="button">SEARCH</button>
		      </span>
		    </div><!-- /input-group -->
	    </div>
	    <div class="col-md-4" style="line-height: 26px">
	    	<span> 千万人都在用的投票网站，用了的人都说好  </span>
	    	
	    	
	    </div>
	    <div class="col-md-2">
	    	<div><a class="btn btn-danger" href="add.jsp">免费发起投票</a> </div>
	    </div>
	   </div> <!-- 次头部 -->
	   
	    <hr>
	    <h3>热门投票</h3>
	    <div class="hotVote row">
	    
	    </div>
	     <hr>
	     
	     
	     
	      <h3>所有投票</h3>
	    <div class="allVote">
	    
			<div id="voteList">
			
			
			
			
				
			</div>
			 <div class="leftButton rock_left None">
				<i class="fa fa-angle-double-left fa-5x" aria-hidden="true"></i>
			</div>
			<div class="rightButton rock_right None">
				<i class="fa fa-angle-double-right fa-5x" aria-hidden="true"></i>
			</div>
		</div>
		
		<div class="col-lg-3 None" id="voteDef"  >
			<img class="img-circle" src="" alt="Generic placeholder image" width="140" height="140">
			<div class="title">
				<h4>投票标题</h4>
			</div>
			
			<p class="desc">投票描述，投票人数，截止时间</p>
			
			<p><a class="btn btn-default" href="#" role="button">点我参与 »</a></p>
			
			
		</div><!-- /.col-lg-4 -->
		
		
	</div>


	

<%@ include file="component/footer.jsp" %>

	</body>
	<script type="text/javascript">
		var voteList;
		var page = 1,
			row = 8;
		
		
		$(".leftButton").click(function(){
			if(page>1){
				page--;
				getVoteListuser("page=" + page + "&row=" + row);	
			}
		});
		
		$(".rightButton").click(function(){
				page++;
				getVoteListuser("page=" + page + "&row=" + row);	
		});

		//初始准备,加载列表
		$(document).ready(function() {
			voteList = $("#voteList");
			//console.log(voteList);
			getVoteListuser("page=" + page + "&row=" + row);
			
			getHotVote();
			
		});
		
		//搜索
		var spage = 1;
		function searchVote(){
			page=1;
			var data = Ajax("vote/list","word="+$("#keyword").val()+"&page="+page);
			var pagedata = eval("(" + data + ")");
			test(pagedata);	
		}
		

		String.prototype.endWith=function(endStr){
		    var d=this.length-endStr.length;
		    return (d>=0&&this.lastIndexOf(endStr)==d)
		  }
		
		//热门投票
		function getHotVote(){
			var data = Ajax("vote/hotList");
			//console.log(data);
			var arrVote = eval("(" + data + ")");
			var hotList = $(".hotVote");
			for(i in arrVote){
				var col = jsonToEle(i,arrVote[i]);
				hotList.append(col);
			}
			
			var child = $(".hotVote").children();
			var len = child.length;
			for(var i = 0 ; i < len ; i++){
				if(i>3)
					$(child.get(i)).hide();
			}
			
			setInterval("hotVoteSlow()","5000");
		}
		
		//热门投票依次展示
		function hotVoteSlow(){
			var child = $(".hotVote").children();
			var len = child.length;
			
			//复制第一个，添加到最后，把第一个删除
			var first = $(child.get(0)).clone();
			first.hide();
			$(".hotVote").append(first);
		    $(child.get(0)).hide(1000, function(){ $(this).remove();$(child.get(4)).show(500);});
		   
		}
		
		
		//渲染投票列表数据
		function test(pagedata) {
			
			//console.log(pagedata);
			
			//绑定翻页按钮事件
			if(pagedata.hasNext){
				$(".rightButton").removeClass("None");
			}else{
				$(".rightButton").addClass("None");
			}
			
			if(pagedata.hasPre){
				$(".leftButton").removeClass("None");
			}else{
				$(".leftButton").addClass("None");
			}
			
			
			var data = pagedata.list;
			var n = 0;
			voteList.html("");
			var newVote = $("<div class='row subject'>");
			if(data.length==0){
				voteList.html("<h3>没搜到相关结果，换个关键词试试或者点我<a role='button' onclick='getVoteListuser()'>查看所有<a></h3>");
			}
			$.each(data, function(idx, item) {
				newVote.css("z-index","0");
				//添加投票到一列
				var col = jsonToEle(idx,item);
				newVote.append(col);
				n++;
				if(n%4 ==0){
					voteList.append(newVote);
					//新建一列
					voteList.append("<hr>");
					newVote = $("<div class='row subject'>");
				}
				 //
				//console.log(voteList);
				newVote.appendTo(voteList);

		
			})
			//$("#voteDef").hide();
		}

		function jsonToEle(idx,item){
			var col = $("#voteDef").clone();
			//显示
			col.removeClass("None");
			col.attr("id","addDiv"+idx); 
			//设置图片
			var img=col.find("img");
			img.attr("src","img/vote.jpg");
			var imgurl = ""+item.url;
			if(!imgurl.endWith("null")){
				//console.log(item.url);
				img.attr("src",item.url);
			}
			
			//设置描述
			var desc= col.find(".desc");
			var num = "已经有"+ item.count+"人参与，快来看看吧"
			if(item.count==0){
				num="还没有人投票呢，快来做第一个投票的人吧";
			}
			var doingStart="";
			if(item.startStatus){
				doingStart="进行中，截止时间:"+ item.endDay +"<br>"
			}else{
				doingStart="暂未开始，开始时间:"+ item.startDay +"<br>"
			}
			desc.html(doingStart +num);
			//设置标题
			var title= col.find("h4");
			title.html(item.titile);
			//设置链接
			var a= col.find("a");
			//console.log(item);
			
			if(item.voted){
				a.html("查看结果");
				a.attr("href","voted/result?id=" + item.id );
			}else{
				a.addClass("breath");
				a.attr("href","vote/view?id=" + item.id );
			}
			return col;
		}	
		
		//用户获取投票
		function getVoteListuser(data) {
			
			voteList.html(""); // 清空
			//转换json
			//console.log(jsoData);
			$.ajax({
				type: "GET",
				data:data,
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

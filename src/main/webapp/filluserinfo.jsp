<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<title>填写个人信息</title>
<%@ include file="component/header.jsp"%>
<style>
	.userinfo{
		position: absolute;
		width: 80%;
	}
	.userinfo2{
		position: absolute;
		right:-100%;
		width: 80%;
	}

</style>
<div class="container middle" style="height: 300px">
<h4> 填写基本信息， 增加3次免费次数，<a href="">先免费试用</a></h4>
	<hr>
	<div class="userinfo">
		<form id="infoForm"  action="sign/addinfo" method="post">
			<div class="form-group">
				<label for="exampleInputEmail1">用户名 </label>
				<div class="input">
					<input   maxlength="20" name="userNick"
						type="text" class="form-control " placeholder="起一个别人一眼就能记住的名字吧">
				</div>
				<!-- /input-group -->
			</div>
	
			<div class="form-group">
					<label  >性别 </label> &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="sex" value="0" />萌妹子 &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="sex" value="1" />糙汉子
			</div>
	
			<div class="form-group">
				<label  > 出生日期（看看同龄段的人都会哪些话题感兴趣）</label>
				<div class="input">
					<input id="startDate" onchange="checkTime()" type="date"
						name="birthday"  />
				</div>
				<!-- /input-group -->
			</div>
		</form>
	</div>
	<div class="userinfo2">
		<form id="infoForm2"  action="sign/addinfo" method="post">
			<div class="form-group">
				<label for="exampleInputEmail1">爱好 </label>
				<div id="hobby" class="input">
					
				</div>
				<!-- /input-group -->
			</div>
	
			<div class="form-group">
					<label  >职业 </label> &nbsp;&nbsp;&nbsp;&nbsp;
						<div class="input">
							类别：<select name="career" id="career" onchange="changeCSelect(this.selectedIndex)">
						</select>
					
							职位：<select name="careerPosition" id="careerPosition">
						</select>
				</div>
			</div>
	
			<div class="form-group">
				<label  > 所在地</label>
				<div class="input">
					省份：<select name="province" id="province" onchange="changeSelect(this.selectedIndex)">
					</select>
					
					市区：<select name="city" id="city">
					</select>
				</div>
				<!-- /input-group -->
			</div>
		</form>
	</div>
	<div class="row Right">
		<a type="button" id="next" class="btn-lg btn-info">继续</a>
	</div>
</div>

</body>
<script>
	var isComplet = false;
	//提交信息
	function submit(formId,type){
		var data =$(formId).serialize(); // new FormData($(formId).get(0));
		data +="&type="+type;
		console.log(data);
		 $.post("sign/addinfo",data,function(d){
			 if(d!='ok'){
				 alert("插入失败");
			 }
		});
	}
	
	//信息展示初始化
	$(function(){
		$("#next").click(function(){
			if(!isComplet){
				
				if($("input[name=userNick]").val()==""){
					layer.msg("用户昵称还未填写呢");
					return ;
				}
				
				if($("input[type=radio]:checked").length==0){
					layer.msg("记得选择性别哦");
					return ;
				}
				
				if($("input[name=birthday]").val()==""){
					layer.msg("出生日期要记得");
					return ;
				}
				
				isComplet = true;
				$(".userinfo").animate({left:'-100%'},1000);
				$(".userinfo2").animate({left:'10%'},1000);
				$("#next").html("完成");
				$("h4").html("填写更多信息，永久免费发布投票");
				submit("#infoForm","base");
			}else{
				submit("#infoForm2","more");
				location.href="index.jsp";
			}
			
		});
		init();
	});
	
	var arrpro=[{id:'0',value:"请选择省份"},
	            {id:'1',value:"河北省"},
	            {id:'2',value:"湖南省"}];
	
	var arrcit=[[{id:'0',value:"请选择城市"}],
	            [{id:'1',value:"石家庄"},{id:'2',value:"邯郸"},{id:'3',value:"唐山"}],
	            [{id:'4',value:"长沙"},{id:'5',value:"张家界"},{id:'6',value:"吉首"}]];
	
	var arrhobby=[{id:'0',value:"运动"},
	              {id:'1',value:"娱乐"},
		          {id:'2',value:"冒险"},
	              {id:'3',value:"收藏"},
		          {id:'4',value:"乐器"},
	              {id:'5',value:"文艺"},
		          {id:'6',value:"游戏"},
	              {id:'7',value:"手工"},
		          {id:'8',value:"学习"}];
	
	var arrCcate=[{id:'0',value:"请选择职业类别"},
				{id:'0',value:"IT业"},
				{id:'0',value:"教育业"},
				{id:'0',value:"其他行业"}];
	
	var arrCdetail=[[{id:'0',value:"请选择职业"}],
	                [{id:'1',value:"程序员"},{id:'2',value:"系统分析员"},{id:'3',value:"产品经理"},{id:'4',value:"测试工程师"}],
	                [{id:'5',value:"任课教师"},{id:'6',value:"教导主任"}],[{id:'7',value:"自由职业者"}]]
	
	function init()
	{
		var province=$("#province");
		
		for(i in arrpro){
			console.log(arrpro[i]);
			province.append("<option value='"+arrpro[i].id+"'>"+arrpro[i].value+"</option>");
		}
		
		var hobby= $("#hobby");
		for(i in arrhobby){
			console.log(arrhobby[i]);
			hobby.append("<input type='checkbox' name='hobby' value="+arrhobby[i].id+">"+arrhobby[i].value + "&nbsp;&nbsp;&nbsp;");
		}
		
		var career = $("#career");
		for(i in arrCcate){
			console.log(arrCcate[i]);
			career.append("<option value='"+arrCcate[i].id+"'>"+arrCcate[i].value+"</option>");
		}
		
		
		
	}
	
	function changeCSelect(index)
	{
		var careerPosition=$("#careerPosition");
		careerPosition.html("");
		var arr= arrCdetail[index];
		for(i in arr){
			console.log(arr[i])
			careerPosition.append("<option value='"+arr[i].id+"'>"+arr[i].value+"</option>");
		}
		
	}
	
	function changeSelect(index)
	{
		province.selectedIndex=index;
		var city=$("#city");
		city.html("");
		var arr= arrcit[index];
		for(i in arr){
			console.log(arr[i])
			city.append("<option id='"+arr[i].id+"' value='"+arr[i].id+"'>"+arr[i].value+"</option>");
		}
		
	}


</script>

</html>
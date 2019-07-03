<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%@ include file="component/header.jsp" %>
<style>
	
	.option{
		height: 300px;
		margin: 30px;
		background: #EEE;
		border-radius: 15px;
		cursor: pointer;
		position: relative;
		padding: 0px;
		text-align: center;
		
	}
	
	.pickme{
		position: absolute;
		bottom: 0;
		width: 100%;
		height:15%;
		background: #F3F3FA;
		border-bottom-right-radius:15px;
		border-bottom-left-radius:15px;
		text-align: center;
		
	}
	
	.pickme span{
		margin:auto;
		line-height: 100%;
		height: 100%;
		font-size: 30px;
	}
	
	.selected{
		background: #888;
		
	}
	
	.center{
		text-align: center;
	}
	
	.option:hover{
		transform: scale(1.1);
		z-index: 0;
		 animation: breath 3s ease-in-out 0s infinite alternate;
	}
	
	.imgDiv{
		margin-top: 10px;
		height:70%;
		text-align: center;
	}
	
	.imgDiv img{
		height: 200px
	}
	
	.optionDesc{
		height:15%;
		margin: auto;
	}
	
	
		
		@keyframes breath{
		  0% { opacity: 1; box-shadow:0 0 30px rgba(235,236,241,0.7),0 0 30px rgba(235,236,241,0.7) inset;}
		  50%{ opacity: 0.6;   box-shadow: 0 0 30px rgba(240,240,253,0.7),0 0 30px rgba(240,240,253,0.7) inset;}
		 100% { opacity: 1; box-shadow:0 0 30px rgba(235,236,241,0.7),0 0 30px rgba(235,236,241,0.7) inset;}
		}
		
	.submit{
		width: 80%;
		height: 40px;
		animation: breath 3s ease-in-out 0s infinite alternate;
	}
	
	.submit:hover{
		transform: scale(1.2);
	}
	
</style>
<div class="container middle"> 
		${Vote_ERR }
		<div class=row>
			<div class="col-md-12"><h3>${subject.titile }</h3></div>
			<div class="col-md-12 bottomBorder"> 
				<span>
					${subject.type==1?'单选':'多选' }
				</span>
				<span class="time">${subject.endDay } 00:00:00 截止 </span>
				
			</div>
		</div>
		
		
		<div id="subjec">
			
			 <br>
			
			<form action="voted/vote" method="post">
			<input type="hidden" name="subjectId" value="${subject.id }">
			<div class="row">
				<c:forEach items="${subject.optionList }" var ="option" varStatus="i">
						<div id="option${option.id }" class="col-md-3 option" onclick="select(this)">
								
								<c:if test="${option.image!=null }">
									<div class="imgDiv">
										<img src="http://192.168.139.128/images/${option.image }">
									</div>
								</c:if>
										
									<div class="optionDesc">
									
											${option.title }
									</div>
									
						<div class="pickme">
						   <span>PICK ME</span>
								<input class="None"  type="checkbox" name="option"  value="${option.id }" />
							</div>
										
						</div>
									
						
					
					</c:forEach>
				</div>
				<div class="center topBorder">
				<br>
					<input class="submit" type="submit" value="提交">
				</div>
				
			</form>
		</div>
</div>

<%@ include file="component/footer.jsp" %>

</body>
<script type="text/javascript">

$(function(){
	if($(".imgDiv").length == 0){
		console.log(111);
		var options = $('.option');
		options.each(function(i,item){
			$(item).css("height","150px");
			$(item).find(".optionDesc").css("height","50%");
			$(item).find(".optionDesc").css("padding-top","5%");
			$(item).find(".pickme").css("height","30%");
		});
	}
	
	
});

var type=${subject.type};

//用户点击选择
function select(option){
	if(type==1){
		allDeSelect();
	}
	
	var pick = $(option).find(".pickme");
	var input = $(option).find("input");
	
	if(pick.hasClass("selected")){
		pick.removeClass("selected");
		input.prop('checked', false);
	}else{
		input.prop('checked', true);
		pick.addClass("selected");
	}
}

//取消所有选择
	function allDeSelect(){
		var pick = $(".pickme");
		var input = $("input[name=option]");
		
		pick.each(function(i,p){
			$(p).removeClass("selected");
		});
		
		input.each(function(i,p){
			$(p).prop('checked', false);
		});
	}



</script>
</html>
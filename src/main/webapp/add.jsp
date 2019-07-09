<%@ page language="java" import="java.util.*,com.jsu.pojo.*" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>

	<title>${subject==null?'添加新投票':'修改投票'}</title>

<style>
	.option{
			height: 80px;
			line-height: 80px;
			background-color: #F3F3F3;;
			padding-left: 5%;
			
		}
		
		.unupload{
			color: red;
		}
		
		.check{
		color: green;
		}
		
		.option label{
			width: 70%;
		}
			.addImgDiv {
				display: none;
				width: 400px;
				height: 30px;
				box-shadow: 5px 5px 20px #777777;
				border-radius: 12px;
				padding: 15px;
				position: fixed;
				background: white;
				left: 600px;
				top: 100px;
			}

			.weChatImg {
				box-shadow: 5px 5px 20px #777777;
				width: 500px;
				height: 680px;
				padding: 10px;
				position: fixed;
				background: white;
				left: 100px;
				top: 50px;
			}

			.weChatImg img {

				width: 480px;

			}

			.row {
				height: 50px;
			}

			.row span {
				font-size: 20px;
			}

			.optionClass {}

			.optionClass img {
				transition: all 0.6s;
				width: 100px;
			}
			#imageForm {
				display: none;
			}
			
			.below{
				z-index: 0;
			}
			
			img{
				height: 140px;
				z-index: 999;
			}
			img:hover{
				transform: scale(1.4);
				z-index: 999;
				
			}
			.DisNone {
				display: none;
			}
			
			.wring{
			animation: wring 2s ease-in-out 0s infinite alternate;
			}
			
			
			@keyframes wring{
			  0% {  box-shadow:0 0 0px red,0 0 10px red;}
			  50%{  box-shadow: 0 0 20px rgba(222,222,254,0.9),0 0 20px rgba(222,222,254,0.9);}
			 100% {  box-shadow:0 0 0px red ,0 0 10px red;}
			}

</style>
<%@ include file="component/header.jsp" %>


		<div class="container">
			<div class="middle">
				<div class="title">
					<h2>${subject==null?'添加新投票':'修改投票'}</h2>
				</div>
				<hr>
				<form id="subjectForm"   id="voteForm" action="${subject==null?'voted/add':'voted/update2' }" method="post">
					<input type="hidden" name="voteId" value="${subject.id }">
					<div class="form-group">
						<label for="exampleInputEmail1">投票名</span></label>
						<div class="input">
							<input value="${subject.titile}"  maxlength="20"  name="voteTitle" type="text" class="form-control " placeholder="1-200个字符">
						</div><!-- /input-group -->
					</div>
					
					<div class="form-group">
						<label for="exampleInputEmail1">投票类型 </label>
						<div class="input">
						<c:if test="${subject==null }">
							<input type="radio" name="voteType" checked value="1" />单选
							<input type="radio" name="voteType" value="2" />多选 
						</c:if>
						<c:if test="${subject.type==1 }">
							<input type="radio" name="voteType" checked  value="1" />单选
							<input type="radio" name="voteType" value="2" />多选 
						</c:if>
						<c:if test="${subject.type==2 }">
							<input type="radio" name="voteType"  value="1" />单选
							<input type="radio" name="voteType" checked  value="2" />多选 
						</c:if>
							
						</div><!-- /input-group -->
					</div>
					
					<div class="form-group">
						<label for="exampleInputEmail1"> 开始时间 </label> 
						<div class="input">
							<input id="startDate" onchange="checkTime()" type="date" name="voteStart" value="${subject.startDay}" />
							<button class="btn btn-default" onclick="changeTime(0,0)" type="button">提交后</button>
							<button class="btn btn-default" onclick="changeTime(0,1)" type="button">明天</button>
							<button class="btn btn-default" onclick="changeTime(0,3)" type="button">三天后</button>
							<button class="btn btn-default" onclick="changeTime(0,7)"type="button">一周后</button>
						</div><!-- /input-group -->
					</div>
					
					<div class="form-group">
						<label for="exampleInputEmail1">截止日期(当日零点截止)  </label>
						<div class="input">
							<input id="endDate" onchange="checkTime()" type="date" name="voteEnd" value="${subject.endDay}" />
							<button class="btn btn-default" onclick="changeTime(1,4)" type="button">三天</button>
							<button class="btn btn-default" onclick="changeTime(1,8)" type="button">一周</button>
							<button class="btn btn-default" onclick="changeTime(1,16)" type="button">十五天</button>
							<button class="btn btn-default" onclick="changeTime(1,30)"type="button">一月</button>
						</div><!-- /input-group -->
					</div>
					<label for="exampleInputEmail1">选项 </label>
					<c:if test="${subject==null }">
								<div class="form-group" id="op0">
									<div class="input-group below">
										<input type="text" name="option" maxlength="100" class="form-control" placeholder="写点什么吧">
										<span class="input-group-btn">
											<button class="btn btn-default" id="0" onclick="addImg(this)" type="button">插入图片</button>
											<button class="btn btn-default" id="0" onclick="delOption(this)" type="button">×</button>
										</span>
									</div><!-- /input-group -->
									<div class="imgDiv DisNone">
										<input id="file0" onchange="sc(this);loadImg(this)" type="file"/>
										<input type="button" id="0" onclick="upload(this)" value="上传">
										<img src="img/def.jpg"  class="thumbnail">
									</div>
								</div>
								<div class="form-group" id="op1">
									<div class="input-group below">
										<input type="text" name="option"  maxlength="100" class="form-control" placeholder="写点什么吧">
										<span class="input-group-btn">
											<button class="btn btn-default" id="1" onclick="addImg(this)" type="button">插入图片</button>
											<button class="btn btn-default" id="1" onclick="delOption(this)" type="button">×</button>
										</span>
									</div><!-- /input-group -->
									<div class="imgDiv DisNone">
										<input id="file1"  onchange="sc(this);loadImg(this)" type="file"/>
										<input type="button" onclick="upload(this)" id="1" value="上传">
										<img src="img/def.jpg"  class="thumbnail">
									</div>
								</div>
					</c:if>
					<c:if test="${subject != null }">
					<c:forEach items="${subject.optionList }" var ="option" varStatus="i">
							 <div class="form-group" id="op${i.index }">
										<div class="input-group below">
											<input type="text" name="option" maxlength="100" class="form-control" value="${option.title }">
											<span class="input-group-btn">
												<button class="btn btn-default" id="${i.index }" onclick="addImg(this)" type="button">
												<c:choose>
														<c:when test="${fn:contains(option.image, 'null')}">
															插入图片
														</c:when>
														<c:otherwise>
															删除图片
														</c:otherwise>
												</c:choose>
												
												</button>
												<button class="btn btn-default" id="${i.index }" onclick="delOption(this)" type="button">×</button>
											</span>
										</div><!-- /input-group -->
										<c:if test="${!fn:contains(option.image, 'null')}">
											<div class="imgDiv">
											<input name="url" type="hidden" value="${option.image }">
											<input id="file${i.index }" onchange="sc(this);loadImg(this)" type="file"/>
											<input type="button" id="${i.index }" onclick="upload(this)" value="上传">
											<img src="${option.image }"  class="thumbnail">
										</div>
										</c:if>
										<c:if test="${!fn:contains(option.image, 'null')}">
											<div class="imgDiv DisNone">
											<input id="file${i.index }" onchange="sc(this);loadImg(this)" type="file"/>
											<input type="button" id="${i.index }" onclick="upload(this)" value="上传">
											<img src="img/def.jpg"  class="thumbnail">
										</div>
										</c:if>
										
									</div>
						</c:forEach>
					</c:if>
					

					<a id="addButton" role="button" onclick="addOption()" class="button button-glow button-border button-rounded ">添加选项</a>
					<span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<a id="submit"  class="button button-glow button-border button-rounded ">提交</a>
				
				</form>

				<br>
				<br>
				<br>

				<div class="weChatImg DisNone">
					<img src="http://192.168.139.128/images/vote/1ea8fd0c-5cd9-45a6-a98c-25d379357d10_mm_facetoface_collect_qrcode_1561906535131.png" />
				</div>
				
				<div class="form-group DisNone" id="opdef">
					<div class="input-group below">
						<input type="text" id="option"  maxlength="100" class="form-control" placeholder="写点什么吧">
						<span class="input-group-btn">
							<button class="btn btn-default" id="0" onclick="addImg(this)" type="button">插入图片</button>
							<button class="btn btn-default" id="0" onclick="delOption(this)" type="button">×</button>
						</span>
					</div><!-- /input-group -->
					<div class="imgDiv DisNone">
						<input id="file" onchange="sc(this);loadImg(this)" type="file"/>
						<input type="button" id=""  onclick="upload(this)"  value="上传">
						<img src="img/def.jpg" class="thumbnail"><i class="fa fa-check"></i>
					</div>
				</div>
				
			</div>
		</div>
		
<%@ include file="component/footer.jsp" %>

	</body>

	<script type="text/javascript">
		//应该插入图片的id
		var insertId;
		//添加选项按钮
		var addBut;
		//选项计数器
		var optionNum = 2;

		//初始准备
		$(document).ready(function() {
			//添加输入框获取焦点正常
			$("input").each(function(i,item){
				$(item).focus(function(){
	  				$(item).removeClass("wring");
			});
			});
			
			//提交
			$("#submit").click(function(){
				var flg=true;
				if($("input[name=voteTitle]").val()==''){
					$("input[name=voteTitle]").addClass("wring");
					layer.msg('投票标题不能为空');
					//alert("投票名不能为空");
					return;
				}
				
				if($(".unupload").length > 0){
					//alert("图片未上传/或未完成");
					layer.msg('图片未上传/或未完成');
					return;
				}
				
				if($("input[name=url]").length > 0 && $("input[name=url]").length != $("input[name=option]").length){
					layer.msg("图片数量与选项数量不符");
					return;
				}
				
				$("input[name=option]").each(function(i,item){
					//console.log(item);
					if(!flg){
						return ;
					}
					
					if($(item).val()==''){
						$(item).addClass("wring");
						layer.msg("选项不能为空");
						flg=false ;
					}
				});
				
				$("#subjectForm").submit();
			})

			$(".weChatImg").click(function() {
				$(".weChatImg").hide();
			});
			//载入添加按钮
			addBut = $("#addButton");

			//载入目前选项个数
			optionNum = $("input[name=option]").length;
			//alert($('#endDate').val());
			//初始化时间为一周后
			if ($('#endDate').val() == null || $('#endDate').val() == "") {
				changeTime(1,7);
			}
			
			//初始化时间为一周后
			if ($('#startDate').val() == null || $('#startDate').val() == "") {
				changeTime(0,0);
			}
               
            });
		
		function changeTime(type,day){
			var time = new Date();
			var inputTime;
			if(type==0){
				console.log("startDate");
				time.setDate(time.getDate() + day);
				inputTime = $("#startDate");
			}else{
				console.log("endDate");
				time.setDate(time.getDate() + day);
				inputTime = $("#endDate");
			}
			
			var day = ("0" + time.getDate()).slice(-2);
			var month = ("0" + (time.getMonth() + 1)).slice(-2);
			var today = time.getFullYear() + "-" + (month) + "-" + (day);
			inputTime.val(today);
		}
		
		function checkTime(){
			console.log($('#endDate').val());
			var startTime = new Date(Date.parse($('#endDate').val() + " 0:0"));
			var date = new Date();
			if(!(startTime>date)){
				layer.msg("时光易逝,请展望未来");
				var time=date.setDate(date.getDate()+1);
				time=new Date(time);
				var day = ("0" + time.getDate()).slice(-2);
				var month = ("0" + (time.getMonth() + 1)).slice(-2);
				var today = time.getFullYear() + "-" + (month) + "-" + (day);
				$('#endDate').val(today);
			}
			//$('#endDate').val(today);
		}
		
		//图片实时预览
		 function loadImg(e) {
			 $(e).siblings("img").attr('src', URL.createObjectURL($(e)[0].files[0]));
			 $(e).siblings("i").remove();
			 $(e).after("<i class='unupload fa fa-exclamation'></i> ");
			 
			 /*console.log($(e).siblings("img"));
			 console.log( URL.createObjectURL($(e)[0].files[0]));*/
		}
		
		 //点击插入图片
		 function addImg(btn){
			 var option = $("#op" + btn.id);
			 var imgDiv = option.find(".imgDiv");
			 
			 //改变btn的名字
			 if(btn.innerHTML=="删除图片"){
				 btn.innerHTML="插入图片";
				 option.find("input[name=url]").remove();
				 imgDiv.hide();
				 }
			else{
				btn.innerHTML="删除图片";
				imgDiv.show();
			}
			 //console.log(option.attr("id"));
		 }

		function addOption() {
			var options = $("input[name=option]");
			console.log(options);
			
			
			if (options.length != 0) {
				if (options.last().val() == "" || options.last().val() == null) {
					alert("请填写上一项");
					return;
				}
			}
	
			if (options.length >= 10) {
				alert("最多填写10项哦,如需增加,请扫码支付！");
				$(".weChatImg").show();
				return;
			}
			
			var option = $("#opdef").clone();
			option.removeClass("DisNone");
			//console.log(option);
			option.attr("id","op"+optionNum);
			var input = option.find("#option");//[0].attr("name","option");
			input.attr("name","option");
			
			console.log(input[0]);
			
			
			option.find("button").each(function(i,item){
				//console.log(item);
				item.id=optionNum;
				//item.attr("id",optionNum);
			});
			
			var filebtn = option.find("input[type=button]");
			filebtn.attr("id",optionNum);
			
			var file = option.find("input[type=file]");
			file.attr("id","file"+optionNum);
			
			console.log(option[0]);
			addBut.before(option);
			
			optionNum++;
		}

		function delOption(option) {
			var options = $("input[name=option]");
			if (options.length <= 2) {
				alert("最少填写2项哦");
				return;
			}

			var id = option.id;
			console.log(id);
			//获取目标选项
			var op = $("div[id=op" + id + "]");
			op.remove();

			console.log(op);

		}

		//检查文件类型
		function sc(image) {
			var img = $(image);
			var animateimg = img.val(); //获取上传的图片名 带//
			var imgarr = animateimg.split('\\'); //分割
			var myimg = imgarr[imgarr.length - 1]; //去掉 // 获取图片名
			var houzui = myimg.lastIndexOf('.'); //获取 . 出现的位置
			var ext = myimg.substring(houzui, myimg.length).toUpperCase(); //切割 . 获取文件后缀

			var file = img.get(0).files[0]; //获取上传的文件
			var fileSize = file.size; //获取上传的文件大小
			var maxSize = 1048576; //最大1MB
			if (ext != '.PNG' && ext != '.GIF' && ext != '.JPG' && ext != '.JPEG' &&
				ext != '.BMP') {
				alert('文件类型错误,请上传图片类型');
				img.val("");
				return false;
			} else if (parseInt(fileSize) >= parseInt(maxSize)) {
				alert('上传的文件不能超过1MB');
				img.val("");
				return false;
			}
			return true;
		}

		function upload(btn) {

			var image = new FormData();
			image.append('file', $('#file' + btn.id)[0].files[0]);
	
			$.ajax({
				url: "image/add",
				type: 'POST',
				data: image,
				cache: false,
				processData: false,
				contentType: false,
				success: function(data) {
					if (data != "fasle") {
						var urlArr = data.split(',');

						/*var result = '';
						result += "<img src='" + urlArr[0] + "' width='100px'>";
						$("#imageForm").append(result);
*/
						//加入图片
						var op = $("#op" + btn.id);
						/*var img = op.children("img");
						img.css("display", "block");
						img.attr("src", urlArr[0]);*/

						//加入图片名字
						console.log(urlArr[1]);
						var imageUrl = "<input type='hidden' value='" + urlArr[1] + "' name='url' />";
						op.append(imageUrl);
						op.find("i").remove();
						$(btn).after("<i class='check fa fa-check'></i>");

					} else {
						/*alert("添加失败");*/

					}

				}
			});
		}
		
	</script>

</html>
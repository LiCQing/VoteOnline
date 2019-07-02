<%@ page language="java" import="java.util.*,com.jsu.pojo.*" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
	
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/common.js"></script>
<link rel="stylesheet" href="css/buttons.css">
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>

		<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
		 crossorigin="anonymous">

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
		 crossorigin="anonymous"></script>
<link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<script src="js/ajaxfileupload.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
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
		</style>
		<style type="text/css">
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
		</style>
	</head>

	<body>
		<div class="container">
			<div class="middle">
				<div class="title">
					<h2>添加新投票</h2>
				</div>

				<form id="subjectForm"  id="voteForm" action="${subject==null?'voted/add':'voted/update2' }" method="post">
					<input type="hidden" name="voteId" value="${subject.id }">
					<div class="form-group">
						<label for="exampleInputEmail1">投票名</label>
						<div class="input">
							<input value="${subject.titile}" name="voteTitle" type="text" class="form-control" placeholder="写点什么吧">
						</div><!-- /input-group -->
					</div>
					
					<div class="form-group">
						<label for="exampleInputEmail1">投票类型 </label>
						<div class="input">
							<input type="radio" name="voteType" value="1" />单选
							<input type="radio" name="voteType" value="2" />多选 
						</div><!-- /input-group -->
					</div>
					
					<div class="form-group">
						<label for="exampleInputEmail1">截止日期  </label>
						<div class="input">
							<input id="endDate" type="date" name="voteEnd" value="${subject.endDay}" />
						</div><!-- /input-group -->
					</div>
					
					<div class="form-group" id="op0">
						<label for="exampleInputEmail1">选项 </label>
						<div class="input-group below">
							<input type="text" name="option" class="form-control" placeholder="写点什么吧">
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
							<input type="text" name="option" class="form-control" placeholder="写点什么吧">
							<span class="input-group-btn">
								<button class="btn btn-default" id="1" onclick="addImg(this)" type="button">插入图片</button>
								<button class="btn btn-default" id="1" onclick="delOption(this)" type="button">×</button>
							</span>
						</div><!-- /input-group -->
						<div class="imgDiv DisNone">
							<input id="file1" onchange="sc(this);loadImg(this)" type="file"/>
							<input type="button" onclick="upload(this)" id="1" value="上传">
							<img src="img/def.jpg"  class="thumbnail">
						</div>
					</div>

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
						<input type="text" id="option"  class="form-control" placeholder="写点什么吧">
						<span class="input-group-btn">
							<button class="btn btn-default" id="0" onclick="addImg(this)" type="button">插入图片</button>
							<button class="btn btn-default" id="0" onclick="delOption(this)" type="button">×</button>
						</span>
					</div><!-- /input-group -->
					<div class="imgDiv DisNone">
						<input id="file" onchange="sc(this);loadImg(this)" type="file"/>
						<input type="button" id=""  onclick="upload(this)"  value="上传">
						<img src="img/def.jpg" class="thumbnail">
					</div>
				</div>
				
			</div>
		</div>

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
			
			$("#submit").click(function(){
				$("#voteForm").submit();
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
				var time = new Date();
				time.setDate(time.getDate() + 7);
				var day = ("0" + time.getDate()).slice(-2);
				var month = ("0" + (time.getMonth() + 1)).slice(-2);
				var today = time.getFullYear() + "-" + (month) + "-" + (day);
				$('#endDate').val(today);
			}
			
			  
               
            });
		//图片实时预览
		 function loadImg(e) {
			 $(e).siblings("img").attr('src', URL.createObjectURL($(e)[0].files[0]));
			 console.log($(e).siblings("img"));
			 console.log( URL.createObjectURL($(e)[0].files[0]));
		}
		
		 //插入图片
		 function addImg(btn){
			 var option = $("#op" + btn.id);
			 var imgDiv = option.find(".imgDiv");
			 
			 //改变btn的名字
			 if(btn.innerHTML=="删除图片"){
				 btn.innerHTML="插入图片";
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

			/*var option = "<div id='op" + optionNum + "' class='optionClass'> 选项:  <input type='text' name='option' />" +
				"<input  type='button' onclick='pop(" + optionNum + ")' value='插入图片' />" +
				"<img  class='DisNone'>" +
				"<input type='button' id='" + optionNum + "'  value='删除' onclick='delOption(this)'></div> ";
			*/
			
			var option = $("#opdef").clone();
			option.removeClass("DisNone");
			//console.log(option);
			option.attr("id","op"+optionNum);
			var input = option.find("#option");//[0].attr("name","option");
			input.attr("name","optin");
			
			option.find("button").each(function(i,item){
				console.log(item);
				item.id=optionNum;
				//item.attr("id",optionNum);
			});
			
			var filebtn = option.find("input[type=button]");
			filebtn.attr("id",optionNum);
			
			var file = option.find("input[type=file]");
			file.attr("id","file"+optionNum);
			
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

						var result = '';
						result += "<img src='" + urlArr[0] + "' width='100px'>";
						$("#imageForm").append(result);

						//加入图片
						var op = $("#op" + insertId);
						var img = op.children("img");
						img.css("display", "block");
						img.attr("src", urlArr[0]);

						//加入图片名字
						console.log(urlArr[1]);
						var imageUrl = "<input type='hidden' value='" + urlArr[1] + "' name='url' />";
						op.append(imageUrl);


					} else {
						alert("添加失败");

					}

				}
			});
		}
		
	</script>

</html>
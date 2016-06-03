<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="Xenon Boostrap Admin Panel" />
	<meta name="author" content="" />
	<title>登录--Findit分享生活</title>
	<link rel="shortcut icon" type="image/x-icon" media="screen" href="${pageContext.request.contextPath}/common/assets/images/black_cat.ico">
	<link rel="stylesheet" href="http://fonts.useso.com/css?family=Arimo:400,700,400italic">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/common/assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/common/assets/css/fonts/fontawesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/common/assets/css/bootstrap.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/common/assets/css/xenon-core.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/common/assets/css/xenon-forms.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/common/assets/css/xenon-components.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/common/assets/css/xenon-skins.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/common/assets/css/custom.css">
	<script src="${pageContext.request.contextPath}/common/assets/js/jquery-1.11.1.min.js"></script>
	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		<script src="assets/js/html5shiv.min.js"></script>
		<script src="assets/js/respond.min.js"></script>
	<![endif]-->
</head>
<body class="page-body login-page login-light" style="background-image:url(${pageContext.request.contextPath}/common/assets/images/backgroundImages/bg-6-mm.jpg)">
<!-- regist dialog -->
<div class="modal fade" id="registModal" style="margin-left:12%">
              <div class="modal-dialog">
              <script type="text/javascript">
              function errorMsg(msg){ //显示错误框
              		$("#rg_errors-container").html('<div class="alert alert-danger">\
						<button type="button" class="close" data-dismiss="alert">\
							<span aria-hidden="true">&times;</span>\
						</button>\
						' + msg + '\
					</div>');
					$("#rg_errors-container").fadeIn();
              	}
				$().ready(function(){
					//验证Username
					$("#rg_username").blur(function(){
						var value = $("#rg_username").val();
						var role = /^[a-zA-Z]\w{3,15}$/;  //以字母开头，长度在6-15之间，只能包含字符，数字和下划线
						var what = value.match(role);
						if(value==""){
							$("#rg_username").parent().parent().attr("class","form-group has-error");
							errorMsg("用户名不能为空");
							
						}else if(!role.test(value)){
							$("#rg_username").parent().parent().attr("class","form-group has-error");
							errorMsg("用户名长度必须在4-15之间，以字母开头,包含字符，数字和下划线");
						}else{
							$.ajax({	//检查用户名是否重复
									url: "${pageContext.request.contextPath}/user/findUserByName",
									method: 'POST',
									dataType: 'HTML',
									data:{'username2':value},
									success: function(resp)
									{	
										if(resp=='"no"'){
											$("#spinIcon-rg").hide();
											$("#smallword-rg").html("此用户名已被占用");
											$("#rg_username").parent().parent().attr("class","form-group has-error");
											errorMsg("用户名已经存在,换一个试试吧~");
										}else{
											$("#validUserName-rg").hide();
											$("#rg_errors-container").fadeOut();
											$("#rg_username").parent().parent().attr("class","form-group");
											$("#rg_errors-container").html("");
											$("#rg_username").attr("isvalid","0");
										}
									},
									beforeSend:function(){
										$("#validUserName-rg").show();
									}
								 });
						}
					});
					
					$("#rg_password").focus(function(){
						$("#pwd2").fadeIn();//显示重复输入密码框
					});
					
					//验证Password
					$("#rg_password").blur(function(){
						
						var value = $("#rg_password").val();
						var role = /\w{5,17}$/;  //以字母开头，长度在6-18之间，只能包含字符，数字和下划线
						var what = value.match(role);
						if(value==""){
							$("#rg_password").parent().parent().attr("class","form-group has-error");
							errorMsg("密码不能为空");
							
						}else if(!role.test(value)){
							$("#rg_password").parent().parent().attr("class","form-group has-error");
							errorMsg("密码长度必须在6-17之间");
						}else{ //验证成功后
							$("#rg_errors-container").fadeOut();
							$("#rg_password").parent().parent().attr("class","form-group");
							$("#rg_errors-container").html("");
							$("#rg_password").attr("isvalid","0");
							
						}
					});
					
					//验证Password2
					$("#pwdInpt2").blur(function(){
						var value = $("#pwdInpt2").val();
						var value2 = $("#rg_password").val();
						
						if(value!=value2){
							$("#pwdInpt2").parent().parent().attr("class","form-group has-error");
							errorMsg("两次输入不一致");
							
						}else{ //验证成功后
							$("#rg_errors-container").fadeOut();
							$("#pwdInpt2").parent().parent().attr("class","form-group");
							$("#rg_errors-container").html("");
							$("#pwdInpt2").attr("isvalid","0");
						}
					});
					
					
					//验证nick
					$("#rg_nick").blur(function(){
						var value = $("#rg_nick").val();
						var role = /^\w{1,6}$/;  //以字母开头，长度在6-15之间，只能包含字符，数字和下划线
						var what = value.match(role);
						if(!role.test(value)){
							$("#rg_nick").parent().parent().attr("class","form-group has-error");
							errorMsg("昵称为1~5的字符");
						}else{
							$("#rg_errors-container").fadeOut();
							$("#rg_nick").parent().parent().attr("class","form-group");
							$("#rg_errors-container").html("");
							$("#rg_nick").attr("isvalid","0");
							
						}
					});
					
					//验证mail
					$("#rg_mail").blur(function(){
						var value = $("#rg_mail").val();
						var role = /\w+([-+.]\w+)*@\w+([-.] \w+)*\.\w+([-.]\w+)*/;  //以字母开头，长度在6-15之间，只能包含字符，数字和下划线
						var what = value.match(role);
						if(!role.test(value)){
							$("#rg_mail").parent().parent().attr("class","form-group has-error");
							errorMsg("请输入正确的邮箱地址");
						}else{
							$("#rg_errors-container").fadeOut();
							$("#rg_mail").parent().parent().attr("class","form-group");
							$("#rg_errors-container").html("");
							$("#rg_mail").attr("isvalid","0");
							
						}
					});
					
					
					//提交
					$("#rg_subBtn").click(function(){
						var inps = $("#registForm").find("input");
						var sum = 0;
						$(inps).each(function(index,e){
							sum += parseInt($(e).attr("isvalid"));
						});
						if(sum==0){//全部通过
							$.ajax({
									url: "${pageContext.request.contextPath}/user/regist",
									method: 'POST',
									dataType: 'json',
									data:$("#registForm").serialize(),
									success: function(resp)
									{
										if(resp.accessGranted == "true")
										{
											$("#smallword-rg").show();
											$("#smallword-rg").html("注册成功,正在跳转");
											window.location.href='${pageContext.request.contextPath}/user/successui.action';
										}
										else
										{
											alert("失败："+resp.accessGranted);
										}
									},
									beforeSend:function(){
										$("#loadPic-rg").show();
									}
								});
						}
					});
				});
			  </script>
                <div class="modal-content  col-md-8 col-sm-8 col-xs-12"">
				<form class="login-form fade-in-effect"  id="registForm"  role="form"  method="post" novalidate="novalidate">
						
						<div class="login-header">
							<a href="${pageContext.request.contextPath}/picture/topPage" class="logo">
								<img src="${pageContext.request.contextPath}/common/assets/images/logo-white-bg@2x_regist.png" alt="" width="80" />
							</a>
						</div>
						<br/>
						
						<div class="form-group">
							<div class="input-group input-group-sm input-group-minimal">
								<span class="input-group-addon">
									<i class="linecons-user"></i>
								</span>
								<input type="text" class="form-control" name="username" id="rg_username"  placeholder="用户名"  isvalid="1" >
							</div>
							<div id="validUserName-rg" style="display:none;color:#636363">
								<span class="fa fa-spin fa-spinner" id="spinIcon-rg"></span>
								<small id="smallword-rg">正在验证此用户名</small>
							</div>
						</div>
						
						<div class="form-group">
							<div class="input-group input-group-sm input-group-minimal">
								<span class="input-group-addon">
									<i class="linecons-key"></i>
								</span>
								<input type="password" class="form-control" name="password" id="rg_password" placeholder="密 码" isvalid="1">
							</div>
						</div>
						
						<div class="form-group has-info" style="display:none;" id="pwd2">
							<div class="input-group input-group-sm input-group-minimal">
								<span class="input-group-addon">
									<i class="linecons-key"></i>
								</span>
								<input type="password" class="form-control" name="password2" id="pwdInpt2" placeholder="重复密码" isvalid="1">
							</div>
						</div>
						
						<div class="form-group">
							<div class="input-group input-group-sm input-group-minimal">
								<span class="input-group-addon">
									<i class="linecons-star"></i>
								</span>
								<input type="text" class="form-control" name="nick" id="rg_nick" placeholder="昵 称" isvalid="1">
							</div>
						</div>
						
						<div class="form-group">
							<div class="input-group input-group-sm input-group-minimal">
								<span class="input-group-addon">
									<i class="linecons-mail"></i>
								</span>
								<input type="text" class="form-control" name="mail" id="rg_mail" placeholder="邮箱" isvalid="1">
							</div>
						</div>
						
						<div id="rg_errors-container" style="display:none;">
						</div>
						
						<div class="form-group">
							<button type="button" class="btn btn-success" id="rg_subBtn">确定</button>
							<button type="reset" class="btn btn-white">重置</button>
						</div>
						<p>加入Findit,分享你的生活！</p>
						<div id="loadPic-rg" style="display:none;color:#636363">
							<span class="fa fa-spin fa-spinner" id="spinIcon-rg"></span>
							<small id="smallword-rg">操作中...</small>
						</div>
					</form>
                </div>
              </div>
            </div>
<!-- regist dialog end -->
	<div class="login-container" id="loginContainer">
		<div class="row">
			<div class="col-md-4 col-sm-7 col-xs-12"">
				<script type="text/javascript">
					jQuery(document).ready(function($)
					{
						// Reveal Login form
						setTimeout(function(){ $(".fade-in-effect").addClass('in'); }, 1);
						// Validation and Ajax action
						$("form#login").validate({
							rules: {
								username: {
									required: true
								},
								
								passwd: {
									required: true
								}
							},
							
							messages: {
								username: {
									required: '请输入用户名.'
								},
								
								passwd: {
									required: '请输入密码.'
								}
							},
							
							// Form Processing via AJAX
							submitHandler: function(form)
							{
								show_loading_bar(70); // Fill progress bar to 70% (just a given value)
								
								var opts = {
									"closeButton": true,
									"debug": false,
									"positionClass": "toast-top-full-width",
									"onclick": null,
									"showDuration": "300",
									"hideDuration": "1000",
									"timeOut": "5000",
									"extendedTimeOut": "1000",
									"showEasing": "swing",
									"hideEasing": "linear",
									"showMethod": "fadeIn",
									"hideMethod": "fadeOut"
								};
									
								$.ajax({
									url: "${pageContext.request.contextPath}/user/login",
									method: 'POST',
									dataType: 'json',
									data:{
										/*do_login: true,*/
										username: $(form).find('#username').val(),
										password: $(form).find('#passwd').val(),
									},
									success: function(resp)
									{
										show_loading_bar({
											delay: .5,
											pct: 100,
											finish: function(){
												// Redirect after successful login page (when progress bar reaches 100%)
												if(resp.accessGranted == "true")
												{
													window.location.href = '${pageContext.request.contextPath}/picture/topPage';
												}
																						}
										});
										// Remove any alert
										$(".errors-container .alert").slideUp('fast');
										
										
										// Show errors
										if(resp.accessGranted == "false")
										{
											$(".errors-container").html('<div class="alert alert-danger">\
												<button type="button" class="close" data-dismiss="alert">\
													<span aria-hidden="true">&times;</span>\
													<span class="sr-only">Close</span>\
												</button>\
												' + resp.error + '\
											</div>');
											
											
											$(".errors-container .alert").hide().slideDown();
											$(form).find('#passwd').select();
										}
									}
								});
								
							}
						});
						
						// Set Form focus
						$("form#login .form-group:has(.form-control):first .form-control").focus();
					});
				</script>
				<!-- Errors container -->
				<div class="errors-container">
				</div>
				<!-- Add class "fade-in-effect" for login form effect -->
				<form method="post" role="form" id="login" class="login-form fade-in-effect">
					
					<div class="login-header">
						<a href="${pageContext.request.contextPath}/picture/topPage" class="logo">
							<img src="${pageContext.request.contextPath}/common/assets/images/logo-white-bg@2x_login.png" alt="" width="80" />
						</a>
					</div>
					<div class="form-group">
						<label class="control-label" for="username">Username</label>
						<input type="text" class="form-control" name="username" id="username" autocomplete="off" />
					</div>
					
					<div class="form-group">
						<label class="control-label" for="passwd">Password</label>
						<input type="password" class="form-control" name="passwd" id="passwd" autocomplete="off" />
					</div>
					
					<div class="form-group">
						<button type="submit" class="btn btn-primary  btn-block text-left">
							<i class="fa-lock"></i>
							登 录
						</button>
					</div>
					
					<div class="login-footer">
						<a href="#">忘记密码?</a>
						
						<div class="info-links">
							<a href="#">ToS</a> -
							<a href="#">Privacy Policy</a>
						</div>
						
					</div>
					
				</form>
				
				<!-- 继续下面的按钮 隐藏登录form 显示注册页面   -->
				<div class="external-login">
					<a onclick="showRegistDialog()" class="facebook">
						<i class="fa fa-user"></i>
						注册新账号
					</a>
				</div>
				<script>
					function showRegistDialog(){//显示注册对话框，隐藏登录
						$("#loginContainer").hide();
	             		$("#registModal").modal('show');
		            }
				</script>
			</div>
			
		</div>
		
	</div>

	<!-- Bottom Scripts -->
	<script src="${pageContext.request.contextPath}/common/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/common/assets/js/TweenMax.min.js"></script>
	<script src="${pageContext.request.contextPath}/common/assets/js/resizeable.js"></script>
	<script src="${pageContext.request.contextPath}/common/assets/js/joinable.js"></script>
	<script src="${pageContext.request.contextPath}/common/assets/js/xenon-api.js"></script>
	<script src="${pageContext.request.contextPath}/common/assets/js/xenon-toggles.js"></script>
	<script src="${pageContext.request.contextPath}/common/assets/js/jquery-validate/jquery.validate.min.js"></script>
	<script src="${pageContext.request.contextPath}/common/assets/js/toastr/toastr.min.js"></script>
	<!-- JavaScripts initializations and stuff -->
	<script src="${pageContext.request.contextPath}/common/assets/js/xenon-custom.js"></script>

</body>
</html>
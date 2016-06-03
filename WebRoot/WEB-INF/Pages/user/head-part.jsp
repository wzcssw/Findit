<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
	<title>
		<s:property value="web_title"/>Findit
	</title>
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
	
	
</head>
<body class="page-body">
<!-- regist dialog -->
<div class="modal fade" id="registModal">
              <div class="modal-dialog" style="margin-top:10%;margin-left:27%">
              <script type="text/javascript">
            function openRegistDialog(){//显示注册对话框，隐藏登录
              		$("#myModal").modal('hide');
              		$("#registModal").modal('show');
              }
              
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
											window.location.href="${pageContext.request.contextPath}/user/successui.action";
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
                <div class="modal-content  col-md-7 col-sm-7 col-xs-10" >
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
<!-- login dialog -->
<div class="modal fade" id="myModal">
<script src="${pageContext.request.contextPath}/common/assets/js/toastr/toastr.min.js"></script>
<script src="${pageContext.request.contextPath}/common/assets/js/jquery-validate/jquery.validate.min.js"></script>
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
													window.location.reload();
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

              <div class="modal-dialog" style="margin-top:10%;margin-left:27%">
                <div class="modal-content col-md-7 col-sm-7 col-xs-12">
                <form method="post" role="form" id="login" class="login-form fade-in-effect">
					
					<div class="login-header">
						<a href="${pageContext.request.contextPath}/picture/topPage" class="logo">
							<img src="${pageContext.request.contextPath}/common/assets/images/logo-white-bg@2x_login.png" alt="" width="80" />
						</a>
					</div>
					<hr/>
					<div class="form-group">
					<label class="control-label" for="username">用户名</label>
						<div class="input-group input-group-sm input-group-minimal">
							<span class="input-group-addon">
								<i class="linecons-user"></i>
							</span>
							<input type="text" class="form-control" name="username" id="username"  placeholder="用户名" >
						</div>
					</div>
					
					<div class="form-group">
					<label class="control-label" for="passwd">密  码</label>
						<div class="input-group input-group-sm input-group-minimal">
							<span class="input-group-addon">
								<i class="linecons-key"></i>
							</span>
							<input type="password" class="form-control" name="passwd" id="passwd" placeholder="密 码">
						</div>
					</div>
					
					<div class="errors-container">
					</div>
					
					<div class="form-group">
						<button type="submit" class="btn btn-primary  btn-block text-left">
							<i class="fa-lock"></i>
							登录
						</button>
					</div>
					
					<div class="login-footer">
						<a onclick="alert('忘了你就哭吧~ 这里还没有写~')" style="cursor:pointer;">忘记密码?</a>
						
						<div class="info-links">
							<a onclick="openRegistDialog()" style="color:blue;cursor:pointer;">新用户注册</a>
						</div>
						
					</div>
					
				</form>
                </div>
              </div>
            </div>

	<!-- other -->
	<div class="modal fade" id="other-modal">
		<div class="modal-dialog" style="margin-top:10%; margin-left:5%">
			<div class="modal-content  col-md-7 col-sm-7 col-xs-12">
				
				<div class="modal-header">
					<h4 class="modal-title" id="otherTitle">分 类</h4>
				</div>
				<div class="modal-body" id="msgP">
					
				</div>
			</div>
		</div>
	</div>
	<!-- other end -->
	
	<nav class="navbar horizontal-menu navbar-fixed-top navbar-minimal " role="navigation">
		
		<div class="navbar-inner">
		<!-- Navbar Brand -->
		<div class="visible-lg-block visible-md-block visible-sm-block">
			<div class="navbar-brand " >
				<a href="${pageContext.request.contextPath}/picture/topPage" class="logo">
					<img src="${pageContext.request.contextPath}/common/assets/images/logo-white-bg@2x.png" width="80" />
				</a>
			</div>
		</div>
		
			<!-- Mobile Toggles Links -->
			<div class="nav navbar-mobile">
				<!-- This will toggle the mobile menu and will be visible only on mobile devices -->
				<div class="mobile-menu-toggle">
				
					<!-- Navbar Brand -->
					<div class="navbar-brand" style=" position:absolute;left:-10%">
						<a href="${pageContext.request.contextPath}/picture/topPage" class="logo">
							<img src="${pageContext.request.contextPath}/common/assets/images/logo-black-bg@2x.png" width="80" />
						</a>
					</div>
					
					<a onclick="$('#other-modal').modal('show');" style=" position:absolute;left:38%">
						<i class="linecons-camera"></i>
						<span class="title">分类</span>
					</a>
					
					
					<s:if test="#session.user == null"><!-- 未登录 -->
						<a href="#" onclick="$('#myModal').modal('show')"  style=" position:absolute;right:15%">
							<i class="fa-user"></i>登录
						</a>
					</s:if>
					<s:else>
						<a href="#collapseOne" data-toggle="collapse" data-parent="#accordion"  style=" position:absolute;right:15%">
							<i class="fa-user"></i>
							
							<s:property value="#session.user.nick"/>
						</a>
					</s:else>
					
					<a href="#collapseOne" data-toggle="collapse" data-parent="#accordion" style=" position:absolute;right:5%">
						<i class="fa-bars"></i>
					</a>
				</div>
			</div>
			
			<!-- main menu -->
			<ul class="navbar-nav">
				<s:if test="web_title==null">
					<li class="active">
				</s:if>
				<s:else>
					<li>
				</s:else>
					<a href="${pageContext.request.contextPath}/picture/topPage">
						<i class="linecons-camera"></i>
						<span class="title">图片</span>
					</a>
					<ul>
						<li>
							<a href="#">
								<span class="title">最新</span>
							</a>
						</li>
						<li>
							<a href="#">
								<span class="title">最热</span>
							</a>
						</li>
						<li>
							<a href="#">
								<span class="title">全部</span>
							</a>
						</li>
					</ul>
				</li>
				<s:if test="web_title=='相册--'">
					<li class="active">
				</s:if>
				<s:else>
					<li>
				</s:else>
					<a href="${pageContext.request.contextPath}/picture/album">
						<i class="linecons-desktop"></i>
						<span class="title">相册</span>
					</a>
					<ul id="albumUL">
					</ul>
					<script>
						$().ready(function(){ //载入相册列表
							$.ajax({
								url: "${pageContext.request.contextPath}/picture/loadAlbumByAJAX",
								method: 'POST',
								dataType: 'json',
								success: function(resp)
								{
									if(resp.msg=="ok"){
										var aa = $(resp.albums);
										$(aa).each(function(index,obj){
											$("#albumUL").append("<li><a href='${pageContext.request.contextPath}/picture/userPicture?aid="+obj.aid+"'><span class='title'>"+obj.aname+"</span></a></li>");
										});
									}
								}
				      		  });
						});
					</script>
				</li>
				<s:if test="web_title=='收藏--'">
					<li class="active">
				</s:if>
				<s:else>
					<li>
				</s:else>
					<a href="${pageContext.request.contextPath}/picture/collectedPictureui">
						<i class="linecons-heart"></i>
						<span class="title">收藏</span>
					</a>
				</li>
				<s:if test="web_title=='上传图片--'">
					<li class="active">
				</s:if>
				<s:else>
					<li>
				</s:else>
					<a href="${pageContext.request.contextPath}/picture/uploadPictureui">
						<i class="linecons-truck"></i>
						<span class="title">上传</span>
					</a>
				</li>
				
				<li class=" visible-lg-block visible-md-block">
					<a href="#">
						<i class="linecons-diamond"></i>
						<span class="title">Other</span>
					</a>
				<ul>
				</li>
						<li>
							<a href="#">
								<i class="linecons-beaker"></i>
								<span class="title">Extra</span>
								<span class="label label-purple pull-right hidden-collapsed">New Items</span>
							</a>
							<ul>
								
								
								
								<li>
									<a href="#">
										<span class="title">Lockscreen</span>
									</a>
								</li>
								<li>
									<a href="#">
										<span class="title">Login Light</span>
									</a>
								</li>
								
							</ul>
						</li>
						<li>
							<a href="#">
								<i class="linecons-globe"></i>
								<span class="title">Charts</span>
							</a>
							<ul>
								<li>
									<a href="#">
										<span class="title">Chart Variants</span>
									</a>
								</li>
								<li>
									<a href="#">
										<span class="title">Range Selector</span>
									</a>
								</li>
								<li>
									<a href="#">
										<span class="title">Sparklines</span>
									</a>
								</li>
							</ul>
						</li>
						
					</ul>
				</li>
			</ul>
					
			
			<!-- notifications and other links -->
			<ul class="nav nav-userinfo navbar-right">
				
				<li class="search-form always-visible"><!-- You can add "always-visible" to show make the search input visible -->
			
					<form method="get" action="#">
						<input type="text" name="s" class="form-control search-field" placeholder="发现..." />
						
						<button type="submit" class="btn btn-link">
							<i class="linecons-search"></i>
						</button>
					</form>
					
				</li>
				
				<li class="dropdown xs-left">
					
					<a href="#" data-toggle="dropdown" class="notification-icon">
						<i class="fa-envelope-o"></i>
						<span class="badge badge-green">15</span>
					</a>
						
					<ul class="dropdown-menu messages">
										<li>
							
						<ul class="dropdown-menu-list list-unstyled ps-scrollbar">
						
							<li class="active"><!-- "active" class means message is unread -->
								<a href="#">
									<span class="line">
										<strong>Luc Chartier</strong>
										<span class="light small">- yesterday</span>
									</span>
									
									<span class="line desc small">
										This ainât our first item, it is the best of the rest.
									</span>
								</a>
							</li>
							
							<li class="active">
								<a href="#">
									<span class="line">
										<strong>Salma Nyberg</strong>
										<span class="light small">- 2 days ago</span>
									</span>
									
									<span class="line desc small">
										Oh he decisively impression attachment friendship so if everything. 
									</span>
								</a>
							</li>
							
							<li>
								<a href="#">
									<span class="line">
										Hayden Cartwright
										<span class="light small">- a week ago</span>
									</span>
									
									<span class="line desc small">
										Whose her enjoy chief new young. Felicity if ye required likewise so doubtful.
									</span>
								</a>
							</li>
							
							<li>
								<a href="#">
									<span class="line">
										Sandra Eberhardt
										<span class="light small">- 16 days ago</span>
									</span>
									
									<span class="line desc small">
										On so attention necessary at by provision otherwise existence direction.
									</span>
								</a>
							</li>
							
							<!-- Repeated -->
							
							<li class="active"><!-- "active" class means message is unread -->
								<a href="#">
									<span class="line">
										<strong>Luc Chartier</strong>
										<span class="light small">- yesterday</span>
									</span>
									
									<span class="line desc small">
										This ainât our first item, it is the best of the rest.
									</span>
								</a>
							</li>
							
							<li class="active">
								<a href="#">
									<span class="line">
										<strong>Salma Nyberg</strong>
										<span class="light small">- 2 days ago</span>
									</span>
									
									<span class="line desc small">
										Oh he decisively impression attachment friendship so if everything. 
									</span>
								</a>
							</li>
							
							<li>
								<a href="#">
									<span class="line">
										Hayden Cartwright
										<span class="light small">- a week ago</span>
									</span>
									
									<span class="line desc small">
										Whose her enjoy chief new young. Felicity if ye required likewise so doubtful.
									</span>
								</a>
							</li>
							
							<li>
								<a href="#">
									<span class="line">
										Sandra Eberhardt
										<span class="light small">- 16 days ago</span>
									</span>
									
									<span class="line desc small">
										On so attention necessary at by provision otherwise existence direction.
									</span>
								</a>
							</li>
							
						</ul>
						
					</li>
					
					<li class="external">
						<a href="blank-sidebar.html">
							<span>All Messages</span>
							<i class="fa-link-ext"></i>
						</a>
					</li>
					</ul>
					
				</li>
				
				<li class="dropdown xs-left">
					<a href="#" data-toggle="dropdown" class="notification-icon notification-icon-messages">
						<i class="fa-bell-o"></i>
						<span class="badge badge-purple">7</span>
					</a>
						
					<ul class="dropdown-menu notifications">
										<li class="top">
						<p class="small">
							<a href="#" class="pull-right">Mark all Read</a>
							You have <strong>3</strong> new notifications.
						</p>
					</li>
					
					<li>
						<ul class="dropdown-menu-list list-unstyled ps-scrollbar">
							<li class="active notification-success">
								<a href="#">
									<i class="fa-user"></i>
									
									<span class="line">
										<strong>New user registered</strong>
									</span>
									
									<span class="line small time">
										30 seconds ago
									</span>
								</a>
							</li>
							
							<li class="active notification-secondary">
								<a href="#">
									<i class="fa-lock"></i>
									
									<span class="line">
										<strong>Privacy settings have been changed</strong>
									</span>
									
									<span class="line small time">
										3 hours ago
									</span>
								</a>
							</li>
							
							<li class="notification-primary">
								<a href="#">
									<i class="fa-thumbs-up"></i>
									
									<span class="line">
										<strong>Someone special liked this</strong>
									</span>
									
									<span class="line small time">
										2 minutes ago
									</span>
								</a>
							</li>
							
							<li class="notification-danger">
								<a href="#">
									<i class="fa-calendar"></i>
									
									<span class="line">
										John cancelled the event
									</span>
									
									<span class="line small time">
										9 hours ago
									</span>
								</a>
							</li>
							
							<li class="notification-info">
								<a href="#">
									<i class="fa-database"></i>
									
									<span class="line">
										The server is status is stable
									</span>
									
									<span class="line small time">
										yesterday at 10:30am
									</span>
								</a>
							</li>
							
							<li class="notification-warning">
								<a href="#">
									<i class="fa-envelope-o"></i>
									
									<span class="line">
										New comments waiting approval
									</span>
									
									<span class="line small time">
										last week
									</span>
								</a>
							</li>
						</ul>
					</li>
					
					<li class="external">
						<a href="#">
							<span>View all notifications</span>
							<i class="fa-link-ext"></i>
						</a>
					</li>
					</ul>
				</li>
		<s:if test="#session.user !=null"><!-- 已登录 -->
				<li class="dropdown user-profile">
					<a href="#" data-toggle="dropdown">
						<s:if test="#session.user.head==null">
							<img src="${pageContext.request.contextPath}/common/assets/images/user-1.png" alt="user-image" class="img-circle img-inline userpic-38" width="38" />
						</s:if>
						<s:else>
							<img src="${pageContext.request.contextPath}/file/showMini?downFileName=<s:property value="#session.user.head.pname"/>" alt="user-image" class="img-circle img-inline userpic-38" width="38" />
						</s:else>
						
						<span>
							${sessionScope.user.nick}
						</span>
					</a>
					
					<ul class="dropdown-menu user-profile-menu list-unstyled">
						<li>
							<a href="${pageContext.request.contextPath}/user/profileui">
								<i class="fa-tree"></i>
								我的信息
							</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/user/modifyResumeui">
								<i class="fa-user"></i>
								修改资料
							</a>
						</li>
						<s:if test="#session.user.role=='admin'">
							<li>
								<a href="${pageContext.request.contextPath}/backstage/systemInfo">
									<i class="fa-cogs"></i>
									系统管理
								</a>
							</li>
						</s:if>
						<li class="last">
							<a href="${pageContext.request.contextPath}/user/logout.action">
								<i class="fa-lock"></i>
								注销
							</a>
						</li>
					</ul>
				</li>
			</s:if>
		<s:if test="#session.user == null"><!-- 未登录 -->
			<li style="min-height: 76px;">
			<div class="fa-hover">
			 	<span data-toggle="modal" data-target="#myModal" style="cursor:pointer;">
			 		<i class="fa fa-user"></i>
						登录
				</span>
			 </div>
				</li>
		</s:if>
				<li style="min-height: 76px;">
						<a href="#" data-toggle="modal" data-target="#other-modal">
							<i class="fa-comments-o"></i>
						</a>
				</li>
			</ul>
	
		</div>
		<!-- xs用户下拉 -->
		<div id="accordion" style="margin-top:16px;;background-color:white;width:40%;float:right; position:absolute;z-index:30;right:2%">
			<div id="collapseOne" class="panel-collapse collapse ">
				<div class="panel-body">
				
					<div class="nav navbar-nav">
						<li class="dropdown open">
							<ul class="dropdown-menu user-profile-menu list-unstyled">
								<li>
									<a href="${pageContext.request.contextPath}/picture/album">
										<i class="fa-tree"></i>
										相册
									</a>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/picture/collectedPictureui">
										<i class="fa-user"></i>
										收藏
									</a>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/picture/uploadPictureui">
										<i class="fa-user"></i>
										上传
									</a>
								</li>
								
								
								
								
								<s:if test="#session.user != null"><!-- 未登录 -->
									<hr/>
									<s:if test="#session.user.role=='admin'">
										<li>
											<a href="${pageContext.request.contextPath}/backstage/systemInfo">
												<i class="fa-cogs"></i>
												系统管理
											</a>
										</li>
									</s:if>
									<li>
										<a href="${pageContext.request.contextPath}/user/modifyResumeui">
											<i class="fa-user"></i>
											修改资料
										</a>
									</li>
									<li>
										<a href="${pageContext.request.contextPath}/user/profileui">
											<i class="fa-tree"></i>
											我的信息
										</a>
									</li>
									<li class="last">
										<a href="${pageContext.request.contextPath}/user/logout.action">
											<i class="fa-lock"></i>
											注销
										</a>
									</li>
								</s:if>
								
							</ul>
						</li>
					</div>
		
				</div>
			</div>
		</div>
		<!-- xs用户下拉 end -->
	</nav>

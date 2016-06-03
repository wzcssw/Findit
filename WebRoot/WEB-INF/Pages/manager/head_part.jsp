<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title><s:property value="web_title"/>后台管理</title>
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
	<!-- 选择用户对话框-->
	<div class="modal fade" id="gallery-image-alert" data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
						<span class="logo">
							<img src="${pageContext.request.contextPath}/common/assets/images/logo-white-bg@2x.png" alt="" width="80" />
						</span>
				</div>
				<div class="modal-body" id="confirmMsg">
					<!-- confirmMsg start -->
					<div class="row">
						<div class="col-xs-3 col-md-3"  style="cursor:pointer"><!-- 左侧图片 -->
							<img id="model_userHeadPic" class="thumbnail img-responsive" src=""/>
							<div class="vertical-top">					
								<button class="btn btn-primary btn-block">Block button</button>
								<button class="btn btn-info btn-block">锁定用户</button>
								<button class="btn btn-danger btn-block" id="delBtn">删除用户</button>
							</div>
          				</div>
          				<div class="col-xs-9 col-md-9"><!-- 右侧form -->
          					<div class="well well-sm" id="nickPos">
          						<table>
          							<tr>
          								<td>用户昵称：<span id="nickSpan"></span></td>
          								<td>&nbsp;</td>
          								<td>上次登录：<span id="lastLoginSpan"></span><span id="idSpan" style="color:red;display:none;"></span></td>
          								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
          							</tr>
          							<tr>
          								<td>&nbsp;</td>
          							</tr>
          							<tr>
          								<td>创建日期：<span id="dateSpan"></span></td>
          								<td>&nbsp;</td>
          								<td>用户角色：<span id="roleSpan"></span></td>
          							</tr>
          						</table>
							</div>
							
							<div>
									<ul class="list-group list-group-minimal">
										<li class="list-group-item">
											<span class="badge badge-roundless badge-primary">5,200</span>
											上传图片
										</li>
										<li class="list-group-item">
											<span class="badge badge-roundless badge-info">22,000</span>
											共享图片
										</li>
										<li class="list-group-item">
											<span class="badge badge-roundless badge-danger">16.7%</span>
											相册数量
										</li>
										<li class="list-group-item">
											<span class="badge badge-roundless badge-success">11,340</span>
											上次登录
										</li>
									</ul>
									
								</div>
							
							<br/>
													
          				</div>
					</div>
				
					<!-- confirmMsg end -->
				</div>
				<div class="modal-footer">
					<div id="loadingPic" style="display:none; float:left;">
							<span class="fa fa-spin fa-spinner" id="spinIcon"></span>
							<small id="smallword">操作中...</small>
					</div>
					<button type="button" class="btn btn-white" id="closeBtn" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 选择用户对话框 end-->
	<!-- 提示对话框-->
	<div class="modal fade" id="gallery-image-info" data-backdrop="static" uid="">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
						<span class="logo">
							<img src="${pageContext.request.contextPath}/common/assets/images/logo-white-bg@2x.png" alt="" width="80" />
						</span>
				</div>
				<div class="modal-body" id="infoconfirmMsg">
					<!-- confirmMsg start -->
					<h5 id="infoH5">删除此用户将同时删除其所有的上传的文件,你确定继续吗？</h5>
					<!-- confirmMsg end -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" id="infoOkBtn">确定</button>
					<button type="button" class="btn btn-white" id="infocloseBtn" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 提示对话框 end-->
	<div class="page-loading-overlay">
				<div class="loader-2"></div>
			</div>
	
	<div class="page-container"><!-- add class "sidebar-collapsed" to close sidebar by default, "chat-visible" to make chat appear always -->
			
		<!-- Add "fixed" class to make the sidebar fixed always to the browser viewport. -->
		<!-- Adding class "toggle-others" will keep only one menu item open at a time. -->
		<!-- Adding class "collapsed" collapse sidebar root elements and show only icons. -->
		<div class="sidebar-menu toggle-others fixed">
			
			<div class="sidebar-menu-inner">	
				
				<header class="logo-env">
					
					<!-- logo -->
					<div class="logo">
						<a href="${pageContext.request.contextPath}/picture/topPage"  class="logo-expanded">
							<img src="${pageContext.request.contextPath}/common/assets/images/logo@2x.png" width="80" alt="" />
						</a>
						
						<a href="${pageContext.request.contextPath}/picture/topPage" class="logo-collapsed">
							<img src="${pageContext.request.contextPath}/common/assets/images/logo-collapsed@2x.png" width="40" alt="" />
						</a>
					</div>
					
					<!-- This will toggle the mobile menu and will be visible only on mobile devices -->
					<div class="mobile-menu-toggle visible-xs">
						<a href="#" data-toggle="user-info-menu">
							<i class="fa-bell-o"></i>
							<span class="badge badge-success">7</span>
						</a>
						
						<a href="#" data-toggle="mobile-menu">
							<i class="fa-bars"></i>
						</a>
					</div>
					
					<!-- This will open the popup with user profile settings, you can use for any purpose, just be creative -->
					<div class="settings-icon">
						<a >
							<i class="linecons-cog"></i>
						</a>
					</div>
					
								
				</header>
						
				
						
				<ul id="main-menu" class="main-menu">
					<s:if test="web_title=='数据--'">
						<li class="opened active">
					</s:if>
					<s:else>
						<li>
					</s:else>
						<a href="${pageContext.request.contextPath}/backstage/systemInfo">
							<i class="linecons-database"></i>
							<span class="title">数据</span>
						</a>
					</li>
					<s:if test="web_title=='用户--'">
						<li class="opened active">
					</s:if>
					<s:else>
						<li>
					</s:else>
						<a href="#">
							<i class="linecons-user"></i>
							<span class="title">用户</span>
						</a>
						<ul>
							<li>
								<a href="${pageContext.request.contextPath}/backstage/userlist.action">
									<span class="title active">用户列表</span>
								</a>
							</li>
							<li>
								<a href="#">
									<span class="title">管理权限</span>
								</a>
							</li>
							<li>
								<a href="#">
									<span class="title">编辑用户</span>
								</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="#">
							<i class="linecons-desktop"></i>
							<span class="title">首页</span>
						</a>
						<ul>
							<li>
								<a href="#">
									<span class="title">Layout Variants &amp; API</span>
								</a>
							</li>
							<li>
								<a href="#">
									<span class="title">Collapsed Sidebar</span>
								</a>
							</li>
							
						</ul>
					</li>
					<li>
						<a href="#">
							<i class="linecons-note"></i>
							<span class="title">UI Elements</span>
						</a>
						<ul>
							<li>
								<a href="#">
									<span class="title">Panels</span>
								</a>
							</li>
							<li>
								<a href="#">
									<span class="title">Buttons</span>
								</a>
							</li>
							
						</ul>
					</li>
				</ul>
						
			</div>
			
		</div>
		<div class="main-content">
			<nav class="navbar user-info-navbar  navbar-minimal" role="navigation">
				<ul class="user-info-menu left-links list-inline list-unstyled">
					
					<li class="hidden-sm hidden-xs">
						<a href="#" data-toggle="sidebar">
							<i class="fa-bars"></i>
						</a>
					</li>
					
					<li class="dropdown hover-line">
						<a href="#" data-toggle="dropdown">
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
					
					<li class="dropdown hover-line">
						<a href="#" data-toggle="dropdown">
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
					
				</ul>
				
				
				<!-- Right links for user info navbar -->
				<ul class="user-info-menu right-links list-inline list-unstyled">
					
					<li class="search-form"><!-- You can add "always-visible" to show make the search input visible -->
						
						<form method="get" action="extra-search.html">
							<input type="text" name="s" class="form-control search-field" placeholder="Type to search..." />
							
							<button type="submit" class="btn btn-link">
								<i class="linecons-search"></i>
							</button>
						</form>
						
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
							<i class="fa-angle-down"></i>
						</span>
					</a>
					
					<ul class="dropdown-menu user-profile-menu list-unstyled">
						<li>
							<a href="${pageContext.request.contextPath}/user/profileui">
								<i class="fa-user"></i>
								详细
							</a>
						</li>
						<s:if test="#session.user.role=='admin'">
							<li class="last">
								<a href="${pageContext.request.contextPath}/backstage/backstage/systemInfo">
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
				<i class="fa fa-user"></i>
			 	<span data-toggle="modal" data-target="#myModal" style="cursor:pointer;">
						登录
				</span>
			 </div>
				</li>
		</s:if>
					
					<li>
						<a href="#" >
							<i class="fa-comments-o"></i>
						</a>
					</li>
					
				</ul>
				
			</nav>
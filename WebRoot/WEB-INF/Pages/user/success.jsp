<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/Pages/user/head-part.jsp"%>
<div class="page-container container">
		<div class="main-content">
<div class="visible-xs-block">
<h3>注册成功，即将跳转...</h3>
</div>
<div class="col-md-12 visible-lg-block visible-md-block">
	<!-- Colored panel, remember to add "panel-color" before applying the color -->
	<div class="panel panel-color panel-info">
		<!-- Add class "collapsed" to minimize the panel -->
		<div class="panel-heading">
			<h3 class="panel-title">注册成功</h3>

			<div class="panel-options">
				<a href="#"> <i class="linecons-cog"></i> </a> <a href="#"
					data-toggle="panel"> <span class="collapse-icon">–</span> <span
					class="expand-icon">+</span> </a> <a href="#" data-toggle="reload">
					<i class="fa-rotate-right"></i> </a> <a href="#" data-toggle="remove">
					× </a>
			</div>
		</div>

		<div class="panel-body">
			<div class="row">
				<div class="col-md-2 col-xs-2">
					<img alt="ok" width="60%" src="${pageContext.request.contextPath}/common/assets/images/Ok_1280px_1183433_easyicon.net.png">
				</div>
				<div class="col-md-10 col-xs-10">
					<h4>
						恭喜您<s:property value="#session.user.nick"/>,注册成功！<br/>
						欢迎您加入Findit,马上加入我们分享您多彩的生活吧.
						<br/><hr/>
						有问题联系我哦~	Email:wzcssw@163.com
					</h4>
				</div>
			</div>

		</div>
	</div>
	<script type="text/javascript">
		$().ready(function(){
			//2秒后跳转
			setInterval(jumpOut,2000);
		});
		 function jumpOut(){//定时清除所有记录
        	window.location.href = '${pageContext.request.contextPath}/picture/topPage';
       	 }
	</script>

</div>

<%@ include file="/WEB-INF/Pages/user/food-part.jsp"%>
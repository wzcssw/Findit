<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/Pages/manager/head_part.jsp"%>		
			<div class="page-title">
				<div class="title-env">
					<h1 class="title">用户</h1>
					<p class="description">管理用户列表</p>
				</div>
					<div class="breadcrumb-env">
								<ol class="breadcrumb bc-1">
									<li>
							<a href="dashboard-1.html"><i class="fa-home"></i>主页</a>
						</li>
								<li>
										<a href="tables-basic.html">系统管理</a>
								</li>
							<li class="active">
										<strong>用户</strong>
								</li>
								</ol>
				</div>
			</div>
			
			<!-- 用户列表 -->
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">用户列表</h3>
					
					<div class="panel-options">
						<a href="#" data-toggle="panel">
							<span class="collapse-icon">&ndash;</span>
							<span class="expand-icon">+</span>
						</a>
						<a href="#" data-toggle="remove">
							&times;
						</a>
					</div>
				</div>
				<div class="panel-body">
					
					<script type="text/javascript">
					jQuery(document).ready(function($)
					{
						$("#example-1").dataTable({
							aLengthMenu: [
								[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]
							]
						});
					});
					</script>
					
					<table id="example-1" class="table table-striped table-bordered" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th></th>
								<th>用户名</th>
								<th>昵称</th>
								<th>用户权限</th>
								<th>电话</th>
								<th>创建日期</th>
								<th>性别</th>
							</tr>
						</thead>
					
						<tfoot>
							<tr>
								<th></th>
								<th>用户名</th>
								<th>昵称</th>
								<th>用户权限</th>
								<th>电话</th>
								<th>创建日期</th>
								<th>性别</th>
							</tr>
						</tfoot>
					
						<tbody>
							<s:iterator value="users" var="u">
								<tr onclick="userSelected(this)" uid="<s:property value="#u.uid" />" username="<s:property value="#u.username" />" nick="<s:property value="#u.nick" />" lastLogin="<s:date name="#u.lastLogin" format="yyyy-MM-dd hh:mm"/>" userRole="<s:property value="#u.role" />" createDate="<s:date name="#u.createDate" format="yyyy-MM-dd"/>" userRole="<s:property value="#u.role" />" fileName="<s:property value="#u.head.pname" />">
									<s:if test="#u.head==null">
									  <td>
										<img src="${pageContext.request.contextPath}/common/assets/images/user-1.png" alt="user-image" style="height:30px; width:30px;" class="img-responsive" />
									  </td>
									</s:if>
									<s:else>
										<td>
											<img src="${pageContext.request.contextPath}/file/showMini?downFileName=<s:property value="#u.head.pname" />" alt="user-image" style="height:30px; width:30px;" class="img-responsive">
										</td>
									</s:else>
									<td>
										<a href="#">
											<s:property value="#u.username" />
										</a>
									</td>
									<td>
										<s:property value="#u.nick" />
									</td>
									<td>
										<s:property value="#u.role" />
									</td>
									<td>
										<s:property value="#u.phone" />
									</td>
									<td>
										<s:date name="#u.createDate" format="yyyy-MM-dd"/>
									</td>
									<td>
										<s:if test="#u.gender==1">男</s:if>
										<s:if test="#u.gender==0">女</s:if>
									</td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
					
				</div>
			</div>
<script type="text/javascript">
	$().ready(function(){
		$("#delBtn").click(function(){
			var uid = $("#idSpan").html();
			if(""!=uid){
				$("#gallery-image-info").attr("uid",uid);
				$("#gallery-image-info").modal("show");
			}
		});
		$("#infoOkBtn").click(function(){
			var uid = $("#gallery-image-info").attr("uid");
			if(uid != ""){
				$.ajax({
					url: "${pageContext.request.contextPath}/user/deleteUser",
					method: 'POST',
					dataType: 'json',
					data:{
						"uid": uid
					},
					success: function(resp)
					{
						if("ok"==resp.accessGranted){
							$("#gallery-image-alert").modal("hide");
							$("#infoOkBtn").attr("disabled","disabled");
							$("#infoH5").html("删除成功！");
							window.setInterval(jumpOut,1000); 
						}
					}
				});
			}
		});
	});
	//打开选择用户的资料modal
	function userSelected(obj){
		var username = $(obj).attr("username");
		var uid = $(obj).attr("uid");
		var nick = $(obj).attr("nick");
		var fileName = $(obj).attr("fileName");
		var lastLogin = $(obj).attr("lastLogin");
		var createDate = $(obj).attr("createDate");
		var role = $(obj).attr("userRole");
		
		if(fileName==""){
			$("#model_userHeadPic").attr("src","${pageContext.request.contextPath}/common/assets/images/user-1.png");
		}else{
			$("#model_userHeadPic").attr("src","${pageContext.request.contextPath}/file/showMini?downFileName="+fileName);
		}
		$("#idSpan").html(uid);
		$("#nickSpan").html(nick);
		$("#lastLoginSpan").html(lastLogin);
		$("#dateSpan").html(createDate);
		$("#roleSpan").html(role);
		
		$("#gallery-image-alert").modal('show');
	
	}
	
	function jumpOut(){
    	window.location.href = '${pageContext.request.contextPath}/backstage/userlist.action';
    }
</script>
<!-- Imported styles on this page -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/common/assets/js/datatables/dataTables.bootstrap.css">

<!-- Bottom Scripts -->
<script
	src="${pageContext.request.contextPath}/common/assets/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/TweenMax.min.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/resizeable.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/joinable.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/xenon-api.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/xenon-toggles.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/datatables/js/jquery.dataTables.min.js"></script>

<!-- Imported scripts on this page -->
<script
	src="${pageContext.request.contextPath}/common/assets/js/datatables/dataTables.bootstrap.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/datatables/yadcf/jquery.dataTables.yadcf.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/datatables/tabletools/dataTables.tableTools.min.js"></script>
<%@ include file="/WEB-INF/Pages/manager/foot_part.jsp"%>
			
			
			
			
			
			
			
		
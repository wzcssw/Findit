<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/Pages/user/head-part.jsp"%>
<div class="page-container container">
	<div class="main-content" style="">
		<input type="hidden" value="" id="hiddenPid"/>
		<div class="panel panel-color panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">修改个人信息</h3>
				<div class="panel-options">
					<a href="#" data-toggle="panel">
						<span class="collapse-icon">–</span>
						<span class="expand-icon">+</span>
					</a>
					
					
					<a href="#" data-toggle="remove">
						×
					</a>
				</div>
			</div>
			<div class="panel-body">
				<div class="row">
						<!-- 新版本 头像 -->
						<div class="col-md-3">
							<div id="uploadPreview"></div> <br/>
							<input id="uploadImage" type="file" name="upload" class="fimg1" onChange="PreviewImage();" />
							<script>
								$("#uploadImage").on("change", function(){
							    var files = !!this.files ? this.files : [];
							    if (!files.length || !window.FileReader) return;
							    if (/^image/.test( files[0].type)){
							        var reader = new FileReader();
							        reader.readAsDataURL(files[0]);
							        reader.onloadend = function(){
							      		 $("#uploadPreview").css("background-image", "url("+this.result+")");
							   		 };
							    }
									});
							</script>
							<style>
								#uploadPreview {
					                width: 180px;
					                height: 180px;                         
					                background-position: center center;
					                background-size: cover;
					                border: 4px solid #fff;
					                -webkit-box-shadow: 0 0 1px 1px rgba(0, 0, 0, .3);
					                display: inline-block;
					                <s:if test="#session.user.head==null">
					                	background-image:url(${pageContext.request.contextPath}/common/assets/images/user-4.png);
									</s:if> 
									<s:else>
										background-image:url(${pageContext.request.contextPath}/file/showMini?downFileName=<s:property value="#session.user.head.pname"/>);
									</s:else>
					                }
					        </style>
				        </div>
						<!-- 新版本 头像 end -->
						
						<script src="${pageContext.request.contextPath}/common/assets/js/ajaxfileupload.js" type="text/javascript"></script>
					    <script type="text/javascript">
					        function ajaxFileUpload() {
					            $.ajaxFileUpload
					            (
					                {
					                    url: '${pageContext.request.contextPath}/file/fileUploadAjax.action', //用于文件上传的服务器端请求地址
					                    secureuri: false, //是否需要安全协议，一般设置为false
					                    fileElementId: 'uploadImage', //文件上传域的ID
					                    dataType: 'json', //返回值类型 一般设置为json
					                    success: function (data) //服务器成功响应处理函数
					                    {	
					                    	if(data.msg == "ok"){
					                    		if(data.pid == ""){
					                    			alert("ajaxFileUpload:上传后未返回Pid值");
					                    		}else{
					                    			changeHeadPic(data.pid);
					                    		}
					                    	}else{
					                    		alert("ajaxFileUpload:上传失败");
					                    	}
					                    },
					                    error: function (resp)//服务器响应失败处理函数
					                    {
					                        alert(resp);
					                    }
					                }
					            );
					            return false;
					        }
					        function changeHeadPic(pid){
					        	$.ajax({
											url: "${pageContext.request.contextPath}/user/modifyResume",
											method: 'POST',
											dataType: 'json',
											data:{"pid":pid},
											success: function(resp)
											{
												if(resp.accessGranted=="true"){
// 													alert("changeHeadPic:成功");
												}
												
											}
										});
					        }
					    </script>
						<!-- 头像end -->
					<form action="${pageContext.request.contextPath}" method="post" role="form" id="form1" method="post" class="validate" novalidate="novalidate">
						<div class="col-md-9">
							<div class="col-md-6">
							
								<label class="control-label">昵称</label> 
								<div class="input-group input-group-sm input-group-minimal">
									<span class="input-group-addon">
										<i class="linecons-user"></i>
									</span>
									<input type="text" class="form-control" name="nick" id="nick" value="<s:property value="#session.user.nick"/>" />
								</div>
								<div class="form-group">
									<label class="control-label">性别</label>
									 <br />
									 	<s:if test="#session.user.gender==1">
										  	 <label class="radio-inline">
										  	 	<input type="radio" value="1" name="gender" class="cbr-input" checked> 男生 
										  	 </label> 
										  	 <label class="radio-inline">
											 	<input type="radio" value="0" name="gender"> 女生 
										  	 </label>
										 </s:if>
										 <s:else>
										 	<label class="radio-inline">
										  	 	<input type="radio" value="1" name="gender" class="cbr-input"> 男生 
										  	 </label> 
										  	 <label class="radio-inline">
											 	<input type="radio" value="0" name="gender" checked> 女生 
										  	 </label>
										 </s:else>
								</div>
								
							</div>
							<div class="col-md-6">
								<label class="control-label">手机</label> 
								<div class="input-group input-group-sm input-group-minimal">
									<span class="input-group-addon">
										<i class="linecons-mobile"></i>
									</span>
									<input type="text" class="form-control" name="phone" id="phone" value="<s:property value="#session.user.phone" />">
								</div>
								
								<label class="control-label">电子邮箱</label>
								<div class="input-group input-group-sm input-group-minimal">
									 <span class="input-group-addon">
										<i class="linecons-mail"></i>
									</span>
									 <input type="text" class="form-control" name="mail" id="mail" value="<s:property value="#session.user.mail" />">
								</div>
								
								<label class="control-label">地址</label> 
								<div class="input-group input-group-sm input-group-minimal">
									<span class="input-group-addon">
										<i class="linecons-truck"></i>
									</span>
									<input type="text" class="form-control" name="address" id="address" value="<s:property value="#session.user.address" />">
								</div>
							</div>
							
							<div class="col-md-12">
								<div class="form-group">
									<button type="submit" class="btn btn-success">确定</button>
									<button type="reset" class="btn btn-white">重置</button>
								</div>
							</div>
							
						</div>
					</form>
				</div>
			</div>

		</div>
		<script type="text/javascript">
			$.validator.setDefaults({
				submitHandler: function() { 
					if($("#uploadImage").val()!=""){
						ajaxFileUpload();
					}
					show_loading_bar(70);
					$.ajax({
							url: "${pageContext.request.contextPath}/user/modifyResume",
							method: 'POST',
							dataType: 'json',
							data:$("#form1").serialize(),
							success: function(resp)
							{
								show_loading_bar({
									delay: .5,
									pct: 100,
									finish: function(){
										// Redirect after successful login page (when progress bar reaches 100%)
										if(resp.accessGranted == "true")
										{
// 											var uploadPid = $("#hiddenPid").val();
											window.location.href = '${pageContext.request.contextPath}/user/profileui';
										}else{
											window.location.href = '${pageContext.request.contextPath}/user/errorPage';
										}
														}
								});
							}
						});
				 }
			});
			
			$().ready(function() {
				
					$("#form1").validate({
						rules: {
							nick:{
								required:true,
							},
							gender:{
								required:true
							},
							birthday:"dateISO",
							mail:{email:true,required:true},
							phone:{
								required:true,
								rangelength:[7,11]
							},
							address:{
								required:true
							}
						},
						messages: {
							nick:{
								required:"<span style='color:red;'>昵称不能为空</span>"
							},
							gender:{
								required:"<span style='color:red;'>请选择性别</span>"
							},
							birthday:"<span style='color:red;'>日期必须符合格式</span>",
							mail:{email:"<span style='color:red;'>请输入正确的邮箱",required:"<span style='color:red;'>请输入邮箱地址</span>"},
							phone:{
								required:"<span style='color:red;'>请输入电话号码</span>",
								range:"<span style='color:red;'>请输入正确的电话号码</span>"
							},
							address:{
								required:"<span style='color:red;'>地址不能为空</span>"
							}
						}
					});
		});
		</script>
		</script>

		<%@ include file="/WEB-INF/Pages/user/food-part.jsp"%>
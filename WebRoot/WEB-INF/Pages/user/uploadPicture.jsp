<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/Pages/user/head-part.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/common/assets/js/select2/select2.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/common/assets/js/select2/select2-bootstrap.css">
<div class="page-container container">
<!-- 载入和警告对话框-->
	<div class="modal fade" id="gallery-image-alert" data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
						<span class="logo">
							<img src="${pageContext.request.contextPath}/common/assets/images/logo-white-bg@2x.png" alt="" width="80" />
						</span>
				</div>
				<div class="modal-body" id="confirmMsg">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-white" id="closeBtn">关闭</button>
				</div>
			</div>
		</div>
	</div>
		<div class="main-content">
			<div class="row">
			<br/><br/>
				<div class="col-md-11 col-ms-11 col-xs-12">
						<div class="panel panel-color panel-blue">
							<div class="panel-heading">
								<h3 class="panel-title">上传图片</h3>
								
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
								<!-- 内容 -->
										<!-- 即显上传图片 -->
										<div class="row">
												<div class="col-md-7 col-xs-12" onclick="uploadImage.click()" style="cursor:pointer" id="upPicPos"><!-- 左侧图片 -->
														<img src="${pageContext.request.contextPath}/common/assets/images/addPic500_400.png" alt="上传的图片" id="pic" class="thumbnail img-responsive"/>
		          								</div>
		          								<div class="col-md-4 col-xs-12"><!-- 右侧form -->
													<div class="input-group" id="title-group">
														<span class="input-group-addon">
															<i class="linecons-pencil"></i>
														</span>
															<input type="text" name="title" id="title" class="form-control" placeholder="标题">
													</div>
													
													<br/>
													<div class="input-group">
														<span class="input-group-addon">
															<i class="linecons-attach"></i>
														</span>
														<input type="text" class="form-control" id="description" name="description" placeholder="描述">
													</div>
													<!-- 选择相册 -->
														<div class="form-group">
															<br/>
															<script type="text/javascript">
																jQuery(document).ready(function($)
																{
																	$("#selectAlbum").select2({
																		placeholder: '请选择存放相册',
																		allowClear: true
																	}).on('select2-open', function()
																	{
																		$(this).data('select2').results.addClass('overflow-hidden').perfectScrollbar();
																	});
																	
																});
															</script>
															<select class="form-control" id="selectAlbum">
																<option></option>
																<optgroup label="<s:property value="#session.user.nick" />" id="optg">
																</optgroup>
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
																						$("#optg").append("<option value="+obj.aid+">"+obj.aname+"</option>");
																					});
																				}
																			}
															      		  });
																	});
																</script>
															</select>
														</div>

													<!-- 选择相册 end -->
													<br/>
													<!-- 标签 checkbox -->
													<label class="control-label">标签</label>
													<div class="row">
															<div class="col-md-6 col-sm-6 col-xs-6">
																<div class="form-group">
																	<div class="form-block" id="addTarget">
																		<label>
																			<input type="checkbox" class="cbr cbr-danger" name="category" value="Sexy">
																			Sexy
																		</label>
																		<br>
																		<label>
																			<input type="checkbox" class="cbr cbr-info" name="category" value="生活">
																			生活
																		</label>
																		<br>
																		<label>
																			<input type="checkbox" class="cbr cbr-purple" name="category" value="萌宠">
																			萌宠
																		</label>
																		
																</div>
																</div>
															</div>
															
															<div class="col-md-6 col-sm-6 col-xs-6">
																<div class="form-group">
																	<div class="form-block">
																		<label>
																			<input type="checkbox" class="cbr cbr-secondary" name="category" value="风景">
																			风景
																		</label>
																		<br>
																		<label>
																			<input type="checkbox" class="cbr cbr-warning" name="category" value="girl">
																			girl
																		</label>
																		<br>
																		<label>
																			<input type="checkbox" class="cbr" name="category" value="文艺">
																			文艺
																		</label>
																</div>
																</div>
															</div>
													</div>
													<!-- 自定义标签 -->
													<div class="input-group">
														<input type="text" class="form-control no-right-border form-focus-info" id="addCatrgoryField"  placeholder="添加自定义标签">
														<span class="input-group-btn">
															<button type="button" class="btn btn-info" id="addCatrgoryBtn">添加</button>
															<!-- 添加按钮事件 -->
															<script type="text/javascript">
																$().ready(function(){
																	$("#addCatrgoryBtn").click(function(){
																		var addCatrgoryField = $("#addCatrgoryField").val();
																		if(addCatrgoryField == ""){
																			$("#confirmMsg").html("请输入自定义标签");
																			$("#gallery-image-alert").modal('show');
																		}else{
																			$.ajax({
																					url: "${pageContext.request.contextPath}/picture/addCategory",
																					method: 'POST',
																					dataType: 'json',
																					data:{"description":addCatrgoryField},
																					success: function(resp)
																					{
																						if(resp.msg=="ok"){
																							 	$("#addTarget").append("<br/>");
																								$("#addTarget").append("<label><div class='cbr-replaced cbr-primary cbr-checked' onclick='mycheckbox(this)'><div class='cbr-input'><input type='checkbox' class='cbr cbr-done' name='category' value='"+addCatrgoryField+"' checked='checked'></div><div class='cbr-state'><span></span></div></div>"+addCatrgoryField+"</label>");
	
																						}else{
																							alert(resp.msg);
																						}
																					},
																					beforeSend:function(){
																						$("#loadPic").css("display","inline");
																						$("#addCatrgoryBtn").attr("disabled",true);
																					},
																					complete:function(){
																						$("#loadPic").css("display","none");
																						$("#addCatrgoryField").val("");
																						$("#addCatrgoryBtn").attr("disabled",false);
																					}
																	      		  });
																			 }
																		});
																	});
																	function mycheckbox(obj){
																		$(obj).parent().remove();
																	}
															</script>
														</span>
													</div>
													<i id="loadPic" style="display:none;"><span class="fa fa-spin fa-spinner"></span>正在处理..</i>
													<br/><br/>
													<!-- 标签 checkbox end -->
													
													<!-- 分享 -->
													<div class="form-group">
														<label class="control-label" id="sharedLabel">分享图片</label>
														<div class="form-block">
																<input type="checkbox" name="shared" id="shared" checked="checked" class="iswitch iswitch-primary" onchange="sharedBtn(this)" flag="1">
														</div>
													</div>
													<script type="text/javascript">
														function sharedBtn(obj){
															if($(obj).attr("flag")=="1"){
																$("#sharedLabel").html("不分享");
																$(obj).attr("flag","0");
															}else{
																$("#sharedLabel").html("分享图片");
																$(obj).attr("flag","1");
															}
														}
													</script>
													<!-- 分享 end -->
													
													<hr/>
													<button class="btn btn-warning btn-icon" id="uploadBtn">
														<i class="fa-rocket"></i>
														<span>上传</span>
													</button>
													<!-- 上传按钮事件 -->
													<script src="${pageContext.request.contextPath}/common/assets/js/ajaxfileupload.js" type="text/javascript"></script>
													<script type="text/javascript">
														$().ready(function(){
															$("#uploadBtn").click(function(){
															if($("#title").val()==''){
																$("#title")[0].focus();
																$("#title").attr("placeholder","请输入图片标题");
																$("#title-group").attr("class","input-group has-error");
															}else{
																$("#title-group").attr("class","input-group");
																if($("#uploadImage").val()==''){
																	$("#confirmMsg").html("您还未添加图片");
																	$("#gallery-image-alert").modal('show');
																}else{
																	$("#confirmMsg").append("<img alt='loadingCat' src='${pageContext.request.contextPath}/common/assets/images/loadingCat.gif' id='loadingCatPic'/>");
																	$("#gallery-image-alert").modal('show');
																	uplaodPic();
																}
															}
															});
														});
														function uplaodPic() {
															var title = $("#title").val();
															var description = $("#description").val();
															var selectAlbum = $("#selectAlbum").val();
															var shared = $("#shared").attr("flag");
															var categories = $("input[name='category']:checked");
															
															var str = "?title="+title+"&selectAlbum="+selectAlbum+"&description="+description+"&shared="+shared	;	//  请求字符串
															$(categories).each(function(index, element) {
																str = str + "&category="+$(element).val();
           													 });
           													 
												            $.ajaxFileUpload
												            (
												                {
												                    url: '${pageContext.request.contextPath}/file/fileUploadAjax.action'+str, //用于文件上传的服务器端请求地址
												                    secureuri: false, //是否需要安全协议，一般设置为false
												                    fileElementId: 'uploadImage', //文件上传域的ID
												                    dataType: 'json', //返回值类型 一般设置为json
												                    success: function (data) //服务器成功响应处理函数
												                    {
												                    	if(data.msg=='ok'){
																			$("#loadingCatPic").remove();
																			$("#confirmMsg").append("<img alt='loadSuccess' src='${pageContext.request.contextPath}/common/assets/images/loadSuccess.gif'id='loadSuccessPic'/>");
																			
																			window.setInterval(jumpOut,1100);    //定时清除所有记录
												                    	}
												                    },
												                    error: function (resp)//服务器响应失败处理函数
												                    {
												                        alert(resp);
												                    }
												                }
												            );
												        }
												        function jumpOut(){//定时清除所有记录
												        	window.location.href = '${pageContext.request.contextPath}/picture/uploadPictureui';
												        }
													</script>
													
													<!-- 关闭btn 事件 -->
													<script type="text/javascript">
													$("#closeBtn").click(function(){
														$("#confirmMsg").empty();
														$("#gallery-image-alert").modal('hide');
													});
													</script>
													<!-- 关闭btn 事件 end -->
													<button class="btn btn-white btn-icon" onclick="javascript:history.go(-1)">
														<i class="fa-angle-left"></i>
														<span>取消</span>
													</button>
												</div>
										</div>
										<!-- 验证表单输入 -->
										<script type="text/javascript">
											$().ready(function(){
												$("#title").blur(function(){
													if($("#title").val()==''){
														$("#title")[0].focus();
														$("#title").attr("placeholder","请输入图片标题");
														$("#title-group").attr("class","input-group has-error");
													}else{
														$("#title-group").attr("class","input-group");
													}
												});
												$("#title").blur(function(){
													if($("#title").val()==''){
														$("#title")[0].focus();
														$("#title").attr("placeholder","请输入图片标题");
														$("#title-group").attr("class","input-group has-error");
													}else{
														$("#title-group").attr("class","input-group");
													}
												});
											});
										</script>
										
										<!-- 验证表单输入 end -->
										<br/>
										<input id="uploadImage" type="file" name="upload" class="fimg1" onChange="PreviewImage();" style="display:none;" />
										<script>
											//即时显示图片
											$("#uploadImage").on("change", function(){
												    var files = !!this.files ? this.files : [];
												    if (!files.length || !window.FileReader) return;
												    if (/^image/.test( files[0].type)){
												        var reader = new FileReader();
												        reader.readAsDataURL(files[0]);
												        reader.onloadend = function(){
												       		$("#pic").attr("src",this.result);
												         
												        };
												    }
												});
										</script>
										<!-- 即显上传文件图片 -->
								<!-- 内容 end -->
							</div>
						</div>
						
					</div>
			</div>
<script src="${pageContext.request.contextPath}/common/assets/js/select2/select2.min.js"></script>
<%@ include file="/WEB-INF/Pages/user/food-part.jsp"%>
 
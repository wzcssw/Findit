<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/Pages/user/head-part.jsp"%>
	<div class="page-container">
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
					<button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 创建新相册 -->
	<div class="modal fade" id="create-new-album-dialog" data-backdrop="static">
		<div class="modal-dialog">
                <div class="modal-content col-md-8">
					<div class="login-header">
						<h3>
						<img src="${pageContext.request.contextPath}/common/assets/images/1169223.png" />
						创建新的相册</h3>
					</div>
					<br/>
					<div class="form-group">
						<label class="control-label" for="aname">相册名</label>
						<input type="text" class="form-control" name="aname" id="aname" autocomplete="off" />
					</div>
					
					<div class="form-group">
						<label class="control-label" for="description">简介</label>
						<input type="text" class="form-control" name="description" id="description" autocomplete="off" />
					</div>
					<div class="errors-container" id="error" style="display:none;">
						<div class="alert alert-warning">
							<button type="button" class="close" data-dismiss="alert">
								<span aria-hidden="true">×</span>
								<span class="sr-only">关闭</span>
							</button>
							<strong>注意！</strong> 相册名称不能为空
						</div>
					</div>
					<br/>
						<div id="loadingPic" style="display:none;">
							<span class="fa fa-spin fa-spinner" id="spinIcon"></span>
							<small id="smallword">操作中...</small>
						</div>
					<br/>
					<div class="form-group text-center">
						<button type="button" class="btn btn-success" id="okBtn">
							<i class="fa-angellist">确定</i>
						</button>
						<button type="button" class="btn btn-gray" data-dismiss="modal">
							<i class="fa-arrow-left">取消</i>
						</button>
					</div>
					
                </div>
              </div>
	</div>
	<!-- 显示图片对话框 -->
	<div class="modal fade" id="gallery-image-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-gallery-image" >
					<img  src="" class="img-responsive" id="model_picture" sharing="" style="display:none;"/>
					<img  src="${pageContext.request.contextPath}/common/assets/images/album-image-full.jpg" class="img-responsive" id="loadImg"/>
		
				</div>
				<div class="modal-body">
					<div class="row">
						<span class="col-xs-4 col-md-4" id="pnameLabal" >未知</span>
						<span class="col-xs-4 col-md-4" id="pidLabal" style="display:none;">未知</span>
						<span class="col-xs-4 col-md-4" id="createDateLabal">未知</span>
						<div class="col-xs-3 col-md-3" style="margin-right:-9%">
							<span class="badge badge-danger" id="modifySharedLabel">分享图片</span>
						</div>
						<div class="form-group" class="col-xs-2 col-md-2">
							<div class="form-block">
								<input type="checkbox" id="modifyShared" checked="checked" class="iswitch-lg iswitch-primary" onchange="modifysharedBtn(this)"  flag="1">
							</div>
						</div>
						<hr/>
					</div>
					<!-- b -->
					<div class="row">
						<div class="col-xs-11 col-md-11"  style="margin-left:4%">
							<div class="input-group" id="title-group2">
								<span class="input-group-addon">
									<i class="linecons-pencil"></i>
								</span>
									<input type="text" id="modifyTitle" class="form-control" placeholder="标题">
							</div>
						</div>
						<script type="text/javascript">
							function modifysharedBtn(obj){
								if($(obj).attr("flag")=="1"){
									$("#modifySharedLabel").html("不分享");
									$("#modifySharedLabel").attr("class","badge badge-primary");
									$(obj).attr("flag","0");
								}else{
									$("#modifySharedLabel").html("分享图片");
									$("#modifySharedLabel").attr("class","badge badge-danger");
									$(obj).attr("flag","1");
								}
							}
						</script>
					</div>
					<br/>
					<div class="row">
						<div class="col-xs-11 col-md-11" style="margin-left:4%">
							<div class="input-group">
								<span class="input-group-addon">
									<i class="linecons-attach"></i>
								</span>
								<textarea class="form-control" cols="5" id="modifyDescription" style="margin-top: 0px; margin-bottom: 0px; height: 50px;" placeholder="描述"></textarea>
							</div>
						</div>
					</div>
					<!-- e -->
				</div>
				
				<div class="modal-footer modal-gallery-top-controls">
					<button type="button" class="btn btn-xs btn-white" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-xs btn-info" id="setSeal" flag="1">设为相册封面<span class="fa fa-spin fa-spinner" id="spinIconSetSeal" style="display:none;"></span></button>
					<button type="button" class="btn btn-xs btn-secondary" id="saveBtn">保存<span class="fa fa-spin fa-spinner" id="spinIcon" style="display:none;"></span></button>
				</div>
			</div>
		</div>
	</div>
	<!-- 显示图片对话框 end -->
	
	
	
	<!-- Gallery Delete Image (Confirm)-->
	<div class="modal fade" id="gallery-image-delete-modal" data-backdrop="static">
		<div class="modal-dialog" style="margin-top:12%; margin-left:30%">
			<div class="modal-content  col-md-7 col-sm-7 col-xs-12" >
				
				<div class="modal-header">
					<h4 class="modal-title">确认对话框</h4>
				</div>
				<div class="modal-body">
					确定删除?
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-danger" id="deleteBtn">删除</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 无法删除对话框 (Confirm)-->
	<div class="modal fade" id="cannot-delete-dialog" data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				
				<div class="modal-header">
					<h4 class="modal-title">错误</h4>
				</div>
				<div class="modal-body">
					<span id="msg"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 上传新图片对话框 -->
	<div class="modal fade" id="addNewPic-dialog" data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				
				<div class="modal-header">
					
					<h5 class="modal-title"><s:property value="album.aname" /></h5>
				</div>
				<div class="modal-body">
					<!-- 上传文件input -->
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
					<div class="row">
						<div class="col-xs-6 col-md-7" onclick="uploadImage.click()" style="cursor:pointer" id="upPicPos"><!-- 左侧图片 -->
							<img src="${pageContext.request.contextPath}/common/assets/images/addPic500_400.png" alt="上传的图片" id="pic" class="thumbnail img-responsive"/>
          				</div>
          				<div class="col-xs-5 col-md-4"><!-- 右侧form -->
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
														<input type="text" class="form-control no-right-border form-focus-info" id="addCatrgoryField"  placeholder="添加标签">
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
																							alert("处理失败请重试");
																						}
																					},
																					beforeSend:function(){
																						$("#loadingPic").css("display","inline");
																						$("#addCatrgoryBtn").attr("disabled",true);
																					},
																					complete:function(){
																						$("#loadingPic").css("display","none");
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
													<i id="loadingPic" style="display:none;"><span class="fa fa-spin fa-spinner"></span>正在处理..</i>
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
													<!-- 两个Button -->
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
																	alert("您还未添加图片");
																}else{
																	$("#addNewPic-dialog").modal('hide');
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
															var selectAlbum = '<s:property value="album.aid" />';
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
												        	window.location.href = '${pageContext.request.contextPath}/picture/userPicture?aid=<s:property value="album.aid" />';
												        }
													</script>
													<button class="btn btn-white btn-icon" data-dismiss="modal">
														<i class="fa-angle-left"></i>
														<span>取消</span>
													</button>
													<!-- 两个Button end -->
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
															$("#modifyTitle").blur(function(){
																if($("#modifyTitle").val()==''){
																	$("#modifyTitle")[0].focus();
																	$("#modifyTitle").attr("placeholder","请输入图片标题");
																	$("#title-group2").attr("class","input-group has-error");
																}else{
																	$("#title-group2").attr("class","input-group");
																}
															});
														});
													</script>
													
													<!-- 验证表单输入 end -->
          				</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
		<div class="main-content">
			<section class="gallery-env">
				<div class="row">
				
					<!-- Gallery Album Optipns and Images -->
					<div class="col-sm-9 gallery-right">
						
						<!-- Album Header -->
						<div class="album-header">
							<h2>
								<s:property value="album.aname" />
							</h2>
							
							<ul class="album-options list-unstyled list-inline">
								<li>
									<input type="checkbox" class="cbr" id="select-all" />
									<label for="select-all">全选</label>
								</li>
								<li>
									<a href="#" data-action="addNewPic">
										<i class="fa-upload"></i>
										添加图片
									</a>
								</li>
								
								<li>
									<a href="#" data-action="trash">
										<i class="fa-trash"></i>
										删除
									</a>
								</li>
							</ul>
						</div>
						
						<!-- Album Images -->
							<!-- ----------- -->
							<div class="album-images row" ccc="hello">
							<s:iterator value="page.data" var="p" status="vs">
									<div class="col-md-3 col-sm-4 col-xs-6" >
										<div class="album-image">
										
											<a href="#" class="thumb" data-action="edit">
												<div  picId="<s:property value="#p.pid" />" desc="<s:property value="#p.description" />" titles="<s:property value="#p.titles" />" picName="<s:property value="#p.pname" />" createDate="<s:date name="#p.createDate" format="yyyy年MM月dd日"/>" sharing="<s:property value="#p.sharing" />" style="height:150px;background:#000000 url(${pageContext.request.contextPath}/file/showMini?downFileName=<s:property value="#p.pname" />)no-repeat center center"></div>
											</a>
											
											<a href="#" class="name">
												<span>
													<s:property value="#p.titles" />
												</span>
												<br/>
												<em>
													上传于：<s:date name="#p.createDate" format="yyyy年MM月dd日"/>
												</em>
											</a>
											<div class="image-options">
												<a href="#" data-action="trash" picId="<s:property value="#p.pid"/>"><i class="fa-trash"></i> 删除</a>
											</div>
											
											<div class="image-checkbox">
												<input type="checkbox" class="cbr"/>
											</div>
											
										</div>
								   </div>
							 </s:iterator>
							 
							 <!-- 用来得到选定图片的属性 -->
							 <span id="hiddenValue" style="display:none;" picId="" desc="" titles="" sharing="" aid="<s:property value="album.aid" />"></span>
							 
							<!------------- -->
							</div>
						<!-- 分页 -->
						<div class="row col-sm-9 ">
							<div style="text-align:center;">
								<%@ include file="/WEB-INF/Pages/user/page_ognl.jsp" %>
							</div>
						</div>
						<!-- 分页 end -->
						
					</div>
					
					<!-- Gallery Sidebar -->
					<div class="col-sm-3 gallery-left">
						
						<div class="gallery-sidebar">			
							
							<a data-toggle="modal" data-target="#create-new-album-dialog" class="btn btn-block btn-secondary btn-icon btn-icon-standalone btn-icon-standalone-right">
								<i class="linecons-photo"></i>
								<span>创建新相册</span>
							</a>
							
							<ul class="list-unstyled visible-lg-block visible-md-block">
							<!--相册列表 -->
							<s:if test="#session.user !=null">
									<s:iterator value="headAlbum.data" var="pp" status="vs">
											<s:if test="#pp.aname==album.aname">
												<li class="active">
													<a href="${pageContext.request.contextPath}/picture/userPicture?aid=<s:property value="#pp.aid" />">
														<i class="fa-folder-open-o"></i>
														<span>
															<s:property value="#pp.aname" />
														</span>
													</a>
												</li>
											</s:if>
											<s:if test="#pp.aname!=album.aname">
												<li>
													<a href="${pageContext.request.contextPath}/picture/userPicture?aid=<s:property value="#pp.aid" />">
														<i class="fa-folder-o"></i>
														<span>
															<s:property value="#pp.aname" />
														</span>
													</a>
												</li>
											</s:if>
								     </s:iterator>
						   </s:if>
							<!-- -- -->
							</ul>
							
						</div>
						
					</div>
				
				</div>
				
			</section>
			
			<script type="text/javascript">
			// Sample Javascript code for this page
			jQuery(document).ready(function($)
			{
				// Sample Select all images
				$("#select-all").on('change', function(ev)
				{	
					var is_checked = $(this).is(':checked');
					
					$(".album-image input[type='checkbox']").prop('checked', is_checked).trigger('change');
				});
				
				$("#model_picture").load(function(e) {
                   $("#loadImg").hide();
                   $("#model_picture").show();
                });
                
				// 打开图片
				$('.gallery-env a[data-action="edit"]').on('click', function(ev)
				{	
					ev.preventDefault();
					var selectedImgName = $(this).children("div:first-child").attr("picName");
					var selectedImgId = $(this).children("div:first-child").attr("picId");
					var isSharing = $(this).children("div:first-child").attr("sharing");
					var titles = $(this).children("div:first-child").attr("titles");
					var description = $(this).children("div:first-child").attr("desc");
					var createDate = $(this).children("div:first-child").attr("createDate");
					var srcUrl = "${pageContext.request.contextPath}/file/show?downFileName=";
					
					$("#hiddenValue").attr("picId",selectedImgId);//将所选图片的属性放入隐藏span中
					$("#hiddenValue").attr("titles",titles);
					$("#hiddenValue").attr("sharing",isSharing);
					$("#hiddenValue").attr("desc",description);
					
					$("#model_picture").attr("src",srcUrl+selectedImgName);
					
					$("#pnameLabal").html(selectedImgName);
					$("#createDateLabal").html(createDate);
					$("#modifyTitle").val(titles);
					$("#modifyDescription").val(description);
					
					if(isSharing=="false"){
						$("#modifySharedLabel").html("不分享");
						$("#modifyShared").attr("flag","0");
						$("#modifyShared").prop("checked",false);
						
					}else{
						$("#modifySharedLabel").html("分享图片");
						$("#modifyShared").attr("flag","1");
						$("#modifyShared").prop("checked",true);
					}
					
					var albumSeal = '<s:property value="album.head.pid" />';
					if(albumSeal == selectedImgId){
						$("#setSeal").html("取消设为封面");
						$("#setSeal").attr("flag","0");
					}else{
						$("#setSeal").html("设为相册封面");
						$("#setSeal").attr("flag","1");
					}
					$("#gallery-image-modal").modal('show');
				});
				
				// Delete Modal
				$('.gallery-env a[data-action="trash"]').on('click', function(ev)
				{
					ev.preventDefault();
					var selectedImgId = $(this).attr("picId");
					var $thisElement = $(this);
					var result = $("#gallery-image-delete-modal").modal('show');
					$("#deleteBtn").click(function(){
						$.ajax({
									url: "${pageContext.request.contextPath}/picture/deletePicture",
									method: 'POST',
									dataType: 'json',
									data:{"pid":selectedImgId},
									success: function(resp)
									{
										if(resp.msg=="ok"){
											$thisElement.parent().parent().parent().empty(this);
											$("#gallery-image-delete-modal").modal('hide');
										}else{
											$("#gallery-image-delete-modal").modal('hide');
											$("#msg").html(resp.msg);
											$("#cannot-delete-dialog").modal('show');
										}
									}
					           });
					});
				});
				
				// 添加新图片
				$('.gallery-env a[data-action="addNewPic"]').on('click', function(ev)
				{
					ev.preventDefault();
					var result = $("#addNewPic-dialog").modal('show');
				});
				
				// 设为相册封面 (修改：在Btn名为取消时，发送另一个ajax)
				$("#setSeal").click(function(){
					var pid = $("#hiddenValue").attr("picId");
					var aid = '<s:property value="album.aid" />';
					if($("#setSeal").attr("flag")=="1"){
						$.ajax({
								url: "${pageContext.request.contextPath}/picture/setSeal",
								method: 'POST',
								dataType: 'json',
								data:{
										"msg":"set",
										"pid":pid,
										"aid":aid
									  },
								success: function(resp)
								{
									if(resp.msg=="ok"){
										$("#gallery-image-modal").modal('hide');
										$("#confirmMsg").html("设置成功！");
										$("#gallery-image-alert").modal('show');
										window.setInterval(jumpOut,1000);
									}else{
										alert(resp.msg);
									}
								},
								beforeSend:function(){
									$("#spinIconSetSeal").css("display","inline");
									$("#setSeal").attr("disabled",true);
								},
								complete:function(){
									$("#spinIcon").css("display","none");
								}
				      		  });
					}else{
						$.ajax({
								url: "${pageContext.request.contextPath}/picture/setSeal",
								method: 'POST',
								dataType: 'json',
								data:{
										"msg":"cancel",
										"pid":pid,
										"aid":aid
									  },
								success: function(resp)
								{
									if(resp.msg=="ok"){
										$("#gallery-image-modal").modal('hide');
										$("#confirmMsg").html("设置成功！");
										$("#gallery-image-alert").modal('show');
										window.setInterval(jumpOut,1000);
									}else{
										alert(resp.msg);
									}
								},
								beforeSend:function(){
									$("#spinIconSetSeal").css("display","inline");
									$("#setSeal").attr("disabled",true);
								},
								complete:function(){
									$("#spinIcon").css("display","none");
								}
				      		  });
					}
					
				});
				
				
				// 保存图片按钮
				$("#saveBtn").click(function(){
					//验证是否为空字符串
					if($("#modifyTitle").val()==''){
						$("#modifyTitle")[0].focus();
						$("#modifyTitle").attr("placeholder","请输入图片标题");
						$("#title-group2").attr("class","input-group has-error");
					}else{
						$("#title-group2").attr("class","input-group");
						////////////////
						var picId = $("#hiddenValue").attr("picId");
						var titles = $("#modifyTitle").val();
						var sharing = $("#modifyShared").prop("checked");
						var desc = $("#modifyDescription").val();
						
						$.ajax({
								url: "${pageContext.request.contextPath}/picture/updatePictureInfo",
								method: 'POST',
								dataType: 'json',
								data:{
										"pid":picId,
										"titles":titles,
										"sharing":sharing,
										"description":desc
									  },
								success: function(resp)
								{
									if(resp.msg=="ok"){
										$("#gallery-image-modal").modal('hide');
										window.location.href = '${pageContext.request.contextPath}/picture/userPicture?aid=<s:property value="album.aid" />';
									}else{
										alert(resp.msg);
									}
								},
								beforeSend:function(){
									$("#spinIcon").css("display","inline");
									$("#saveBtn").attr("disabled",true);
								},
								complete:function(){
									$("#spinIcon").css("display","none");
								}
				      		  });
					}
				});
				
				//创建新相册
				
				$("#okBtn").click(function(){
					var aname = $("#aname").val();
					var description = $("#description").val();
					if(aname != ""){
						$.ajax({
									url: "${pageContext.request.contextPath}/picture/createAlbum",
									method: 'POST',
									dataType: 'json',
									data:{"aname":aname,"description":description},
									success: function(resp)
									{
										if(resp.msg=="ok"){
											$("#spinIcon").css("display","none");
											$("#smallword").html("创建成功!");
											setInterval(function(){
												$("#create-new-album-dialog").modal('hide');
											},"1300");
											window.location.href = '${pageContext.request.contextPath}/picture/album';
										}else{
											$("#smallword").html("创建失败:"+msg);
										}
									},
									beforeSend:function(){
										$("#loadingPic").css("display","inline");
									}
					        });
					}else{
						$("#error").fadeIn("slow");
						setInterval(function(){
							$("#error").fadeOut("slow");
						},"2000");
					}
				});
			});
			</script>
	<script src="${pageContext.request.contextPath}/common/assets/js/jquery-ui/jquery-ui.min.js"></script>
<%@ include file="/WEB-INF/Pages/user/food-part.jsp"%>
 
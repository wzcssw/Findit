<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/Pages/user/head-part.jsp"%>
<div class="page-container container"><!-- add class "sidebar-collapsed" to close sidebar by default, "chat-visible" to make chat appear always -->
<!-- 创建新相册 -->
	<script>
		$().ready(function(){
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
										$("#loadPic").css("display","inline");
									}
					        });
					}else{
						$("#error").fadeIn("slow");
						setInterval(function(){
							$("#error").fadeOut("slow");
						},"2000");
					}
				});
				
				//重命名相册
				$("#okBtn-rename").click(function(){
					var aname = $("#renameInputId").val();
					if(aname != ""){
						$.ajax({
									url: "${pageContext.request.contextPath}/picture/renameAlbum",
									method: 'POST',
									dataType: 'json',
									data:{
											"aname":aname,
											"aid":$("#hiddenValue").val()
										},
									success: function(resp)
									{
										if(resp.msg=="ok"){
											$("#spinIcon-rename").css("display","none");
											$("#smallword-rename").html("修改成功!");
											setInterval(function(){
												$("#rename-album-dialog").modal('hide');
											},"1300");
											window.location.href = '${pageContext.request.contextPath}/picture/album';
										}else{
											$("#smallword-rename").html("修改失败:"+msg);
										}
									},
									beforeSend:function(){
										$("#loadPic-rename").css("display","inline");
									}
					        });
					}else{
						$("#error-rename").fadeIn("slow");
						setInterval(function(){
							$("#error-rename").fadeOut("slow");
						},"2000");
					}
				});
		});
	</script>
	
	
	<!-- 重命名相册 -->
	<div class="modal fade" id="rename-album-dialog" data-backdrop="static">
		<div class="modal-dialog">
                <div class="modal-content col-md-8 col-sm-8 col-xs-12">
					<div class="login-header">
						<h3>
						<img src="${pageContext.request.contextPath}/common/assets/images/1169223.png" />
						重命名相册</h3>
					</div>
					<br/>
					<div class="form-group">
						<label class="control-label" for="aname">相册名</label>
						<input id="renameInputId" type="text" class="form-control" name="aname" autocomplete="off" placeholder=""/>
					</div>
					
					<div class="errors-container" id="error-rename" style="display:none;">
						<div class="alert alert-warning">
							<button type="button" class="close" data-dismiss="alert">
								<span aria-hidden="true">×</span>
								<span class="sr-only">关闭</span>
							</button>
							<strong>注意！</strong> 相册名称不能为空
						</div>
					</div>
					<br/>
						<div id="loadPic-rename" style="display:none;">
							<span class="fa fa-spin fa-spinner" id="spinIcon-rename"></span>
							<small id="smallword-rename">操作中...</small>
						</div>
					<br/>
					<div class="form-group text-center">
						<button type="button" class="btn btn-success" id="okBtn-rename">
							<i class="fa-angellist">确定</i>
						</button>
						<button type="button" class="btn btn-gray" data-dismiss="modal">
							<i class="fa-arrow-left">取消</i>
						</button>
					</div>
					
                </div>
              </div>
	</div>
	<!-- 重命名相册 end -->
	<!-- 创建新相册 -->
	<div class="modal fade" id="create-new-album-dialog" data-backdrop="static" style="margin-left:12%; margin-top:10%">
		<div class="modal-dialog">
                <div class="modal-content col-md-8 col-sm-8 col-xs-12">
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
						<div id="loadPic" style="display:none;">
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
	
	<!-- 提示框 -->
	<div class="modal fade" id="gallery-image-delete-modal" data-backdrop="static">
		<div class="modal-dialog" style="margin-top:12%; margin-left:30%">
			<div class="modal-content  col-md-7 col-sm-7 col-xs-12">
				
				<div class="modal-header">
					<h4 class="modal-title">确认对话框</h4>
				</div>
				<div class="modal-body" id="msgP">
					确定删除此相册?
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-danger" id="deleteBtn">删除</button>
					<div id="loadingPic" style="display:none; float:left;">
							<span class="fa fa-spin fa-spinner" id="spinIcon"></span>
							<small id="smallword">操作中...</small>
						</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 提示框 end -->
	<input type="hidden" value="" id="hiddenValue">
		<div class="main-content">
			<!-- 左侧 -->
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
												<li>
													<a href="${pageContext.request.contextPath}/picture/userPicture?aid=<s:property value="#pp.aid" />">
														<i class="fa-folder-o"></i>
														<span>
															<s:property value="#pp.aname" />
														</span>
													</a>
												</li>
								     </s:iterator>
						   </s:if>
							<!-- -- -->
							</ul>
							
						</div>
						
					</div>
					<!-- 左侧 -->
			<section class="gallery-env">
				<div class="col-sm-9 gallery">
        			<div class="album-images row">
     <s:iterator value="headAlbum.data" var="p" status="vs">
        	
        			<div class="col-md-3 col-sm-4 col-xs-12">
						<div class="thumbnail">
						
							<a href="${pageContext.request.contextPath}/picture/userPicture?aid=<s:property value="#p.aid" />" class="thumb" data-action="edit">
									<s:if test="#p.head==null">
										<s:if test="#p.aname=='默认相册'">
											<s:if test="#session.user.head==null">
												<div style="height:150px;background:#000000 url(${pageContext.request.contextPath}/common/assets/images/album-null.png)no-repeat center center"></div>
											</s:if>
											<s:else>
												<div style="height:150px;background:#000000 url(${pageContext.request.contextPath}/file/showMini?downFileName=<s:property value="#session.user.head.pname"/>)no-repeat center center"></div>
											</s:else>
										</s:if>
										<s:else>
											<div style="height:150px;background:#000000 url(${pageContext.request.contextPath}/common/assets/images/album-null.png)no-repeat center center"></div>
										</s:else>
									</s:if>
									<s:else>
											<div style="height:150px; background:#000000 url(${pageContext.request.contextPath}/file/showMini?downFileName=<s:property value="#p.head.pname" />)no-repeat center center"></div>
									</s:else>
							</a>
							<a href="#" class="name">
								<span>
									<s:property value="#p.aname" />
								</span>
								<br/>
								<em>
									<s:date name="#p.createDate" format="yyyy年MM月dd日"/>&nbsp;&nbsp;&nbsp;
								</em>
								<br/><s:property value="#p.pictures.size" /> 张图片
							</a>
							<s:if test="#p.aname!='默认相册'">
								<div class="image-options">
									<a href="#" onclick="renameAlbum(this)" aid="<s:property value="#p.aid" />" aname="<s:property value="#p.aname" />"  ><i class="fa-pencil">重命名</i></a>&nbsp;
									<a onclick="deleteAlbum(this)" href="#" data-action="trash" aid="<s:property value="#p.aid" />" ><i class="fa-trash">删除</i></a>
								</div>
							</s:if>
							<s:else>
								<div class="image-options">
									@Findit
								</div>
							</s:else>
						</div>
					</div>
	 </s:iterator>
	 							<!-- 删除相册 -->
								<script type="text/javascript">
									function deleteAlbum(obj){
										$("#hiddenValue").val($(obj).attr("aid"));
										$("#gallery-image-delete-modal").modal('show');
									}
									function renameAlbum(obj){
										$("#hiddenValue").val($(obj).attr("aid"));
										$("#renameInputId").val($(obj).attr("aname"));
										$("#rename-album-dialog").modal('show');
									}
									function jumpOut(){
							        	window.location.href = '${pageContext.request.contextPath}/picture/album';
							        }
									$().ready(function(){
										$("#deleteBtn").click(function(){
											$.ajax({
													url: "${pageContext.request.contextPath}/picture/deleteAlbum",
													method: 'POST',
													dataType: 'json',
													data:{"aid":$("#hiddenValue").val()},
													success: function(resp)
													{
														if(resp.msg=="ok"){
															$("#deleteBtn").hide();
															$("#loadingPic").hide();
															$("#msgP").html("删除成功！");
															window.setInterval(jumpOut,1100);
														}else{
															alert("failed");
														}
													},
													beforeSend:function(){
														$("#loadingPic").show();
														}
											        });
										});
									});
								</script>
								<!-- 删除相册 end -->
	 		</div>
	 	</div>
	 </section>
<%@ include file="/WEB-INF/Pages/user/food-part.jsp"%>
 
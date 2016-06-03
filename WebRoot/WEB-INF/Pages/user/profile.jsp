<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/Pages/user/head-part.jsp"%>
<div class="page-container ">
	<div class="main-content">
		<section class="profile-env">
			<div class="row">
				<!-- 侧边 -->
				<div class="col-sm-3 col-xs-12">
					<!-- User Info Sidebar -->
					<div class="user-info-sidebar">

						<a href="#" class="user-img">
							<s:if test="user.head==null">
									<img src="${pageContext.request.contextPath}/common/assets/images/user-4.png" alt="user-img" class="img-cirlce img-responsive img-thumbnail">
							</s:if> 
							<s:else>
									<img src="${pageContext.request.contextPath}/file/showMini?downFileName=<s:property value="user.head.pname"/>" alt="user-img" class="img-cirlce img-responsive img-thumbnail userpic-115		" width="115">
							</s:else>
						</a> 
						<a href="#" class="user-name">
								<s:property value="user.nick"/>
								<span class="user-status is-online"></span>
							 </a>
						<s:if test="#session.user.uid==user.uid">
							<a href="${pageContext.request.contextPath}/user/modifyResumeui">
								 <span class="user-title">
								 	修改资料
								 </span>
							</a>
						</s:if>
							
						<hr>

						<ul class="list-unstyled user-info-list">
							<s:if test="user.gender==1">
								<li>
									<i class="el-male"></i>
									 <a href="#">男生</a></li>
								<li>
							</s:if>
							<s:else>
								<li>
									<i class="el-female"></i>
									 <a href="#">女生</a></li>
								<li>
							</s:else>
							<li>
								<i class="fa-home"></i>
								<s:property value="user.address" />
							</li>
								<i class="fa fa-envelope"></i> 
								<s:property value="user.mail"/>
							</li>
						</ul>

						<hr>

						<ul class="list-unstyled user-friends-count">
							<li><span>643</span> 关注</li>
							<li><span>108</span> 被关注</li>
						</ul>

						<button type="button" class="btn btn-success btn-block text-left">
							加关注 <i class="fa-check pull-right"></i>
						</button>
					</div>
				</div>
				<!-- 右边 -->
				<div class="col-sm-9 col-xs-12">
						<div>
								
								<!-- Colored panel, remember to add "panel-color" before applying the color -->
								<div class="panel panel-color panel-success"><!-- Add class "collapsed" to minimize the panel -->
									<div class="panel-heading">
										<h3 class="panel-title">
											<s:if test="#session.user.uid==user.uid">
												我的图片
											</s:if>
											<s:else>
												<s:property value="user.username"/>
											&nbsp;分享的图片
											</s:else>
											
										</h3>
										<div class="panel-options">
											<a href="#">
												<i class="linecons-cog"></i>
											</a>
											<a href="#" data-toggle="panel">
												<span class="collapse-icon">–</span>
												<span class="expand-icon">+</span>
											</a>
											<a href="#" data-toggle="reload">
												<i class="fa-rotate-right"></i>
											</a>
											<a href="#" data-toggle="remove">
												×
											</a>
										</div>
									</div>
									<div class="panel-body" id="picturePanel">
										<span id="spinIcon" style="display:none;margin-left:45%">
											<span class="fa fa-spin fa-spinner" ></span>
											载入中..
										</span>
										 <!-- 这里11 -->
									</div>
									<div class="row" id="alertDiv">
										<div class="col-md-12" style="display:none;" id="FirstOneAlert">
											<div class="alert alert-warning">
												<button type="button" class="close" data-dismiss="alert">
													<span aria-hidden="true">×</span>
													<span class="sr-only">Close</span>
												</button>
												<strong>已经是第一页</strong>
											</div>
										</div>
										<div class="col-md-12" style="display:none;" id="lastOneAlert">
											<div class="alert alert-warning">
												<button type="button" class="close" data-dismiss="alert">
													<span aria-hidden="true">×</span>
													<span class="sr-only">Close</span>
												</button>
												<strong>已经是最后一页</strong>
											</div>
										</div>
									</div>
									<ul class="pager">
										<li>
											<span id="lastbtn" style="cursor:pointer">
												<i class="fa-angle-double-left " ></i> 
												上一页
											</span>
										</li>
										
										<li>
											<span  id="nextbtn" style="cursor:pointer">
												下一页 
												<i class="fa-angle-double-right"></i>
											</span>
										</li>
									</ul>
								</div>
							</div>
				</div>
			</div>
		</section>
		<input id="pageNumRecords" value="" type="hidden"/>
		<input id="pageCount" value="" type="hidden"/>
		<script type="text/javascript">
			$().ready(function(){
				loadPicture(1);
			});
			function loadPicture(pageNum){
					$.ajax({
									url: "${pageContext.request.contextPath}/picture/loadPictureByUserAJAX",
									method: 'POST',
									dataType: 'json',
									data:{
										"uid":"<s:property value="user.uid"/>",
										"pageNum":pageNum
									},
									beforeSend:function(){
										$("#spinIcon").show();
									},
									success: function(resp)
									{
										$("#spinIcon").hide();
										//记录当前页码
                						$("#pageNumRecords").val(resp.page);
                						//记录总页数
                						$("#pageCount").val(resp.pageCount);
										$(resp.data).each(function(index, picture) {
											if(index%4==0){
												$("<div class='row'>").appendTo("#picturePanel");
											}
                							var divTag =$("<div class='col-md-3 col-xs-12'></div>");
                							var aTag = $("<a href='${pageContext.request.contextPath}/picture/viewPicture?pid="+picture.pid+"' class='thumbnail'></a>");
//                 							var imgTag = $("<img />").attr("src","${pageContext.request.contextPath}/file/showMini?downFileName="+picture.pname);
                							var imgTag = $("<div></div>").attr("style","height:150px;background:#000000 url(${pageContext.request.contextPath}/file/showMini?downFileName="+picture.pname+")no-repeat center center");
                							$(imgTag).appendTo(aTag);
                							$(aTag).appendTo(divTag);
                							$(divTag).appendTo("#picturePanel");
                							if((index+1)%4==0){
                								$("</div>").appendTo("#picturePanel");
                							}
           								 });
									}
								});
					}
		</script>
		<script type="text/javascript">
			$().ready(function(){
				$("#nextbtn").click(function(){
					removeAllAlert();
					$("#picturePanel").empty();
					var pageNum = $("#pageNumRecords").val();
					var pageCount = $("#pageCount").val();
					var intPageNum = parseInt(pageNum);
					var intPageCount = parseInt(pageCount);
					if(intPageNum == intPageCount){
						$("#lastOneAlert").attr("style","display:normal;");
						loadPicture(intPageNum);
					}else{
						loadPicture(intPageNum+1);
					}
				});
				$("#lastbtn").click(function(){
					removeAllAlert();
					$("#picturePanel").empty();
					var pageNum = $("#pageNumRecords").val();
					var pageCount = $("#pageCount").val();
					var intPageNum = parseInt(pageNum);
					var intPageCount = parseInt(pageCount);
					if(intPageNum == 1){
						$("#FirstOneAlert").attr("style","display:normal;");
						loadPicture(intPageNum);
					}else{
						loadPicture(intPageNum-1);
					}
				});
			});
			function removeAllAlert(){
				$("#FirstOneAlert").attr("style","display:none;");
				$("#lastOneAlert").attr("style","display:none;");
			}
		</script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/common/assets/css/fonts/elusive/css/elusive.css">
		<%@ include file="/WEB-INF/Pages/user/food-part.jsp"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/Pages/user/head-part.jsp"%>
<div class="page-container container">
<!-- 载入和警告对话框-->
<div class="modal fade" id="gallery-image-alert" data-backdrop="static" style="width:28%; margin-left:30%">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
					<span class="logo">
						<img src="${pageContext.request.contextPath}/common/assets/images/logo-white-bg@2x_loading.png" alt="" width="80" />
					</span>
			</div>
			<div class="modal-body" id="confirmMsg">
				<div class="row">
					<div class="col-sm-6 center">
						<img src="${pageContext.request.contextPath}/common/assets/images/uploadingComment.gif" />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="visible-xs-block">
	<img width="100%" src="${pageContext.request.contextPath}/file/show?downFileName=<s:property value="picture.pname"/>"/>
		<span id="collectBtn2" style="cursor:pointer;" isdone="">
			<span class="fa fa-spin fa-spinner" id="spinIcon2" style="display:none"></span>
			<small>
				<i class="fa fa-heart-o" style="color:red;" id="redHeart2"></i>
				<span id="collectP2">收藏</span>
			</small>
		</span>
		<a href="${pageContext.request.contextPath}/file/download?downFileName=<s:property value="picture.pname"/>">下载原图 </a>
	<span style="float:right;">
		<span style="color:#40bbea;">
			<i class="fa fa-user" style="color:#40bbea;"></i>
			<s:property value="picture.author.nick"/>
		</span>
		创建于&nbsp;<s:property value="picture.createDate_str"/>
	</span>
</div>
	<div class="main-content">
	
		<div class="row">
				<div class="col-sm-9 col-xs-12 visible-md-block visible-sm-block visible-lg-block"><!-- 左侧 -->
				
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 style="float:left;">
								<s:property value="picture.titles"/>
								&nbsp;&nbsp;
								<span id="collectBtn" style="cursor:pointer;" isdone="">
									<span class="fa fa-spin fa-spinner" id="spinIcon" style="display:none"></span>
									<small>
										<i class="fa fa-heart-o" style="color:red;" id="redHeart"></i>
										<span id="collectP">收藏</span>
									</small>
								</span>
							</h4>
							<h5 style="float:right;">
								<span style="color:#40bbea;">
									<i class="fa fa-user" style="color:#40bbea;"></i>
									<s:property value="picture.author.nick"/>
								</span>
								创建于&nbsp;<s:property value="picture.createDate_str"/>
							</h5>
							
						</div>
						
						<div class="panel-body">
							<!-- 这里 -->
							<div class="col-md-12 col-xs-12">
								<div class="">
									<img width="100%" src="${pageContext.request.contextPath}/file/show?downFileName=<s:property value="picture.pname"/>"/>
								</div>
          					</div>
							<!-- 这里结束 -->
							<hr/>
						<div class="row col-md-12" style="margin-left:0.23%;margin-top:0.23%">
							<a
								href="${pageContext.request.contextPath}/file/download?downFileName=<s:property value="picture.pname"/>">
								<button class="btn btn-danger btn-icon" " data-toggle="popover"
									data-trigger="hover" data-placement="right"
									data-content="下完自己看，别让妈妈看到">
									<i class="fa-download"></i> <span>下载图片</span>
								</button> </a>
							<button class="btn btn-secondary btn-icon btn-icon-standalone"
								id="zanBtn" isZan="false">
								<i class="fa-thumbs-up" id="zanValue"> <s:property
										value="picture.zan" /> </i>
								<s:if test="isZan!='yes'">
									<span id="zanString">&nbsp;赞 </span>
								</s:if>
								<s:if test="isZan=='yes'">
									<span id="zanString">&nbsp;已赞 </span>
									<script type="text/javascript">
												$().ready(function(){
													$("#zanBtn").attr("isZan","true");
												});
											</script>
								</s:if>
							</button>
							<script type="text/javascript">
										function setCookie(name,value){
											var Days = 0.25;
											var exp = new Date();
											exp.setTime(exp.getTime()+Days*24*60*60*1000);
											document.cookie = name + "=" +escape(value) +";expires="+exp.toGMTString();
										}
										$().ready(function(){
											$("#zanBtn").click(function(){
												var result = $("#zanBtn").attr("isZan");
												var pidValue = "<s:property value='picture.pid'/>";
												if(result != "true"){
													$.ajax({
														url: "${pageContext.request.contextPath}/picture/zanPicture",
														method: 'POST',
														dataType: 'json',
														data:{
															"pid": pidValue
														},
														success:function(resp){
															if(resp.msg=="ok"){
																/////写入cookie
																setCookie(pidValue,"<s:property value="#session.user.uid"/>");
																var zanV = $("#zanValue").html();
																var zanInt = parseInt(zanV);
																zanInt++;
																$("#zanValue").html(zanInt);
																$("#zanString").html("&nbsp;已赞");
																$("#zanBtn").attr("isZan","true");
															}else if(resp.msg=="login"){
																$("#myModal").modal('show');
															}else{
																alert(resp.msg);
															}
														}
													});
												}
											});
											$("#collectBtn").click(function(){//收藏按钮
												if($("#collectBtn").attr("isdone")==""){
													$.ajax({
														url: "${pageContext.request.contextPath}/picture/collectPicture",
														method: 'POST',
														dataType: 'json',
														data:{
															"pid": "<s:property value="picture.pid"/>"
														},
														success: function(resp)
														{
															if(resp.msg=="ok"){
																$("#redHeart").show();
																$("#spinIcon").hide();
																$("#collectP").html("已收藏");
																$("#collectBtn").attr("isdone","yes");
															}else if(resp.msg=="login"){
																$("#redHeart").show();
																$("#spinIcon").hide();
																$("#myModal").modal('show');
															}else{
																alert("处理失败请重试");
															}
														},
														beforeSend:function(){
															$("#redHeart").hide();
															$("#spinIcon").show();
														}
													});
												}
												
											});
											
											$("#collectBtn2").click(function(){//收藏按钮2
												if($("#collectBtn2").attr("isdone")==""){
													$.ajax({
														url: "${pageContext.request.contextPath}/picture/collectPicture",
														method: 'POST',
														dataType: 'json',
														data:{
															"pid": "<s:property value="picture.pid"/>"
														},
														success: function(resp)
														{
															if(resp.msg=="ok"){
																$("#redHeart2").show();
																$("#spinIcon2").hide();
																$("#collectP2").html("已收藏");
																$("#collectBtn2").attr("isdone","yes");
															}else if(resp.msg=="login"){
																$("#redHeart2").show();
																$("#spinIcon2").hide();
																$("#myModal").modal('show');
															}else{
																alert("处理失败请重试");
															}
														},
														beforeSend:function(){
															$("#redHeart2").hide();
															$("#spinIcon2").show();
														}
													});
												}
												
											});
											
											<s:iterator value="picture.categories" var="c"  status="vs">
												$("#rightBar_well").append("<a href='${pageContext.request.contextPath}/picture/topPage?selectModal=ByCategory&cname=<s:property value="#c.cid"/>' class='label label-"+getRandomClass()+"'><s:property value="#c.description"/></a>&nbsp;&nbsp;");
												<s:if test="(#vs.index+1)%3	==0">
													$("#rightBar_well").append("<br/><br/>");
												</s:if>
											</s:iterator>
											$("#rightBar_well").show();
										});
										
									</script>
							<div class="dropdown user-profile" style="float:right;">
								<a
									href="${pageContext.request.contextPath}/user/profileui?uid=<s:property value="picture.author.uid" />">
									<div class="row">
										<div class="col-sm-4 col-xs-4">
											<s:if test="picture.author.head==null">
												<img src="${pageContext.request.contextPath}/common/assets/images/user-1.png" alt="user-image" class=" img-inline userpic-38" width="38" />
											</s:if>
											<s:else>
												<img
												src="${pageContext.request.contextPath}/file/showMini?downFileName=<s:property value="picture.author.head.pname"/>"
												alt="user-image" class=" img-inline userpic-38" width="38">
											</s:else>
										</div>
										<div class="col-sm-8 col-xs-8">
											<p>
												<s:if test="picture.author.uid==#session.user.uid">
													<s:if test="picture.sharing==0">
														我的私人图片
													</s:if>
													<s:else>
														我分享的图片
													</s:else>
												</s:if>
												<s:else>
													<s:property value="picture.author.nick" />
													&nbsp;分享
												</s:else>
											</p>
										</div>
									</div> </a>
							</div>
								<!-- 留言 -->
								<%@ include file="/WEB-INF/Pages/user/comment-part.jsp" %>
								<!-- 留言 end -->
						</div>
					</div>
						
					</div>
					
				</div>
				<!-- 右侧 -->
					
					<%@ include file="/WEB-INF/Pages/user/rightBar.jsp" %>
				<!-- 右侧 end -->
				<div class="col-sm-5">
					
				</div>
		</div>
<%@ include file="/WEB-INF/Pages/user/food-part.jsp"%>

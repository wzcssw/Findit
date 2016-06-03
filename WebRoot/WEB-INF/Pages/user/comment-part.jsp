<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<div class="row">
					<div class="col-sm-12 col-xs-12 ">
						<div class="xe-widget xe-conversations">
							<s:if test="page.data.size>1">
								<div class="xe-bg-icon">
									<i class="linecons-comment"></i>
								</div>
							</s:if>
							<div class="xe-body">
								<ul class="list-unstyled">
									<s:iterator value="page.data" var="com">
										<li  onmouseover="a_show(this)" onmouseout="a_hide(this)">
											<div class="xe-comment-entry">
												<a href="${pageContext.request.contextPath}/user/profileui?uid=<s:property value="#com.user.uid"/>" class="xe-user-img">
													<s:if test="#com.user.head==null">
														<img src="${pageContext.request.contextPath}/common/assets/images/user-4.png" class="img-circle" width="40" />
													</s:if>
													<s:else>
														<img src="${pageContext.request.contextPath}/file/showMini?downFileName=<s:property value="#com.user.head.pname"/>" class="img-circle" width="40" />
													</s:else>
												</a>
												<div class="xe-comment">
													<a href="${pageContext.request.contextPath}/user/profileui?uid=<s:property value="#com.user.uid"/>" class="xe-user-name">
														<strong>
															<s:property value="#com.user.nick"/>
														</strong>
														<small style="margin-left:3%;color:#8F8F8F"><s:property value="#com.createtime_str"/></small>
													</a>
													<s:if test="#session.user.uid==picture.author.uid">
														<span style="margin-right:15%;float:right;display:none;cursor:pointer;" onclick="delComment('<s:property value="#com.comid"/>',this)"  class="img-circle"><span class="fa fa-spin fa-spinner" style="display:none;"></span><i class="fa-trash" ></i>删除</span>
													</s:if>
													<p>
														<s:property value="#com.msg"/>
													</p>
												</div>
											</div>
										</li>
									</s:iterator>
								</ul>
								<script type="text/javascript">
										//显示’删除‘按钮
										function a_show(obj){
											$(obj).find("span").eq(0).show();
										}
										//隐藏’删除‘按钮
										function a_hide(obj){
											$(obj).find("span").eq(0).hide();
										}
										function delComment(comid,obj){
											$.ajax({
														url: "${pageContext.request.contextPath}/picture/delComment",
														method: 'POST',
														dataType: 'json',
														data:{
															"comid":comid
														},
														success: function(resp)
														{
																if(resp.msg=='ok'){
																	window.location.reload();
																}
														},
														beforeSend:function(){
															$(obj).find("span").eq(0).show();
															$(obj).find("i").eq(0).hide();
														}
													});
										}
									</script>
									<s:if test="#session.user!=null">
										<!-- 评论输入 -->
										<div class="row">
											<div class="col-sm-10 col-xs-10">
												<div class="profile-env">
													<div class="profile-post-form">
														<textarea id="textA" class="form-control input-unstyled  autogrow" placeholder="说点什么吧~" style="overflow: hidden; word-wrap: break-word; height: 66px;"></textarea>
														<i class="el-edit block-icon"></i>
														<br/>
														<button id="subBtn" class="btn btn-single btn-xs btn-success post-story-button">提交</button>
													</div>
												</div>
											</div>
										</div>
										<script type="text/javascript">
											$().ready(function(){//添加评论
												$("#subBtn").click(function(){
													$.ajax({
																url: "${pageContext.request.contextPath}/picture/addComment",
																method: 'POST',
																dataType: 'json',
																data:{
																	"msg": $("#textA").val(),
																	"pid":"<s:property value='picture.pid'/>"
																},
																success: function(resp)
																{
																		if(resp.msg=='ok'){
																			window.location.reload();
																		}
																},
																beforeSend:function(){
																	$("#gallery-image-alert").modal('show');
																}
															});
												});
											});
										</script>
										<!-- 评论输入 end -->
									</s:if>
									<s:else>
										<span style="float:right;">添加评论需要<span style="color:blue; cursor:pointer;" onclick="$('#myModal').modal('show');">登陆</span>哦</span>
									</s:else>
							</div>
							<s:if test="page.pageCount>1">
								<div class="xe-footer">
									<!-- 分页 -->
									<div class="row col-sm-9  col-xs-12">
										<div style="text-align:center;">
											<%@ include file="/WEB-INF/Pages/user/page_ognl.jsp" %>
										</div>
									</div>
									<!-- 分页 end -->
								</div>
							</s:if>
						</div>
						
					</div>
				</div>
				
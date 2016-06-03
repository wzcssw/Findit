<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/Pages/user/head-part.jsp"%>
<div class="page-container container">
	<div class="main-content">
				<s:if test="page.data.size==0">
			   		<div class="alert alert-success">
						<button type="button" class="close" data-dismiss="alert">
							<span aria-hidden="true">×</span>
							<span class="sr-only">关闭</span>
						</button>
						<strong>你还没有收藏任何图片哦~</strong>
					</div>
			   	</s:if>
				<s:iterator value="page.data" var="p" status="vs">
					<s:if test="(#vs.index+4)%4==0">
						<div class="row"><!-- 头 -->
					</s:if>
						<div class="col-md-3">
							<div class="xe-widget xe-single-news">
								<a href="${pageContext.request.contextPath}/picture/viewPicture?pid=<s:property value="#p.pid" />">
									<div class="xe-image">
										<div style="width:255px;height:150px;background:#000000 url(${pageContext.request.contextPath}/file/showMini?downFileName=<s:property value="#p.pname" />)no-repeat center center"></div>
									</div>
								</a>
									<div class="xe-details">
										<time>
											<div class="row">
											
									    	<div style="float:left" class="col-md-3">
									        	<s:if test="#p.author.head==null">
													<a href="${pageContext.request.contextPath}/user/profileui?uid=<s:property value="#p.author.uid" />">
										    			<img src="${pageContext.request.contextPath}/common/assets/images/user-1.png" alt="user-image" style="height:30px; width:30px;" class="img-responsive" />
										        	</a>
												</s:if>
												<s:else>
													<a href="${pageContext.request.contextPath}/user/profileui?uid=<s:property value="#p.author.uid" />">
										    			<img src="${pageContext.request.contextPath}/file/showMini?downFileName=<s:property value="#p.author.head.pname"/>" alt="user-image" style="height:30px; width:30px;" class="img-responsive" />
										        	</a>
												</s:else>
									        </div>
									        <div class="col-md-6" style="margin-left:-7%">
									        	<h5>
									        		<s:property value="#p.author.nick" />
									        		收录
									        	</h5>
									        </div>
									        <div style="float:right" class="col-md-3">
									        	<h5>
									        		<i class="fa fa-heart-o" style="color:red;" id="redHeart"></i>
									        	</h5>
									        </div>
									     </div>		
										</time>
									</div>
							</div>
						</div>
							<s:if test="(page.data.size-2)<#vs.index">
								</div><!-- 屁股 last -->
							</s:if>
							<s:else>
								<s:if test="(#vs.index+1)%4==0">
									</div><!-- 屁股 -->
								</s:if>
							</s:else>
						</s:iterator>
						
						<!-- 分页 -->
						<div class="row col-sm-9 ">
							<div style="text-align:center;margin:3%;">
								<%@ include file="/WEB-INF/Pages/user/page_ognl.jsp" %>
							</div>
						</div>
						<!-- 分页 end -->
<%@ include file="/WEB-INF/Pages/user/food-part.jsp"%>
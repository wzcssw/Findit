<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/Pages/user/head-part.jsp"%>
<div class="page-container container">
	<div class="main-content">
		<div class="row " >
    		<p>
    			<s:property value="pageMsg"/>
    		</p>
    	</div>
	    <div class="row">
		    <div class="col-md-9 col-sm-12 col-xs-12"><!-- 左侧 -->
		    	<s:if test="page.data.size==0">
		    		<div class="alert alert-success">
						<button type="button" class="close" data-dismiss="alert">
							<span aria-hidden="true">×</span>
							<span class="sr-only">关闭</span>
						</button>
						<strong>现在还没有图片哎~</strong>快来分享你的相片吧！
					</div>
		    	</s:if>
				<s:iterator value="page.data" var="p" status="vs">
						<div class="col-md-4 col-sm-4 col-xs-12">
							<div class="xe-widget xe-single-news ">
								<a href="${pageContext.request.contextPath}/picture/viewPicture?pid=<s:property value="#p.pid" />">
									<div class="xe-image">
										<div style="height:150px;background:#000000 url(${pageContext.request.contextPath}/file/showMini?downFileName=<s:property value="#p.pname" />)no-repeat center center"></div>
									</div>
								</a>
									<div class="xe-details">
										<time>
											<div class="row">
											
									    	<div style="float:left" class="col-md-3 col-xs-5">
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
									        <div class="col-md-6 col-xs-7" style="margin-left:-7%">
									        	<h5>
									        		<s:property value="#p.author.nick" />
									        		收录
									        	</h5>
									        </div>
									        <div style="float:right" class="col-md-3 col-xs-3">
									        	<!-- 右边的位置 暂时还没东西 -->
									        </div>
									     </div>		
										</time>
									</div>
							</div>
						</div>
						</s:iterator>
				</div>
				<!-- 右侧 -->
				<%@ include file="/WEB-INF/Pages/user/rightBar.jsp" %>
				<!-- 右侧 end -->
				<script type="text/javascript">
					$().ready(function(){
						<s:iterator value="categories" var="c"  status="vs">
							$("#rightBar_well").append("<a href='${pageContext.request.contextPath}/picture/topPage?selectModal=ByCategory&cname=<s:property value="#c.cid"/>' class='label label-"+getRandomClass()+"'><s:property value="#c.description"/></a>&nbsp;&nbsp;");
							<s:if test="(#vs.index+1)%3	==0">
								$("#rightBar_well").append("<br/><br/>");
							</s:if>
						</s:iterator>
						<s:if test="categories!=null">
							$("#rightBar_well").show();
						</s:if>
					});
				</script>
				<!-- 分页 -->
				<div class="row col-sm-9 col-xs-9">
					<div style="text-align:center;">
						<%@ include file="/WEB-INF/Pages/user/page_ognl.jsp" %>
					</div>
				</div>
				<!-- 分页 end -->
			</div>
<!-- Imported styles on this page -->
<link rel="stylesheet"
	href="assets/css/fonts/meteocons/css/meteocons.css">
<!-- Imported scripts on this page -->

<script src="assets/js/xenon-widgets.js"></script>
<script src="assets/js/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script
	src="assets/js/jvectormap/regions/jquery-jvectormap-world-mill-en.js"></script>

<%@ include file="/WEB-INF/Pages/user/food-part.jsp"%>

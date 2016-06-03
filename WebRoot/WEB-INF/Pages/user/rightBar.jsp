<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<div class="col-md-3 visible-md-block visible-lg-block">
<div class="panel panel-color panel-info">
		<div class="panel-heading">
			Findit-wzcssw.com
			
		</div>
		<div class="panel-body">
			<div class="well well-lg" style="display:none;" id="rightBar_well"></div>
			<div class="btn-group btn-group-justified"  style="margin-bottom:10%;margin-top:5%">					
				<a type="button" class="btn btn-warning bg-lg" href="${pageContext.request.contextPath}/picture/uploadPictureui">上传图片</a>
			</div>
			<h5>标签</h5>
			<div class="bs-example" id="categoryListDiv"></div>
		</div>
		
		<div class="panel-body">
			<hr>
			<div class="row" id="rightBottonDiv">
				<s:if test="picture!=null">
					<h5><i class="fa fa-user"></i>  收藏此图的用户(<s:property value="picture.collectedUsers.size"/>)</h5>
					<s:iterator value="picture.collectedUsers" status="vs" var="u">
						<s:if test="#vs.index<20">
							<s:if test="#u.head==null">
								<a href="${pageContext.request.contextPath}/user/profileui?uid=<s:property value="#u.uid"/>">
									<img style="margin-bottom:2%;" src="${pageContext.request.contextPath}/common/assets/images/user-1.png" alt="user-image" class=" img-inline userpic-50" width="50" />
								</a>
							</s:if>
							<s:else>
								<a href="${pageContext.request.contextPath}/user/profileui?uid=<s:property value="#u.uid"/>">
									<img style="margin-bottom:2%;" src="${pageContext.request.contextPath}/file/showMini?downFileName=<s:property value="#u.head.pname"/>"
									alt="user-image" class=" img-inline userpic-50" width="50">
								</a>
							</s:else>
						</s:if>
					</s:iterator>
						<h5>扫码下载此图</h5>
						<!-- 二维码 -->
							<img src="${pageContext.request.contextPath}/file/buildCode?title=/file/download?downFileName=<s:property value="picture.pname"/>" width='140px;' />
						<!-- 二维码 end -->
				</s:if>
				<s:if test="pageMsg=='全部分享的相片'">
					<script>
						$().ready(function(){
							$.ajax({//载入一些用户头像
								url: "${pageContext.request.contextPath}/user/findSomeUserByAJAX",
								method: 'POST',
								dataType: 'json',
								success: function(resp)
								{
									$(resp).each(function(index,obj){
										if(obj.head!=null){
											$("#rightBottonDiv").append("<a href='${pageContext.request.contextPath}/user/profileui?uid="+obj.uid+"'><img class='img-inline userpic-50' width='50' style='margin-bottom:2%;' src='${pageContext.request.contextPath}/file/showMini?downFileName="+obj.head.pname+"'/></a>");
										}
									});
								}
							});
						});
					</script>
				</s:if>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$().ready(function(){
		$.ajax({
			url: "${pageContext.request.contextPath}/picture/loadCategoryAJAX",
			method: 'POST',
			dataType: 'json',
			success: function(resp)
			{
				$(resp.categories).each(function(index,obj){
					if((index+1)%4==0){
						$("#categoryListDiv").append("<br/>");
						$("#msgP").append("<br/> <br/>");
					}
					$("#categoryListDiv").append("<a href='${pageContext.request.contextPath}/picture/topPage?selectModal=ByCategory&cname="+obj.cid+"' class='label label-"+getRandomClass()+"'>"+obj.description+"</a>");
					$("#msgP").append("<a style='margin:2%' href='${pageContext.request.contextPath}/picture/topPage?selectModal=ByCategory&cname="+obj.cid+"' class='label label-"+getRandomClass()+"'>"+obj.description+"</a>");
				});
			}
		});
	});
	function getRandomNum(min,max){
		var range = max - min;
		var rand = Math.random();
		return (min+Math.round(rand*range));
	}
	function getRandomClass(){
		var randNum = getRandomNum(1,8);
		var str = "";
		switch(randNum){
			case 1:
				str = "turquoise";
				break;
			case 2:
				str = "orange";
				break;
			case 3:
				str = "secondary";
				break;		
			case 4:
				str = "info";
				break;
			case 5:
				str = "purple";
				break;	
			case 6:
				str = "pink";
				break;	
			case 7:
				str = "success";
				break;	
			default:
				str = "blue";
				break;	
		}
		return str;
	}
</script>
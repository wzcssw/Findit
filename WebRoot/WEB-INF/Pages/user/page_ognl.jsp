<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<ul class="pagination">
	<li
		<s:if test="page.page<=1">
			class="disabled"
		</s:if>
		>
		<a
			<s:if test="page.page<=1">
				href="#"
			</s:if> 
			<s:else>
				href="${pageContext.request.contextPath}<s:property value="page.servletUrl"/>&pageNum=<s:property value="page.page<=1?1:page.page-1"/>"
			</s:else>
		><i class="fa-angle-left"></i></a>
	</li>
	<s:iterator begin="page.s" end="page.e" status="vs">
		<s:if test="(#vs.index+page.s)!=page.page">
			<li>
				<a href="${pageContext.request.contextPath}<s:property value="page.servletUrl"/>&pageNum=<s:property value="(#vs.index+page.s)"/>"><s:property value="(#vs.index+page.s)"/></a>
			</li>
		</s:if>
		<s:if test="(#vs.index+page.s)==page.page">
				<li class="active">
					<a href="#"><s:property value="(#vs.index+page.s)"/></a>
				</li>
		 </s:if>
	</s:iterator>
	<li
		<s:if test="page.pageCount<=page.page">
			class="disabled"
		</s:if>
	>
		<a 
			<s:if test="page.pageCount<=page.page">
				href="#"
			</s:if> 
			<s:else>
				href="${pageContext.request.contextPath}<s:property value="page.servletUrl"/>&pageNum=<s:property value="page.pageCount==page.page?page.page:page.page+1"/>"
			</s:else>
		><i class="fa-angle-right"></i></a>
	</li>
</ul>
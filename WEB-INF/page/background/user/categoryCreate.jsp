<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title>CategoryJsp_createView</title>
<meta charset="utf-8" >
<script type="text/javascript">
function xmlCheck() {
	$.post("${pageContext.request.contextPath}/category/bCreateRepeat"
			, {userType: ${"userTypeId"}.value
				, id: ${"categoryId"}.value}
			, function(data) {
				if(data!= "") {
					$("#userTypeId").focus();
					alert(data);
				}
			});
}
</script>
</head>
<body>
	<section>
		<form action="${pageContext.request.contextPath }/category/bCreate" method="post">
			<div>
			<s:if test="#request.user==null">
				<h1>用户类型创建</h1>
			</s:if>
			<s:else>
				<h1>用户类型修改</h1>
			</s:else>
			</div>
			
			<input type="text" value="${category.userType }" name="category.userType" required="required" placeholder="用户类型" onblur="xmlCheck()" id="userTypeId" autofocus="autofocus"/>
			<input type="hidden" value="${category.id }" name="category.id" id="categoryId"/>
			
			<input type="submit" value="保存" />
		</form>
		<input type="button" onclick="history.back()" value="back" />
	</section>
</body>
</html>

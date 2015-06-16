<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title>文件已删除</title>
<meta charset="UTF-8">
<style type="text/css">
a {
	text-decoration: none;
}
a:HOVER {
	color: red;
}
section {
	border-style: dotted;
	border-width: 3px;
	border-color: green;
	padding: 10px;
	margin-bottom: 20px;
	width: 330px;
}
</style>
</head>
<body>
<c:if test="${not empty sessionScope.customer }">
	<a href="customerService/updateView">${sessionScope.customer.name }个人设置</a>
</c:if>
<c:if test="${not empty sessionScope.process }">
	<a href="processStaff/updateView">${sessionScope.process.name }个人设置</a>
</c:if>

</body>
</html>

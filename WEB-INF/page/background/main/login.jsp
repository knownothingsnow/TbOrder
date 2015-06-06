<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title>index</title>
<meta charset="UTF-8">
</head>
<body>
	<h2>后台管理员登陆</h2>
	<form action="admin/bAdminLogin" >
		<input type="text" name="username" required="required" placeholder="用户名" id="usernameId" autofocus="autofocus"/>
		<input type="password" name="password" required="required" placeholder="密码" id="passwordId"/>
		<input type="submit" value="login" />
		<input type="button" onclick="history.back()" value="back" />
	</form>
</body>
</html>

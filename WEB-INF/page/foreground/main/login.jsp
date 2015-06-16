<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title>login</title>
<meta charset="UTF-8">
<!-- <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/signin.css">
</head>
<body>
	<div class="container ">
		<form action="customerService/customerLogin" class="form-signin" role="form" >
			<h2 class="form-signin-heading">Lemon订单管理系统</h2>
			<input type="text" name="username" placeholder="用户名" id="usernameId" class="form-control" autofocus required /> 
			<input type="password" name="password" placeholder="密码" id="passwordId" class="form-control" required /> 
			<label class="checkbox"> 
				<input type="checkbox" value="remember-me"> 记住此账号
			</label> 			
			<button class="btn btn-lg btn-primary btn-block" type="submit" onclick="login()">登录</button>
		</form>
	</div> <!-- /container -->
</body>
</html>

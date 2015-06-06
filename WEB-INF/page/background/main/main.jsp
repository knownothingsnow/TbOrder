<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%= basePath%>">
<title>index</title>
<meta charset="UTF-8">
</head>
<body>
    <div class="container-fluid" id="page-wrapper">
      <div class="row">          
	      <div class="col-md-12 page-header">
			<h2>管理员信息更新</h2>
		  </div>
        <div class="col-md-12 form-cent" style="text-align: center;">
		<form action="admin/bAdminCreate" method="post" class="form-horizontal" >
		
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">账号</label>
              <div class="col-sm-4">
			<input type="text" name="administrator.username" value="${administrator.username }"  class="form-control"/></div>
              <label for="inputID" class="col-sm-1 control-label">密码</label>
              <div class="col-sm-4">
			<input type="text" name="administrator.password" value="${administrator.password }"  class="form-control"/></div></div>
			
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">手机</label>
              <div class="col-sm-4">
			<input type="text" name="administrator.phone" value="${administrator.phone }"  class="form-control"/></div>
              <label for="inputID" class="col-sm-1 control-label">邮箱</label>
              <div class="col-sm-4">
			<input type="text" name="administrator.email" value="${administrator.email }"  class="form-control"/></div></div>
			
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">登陆次数</label>
              <div class="col-sm-2">
			<input type="text" name="administrator.loginCount" value="${administrator.loginCount }"  class="form-control"/></div>
              <label for="inputID" class="col-sm-1 control-label">登陆ip</label>
              <div class="col-sm-2">
			<input type="text" name="administrator.ip" value="${administrator.ip }" class="form-control"/></div>
              <label for="inputID" class="col-sm-1 control-label">更新时间</label>
              <div class="col-sm-2">
			<label class="form-control"><fmt:formatDate value="${administrator.createTime }" type="Date" pattern="yyyy-MM-dd-HH-mm"/></label></div>
              <label for="inputID" class="col-sm-1 control-label">最后在线</label>
              <div class="col-sm-2">
			<label class="form-control"><fmt:formatDate value="${administrator.onlineTime }" type="Date" pattern="yyyy-MM-dd-HH-mm" /></label></div></div>
			
			<input type="hidden" name="administrator.id" value="${administrator.id }" />
			<input type="submit" value="更新"  class="btn btn-success btn-lg"/>
		</form>
		</div>
	</div>
</div>
</body>
</html>

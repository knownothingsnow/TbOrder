<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title>客服人员信息</title>
<meta charset="utf-8" >
</head>
<body>
    <div class="container-fluid" id="page-wrapper">
      <div class="row">          
	      <div class="col-md-12 page-header">
			<h1 id="header-of-page">客服信息更新</h1>
		  </div>
        <div class="col-md-12 form-cent" style="text-align: center;">
		<form action="customerService/update"
		onsubmit="return checkForm()" method="post" enctype="multipart/form-data" class="form-horizontal" >
	
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">姓名</label>
              <div class="col-sm-3">
			<input type="text" value="${customerService.name }" name="customerService.name" id="nameId"  class="form-control" /></div>
              <label for="inputID" class="col-sm-1 control-label">手机</label>
              <div class="col-sm-3">
			<input type="text" value="${customerService.phone }" name="customerService.phone"  class="form-control" /></div>
              <label for="inputID" class="col-sm-1 control-label">淘宝账号</label>
              <div class="col-sm-3">
			<input type="text" value="${customerService.tbUsername }" name="customerService.tbUsername"  class="form-control" /></div></div>
			
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">用户名</label>
              <div class="col-sm-3">
			<input type="text" value="${customerService.username }" name="customerService.username" required="required" placeholder="用户名" 
				onblur="xmlCheck()" id="usernameId" autofocus="autofocus" class="form-control"/></div>
              <label for="inputID" class="col-sm-1 control-label">密码</label>
              <div class="col-sm-3">
			<input type="text" value="${customerService.password }" name="customerService.password" required="required"  class="form-control"/></div>
              <label for="inputID" class="col-sm-1 control-label">邮箱</label>
              <div class="col-sm-3">
			<input type="text" value="${customerService.email }" name="customerService.email"  class="form-control"/></div></div>
			
			<hr/><!-- 后台自动生成的数据 -->
            <div class="form-group" style="margin-bottom: 60px;">            
              <label for="inputID" class="col-sm-1 control-label">登陆次数</label>
              <label for="inputID" class="col-sm-1 control-label">${customerService.loginCount }</label>
			  <input type="hidden" value="${customerService.loginCount }" name="customerService.loginCount"/>
			  
              <label for="inputID" class="col-sm-1 control-label">录入订单</label>
              <label for="inputID" class="col-sm-1 control-label">${customerService.orderNumber }</label>
			  <input type="hidden" value="${customerService.orderNumber }" name="customerService.orderNumber"/>
			  
              <label for="inputID" class="col-sm-1 control-label">设计订单</label>
              <label for="inputID" class="col-sm-1 control-label">${customerService.designNumber }</label>
			  <input type="hidden" value="${customerService.designNumber }" name="customerService.designNumber"/>
			  
              <label for="inputID" class="col-sm-1 control-label">创建时间</label>
              <label for="inputID" class="col-sm-2 control-label">${customerService.createTime }</label>
			</div>
			
			<!-- input -->
			<input type="hidden" value="${customerService.id }" name="customerService.id" id="customerServiceId"/>
			<input type="submit" value="保存"  class="btn btn-success btn-lg"/>
			<input type="button" onclick="javascript:window.opener=null;window.open('','_self');window.close();" value="关闭"  class="btn btn-success btn-lg" />
		</form>
		</div>
      </div>
	</div>
<script type="text/javascript" src="js/foreground/user-customerService.js"></script>
</body>
</html>

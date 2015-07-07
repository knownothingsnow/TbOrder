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
<title>加工部人员信息</title>
<meta charset="utf-8" >
</head>
<body>
    <div class="container-fluid" id="page-wrapper">
      <div class="row">          
	      <div class="col-md-12 page-header">
			<h1 id="header-of-page">加工人员信息更新</h1>
		  </div>
        <div class="col-md-12 form-cent" style="text-align: center;">
		<form action="processStaff/update"
		onsubmit="return checkForm()" method="post" enctype="multipart/form-data"  class="form-horizontal">
	
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">姓名</label>
              <div class="col-sm-3">
			<input type="text" value="${processStaff.name }" name="processStaff.name" id="nameId"  class="form-control" /></div>
              <label for="inputID" class="col-sm-1 control-label">手机</label>
              <div class="col-sm-3">
			<input type="text" value="${processStaff.phone }" name="processStaff.phone" class="form-control"  /></div></div>
			
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">用户名</label>
              <div class="col-sm-3">
			<input type="text" value="${processStaff.username }" name="processStaff.username" required="required" placeholder="用户名" 
				onblur="xmlCheck()" id="usernameId" autofocus="autofocus" class="form-control"/></div>
              <label for="inputID" class="col-sm-1 control-label">密码</label>
              <div class="col-sm-3">
			<input type="text" value="${processStaff.password }" name="processStaff.password" required="required"  class="form-control" /></div></div>
			
			<hr><!-- 后台自动生成的数据 -->
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">发货数量</label>
              <label for="inputID" class="col-sm-1 control-label">${processStaff.publishNumber }</label>
			  <input type="hidden" value="${processStaff.publishNumber }" name="processStaff.publishNumber"/>
			  
              <label for="inputID" class="col-sm-1 control-label">创建时间</label>
              <label for="inputID" class="col-sm-2 control-label">${processStaff.createTime }</label>
            </div>
			
			<!-- input -->
			<input type="hidden" value="${processStaff.id }" name="processStaff.id" id="processStaffId"/>
			<input type="submit" value="保存"  class="btn btn-success btn-lg"/>
			<input type="button" onclick="javascript:window.opener=null;window.open('','_self');window.close();" value="关闭"  class="btn btn-success btn-lg" />
		</form>
		</div>
	</div>
</div>
</body>
</html>

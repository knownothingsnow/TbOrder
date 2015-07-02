<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title>加工部信息更新</title>
<meta charset="utf-8" >
</head>
<body>
    <div class="container-fluid" id="page-wrapper">
      <div class="row">
          <div class="col-md-12 page-header">
			<s:if test="#request.processStaff==null">
				<h1 id="header-of-page">加工人员创建</h1>
			</s:if>
			<s:else>
				<h1 id="header-of-page">加工人员修改(用户名修改无效)</h1>
			</s:else>
          </div>
          
        <div class="col-md-12 form-cent" style="text-align: center;">
		<form action="processStaff/bCreate"
		onsubmit="return checkForm()" method="post" enctype="multipart/form-data" class="form-horizontal" >
			
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-2 control-label">用户名</label>
              <div class="col-sm-10">
			<input type="text" value="${processStaff.username }" name="processStaff.username" required="required" placeholder="用户名" 
				onblur="xmlCheck()" id="usernameId"  class="form-control" style="width:250px; margin-bottom:5px;" /></div>
              <label for="inputID" class="col-sm-2 control-label">密码</label>
              <div class="col-sm-10">
			<input type="text" value="${processStaff.password }" name="processStaff.password" required="required" autofocus class="form-control" style="width:250px; margin-bottom:5px;" /></div></div>
			
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-2 control-label">姓名</label>
              <div class="col-sm-10">
			<input type="text" value="${processStaff.name }" name="processStaff.name" id="nameId" class="form-control"  style="width:250px; margin-bottom:5px;" /></div>
              <label for="inputID" class="col-sm-2 control-label">手机</label>
              <div class="col-sm-10">
			<input type="text" value="${processStaff.phone }" name="processStaff.phone"  class="form-control" style="width:250px; margin-bottom:5px;" /></div></div>
			
			<!-- <span style="float: left; color: red;">以下可不填</span><br>
			<hr> -->
			<s:if test="#request.processStaff!=null">
            <div class="form-group" style="margin-bottom: 60px; ">
              <label for="inputID" class="col-sm-2 control-label">发货数量</label>
              <label for="inputID" class="col-sm-1 control-label">${processStaff.publishNumber }</label>
              <input type="hidden" value="${processStaff.publishNumber }" name="processStaff.publishNumber"/>
              
              <label for="inputID" class="col-sm-2 control-label">更新时间</label>
              <label for="inputID" class="col-sm-2 control-label">${processStaff.createTime }</label>
            </div>
			</s:if>
			
			<!-- input -->
			<input type="hidden" value="${processStaff.id }" name="processStaff.id" id="processStaffId"/>
			<input type="submit" value="保存"  class="btn btn-success btn-lg"/>
			<input type="button" onclick="javascript:window.opener=null;window.open('','_self');window.close();" value="关闭"  class="btn btn-success btn-lg"/>
		</form>
		</div>
	</div>
  </div>
<script type="text/javascript" src="js/background/user-processStaffCreate.js"></script>
</body>
</html>

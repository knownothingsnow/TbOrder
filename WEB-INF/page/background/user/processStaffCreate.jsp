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
<title>CustomerService</title>
<meta charset="utf-8" >
<script type="text/javascript">
function xmlCheck() {
	$.post("processStaff/bCreateRepeat"
			, {username: $("#usernameId").val()
				, id: $("#processStaffId").val()}
			, function(data) {
				if(data.length> 0) {
					$("#usernameId").focus();
					alert(data.message);
				}
			});
}

function checkForm() {
	/*
	if(ue.getContentTxt()=="") {
		alert("请输入内容");
		return false;
	}
	if(processStaffTypeId.selectedIndex== 0) {
		alert("please selete the processStaffType!!");
		return false;
	}
	*/
	return true;
}
</script>
</head>
<body>
    <div class="container-fluid" id="page-wrapper">
      <div class="row">
          <div class="col-md-12 page-header">
			<s:if test="#request.processStaff==null">
				<h1>加工人员创建</h1>
			</s:if>
			<s:else>
				<h1>加工人员修改</h1>
			</s:else>
          </div>
          
        <div class="col-md-12 form-cent" style="text-align: center;">
		<form action="processStaff/bCreate"
		onsubmit="return checkForm()" method="post" enctype="multipart/form-data" class="form-horizontal" >
			
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-2 control-label">用户名</label>
              <div class="col-sm-3">
			<input type="text" value="${processStaff.username }" name="processStaff.username" required="required" placeholder="用户名" 
				onblur="xmlCheck()" id="usernameId" autofocus="autofocus" class="form-control"/></div>
              <label for="inputID" class="col-sm-2 control-label">密码</label>
              <div class="col-sm-3">
			<input type="text" value="${processStaff.password }" name="processStaff.password" required="required" class="form-control"/></div></div>
			
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-2 control-label">姓名</label>
              <div class="col-sm-3">
			<input type="text" value="${processStaff.name }" name="processStaff.name" id="nameId" class="form-control" /></div>
              <label for="inputID" class="col-sm-2 control-label">手机</label>
              <div class="col-sm-3">
			<input type="text" value="${processStaff.phone }" name="processStaff.phone"  class="form-control" /></div></div>
			
			<span style="float: left; color: red;">以下可不填</span><br>
			<hr>
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-2 control-label">发货数量</label>
              <div class="col-sm-3">
			<input type="text" value="${processStaff.publishNumber }" name="processStaff.publishNumber" class="form-control"/></div>
              <label for="inputID" class="col-sm-2 control-label">创建时间</label>
              <div class="col-sm-3">
			<input type="text" value="${processStaff.createTime }" name="processStaff.createTime" class="form-control" /></div></div>
			
			<input type="hidden" value="${processStaff.id }" name="processStaff.id" id="processStaffId"/>
			<input type="submit" value="保存"  class="btn btn-success btn-lg"/>
			<input type="button" onclick="javascript:window.opener=null;window.open('','_self');window.close();" value="关闭"  class="btn btn-success btn-lg"/>
		</form>
		</div>
	</div>
  </div>
</body>
</html>

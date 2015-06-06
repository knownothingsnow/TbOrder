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
	$.post("customerService/bCreateRepeat"
			, {username: $("#usernameId").val()
				, id: $("#customerServiceId").val()}
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
	if(customerServiceTypeId.selectedIndex== 0) {
		alert("please selete the customerServiceType!!");
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
			<s:if test="#request.customerService==null">
				<h2>客服创建</h2>
			</s:if>
			<s:else>
				<h2>客服修改</h2>
			</s:else>
          </div>
          
        <div class="col-md-12 form-cent" style="text-align: center;">
		<form action="customerService/bCreate"
		onsubmit="return checkForm()" method="post" enctype="multipart/form-data" class="form-horizontal">
	
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
			
			<span style="float: left; color: red;">以下可不填</span><br>
			<hr>
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">登陆次数</label>
              <div class="col-sm-2">
			<input type="text" value="${customerService.loginCount }" name="customerService.loginCount"  class="form-control"/></div>
              <label for="inputID" class="col-sm-1 control-label">录入订单</label>
              <div class="col-sm-2">
			<input type="text" value="${customerService.orderNumber }" name="customerService.orderNumber"  class="form-control"/></div>
              <label for="inputID" class="col-sm-1 control-label">设计订单</label>
              <div class="col-sm-2">
			<input type="text" value="${customerService.designNumber }" name="customerService.designNumber" class="form-control" /></div>
              <label for="inputID" class="col-sm-1 control-label">创建时间</label>
              <div class="col-sm-2">
			<input type="text" value="${customerService.createTime }" name="customerService.createTime" class="form-control" /></div></div>
			
			<input type="hidden" value="${customerService.id }" name="customerService.id" id="customerServiceId"/>
			<input type="submit" value="保存"  class="btn btn-success btn-lg"/>
			<input type="button" onclick="javascript:window.opener=null;window.open('','_self');window.close();" value="关闭"  class="btn btn-success btn-lg" />
		</form>
		</div>
	</div>
  </div>
</body>
</html>

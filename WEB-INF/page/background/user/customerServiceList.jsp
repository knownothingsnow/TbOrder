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
<base href="<%=basePath%>">
<title>CustomerService</title>
<meta charset="UTF-8">
  </head>
  <body>
     
	<section id="searchSection">
        <div class="col-md-12 form-cent" style="text-align: center;"> 
	<div class="col-lg-1"></div>
		<div class="row">
        <div class="col-lg-3">
		<input type="text" name="username" id="usernameId" placeholder="用户名" value="${username }"class="form-control" placeholder="用户名"/></div>
         <div class="col-lg-2">
		<select name="isVague" id="isVagueId" class="form-control">
			<option value="0">精确</option>
			<option value="1">模糊</option>
		</select>
		</div>
         <div class="col-lg-2">
		<select name="orderBy" id="orderById" class="form-control">
			<option value="0">创建时间</option>
			<option value="1">录入</option>
			<option value="2">设计</option>
			<option value="3">录入和设计</option>
		</select>
		</div>
         <div class="col-lg-2">
		<select name="order" id="orderId" class="form-control">
			<option value="0">倒序排序</option>
			<option value="1">顺序排序</option>
		</select>
		</div>
        <div class="col-lg-1">
		<input type="button" value="排序或检索" onclick="xmlPage(0)"  class="btn btn-default"/></div></div></div>
	</section>
	<br><hr>
	
	<!-- 设置内边距，将表格实现缩进 -->
  	<section style="padding:0 50px;">
		<table class="table table-hover table-striped" id="customerServiceListTable">
			<tr>
				<th>姓名</th>
				<th>用户名</th>
				<th>密码</th>
				<th>录入订单数量</th>
				<th>设计图案数量</th>
				<th>注册时间</th>
				<th>Operation</th>
			</tr>
			
			<c:forEach items="${customerServiceList }" var="list">
				<tr>
					<td>${list.name }</td>
					<td>${list.username }</td>
					<td>${list.password }</td>
					<td>${list.orderNumber }</td>
					<td>${list.designNumber }</td>
					<td><fmt:formatDate value="${list.createTime }" type="date" pattern="yyyy-MM-dd" /></td>
					<td>
					<a href="customerService/bCreateView?id=${list.id }" target="_blank" class="btn btn-default" >modify</a>
					<a href="javascript:;" onclick="del('${list.id}')" class="btn btn-default" >delete</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<jsp:include page="/WEB-INF/page/background/main/page.jsp"></jsp:include>
	</section>
	<section>
		<input type="hidden" id="deleteId" value="" />
	</section>
  <script type="text/javascript" src="js/background/user-customerServiceList.js"></script>
</body>
</html>

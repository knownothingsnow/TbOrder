<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
  <script type="text/javascript">
  	function xmlPage(n) {
  		var cp= calcCurrentPage(n);
  		$.getJSON("${pageContext.request.contextPath}/user/bListXml", 
	  				{currentPage: cp
						, orderByUserType: $("#orderByUserTypeId").val()
						, order: $("#orderId").val()
						, userType: $("#userTypeId").val()
						, username: $("#usernameId").val()
						, isVague: $("#isVagueId").val()
						, step: $("#stepId").val()
						, id: $("#deleteId").val()},
					function(json) {
						$("#userListTable tr:not(:first)").remove();
						
						var str= "";
						for(var i=0; i< json.jsonArray.length; i++) {
							str+= "<tr><td>"+ json.jsonArray[i].id+ "</td>";
							str+= "<td>"+ json.jsonArray[i].username+ "</td>";
							str+= "<td>"+ json.jsonArray[i].password+ "</td>";
							str+= "<td>"+ json.jsonArray[i].createTime+ "</td>";
							str+= "<td>"+ json.jsonArray[i].userType+ "</td>";
							str+= "<td><a href='${pageContext.request.contextPath }/user/bCreateView?id="+ json.jsonArray[i].id + "' target='_blank'>modify</a>&nbsp;"
									+ "<a href='javascript:;' onclick=del('"+ json.jsonArray[i].id+ "')>delete</a></td></tr>";
						}
						$("#userListTable").append(str);
						$("#currentPageId").val(json.currentPage);
						$("#maxPageId").val(json.maxPage);
					});
  	}
  	function del(o) {
  		$("#deleteId").val(o);
  		xmlPage(0);
  	}
  </script>
  </head>
  <body>
	<section>
		<div>
			<select id="orderByUserTypeId" name="orderByUserType">
				<option value="0">按创建时间</option>
				<option value="1">按用户类型</option>
			</select>
			<select id="orderId" name="order">
				<option value="0">倒序排序</option>
				<option value="1">顺序排序</option>
			</select>
			<select id="userTypeId" name="userType">
				<option value="">检索用户类型</option>
				<c:forEach var="list" items="${userTypeList }">
					<option value="${list }">${list }</option>
				</c:forEach>
			</select>
			<input type="text" id="usernameId" maxlength="20" placeholder="用户名" name="username" />
			<select id="isVagueId" name="isVague">
				<option value="0">精确</option>
				<option value="1">模糊</option>
			</select>
			<input type="button" value="排序或检索" onclick="xmlPage(0)" />
		</div>
	</section>
	
	<hr>
	
  	<section>
		<table class="tableList" id="userListTable">
			<tr>
				<th>id</th>
				<th>username</th>
				<th>password</th>
				<th>createTime</th>
				<th>userType</th>
				<th>Operation&nbsp;<a href="${pageContext.request.contextPath }/user/bCreateView" target="_blank">create</a>
				</th>
			</tr>
			<c:forEach var="list" items="${userList }">
				<tr>
					<td>${list.id }</td>
					<td>${list.username }</td>
					<td>${list.password }</td>
					<td><fmt:formatDate value="${list.createTime }" type="date" pattern="yyyy-MM-dd" /></td>
					<td>${list.category.userType }</td>
					<td>
					<a href="${pageContext.request.contextPath }/user/bCreateView?id=${list.id }" target="_blank">modify</a>
					<a href="javascript:;" onclick="del('${list.id}')">delete</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<jsp:include page="/WEB-INF/page/background/main/page.jsp"></jsp:include>
	</section>
	<section>
		<input type="hidden" id="deleteId" value="" />
	</section>
  </body>
</html>

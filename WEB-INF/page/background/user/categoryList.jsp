<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>categoryList</title>
    <meta charset="utf-8">
  	<script type="text/javascript">
  	function xmlPage(n) {
  		var cp= calcCurrentPage(n);
  		$.post("${pageContext.request.contextPath}/category/bListXml"
  				, {currentPage: cp
  				, step: $("#stepId").val()
  				, id: $("#deleteId").val()}
  				, function(data) {
				  	var args= data.substring(data.indexOf("<Args>", 0)+6, data.length).split("#");
				  	data= data.substring(0, data.indexOf("<Args>", 0)-1);
					$("#categoryListTable tr:not(:first)").remove();
					$("#categoryListTable").append(data);
					$("#currentPageId").val(args[0]);
					$("#maxPageId").val(args[1]);
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
		<table class="tableList" id="categoryListTable">
			<tr>
				<th>uuid</th>
				<th>userType</th>
				<th>operation&nbsp;
				<a href="${pageContext.request.contextPath }/category/bCreateView">create</a>
				</th>
			</tr>
			<c:forEach var="list" items="${categoryList }" varStatus="status">
			<tr>
				<td>${list.id }</td>
				<td>${list.userType }</td>
				<td>
				<a href="${pageContext.request.contextPath }/category/bCreateView?id=${list.id }">modify</a>
				<a href="javascript:del('${list.id}')">delete</a>
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

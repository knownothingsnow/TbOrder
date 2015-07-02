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
<title>Product</title>
<meta charset="UTF-8">
  </head>
  <body>
	<div class="container-fluid">
		<div class="row">
	        <div class="col-md-12 col-lg-12 page-header">
	        <h1 id="header-of-page">商品类别检索<small>&nbsp;&nbsp;
			<select name="kind" id="kindId" onchange="xmlPage(0)">
				<option value="">商品分类</option>
				<c:forEach items="${assortmentList }" var="list">
					<option value="${list.kind }">${list.kind }</option>
				</c:forEach>
			</select></small></h1>
			</div>
	
  	<!-- 设置内边距，将表格实现缩进 -->
  	<section style="padding:0 50px;">
		<table class="table table-hover table-striped" id="productListTable">
			<tr>
				<th>商品名称</th>
				<th>类别</th>
				<th>Operation</th>
			</tr>
			
			<c:forEach items="${productList }" var="list">
				<tr>
					<td>${list.name }</td>
					<td>${list.productAssortment.kind }</td>
					<td>
					<a href="product/bCreateView?id=${list.id }" target="_blank" class="btn btn-default" >modify</a>
					<a href="javascript:;" onclick="del('${list.id}')" class="btn btn-default" >delete</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<jsp:include page="/WEB-INF/page/background/main/page.jsp"></jsp:include>
	</section>
	<!-- hidden -->
	<section>
		<input type="hidden" id="deleteId" value="" />
	</section>
	<!-- mustache -->
	<section>
		<table id="productListTableMustache" style="display: none;">
		<tr>
			<td>{{name }}</td>
			<td>{{kind }}</td>
			<td>
			<a href="product/bCreateView?id={{id }}" target="_blank" class="btn btn-default" >modify</a>
			<a href="javascript:;" onclick="del('{{id}}')" class="btn btn-default" >delete</a>
			</td>
		</tr>
		</table>
	</section>
	</div>
	</div>
  <script type="text/javascript" src="js/background/product-productList.js"></script>
</body>
</html>
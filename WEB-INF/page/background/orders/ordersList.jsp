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
  </head>
  <body>
	<div class="container-fluid">
		<div class="row">
        <div class="col-md-12 col-lg-12 page-header">
        <h1 id="header-of-page">订单列表<small>&nbsp;&nbsp;
        <!-- class="form-control" -->
		<select id="stateId" name="state" onchange="xmlPage(0)">
			<option value="">订单状态</option>
			<option value="待分发">待分发</option>
			<option value="正在设计">正在设计</option>
			<option value="待确认">待确认</option>
			<option value="待加工">待加工</option>
			<option value="正在加工">正在加工</option>
			<option value="已发货">已发货</option>
			<option value="交易完成">交易完成</option>
			<option value="撤单">撤单</option>
			<option value="已删除">已删除</option>
		</select>
		
		<select id="priorityId" name="priority" onchange="xmlPage(0)">
			<option value="">优先级</option>
			<option value="普通">普通</option>
			<option value="加急">加急</option>
		</select>
		
		<select id="kindId" name="kind" onchange="toProduct()" >
			<option value="">商品分类</option>
			<c:forEach items="${productAssortmentList }" var="productAssortmentList">
				<option>${productAssortmentList.kind }</option>
			</c:forEach>
		</select>
		
		<select id="nameId" name="name" onchange="toColor()" disabled="disabled" >
			<option value="">商品名称</option>
		</select>

		<select id="colorId" name="color" disabled="disabled" onchange="xmlPage(0)">
			<option value="">颜色分类</option>
		</select>

		<select id="orderId" name="order" onchange="xmlPage(0)">
			<option value="0">倒序排序</option>
			<option value="1">顺序排序</option>
		</select></small></h1>
		</div></div>
	
  	<section>
		<table class="table table-hover table-striped" id="ordersListTable">
			<tr>
<!-- 				<th>商品名称</th> -->
				<th>订单号</th>
<!-- 				<th>淘宝账号</th> -->
				<th>优先级</th>
				<th>状态</th>
				<th>类型</th>
				<th>颜色</th>
				<th>customerPicture</th>
				<th>designPicture</th>
<!-- 				<th>买家手机</th> -->
<!-- 				<th>姓名</th> -->
				<th>录入时间</th>
				<th>Operation</th>
			</tr>
			<c:forEach var="list" items="${ordersList }">
				<tr>
<!-- 					<td>${list.name }</td> -->
					<td>${list.tbNumber }</td>
<!-- 					<td>${list.tbUsername }</td> -->
					<td>${list.priority }</td>
					<td>${list.state }</td>
					<td>${list.kind }</td>
					<td>${list.color }</td>
					<td><img src="file/${list.customerPicture }" width="120" height="80" /></td>
					<td><img src="file/${list.designPicture }" width="120" height="80" /></td>
<!-- 					<td>${list.phone }</td> -->
<!-- 					<td>${list.username }</td> -->
					<td><fmt:formatDate value="${list.createTime }" type="date" pattern="yyyy-MM-dd" /></td>
					<td>
					<a href="orders/bcreateView?id=${list.id }" target="_blank" class="btn btn-default" >modify</a>
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
	<!-- mustache -->
	<section>
		<table id="ordersListTableMustache" style="display: none;">
		<tr>
<!-- 			<td>{{name }}</td> -->
			<td>{{tbNumber }}</td>
<!-- 			<td>{{tbUsername }}</td> -->
			<td>{{priority }}</td>
			<td>{{state }}</td>
			<td>{{color }}</td>
			<td><img src="file/{{customerPicture }}" width="120" height="80" /></td>
			<td><img src="file/{{designPicture }}" width="120" height="80" /></td>
			<td>{{kind }}</td>
<!-- 			<td>{{phone }}</td> -->
<!-- 			<td>{{username }}</td> -->
			<td>{{createTime }}</td>
			<td>
			<a href="orders/bcreateView?id={{id }}" target="_blank" class="btn btn-default" >modify</a>
			<a href="javascript:;" onclick="del('{{id}}')" class="btn btn-default" >delete</a>
			</td>
		</tr>
		</table>
	</section>
	</div>
  <script type="text/javascript" src="js/background/orders-ordersList.js"></script>
  </body>
</html>

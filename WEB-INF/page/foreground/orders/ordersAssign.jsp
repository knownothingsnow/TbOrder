<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title></title>
<meta charset="UTF-8">
<script type="text/javascript">
	function xmlPage(n) {
		var cp= calcCurrentPage(n);
		$.getJSON("orders/listXml",
  				{currentPage: cp
					, step: $("#stepId").val()
					, id: $("#deleteId").val()
					, priority: $("#priorityId").val()
					, kind: $("#kindId").val()
					, name: nameI
					, color: $("#colorId").val()
					, od: $("#orderId").val() },
				function(json) {
					$("#ordersListTable").find("li").remove();

					var str= "";
					for(var i=0; i< json.jsonArray.length; i++) {
						str+= "<li class='list-group-item list-group-item-info'>";
						str+= "<h4><strong>淘宝订单编号:</strong>"+ json.jsonArray[i].tbNumber+ "<strong>&nbsp;状态:</strong>"+ json.jsonArray[i].state+ "</h4>";
						str+= "<p><strong>买家淘宝用户名:</strong>"+ json.jsonArray[i].tbUsername+ "</p>";
						str+= "<p><strong>优先级:</strong>"+ json.jsonArray[i].priority+ "</p>";
						str+= "<p><strong>类型:</strong>"+ json.jsonArray[i].kind+ "</p>";
						str+= "<p><strong>商品名:</strong>"+ json.jsonArray[i].name+ "</p>";
						str+= "<p><strong>颜色:</strong>"+ json.jsonArray[i].color+ "</p>";
						str+= "<p><strong>录入时间:</strong>"+ json.jsonArray[i].createTime+ "</p>";
						str+= "<p><strong>收货人:</strong>"+ json.jsonArray[i].username+ "</p>";
						str+= "<p><strong>电话:</strong>"+ json.jsonArray[i].phone+ "</p>";
						
						str+= "<div class='btn-group btn-icno'  role='group'>"
				                + "<button type='button' class='btn btn-default' title='详细信息' onclick=toDetail('"+ json.jsonArray[i].id + "')><i class='icon-list-ul icon-2x'></i></button>"
				                + "<div></li>";
					}
					$("#ordersListTable").append(str);
					$("#currentPageId").val(json.currentPage);
					$("#maxPageId").val(json.maxPage);
				});
	}
function toDetail(o) {
	window.open("orders/createView?id="+ o);
}
</script>
</head>
<body>
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-12 col-lg-12 page-header">
          <h1 id="header-of-page">特定订单列表<small>没有其他查询方式!</small></h1>
        </div>
      </div>
      <div class="row">
        <div class="col-md-9 col-lg-10">
          <ul class="list-group">
			<c:forEach var="list" items="${ordersList }">
            <li class="list-group-item list-group-item-info">
              <h4><strong>淘宝订单编号:</strong>${list.tbNumber }<strong>&nbsp;状态:</strong>${list.state }</h4>
              <p><strong>买家淘宝用户名:</strong>${list.tbUsername }</p>
              <p><strong>优先级:</strong><c:if test="${list.priority== 1 }">普通</c:if><c:if test="${list.priority== 2 }">加急</c:if> </p>
              
              <p><strong>类型:</strong>${list.kind }</p>
              <p><strong>商品名:</strong>${list.name }</p>
              <p><strong>颜色:</strong>${list.color }</p>
              
              <p><strong>录入时间:</strong><fmt:formatDate value="${list.createTime }" type="date" pattern="yyyy-MM-dd" /></p>
              <p><strong>收货人:</strong>${list.username }</p>
              <p><strong>电话:</strong>${list.phone }</p>
              <div class="btn-group btn-icno"  role="group">
                <button type="button" class="btn btn-default" title="详细信息" onclick="toDetail('${list.id }')"><i class="icon-list-ul icon-2x"></i></button>
              </div>
            </li>             
            </c:forEach>
          </ul>
        </div>
      </div>
		<jsp:include page="/WEB-INF/page/background/main/page.jsp"></jsp:include>
    </div>

</body>
</html>

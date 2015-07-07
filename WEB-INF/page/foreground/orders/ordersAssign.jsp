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
</head>
<body>
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-12 col-lg-12 page-header">
          <h1 id="header-of-page">特定订单列表</h1>
        </div>
      </div>
      <div class="row">
        <div class="col-md-9 col-lg-10">
          <ul class="list-group" id="ordersListTable">
			<c:forEach var="list" items="${ordersList }">
            <li class="list-group-item list-group-item-default">
              <h4><strong>淘宝订单编号:</strong>${list.tbNumber }<strong>&nbsp;状态:</strong>${list.state }</h4>
              <p><strong>买家淘宝用户名:</strong>${list.tbUsername }</p>
              <p><strong>优先级:</strong>${list.priority }</p>
              
              <p><strong>类型:</strong>${list.kind }</p>
              <p><strong>商品名:</strong>${list.name }</p>
              <p><strong>颜色:</strong>${list.color }</p>
              <br/>
              <p><strong>录入时间:</strong>${list.createTime }</p>
              <p><strong>收货人:</strong>${list.username }</p>
              <p><strong>电话:</strong>${list.phone }</p>
              <div class="btn-group btn-icno"  role="group">
              	<c:if test="${not empty sessionScope.process }">
              		<button id="toDesignId" type="button" class="btn btn-default" title="已发货" onclick="toDesign('${list.id }')">
                        <i class="icon-plus-sign-alt icon-2x"></i>
                    </button>
              	</c:if>
                    <button type="button" class="btn btn-default" title="详细信息" onclick="toDetail('${list.id }')">
                        <i class="icon-cog icon-2x"></i>
                    </button>
              </div>
            </li>             
            </c:forEach>
          </ul>
        </div>
      </div>
		<jsp:include page="/WEB-INF/page/foreground/main/page.jsp"></jsp:include>
    </div>
    
	<!-- mustache -->
    <section>    
		<ul id="ordersListTableMustache" style="display: none;">
           <li class="list-group-item list-group-item-default">
             <h4><strong>淘宝订单编号:</strong>{{tbNumber }}<strong>&nbsp;状态:</strong>{{state }}</h4>
             <p><strong>买家淘宝用户名:</strong>{{tbUsername }}</p>
             <p><strong>优先级:</strong>{{priority }}</p>
             
             <p><strong>类型:</strong>{{kind }}</p>
             <p><strong>商品名:</strong>{{name }}</p>
             <p><strong>颜色:</strong>{{color }}</p>
             
             <p><strong>录入时间:</strong>{{createTime }}</p>
             <p><strong>收货人:</strong>{{username }}</p>
             <p><strong>电话:</strong>{{phone }}</p>
             <div class="btn-group btn-icno"  role="group">
             	<c:if test="${not empty sessionScope.process }">
                <button id="toDesignId" type="button" class="btn btn-default" title="已发货" onclick="toDesign('{{id }}')"><i class="icon-plus-sign-alt icon-2x"></i></button>
             	</c:if>
                <button type="button" class="btn btn-default" title="详细信息" onclick="toDetail('{{id }}')"><i class="icon-cog icon-2x"></i></button>
             </div>
           </li>             
         </ul>
	</section>

	<section>
		<input type="hidden" value="${state }" name="state" id="stateId"/>
	</section>
<script type="text/javascript" src="js/foreground/orders-ordersAssign.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var me= "${message}";
        if(me== "delete") {
            $("#header-of-page").text("回收站");
            $("#toDesignId").css("display", "none");
        } else if(me== "design") {
            $("#header-of-page").text("正在设计");
        } else if(me== "process") {
            $("#header-of-page").text("正在加工");
        }
    });
</script>
</body>
</html>

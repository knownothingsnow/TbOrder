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
    
    <style type="text/css">
	#selectGroupDiv select {
		margin-bottom: 10px;
	}
	</style>
	
  </head>
  <body>
	<div class="container-fluid">
		<div class="row">
		  <div class="col-md-12 col-lg-12 page-header">
		    <h1 id="header-of-page">订单列表</h1>
		  </div>
		</div>
	
     <div class="row">
       <div class="col-md-9 col-lg-10">
         <ul class="list-group" id="ordersListTable"><!-- 七种颜色代表七种订单状态 -->
         <!-- default/danger/primary/info/info/success/warning/warning/warning 总共找到6中颜色值-->
         <!-- 1待分发、2正在设计、3待确认、4待加工、5正在加工、6已发货、7交易完成、8撤单、-1已删除 -->
         
			<!-- file/${list.customerPicture }${list.designPicture } -->
			
			<c:forEach var="list" items="${ordersList }">
			
			
			<c:if test="${list.state=='待分发' }"><li class="list-group-item list-group-item-default"></c:if>
			<c:if test="${list.state=='正在设计' }"><li class="list-group-item list-group-item-danger"></c:if>
			<c:if test="${list.state=='待确认' }"><li class="list-group-item list-group-item-primary"></c:if>
			<c:if test="${list.state=='待加工' }"><li class="list-group-item list-group-item-info"></c:if>
			<c:if test="${list.state=='正在加工' }"><li class="list-group-item list-group-item-state1"></c:if>
			<c:if test="${list.state=='已发货' }"><li class="list-group-item list-group-item-success"></c:if>
			<c:if test="${list.state=='交易完成' }"><li class="list-group-item list-group-item-warning"></c:if>
			<c:if test="${list.state=='撤单' }"><li class="list-group-item list-group-item-state2"></c:if>
			<c:if test="${list.state=='已删除' }"><li class="list-group-item list-group-item-state3"></c:if>
            
            
              <h4><strong>淘宝订单编号:</strong>${list.tbNumber }<strong>&nbsp;状态:</strong>${list.state }</h4>
              <p><strong>买家淘宝用户名:</strong>${list.tbUsername }</p>
              <p><strong>优先级:</strong>${list.priority }</p>
              
              <p><strong>类型:</strong>${list.kind }</p>
              <p><strong>商品名:</strong>${list.name }</p>
              <p><strong>颜色:</strong>${list.color }</p>
              <br />
<!--          <p><strong>录入时间:</strong><fmt:formatDate value="${list.createTime }" type="date" pattern="yyyy-MM-dd" /></p> -->
			  <p><strong>录入时间:</strong>${list.createTime }</p>
              <p><strong>收货人:</strong>${list.username }</p>
              <p><strong>电话:</strong>${list.phone }</p>
              <div class="btn-group btn-icon"  role="group">
                <button type="button" class="btn btn-default" title="设计订单" onclick="toDesign('${list.id}', '${list.state }')"><i class="icon-plus-sign-alt icon-2x"></i></button>
                <button type="button" class="btn btn-default" title="详细信息" onclick="toDetail('${list.id }')"><i class="icon-cog icon-2x"></i></button>
                <button type="button" class="btn btn-default" title="撤销订单" onclick="del('${list.id}')"><i class="icon-share-alt icon-2x"></i></button>
              </div>
            </li>
            
            </c:forEach>          
            <!-- 
            <div class="alert alert-danger alert-dismissible fade in" role="alert">
              <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
              <h5>警告!</h5>
              <p>你确定要删除此订单吗?一旦撤销订单就会作废,请联系管理员恢复.</p>
              <button type="button" class="btn btn-danger">撤销订单</button>
              <button type="button" class="btn btn-default">取消操作</button>
            </div>
             -->
		</ul>
		
		<jsp:include page="/WEB-INF/page/foreground/main/page.jsp"></jsp:include>
		<!-- hidden -->
		<section>
			<input type="hidden" id="deleteId" value="" />
		</section>
		
		<!-- mustache -->
		<section>
			<ul id="ordersListTableMustache" style="display: none;">
            <li class="{{class}}">
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
                <button type="button" class="btn btn-default" title="设计订单" class="hoverTitle" onclick="toDesign('{{id }}', '{{state }}')"><i class="icon-plus-sign-alt icon-2x"></i></button>
                <button type="button" class="btn btn-default" title="详细信息" onclick="toDetail('{{id }}')"><i class="icon-cog icon-2x"></i></button>
                <button type="button" class="btn btn-default" title="撤销订单" onclick="del('{{id}}')"><i class="icon-share-alt icon-2x"></i></button>
              </div>
            </li>
			</ul>
		</section>
    	</div>
    	
        <div class="col-md-3 col-lg-2" id="selectGroupDiv">
			<select id="stateId" name="state" onchange="xmlPage(0)" class="col-md-2 form-control">
				<option value="">订单状态</option>
				<option>待分发</option>
				<option>正在设计</option>
				<option>待确认</option>
				<option>待加工</option>
				<option>正在加工</option>
				<option>已发货</option>
				<option>交易完成</option>
				<option>撤单</option>
				<option>已删除</option>
			</select>
	          
			<select id="priorityId" name="priority" onchange="xmlPage(0)" class="col-md-2 form-control">
				<option value="">优先级</option>
				<option>普通</option>
				<option>加急</option>
			</select>
	          
			<select id="kindId" name="kind" onchange="toProduct()" class="col-md-2 form-control">
				<option value="">商品分类</option>
				<c:forEach items="${productAssortmentList }" var="productAssortmentList">
					<option>${productAssortmentList.kind }</option>
				</c:forEach>
			</select>
			<select id="nameId" name="name" onchange="toColor()" disabled="disabled" class="col-md-2 form-control">
				<option value="">商品名称</option>
			</select>
			<select id="colorId" name="color" disabled="disabled" onchange="xmlPage(0)" class="col-md-2 form-control">
				<option value="">颜色分类</option>
			</select>
	          
			<select id="orderId" name="od" onchange="xmlPage(0)" class="col-md-2 form-control">
				<option value="0">倒序排序</option>
				<option value="1">顺序排序</option>
			</select>
		</div>
	</div><!--row end-->
  </div><!-- container-fluid end -->
  <script type="text/javascript" src="js/foreground/orders-ordersList.js"></script>
  <script type="text/javascript">
	//$(document).ready(function(){
	window.onload= function() {
		// 预选择加载
		var pro= "${sessionScope.process }";
		var cus= "${sessionScope.customer }";
		if(pro!= "") {
			$("#stateId option:contains('待加工')").attr("selected", true);
			$("#stateId").change();
		} else if(cus!= "") {
			$("#stateId option:contains('待分发')").attr("selected", true);
			$("#stateId").change();
		}
	};
  </script>
  </body>
</html>

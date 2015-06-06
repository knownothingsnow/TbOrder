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
  		var nameI= "";
  		if($("#nameId").val()!= "") {
  			nameI= $("#nameId :selected").text();
  		}
  		var cp= calcCurrentPage(n);
  		$.getJSON("orders/listXml",
	  				{currentPage: cp
						, step: $("#stepId").val()
						, id: $("#deleteId").val()
						, state: $("#stateId").val()
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
									+ "<button type='button' class='btn btn-default' title='设计订单' onclick=toDesign('"+ json.jsonArray[i].id + "')><i class='icon-plus-sign-alt icon-2x'></i></button>"
					                + "<button type='button' class='btn btn-default' title='详细信息' onclick=toDetail('"+ json.jsonArray[i].id + "')><i class='icon-list-ul icon-2x'></i></button>"
					                + "<button type='button' class='btn btn-default' title='撤销订单' onclick=     del('"+ json.jsonArray[i].id + "')><i class='icon-share-alt icon-2x'></i></button>"
					                + "<div></li>";
						}
						$("#ordersListTable").append(str);
						$("#currentPageId").val(json.currentPage);
						$("#maxPageId").val(json.maxPage);
					});
  	}
  	function del(o) {
  		if(confirm("确认要撤销？")) {
	  		$("#deleteId").val(o);
	  		xmlPage(0);
  		}
  	}
  	function toProduct() {
		$("#nameId option:first").attr("selected", true);
  		$("#colorId option:first").attr("selected", true);
  		xmlPage(0);
  		
  		if($("#kindId").val()== "") {
			$("#nameId option:not(:first)").remove();
			$("#nameId").attr("disabled", true);
  		}
  		$("#colorId option:not(:first)").remove();
		$("#colorId").attr("disabled", true);  	
  		
  		$.getJSON("orders/productList", 
  				{ kind: $("#kindId").val() }, 
  				function(json) {
  					$("#nameId").attr("disabled", false);
  					$("#nameId option:not(:first)").remove();
  					
  					var str= "";
  					for(var i=0; i<json.jsonArray.length; i++) {
  						str+= "<option value='"+ json.jsonArray[i].id+ "'>"+ json.jsonArray[i].name+ "</option>";
  					}
  					$("#nameId").append(str);
  				});
  	}
  	function toColor() {
  		$("#colorId option:first").attr("selected", true);
  		xmlPage(0);
  		
  		if($("#nameId").val()== "") {
	  		$("#colorId option:not(:first)").remove();
  			$("#colorId").attr("disabled", true);
  		}
  		
  		$.getJSON("orders/colorAssortmentList", 
  				{ productId: $("#nameId :selected").val() },
				function(json) {
  		  			$("#colorId").attr("disabled", false);
  		  			$("#colorId option:not(:first)").remove();
  		  			
					var str= "";
					for(var i=0; i< json.jsonArray.length; i++) {
						str+= "<option>"+ json.jsonArray[i].color+ "</option>";
					}
					$("#colorId").append(str);
				});
  	}
  	
  	function toDetail(o) {
  		window.open("orders/createView?id="+ o);
  	}
  	function toDesign(o) {
  		$.getJSON("orders/toDesign",
  				{id: o}, 
  				function(json) {
  					alert(json.message);
  				});
  	}
  </script>
  </head>
  <body>
	<div class="container-fluid">
		<div class="row">
		  <div class="col-md-12 col-lg-12 page-header">
		    <h1 id="header-of-page">订单检索
		    	<small>
				<select id="stateId" name="state" onchange="xmlPage(0)">
					<option value="0">订单状态</option>
					<option value="1">待分发</option>
					<option value="2">正在设计</option>
					<option value="3">待确认</option>
					<option value="4">待加工</option>
					<option value="5">正在加工</option>
					<option value="6">已发货</option>
					<option value="7">交易完成</option>
					<option value="8">撤单</option>
					<option value="-1">已删除</option>
				</select>
		          
				<select id="priorityId" name="priority" onchange="xmlPage(0)">
					<option value="0">优先级</option>
					<option value="1">普通</option>
					<option value="2">加急</option>
				</select>
		          
				<select id="kindId" name="kind" onchange="toProduct()">
					<option value="">商品分类</option>
					<c:forEach items="${productAssortmentList }" var="productAssortmentList">
						<option>${productAssortmentList.kind }</option>
					</c:forEach>
				</select>
				<select id="nameId" name="name" onchange="toColor()" disabled="disabled">
					<option value="">商品名称</option>
				</select>
				<select id="colorId" name="color" disabled="disabled" onchange="xmlPage(0)">
					<option value="">颜色分类</option>
				</select>
		          
				<select id="orderId" name="od" onchange="xmlPage(0)">
					<option value="0">倒序排序</option>
					<option value="1">顺序排序</option>
				</select>
				</small></h1>
		  </div>
		</div><!--row1 end-->
	
	
     <div class="row">
       <div class="col-md-9 col-lg-10">
         <ul class="list-group" id="ordersListTable"><!-- 七种颜色代表七种订单状态 -->
         
			<!-- file/${list.customerPicture }${list.designPicture } -->
			
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
                <button type="button" class="btn btn-default" title="设计订单" onclick="toDesign('${list.id}')"><i class="icon-plus-sign-alt icon-2x"></i></button>
                <button type="button" class="btn btn-default" title="详细信息" onclick="toDetail('${list.id }')"><i class="icon-list-ul icon-2x"></i></button>
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
		<jsp:include page="/WEB-INF/page/background/main/page.jsp"></jsp:include>
		<section>
			<input type="hidden" id="deleteId" value="" />
		</section>
    	</div>
	</div>
  </div>
  </body>
</html>

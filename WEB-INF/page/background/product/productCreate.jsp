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
<title>Product</title>
<meta charset="utf-8" >
<style type="text/css">
#colorId li {
	float: left;
}
</style>
</head>
<body>
    <div class="container-fluid" id="page-wrapper">
      <div class="row">
          <div class="col-md-12 page-header">
			<s:if test="#request.product==null">
				<h1>商品创建</h1>
			</s:if>
			<s:else>
				<h1>商品修改</h1>
			</s:else>
			</div>

        <div class="col-md-12 form-cent" style="text-align: center;">		
        <form action="product/bCreate"
		onsubmit="return checkForm()" method="post" enctype="multipart/form-data" class="form-horizontal" >

            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">商品名称</label>
              <div class="col-sm-3">
			<input type="text" value="${product.name }" name="product.name" required="required" placeholder="商品名称" 
				onblur="xmlCheck()" id="nameId" autofocus="autofocus" class="form-control"/></div>
              <div class="col-sm-3">
			<select name="kindId" class="form-control">
				<option value="0">商品类别</option>
				<c:forEach items="${assortmentList }" var="aList">
					<option value="${aList.id }" ${aList.id== product.productAssortment.id ? 'selected': '' }  >${aList.kind }</option>
				</c:forEach>
			</select></div></div>
			
			<!-- 创建商品去掉颜色添加 -->
			<s:if test="#request.product!= null">
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">颜色分类</label>
              <div class="col-sm-11">
			<ul id="colorId" style="list-style: none;">
			<c:forEach items="${colorList }" var="cList">
				<li><a href="javascript:;" onclick="colorUpdate(this, '${cList.id }')">${cList.color }${cList.price }&nbsp;&nbsp;</a></li>
			</c:forEach>
			</ul></div></div>
			
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">添加颜色</label>
              <div class="col-sm-3">			
			<input type="text" id="colorText" placeholder="颜色" class="form-control"/></div>
              <div class="col-sm-3">			
			<input type="number" id="priceText"  placeholder="单价" class="form-control"/></div>
              <div class="col-sm-3">
			<input type="button" onclick="colorUpdate(null, 0)" value="添加"  class="form-control"/></div></div>
			</s:if>
			
			<input type="hidden" value="${product.id }" name="product.id" id="productId"/>
			<input type="hidden" value="${product.productAssortment.id }" name="product.productAssortment.id" />
			<input type="submit" value="保存" class="btn btn-success btn-lg"/>
			<input type="button" onclick="javascript:window.opener=null;window.open('','_self');window.close();" value="关闭"  class="btn btn-success btn-lg" />
		</form>
		</div>
	</div>
	</div>
<script type="text/javascript" src="js/background/product-productCreate.js"></script>
</body>
</html>

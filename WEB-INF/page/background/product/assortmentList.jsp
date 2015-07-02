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
<title>ProductAssortment</title>
<meta charset="UTF-8">
<style type="text/css">
#kindId li {
	float: left;
}
</style>
</head>
<body>
    <div class="container-fluid" id="page-wrapper">
      <div class="row">
          <div class="col-md-12 page-header">
			<h1>商品类别创建</h1>
		  </div>

        <div class="col-md-12 form-cent" style="text-align: center;">
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">商品分类</label>
              <div class="col-sm-11">
			<ul id="kindId" style="list-style: none;">
			<c:forEach items="${kindList }" var="list">
				<li><a href="javascript:;" onclick="kindUpdate(this, '${list.id }')">${list.kind }&nbsp;&nbsp;</a></li>
			</c:forEach>
			</ul></div></div>
			
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">添加类别</label>
              <div class="col-sm-3">			
			<input type="text" id="kindText" placeholder="类别" class="form-control"/></div>
              <div class="col-sm-3">
			<input type="button" onclick="kindUpdate(null, 0)" value="添加"  class="form-control"/></div></div>
		</div>
	</div>
</div>
<script type="text/javascript" src="js/background/product-assortmentList.js"></script>
</body>
</html>

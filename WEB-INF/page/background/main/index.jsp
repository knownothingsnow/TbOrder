<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	String backMainPage= (String) request.getAttribute("backMainPage");
	if(backMainPage== null || backMainPage.isEmpty()) {
		backMainPage= "/WEB-INF/page/background/main/main.jsp";
	}
%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title>TbOrderBackground</title>
<meta charset="UTF-8">
<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/index.css">
<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">

<!-- xh -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/common.css">

<script type="text/javascript" src="${pageContext.request.contextPath }/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/uploadPreview.min.js"></script>


<script type="text/javascript">
window.onload= function() {
	new uploadPreview({ UpBtn: "customerPictureId", DivShow: "imgdiv1", ImgShow: "customerPictureShow" });
	new uploadPreview({ UpBtn: "designPictureId", DivShow: "imgdiv2", ImgShow: "designPictureShow" });
};
function xhClick(o) {
	o.click();
}
</script>

</head>
<body>	
	<nav class="navbar navbar-default navbar-fixed-top navbar-inverse">
	  <div class="container-fluid" id="container-fluid-nav">
	    <div class="navbar-header">
	      <a class="navbar-brand" href="admin/bAdminCreateView">${sessionScope.admin.username }</a>
	    </div>
	    <div class="collapse navbar-collapse">
	      <ul class="nav navbar-nav navbar-right">
	        <li><a href="admin/bAdminLoginout">注销</a></li>
	      </ul>
	    </div>
	  </div>
	</nav>
    <div class="collapse navbar-collapse navbar-ex1-collapse">
      <ul class="nav side-nav try">
            <li>
              <a href="javascript:;" data-toggle="collapse" data-target="#User" onmouseover="xhClick(this)">账户管理</a>
              <ul id="User" class="collapse">
                <li id="user" class="active"><a href="customerService/bList" class="mid">客服</a></li>
                <li id="user" class="active"><a href="processStaff/bList" class="mid">加工部</a></li>
                <li><a href="customerService/bCreateView" class="mid">添加客服人员</a></li>
                <li><a href="processStaff/bCreateView" class="mid">添加加工人员</a></li>
              </ul>
            </li>

            <li>
              <a href="javascript:;" data-toggle="collapse" data-target="#Commodity" onmouseover="xhClick(this)">商品管理</a>
              <ul id="Commodity" class="collapse">
                <li><a href="productAssortment/bList" class="mid">商品分类</a></li>
                <li><a href="product/bList" class="mid">商品</a></li>
                <li><a href="product/bCreateView" class="mid">添加新商品</a></li>
              </ul>
            </li>

            <li>
              <a href="javascript:;" data-toggle="collapse" data-target="#Order" onmouseover="xhClick(this)">订单管理</a>
              <ul id="Order" class="collapse">
                <li><a href="orders/blist" class="mid">订单浏览</a></li>
                <li><a href="orders/bcreateView" class="mid">订单录入</a></li>
              </ul>
            </li>
      </ul>
  </div>
	
	<div class="content">
		<jsp:include page="<%=backMainPage %>"></jsp:include>
	</div>
</body>
</html>

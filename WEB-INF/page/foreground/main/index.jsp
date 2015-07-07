<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	String MainPage= (String) request.getAttribute("MainPage");
	if(MainPage== null || MainPage.isEmpty()) {
		MainPage= "/WEB-INF/page/foreground/main/main.jsp";
	}
%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<head>
    <base href="<%=basePath%>">
    <title>TbOrderForeground</title>
    <meta charset="UTF-8">

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">


    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <link rel="stylesheet" type="text/css" href="css/pagination.css"/>

    <!-- xiaohong -->
    <link rel="stylesheet" type="text/css" href="css/common.css">

</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top navbar-inverse">
	    <div class="container-fluid" id="container-fluid-nav">
	        <div class="navbar-header">
	            <span class="navbar-brand">Lemon</span>
	        </div>
	        <div class="collapse navbar-collapse">
	            <ul class="nav navbar-nav navbar-right">
	                <li><a class="navbar-brand"href="customerService/customerLoginout">注销</a></li>
	                <li><a class="navbar-brand" href="customerService/updateView">${sessionScope.user }</a></li>
	            </ul>
	        </div>
	    </div>
	</nav>

	<div class="wrapper">
	  <div class="side-nav">
	    <ul>
	      <li><a href="orders/list">浏览订单</a></li>

	      <li><a href="orders/assignOrders">
		      <c:if test="${empty sessionScope.process }">设计订单</c:if>
		      <c:if test="${not empty sessionScope.process }">制作订单</c:if>
	      </a></li>

	      <c:if test="${empty sessionScope.process }">
		      <li><a href="orders/createView">录入订单</a></li>
		      <li><a href="orders/assignOrders?state=已删除">回收站</a></li>
	      </c:if>
	    </ul>
	  </div><!--side-nav end-->
	  <div class="content">
		<jsp:include page="<%=MainPage %>"></jsp:include>
	  </div><!--content end-->
	</div><!--wrapper end-->


    <!-- xiaohong -->
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="js/mustache.js"></script>
</body>


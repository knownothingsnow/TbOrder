<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<div id="pageDiv">
	<input type="button" value="首页" onclick="xmlPage(0)" class="btn btn-success btn-lg"/>
	<input type="button" value="上一页" onclick="xmlPage(-1)"  class="btn btn-success"/>
	
	<span>当前页aaaaa
	<input type="text" id="currentPageId" name="currentPage" value="${currentPage }" readonly="readonly"   /></span>
	
	<input type="button" value="下一页" onclick="xmlPage(1)"  class="btn btn-success"/>
	<input type="button" value="末页" onclick="xmlPage(2)"  class="btn btn-success btn-lg"/>
	
	<br>
	<input type="button" value="跳转" onclick="xmlPage(3)"  class="btn btn-info"/>
	<input type="number" id="jumpPageId" name="currentPage" placeholder="跳转到第几页"  />
	<span>总页数
	<input type="text" id="maxPageId" name="maxPage" value="${maxPage }" readonly="readonly"  /></span>
	<span>每页显示条数
	<input type="text" id="stepId" name="step" value="${step }"  /></span>
	<input type="button" value="显示" onclick="xmlPage(4)"  class="btn btn-info"/>
</div>

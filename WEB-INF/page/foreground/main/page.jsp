<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <title>分页按钮</title>
</head>
<body>
<div id="pageDiv"> <!--  style=" padding:25px;  text-align: center; " -->
	<input type="button" value="首页" onclick="xmlPage(0)" class="btn btn-success"/>
	<input type="button" value="上一页" onclick="xmlPage(-1)"  class="btn btn-success"/>
	
	<span>当前页
	<input type="text" id="currentPageId" name="currentPage" value="${currentPage }" readonly="readonly"   /></span>
	
	<input type="button" value="下一页" onclick="xmlPage(1)"  class="btn btn-success"/>
	<input type="button" value="末页" onclick="xmlPage(2)"  class="btn btn-success"/>
	
	<!-- 
	<br>
	<input type="button" value="跳转" onclick="xmlPage(3)"  class="btn btn-info"/>
	<input type="number" id="jumpPageId" name="currentPage" placeholder="跳转到第几页"  /> -->
	
	<span>总页数
	<input type="text" id="maxPageId" name="maxPage" value="${maxPage }" readonly="readonly"  /></span>
	
	<!-- 
	<span>每页显示条数
	<input type="text" id="stepId" name="step" value="${step }"  /></span>
	<input type="button" value="显示" onclick="xmlPage(4)"  class="btn btn-info"/> -->
</div>

<nav>
    <ul class="pagination">
        <li>
            <a href="#" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
            </a>
        </li>
<!--         <li><a href="#">1</a></li><%--动态生成页面的跳转链接--%> -->
<!--         <li><a href="#">2</a></li> -->
<!--         <li><a href="#">3</a></li> -->
<!--         <li><a href="#">4</a></li> -->
<!--         <li><a href="#">5</a></li> -->
        <li>
            <a href="#" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
            </a>
        </li>
    </ul>
</nav>
<script type="text/javascript">
$(document).ready(function() {
	// 数字页码处理
	var current= "${currentPage}";
	var max= "${maxPage}";
	var str= "<li><a href='javascript:;' onclick='xmlPage(where)'>where</a></li>";
	var replace= /where/g; // 正则表达式，全局匹配
	var result= ""; // 插入li
	
	// 长度取5个
	if(current-2 > 0) {
		result+= str.replace(replace, current-2);
	}
	if(current-1 > 0) {
		result+= str.replace(replace, current-1);
	}
	result+= str.replace(replace, current);
	if(current+1 < max) {
		result+= str.replace(replace, current+1);
	}
	if(current+2 < max) {
		result+= str.replace(replace, current+2);
	}

	$(result).insertAfter($(".pagination li:first"));
});
</script>
</body>
</html>
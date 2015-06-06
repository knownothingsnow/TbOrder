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
<title>UserJsp_createView</title>
<meta charset="utf-8" >
<script type="text/javascript">
function xmlCheck() {
	$.post("${pageContext.request.contextPath}/user/bCreateRepeat"
			, {username: $("#usernameId").val()
				, id: $("#userId").val()}
			, function(data) {
				if(data!= "") {
					$("#usernameId").focus();
					alert(data);
				}
			});
}

function checkForm() {
	if(ue.getContentTxt()=="") {
		alert("请输入内容");
		return false;
	}
	if(userTypeId.selectedIndex== 0) {
		alert("please selete the userType!!");
		return false;
	}
	return true;
}
</script>
</head>
<body>
	<section>
		<form action="${pageContext.request.contextPath }/user/bCreate"
		onsubmit="return checkForm()" method="post" enctype="multipart/form-data" >
			<div>
			<s:if test="#request.user==null">
				<h1>用户创建</h1>
			</s:if>
			<s:else>
				<h1>用户修改</h1>
			</s:else>
			</div>
			
			<input type="text" value="${user.username }" name="user.username" required="required" placeholder="用户名" onblur="xmlCheck()" id="usernameId" autofocus="autofocus"/>
			<input type="text" value="${user.password }" name="user.password" required="required" placeholder="密码"/>
			<select name="userType" id="userTypeId">
				<option value="">用户类型</option>
				<c:forEach var="list" items="${userTypeList }">
					<option ${user.category.userType==list? 'selected' : '' }
					value="${list}">${list }</option>
				</c:forEach>
			</select>
			
			<input type="text" class="Wdate" onclick="javascript:WdatePicker()" name="user.birthday" value="${user.birthday }" placeholder="生日" />
			
			<script id="editor" type="text/plain" style="width:800px;height:500px;" name="user.content" >${user.content}</script>
			<script type="text/javascript">var ue = UE.getEditor('editor'); UEDITOR_HOME_URL= "./js/ueditor/";</script>
			
			<input type="hidden" name="user.videoName" value="${user.videoName }" />
			<input type="file" name="videoUpload" id="videoUploadId" />
			<!-- mp4 -->
			<video id="videoId" class="video-js vjs-default-skin" controls preload="none" width="640" height="264" 
				data-setup="{}">
			  <source src="${pageContext.request.contextPath}/file/${user.videoName }" type='video/mp4'></source>
			</video>
			
			<!-- 暂时没有启用图片 -->
			<input name="" type="file" id="imgFile"/>
			<div id="imgdiv">图片预览 : <img id="imgShow" width="160" height="100" /></div>
			
			<input type="hidden" value="${user.id }" name="user.id" id="userId"/>
			<input type="submit" value="保存" />
			<input type="button" onclick="history.back()" value="back" />
		</form>
	</section>
</body>
</html>

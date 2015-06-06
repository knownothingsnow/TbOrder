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
<title>Order</title>
<meta charset="utf-8" >
<script type="text/javascript">
function checkForm() {
	/*
	if(ue.getContentTxt()=="") {
		alert("请输入内容");
		return false;
	}
	if(ordersTypeId.selectedIndex== 0) {
		alert("please selete the ordersType!!");
		return false;
	}*/
	return true;
}
  	function toProduct() {
  		if($("#kindId").val()== "") {
			$("#nameId option:not(:first)").remove();
			$("#nameId").attr("disabled", true);
  		}
  		$("#kindId1").val($("#kindId").val());
  		$("#nameId1").val("");
  		$("#colorId1").val("");
  		$("#colorId option:not(:first)").remove();
		$("#colorId").attr("disabled", true);  	
  		
  		$.getJSON("orders/bproductList", 
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
  		if($("#nameId").val()== "") {
	  		$("#colorId option:not(:first)").remove();
  			$("#colorId").attr("disabled", true);
  		}  		

  		$("#nameId1").val($("#nameId :selected").text());
  		$("#colorId1").val("");
  		$.getJSON("orders/bcolorAssortmentList", 
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
  	function toWrite() {
  		$("#colorId1").val($("#colorId").val());
  	}
  	
  	function updateCheck(o) {
  		var i= o.value;
  		
  		if(i != '' && ! (i.indexOf('.jpg') != -1
  		|| i.indexOf('.JPG') != -1
  		|| i.indexOf('.png') != -1
  		|| i.indexOf('.PNG') != -1
  		|| i.indexOf('.jpeg') != -1
  		|| i.indexOf('.JPEG') != -1
  		|| i.indexOf('.bmp') != -1
  		|| i.indexOf('.BMP') != -1 )) {
  			alert('文件格式错误!');
  			$(o).val("");
  		}
  	}

</script>
</head>
<body>
    <div class="container-fluid" id="page-wrapper">
      <div class="row">
          <div class="col-md-12 page-header">
			<s:if test="#request.orders==null">
				<h2>订单创建</h2>
			</s:if>
			<s:else>
				<h2>订单修改</h2>
			</s:else>
		  </div>
          
        <div class="col-md-12 form-cent" style="text-align: center;">
		<form action="orders/bcreate" 
		onsubmit="return checkForm()" method="post" enctype="multipart/form-data"  class="form-horizontal">
	
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-2 control-label">淘宝订单号</label>
              <div class="col-sm-3">
			<input type="text" value="${orders.tbNumber }" name="orders.tbNumber" required placeholder="淘宝订单号" autofocus  class="form-control"/></div>
              <label for="inputID" class="col-sm-2 control-label">定制文字</label>
              <div class="col-sm-3">
			<input type="text" value="${orders.customerWord }" name="orders.customerWord"  class="form-control" /></div></div>
	
            <div class="form-group" style="margin-bottom: 60px;">
			<select id="stateId" name="orders.state"  class="col-sm-2 ">
				<option value="0" ${orders.state==0? 'selected' : '' }>订单状态</option>
				<option value="1" ${orders.state==1? 'selected' : '' }>待分发</option>
				<option value="2" ${orders.state==2? 'selected' : '' }>正在设计</option>
				<option value="3" ${orders.state==3? 'selected' : '' }>待确认</option>
				<option value="4" ${orders.state==4? 'selected' : '' }>待加工</option>
				<option value="5" ${orders.state==5? 'selected' : '' }>正在加工</option>
				<option value="6" ${orders.state==6? 'selected' : '' }>已发货</option>
				<option value="7" ${orders.state==7? 'selected' : '' }>交易完成</option>
				<option value="8" ${orders.state==8? 'selected' : '' }>撤单</option>
				<option value="-1" ${orders.state==-1? 'selected' : '' }>已删除</option>
			</select>
			<select id="priorityId" name="orders.priority" class="col-sm-2">
				<option value="0">优先级</option>
				<option value="1" ${orders.priority==1? 'selected' : '' }>普通</option>
				<option value="2" ${orders.priority==2? 'selected' : '' }>加急</option>
			</select>
			
			<select id="kindId" onchange="toProduct()" class="col-sm-2" >
				<option value="">商品分类</option>
				<c:forEach items="${productAssortmentList }" var="productAssortmentList">
					<option>${productAssortmentList.kind }</option>
				</c:forEach>
			</select>
			<select id="nameId" onchange="toColor()" disabled="disabled" class="col-sm-2">
				<option value="">商品名称</option>
			</select>
			<select id="colorId" onchange="toWrite()" disabled="disabled" class="col-sm-2">
				<option value="">颜色分类</option>
			</select></div>
			
            <div class="form-group" style="margin-bottom: 60px;">
            <label for="inputID" class="col-sm-4 control-label"></label>
            <div class="col-sm-2">
			<input type="text" value="${orders.kind }" name="orders.kind"  id="kindId1"  required="required" class="form-control" placeholder="商品分类"/></div>
            <div class="col-sm-2">
			<input type="text" value="${orders.name }" name="orders.name"  id="nameId1" required="required" class="form-control" placeholder="商品名称" /></div>
            <div class="col-sm-2">
			<input type="text" value="${orders.color }" name="orders.color"  id="colorId1"  required="required" class="form-control" placeholder="颜色分类"/></div></div>
			
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-2 control-label">
              <input name="customerPicture" type="file" id="customerPictureId" onchange="updateCheck(this)" class="form-control"/></label>
              <div class="col-sm-3">	
			<div id="imgdiv1"><img id="customerPictureShow" width="160" height="100" alt="图片预览"/></div></div>
			
              <label for="inputID" class="col-sm-2 control-label">
              <input name="designPicture" type="file" id="designPictureId" onchange="updateCheck(this)" class="form-control"/></label>
              <div class="col-sm-3">	
			<div id="imgdiv2"><img id="designPictureShow" width="160" height="100" alt="图片预览"/></div></div></div>
			
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-2 control-label">定制图片</label>
              <div class="col-sm-3"><img src="file/${orders.customerPicture }" width="160" height="120" /></div>
              <label for="inputID" class="col-sm-2 control-label">设计图案</label>
			  <div class="col-sm-3"><img src="file/${orders.designPicture }" width="160" height="120" /></div></div>
			
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">买家淘宝</label>
              <div class="col-sm-3">
			<input type="text" value="${orders.tbUsername }" name="orders.tbUsername"  class="form-control" /></div>
              <label for="inputID" class="col-sm-1 control-label">收货人</label>
              <div class="col-sm-3">
			<input type="text" value="${orders.username }" name="orders.username" class="form-control"  /></div>
              <label for="inputID" class="col-sm-1 control-label">手机</label>
              <div class="col-sm-3">
			<input type="text" value="${orders.phone }" name="orders.phone"  class="form-control" /></div></div>
			
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">订单总额</label>
              <div class="col-sm-3">
			<input type="text" value="${orders.money }" name="orders.money" class="form-control"  /></div>
              <label for="inputID" class="col-sm-1 control-label">发货地址</label>
              <div class="col-sm-3">
			<input type="text" value="${orders.address }" name="orders.address"  class="form-control" /></div>
              <label for="inputID" class="col-sm-1 control-label">备注</label>
              <div class="col-sm-3">
			<input type="text" value="${orders.mark }" name="orders.mark"  class="form-control" /></div></div>
			
            <div class="form-group" style="margin-bottom: 60px;">
              <label for="inputID" class="col-sm-1 control-label">创建时间</label>
              <div class="col-sm-3">
			<label  class="form-control" >${orders.createTime }</label></div>
              <label for="inputID" class="col-sm-1 control-label">发货时间</label>
              <div class="col-sm-3">
			<label  class="form-control" >${orders.publishTime }</label></div>
              <label for="inputID" class="col-sm-1 control-label">撤单时间</label>
              <div class="col-sm-3">
			<label  class="form-control" >${orders.undoTime }</label></div></div>
			
			<input type="hidden" value="${orders.id }" name="orders.id" id="ordersId"/>
			<input type="submit" value="保存"  class="btn btn-success btn-lg"/>
			<input type="button" onclick="javascript:window.opener=null;window.open('','_self');window.close();" value="关闭"  class="btn btn-success btn-lg" />
		</form>
		</div>
	</div>
</body>
</html>

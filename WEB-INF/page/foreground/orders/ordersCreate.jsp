
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
<title>ordersCreate</title>
<meta charset="utf-8" >
<link rel="stylesheet" href="css/ordersCreate.css"/>

<style type="text/css">
#selectGroupDiv {
	margin-bottom: 60px;
}
#selectGroupDiv select {
	margin-right: 5px;
}
</style>

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
  		if($("#nameId").val()== "") {
	  		$("#colorId option:not(:first)").remove();
  			$("#colorId").attr("disabled", true);
  		}  		

  		$("#nameId1").val($("#nameId :selected").text());
  		$("#colorId1").val("");
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

  	function viewNow(o) {
  		$("#"+ o).click();
  	}
</script>
</head>
<body>
    <div class="container-fluid" id="page-wrapper">
      <div class="row">
          <div class="col-md-12 col-lg-12 page-header">
			<s:if test="#request.orders==null">
				<h1 id="header-of-page">订单创建</h1>
			</s:if>
			<s:else>
				<h1 id="header-of-page">订单修改</h1>
			</s:else>
		  </div>
	  </div>
          
      <div class="row"><!-- row-2 -->
        <div class="col-md-2"></div><!-- 占位 -->
        <div class="col-md-8 form-cent">
        
		<form action="orders/create" 
		onsubmit="return checkForm()" method="post" enctype="multipart/form-data"  class="form-horizontal">
	
<!--             <div class="btn-group"> -->
<!--                 <button type="button" class="btn btn-default " data-toggle="dropdown" > -->
<!--                     订单状态 <span class="caret"></span> -->
<!--                 </button> -->
<!--                 <ul  class=" dropdown-menu"> -->
<!--                     <li><a href="javascript:;">待分发</a></li> -->
<!--                     <li>正在设计</li> -->
<!--                     <li >待确认</li> -->
<!--                     <li >待加工</li> -->
<!--                     <li >正在加工</li> -->
<!--                     <li >已发货</li> -->
<!--                     <li >交易完成</li> -->
<!--                     <li>撤单</li> -->
<!--                     <li >已删除</li> -->
<!--                 </ul> -->
<!--             </div> -->
            
            <!-- 下拉列表选择 -->
            <div class="form-group" id="selectGroupDiv">
			<select id="stateId" name="orders.state" class="col-md-2 form-control">
				<option value="" ${orders.state==''? 'selected' : '' }>订单状态</option>
				<option ${orders.state=='待分发'? 'selected' : '' }>待分发</option>
				<option ${orders.state=='正在设计'? 'selected' : '' }>正在设计</option>
				<option ${orders.state=='待确认'? 'selected' : '' }>待确认</option>
				<option ${orders.state=='待加工'? 'selected' : '' }>待加工</option>
				<option ${orders.state=='正在加工'? 'selected' : '' }>正在加工</option>
				<option ${orders.state=='已发货'? 'selected' : '' }>已发货</option>
				<option ${orders.state=='交易完成'? 'selected' : '' }>交易完成</option>
				<option ${orders.state=='撤单'? 'selected' : '' }>撤单</option>
				<option ${orders.state=='已删除'? 'selected' : '' }>已删除</option>
			</select>
			<select id="priorityId" name="orders.priority" class="col-md-2 form-control">
				<option value="">优先级</option>
				<option ${orders.priority=='普通'? 'selected' : '' }>普通</option>
				<option ${orders.priority=='加急'? 'selected' : '' }>加急</option>
			</select>
			
			<select id="kindId" onchange="toProduct()" class="col-md-2 form-control">
				<option value="">商品分类</option>
				<c:forEach items="${productAssortmentList }" var="productAssortmentList">
					<option>${productAssortmentList.kind }</option>
				</c:forEach>
			</select>
			<select id="nameId" onchange="toColor()" disabled="disabled" class="col-md-2 form-control">
				<option value="">商品名称</option>
			</select>
			<select id="colorId" onchange="toWrite()" disabled="disabled" class="col-md-2 form-control">
				<option value="">颜色分类</option>
			</select>
			</div><!-- end selectGroupDiv -->
			
			<!-- begin 修改订单 -->
			<s:if test="#request.orders!=null">
			<!-- 商品具体信息 -->
            <div class="form-group">
	            <div class="col-sm-3">
				<input type="text" value="${orders.kind }" name="orders.kind"  id="kindId1"  
						required class="form-control" placeholder="商品分类"/></div>
	            <div class="col-sm-3">
				<input type="text" value="${orders.name }" name="orders.name"  id="nameId1" 
						required class="form-control" placeholder="商品名称"/></div>
	            <div class="col-sm-4">
				<input type="text" value="${orders.color }" name="orders.color"  id="colorId1"  
					required class="form-control" placeholder="颜色分类"/></div>
			</div>			
			<!-- 订单时间统计 -->
            <div class="form-group">
              <label for="inputID" class="col-md-2 control-label">创建时间</label>
              <label for="inputID" class="col-md-2 control-label">${orders.createTime }</label>
<!--               <input type="hidden" name="orders.createTime" value="${orders.createTime }"/> -->
              
              <label for="inputID" class="col-md-2 control-label">发货时间</label>
              <label for="inputID" class="col-md-2 control-label">${orders.publishTime }</label>
<!--               <input type="hidden" name="orders.publishTime" value="${orders.publishTime }"/> -->
              
              <label for="inputID" class="col-md-2 control-label">撤单时间</label>
              <label for="inputID" class="col-md-2 control-label">${orders.undoTime }</label>
<!--               <input type="hidden" name="orders.createTime" value="${orders.createTime }"/> -->
			</div>
			</s:if>
			<!-- end 修改订单 -->
			
			<!-- 订单其他主要信息 autofocus -->
            <div class="form-group">
                <label for="inputID" class="col-md-2 control-label">淘宝订单号</label>
                <input type="text" value="${orders.tbNumber }" name="orders.tbNumber" required class="form-control col-md-6"/>
            </div>
        
            <div class="form-group">
                <label for="inputID" class="col-md-2 control-label">买家淘宝ID</label>
                <input type="text" value="${orders.tbUsername }" name="orders.tbUsername"  class="form-control col-md-6" />
            </div>

            <div class="form-group">
                <label for="inputID" class="col-md-2 control-label">发货地址</label>
                <input type="text" value="${orders.address }" name="orders.address"  class="form-control col-md-6" />
            </div>

            <div class="form-group">
                <label for="inputID" class="col-md-2 control-label">收货人</label>
                <input type="text" value="${orders.username }" name="orders.username" class="form-control col-md-6"  />
            </div>

            <div class="form-group">
                <label for="inputID" class="col-md-2 control-label">手机</label>
                <input type="text" value="${orders.phone }" name="orders.phone"  class="form-control col-md-6" />
            </div>

            <div class="form-group">
                <label for="inputID" class="col-md-2 control-label">订单总额</label>
                <input type="text" value="${orders.money }" name="orders.money" class="form-control col-md-6"  />
            </div>

            <div class="form-group">
                <label for="inputID" class="col-md-2 control-label">备注</label>
                <input type="text" value="${orders.mark }" name="orders.mark"  class="form-control col-md-6" />
            </div>

            <div class="form-group">
                <label for="inputID" class="col-md-2 control-label">定制文字</label>
                <input type="text" value="${orders.customerWord }" name="orders.customerWord"  class="form-control col-md-6" />
            </div>

			<!-- 图片 -->
            <div class="form-group">
                <label for="inputID" class=" control-label">定制图片</label>
                <a href="file/${orders.customerPicture }" target="_blank">
                <img src="file/${orders.customerPicture }" width="160" height="120" /></a>
                
                <label for="inputID" class=" control-label">设计图案</label>
                <a href="file/${orders.designPicture }" target="_blank">
                <img src="file/${orders.designPicture }" width="160" height="120" /></a>
            </div>
            
            <div id="imgdiv1">
                <img id="customerPictureShow" width="160" height="100" alt="图片预览"/>
                <button class="btn btn-default" type="button" onclick="viewNow('customerPictureId')">上传定制图片</button>
                <input name="customerPicture" type="file" id="customerPictureId" onchange="updateCheck(this)" style="display: none;"/>
            </div>
            <div id="imgdiv2">
`                <img id="designPictureShow" width="160" height="100" alt="图片预览"/>
                 <button class="btn btn-default" type="button" onclick="viewNow('designPictureId')">上传设计图案</button>
                 <input name="designPicture" type="file" id="designPictureId" onchange="updateCheck(this)" style="display: none;"/>
            </div>
			
         	<!-- input -->
			<input type="hidden" value="${orders.id }" name="orders.id" id="ordersId"/>
			<c:if test="${empty sessionScope.process }">
			<input type="submit" value="保存"  class="btn btn-success"/></c:if>
			<input type="button" value="关闭"  class="btn btn-success"
			 onclick="javascript:window.opener=null;window.open('','_self');window.close();" />
			 <div class="col-md-3"></div><!-- 占位 -->
			<strong>${message }</strong>
		</form>
		</div>
		</div>
	</div>
	
</body>
</html>

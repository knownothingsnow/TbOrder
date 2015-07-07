
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
img:hover {
	cursor: pointer;
}
img {
	background-color: grey;
	color: wheat;
	width: 160px;
	height: 100px;
}
.hover {
	
}
</style>
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
            <!-- 修改时显示 -->
            <s:if test="#request.id!= null">
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
			</select></s:if>
			<s:if test="#request.state!= null">
				<input type="hidden" name="orders.state" value="${state }"/>
			</s:if>
			
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
                <label for="inputID" class="col-md-2 control-label">商品分类</label>
				<input type="text" value="${orders.kind }" name="orders.kind"  id="kindId1"  
						required class="form-control col-md-6" placeholder="商品分类"/>
			</div>

			<div class="form-group">
                <label for="inputID" class="col-md-2 control-label">商品名称</label>
				<input type="text" value="${orders.name }" name="orders.name"  id="nameId1" 
						required class="form-control col-md-6" placeholder="商品名称"/>
			</div>

			<div class="form-group">
                <label for="inputID" class="col-md-2 control-label">颜色分类</label>
				<input type="text" value="${orders.color }" name="orders.color"  id="colorId1"  
					required class="form-control col-md-6" placeholder="颜色分类"/>
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
			<hr />
			
			<s:if test="#request.orders==null">
				<input type="hidden" name="orders.kind"  id="kindId1"/>
				<input type="hidden" name="orders.name"  id="nameId1"/>
				<input type="hidden" name="orders.color"  id="colorId1"/>
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

			<!-- xiaohong -->
            <c:if test="${empty orders or empty orders.customerPicture }"> </c:if>
            <c:if test="${not empty orders and empty orders.designPicture}"></c:if>
            <c:if test="${not empty orders.customerPicture }"></c:if>
            
			<!-- 图片 -->			
            <!-- 录入时显示 -->            
            <div class="form-group" id="pn1">
                <label for="inputID" class="col-md-2 control-label">定制文字</label>
                <input type="text" value="${orders.customerWord }" name="orders.customerWord"  class="form-control col-md-6" id="ocwText1"/>
                <input type="hidden" value="${orders.customerPicture }" name="orders.customerPicture" id="ocpHidden1"/>
                <input type="hidden" value="${orders.designPicture }" name="orders.designPicture" id="odpHidden1"/>
	            
            	<div class="col-sm-3">
	            <div id="imgDiv1">
	                <img id="customerPictureShow1" src="file/${orders.customerPicture }"
	                	 alt="定制图片" title="定制图片" onclick="viewNow('customerPictureId1')"/>
	                
					<div class="hover">
						<a target="_self" href="download/picture?downloadFileName=${orders.customerPicture }">download</a>
					</div>	                
					
	                <!-- <button class="btn btn-default" type="button" onclick="viewNow('customerPictureId')">上传定制图片</button> -->
	                <input name="customerPicture" type="file" id="customerPictureId1" onchange="updateCheck(this)" style="display: none;"/>
	                
	                
            		<!-- 修改时显示 -->
            		<div class="isModify">
	                <img id="designPictureShow1" src="file/${orders.designPicture }"
	                	 alt="设计图案" title="设计图案" onclick="viewNow('designPictureId1')"/>

					<div class="hover">
						<a target="_self" href="download/picture?downloadFileName=${orders.designPicture }">download</a>
					</div>	           
	                
<!-- 	                <button class="btn btn-default" type="button" onclick="viewNow('designPictureId1')">上传设计图案</button> -->
	                <input name="designPicture" type="file" id="designPictureId1" onchange="updateCheck(this)" style="display: none;"/>
	                </div>
	            </div>
	            <button class="btn btn-default" onclick="clearPicture('pn1')" type="button">清除该信息</button></div>
            </div>
            
            <!-- pictureNumber、wordNumber、customerWord、customerWordName、imgDiv、
            ocwText、ocpHidden、odpHidden、
            customerPictureShow、customerPicture、customerPictureName、customerPictureId、
            designPictureShow、designPicture、designPictureName、designPictureId、 -->            
            <section id="pictureMustache" style="display: none;">
            <div class="form-group" id="{{pictureNumber }}">
                <label for="inputID" class="col-md-2 control-label">{{wordNumber }}</label>
                <input type="text" value="{{customerWord }}" name="{{customerWordName }}"  class="form-control col-md-6" id="{{ocwText }}"/>
                <input type="hidden" value="{{customerPicture }}" name="{{ordersCustomerPictureName }}" id="{{ocpHidden }}"/>
                <input type="hidden" value="{{designPicture }}" name="{{ordersDesignPictureName }}" id="{{odpHidden }}"/>
	            
            	<div class="col-sm-3">
	            <div id="{{imgDiv }}">
	                <img id="{{customerPictureShow }}" src="file/{{customerPicture }}"
	                	 alt="定制图片" title="定制图片" onclick="viewNow('{{customerPictureId }}')"/>
	                
					<div class="hover">
						<a target="_self" href="download/picture?downloadFileName={{customerPicture }}">download</a>
					</div>	                

	                <input name="{{customerPictureName }}" type="file" id="{{customerPictureId }}" onchange="updateCheck(this)" style="display: none;"/>
	                	                
            		<!-- 修改时显示 -->
            		<div class="isModify">
	                <img id="{{designPictureShow }}" src="file/{{designPicture }}"
	                	 alt="设计图案" title="设计图案" onclick="viewNow('{{designPictureId }}')"/>
	                	 
					<div class="hover">
						<a target="_self" href="download/picture?downloadFileName={{designPicture }}">download</a>
					</div>	                
					
	                <input name="{{designPictureName }}" type="file" id="{{designPictureId }}" onchange="updateCheck(this)" style="display: none;"/>
	                </div>
	            </div>
	            <button class="btn btn-default" onclick="clearPicture('{{pictureNumber }}')" type="button">清除该信息</button></div>
            </div>
            </section>                        
			
			
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
	
<!--  图片预览 -->
<script type="text/javascript" src="${pageContext.request.contextPath }/js/uploadPreview.min.js"></script>
<script type="text/javascript" src="js/foreground/orders-ordersCreate.js"></script>
<script type="text/javascript">
    // 获取后台数据（定制文字、定制图片、设计图片），写入数组 --- 全局变量
    data= new Array(4);
    data[0]= {
        "cw": "${orders.customerWord2}",
        "cp": "${orders.customerPicture2}",
        "dp": "${orders.designPicture2}"
    };
    data[1]= {
            "cw": "${orders.customerWord3}",
            "cp": "${orders.customerPicture3}",
            "dp": "${orders.designPicture3}"
        };
    data[2]= {
            "cw": "${orders.customerWord4}",
            "cp": "${orders.customerPicture4}",
            "dp": "${orders.designPicture4}"
        };
    data[3]= {
            "cw": "${orders.customerWord5}",
            "cp": "${orders.customerPicture5}",
            "dp": "${orders.designPicture5}"
        };

    // windowOnload
    window.onload= function() {
        new uploadPreview({ UpBtn: "customerPictureId1", DivShow: "imgDiv1", ImgShow: "customerPictureShow1" });
        new uploadPreview({ UpBtn: "designPictureId1", DivShow: "imgDiv1", ImgShow: "designPictureShow1" });

        // 初始化--------
        for(var i=0; i< data.length; i++) {
            if(data[i]["cp"]!= "") {
                pictureWordCreate(i+2);
            } else {
                if(i!= 0) {
                    pictureWordCreate(i+2);
                }
                break;
            }
        }
        removeDesignPicture();
    };
</script>
	
</body>
</html>

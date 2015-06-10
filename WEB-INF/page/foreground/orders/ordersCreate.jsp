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
    <script type="text/javascript">
        function checkForm() {
            return true;
        }
        function toProduct() {
            if($("#kindId").val()== "") {
                $("#nameId li:not(:first)").remove();
                $("#nameId").attr("disabled", true);
            }
            $("#kindId1").val($("#kindId").val());
            $("#nameId1").val("");
            $("#colorId1").val("");
            $("#colorId li:not(:first)").remove();
            $("#colorId").attr("disabled", true);

            $.getJSON("orders/bproductList",
                    { kind: $("#kindId").val() },
                    function(json) {
                        $("#nameId").attr("disabled", false);
                        $("#nameId li:not(:first)").remove();

                        var str= "";
                        for(var i=0; i<json.jsonArray.length; i++) {
                            str+= "<li value='"+ json.jsonArray[i].id+ "'>"+ json.jsonArray[i].name+ "</li>";
                        }
                        $("#nameId").append(str);
                    });

        }
        function toColor() {
            if($("#nameId").val()== "") {
                $("#colorId li:not(:first)").remove();
                $("#colorId").attr("disabled", true);
            }

            $("#nameId1").val($("#nameId :selected").text());
            $("#colorId1").val("");
            $.getJSON("orders/bcolorAssortmentList",
                    { productId: $("#nameId :selected").val() },
                    function(json) {
                        $("#colorId").attr("disabled", false);
                        $("#colorId li:not(:first)").remove();

                        var str= "";
                        for(var i=0; i< json.jsonArray.length; i++) {
                            str+= "<li>"+ json.jsonArray[i].color+ "</li>";
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
    <div class="row"><!-- row-1 -->
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
            <div class="btn-group">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    订单状态 <span class="caret"></span>
                </button>
                <ul id="stateId" name="orders.state"  class=" dropdown-menu">
                    <li value="0" ${orders.state==0? 'selected' : '' }>订单状态</li>
                    <li value="1" ${orders.state==1? 'selected' : '' }>待分发</li>
                    <li value="2" ${orders.state==2? 'selected' : '' }>正在设计</li>
                    <li value="3" ${orders.state==3? 'selected' : '' }>待确认</li>
                    <li value="4" ${orders.state==4? 'selected' : '' }>待加工</li>
                    <li value="5" ${orders.state==5? 'selected' : '' }>正在加工</li>
                    <li value="6" ${orders.state==6? 'selected' : '' }>已发货</li>
                    <li value="7" ${orders.state==7? 'selected' : '' }>交易完成</li>
                    <li value="8" ${orders.state==8? 'selected' : '' }>撤单</li>
                    <li value="-1" ${orders.state==-1? 'selected' : '' }>已删除</li>
                </ul>
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    优先级 <span class="caret"></span>
                </button>
                <ul id="priorityId" name="orders.priority" class=" dropdown-menu">
                    <li value="0">优先级</li>
                    <li value="1" ${orders.priority==1? 'selected' : '' }>普通</li>
                    <li value="2" ${orders.priority==2? 'selected' : '' }>加急</li>
                </ul>

                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    商品分类 <span class="caret"></span>
                </button>
                <ul id="kindId" onchange="toProduct()" class=" dropdown-menu" >
                    <li value="">商品分类</li>
                    <c:forEach items="${productAssortmentList }" var="productAssortmentList">
                        <li>${productAssortmentList.kind }</li>
                    </c:forEach>
                </ul>

                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    商品名称 <span class="caret"></span>
                </button>
                <ul id="nameId" onchange="toColor()" disabled="disabled" class=" dropdown-menu">
                    <li value="">商品名称</li>
                </ul>

                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    颜色分类 <span class="caret"></span>
                </button>
                <ul id="colorId" onchange="toWrite()" disabled="disabled" class=" dropdown-menu">
                    <li value="">颜色分类</li>
                </ul>
            </div>

            <form action="orders/bcreate" onsubmit="return checkForm()" method="post" enctype="multipart/form-data"  class="form-horizontal">
                <div class="form-group">
                    <label for="inputID" class="col-md-2 control-label">淘宝订单号</label>
                    <input type="text" value="${orders.tbNumber }" name="orders.tbNumber" required autofocus  class="form-control col-md-6"/>
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


                <div id="imgdiv1">
                    <img id="customerPictureShow" width="160" height="100" alt="图片预览"/>
                    <button class="btn btn-default" type="submit">选择用户图片</button>
                </div>
                <div class="form-group pic-submit">
                    <label for="inputID" class=" control-label">上传用户图片</label>
                    <input name="customerPicture" type="file" id="customerPictureId" onchange="updateCheck(this)" class="form-control"/>
                </div><%--被隐藏了,功能由上方button绑定事件触发--%>

                <div id="imgdiv2">
`                    <img id="designPictureShow" width="160" height="100" alt="图片预览"/>
                    <button class="btn btn-default" type="submit">选择设计稿</button>
                </div>

                <div class="form-group pic-submit">
                    <label for="inputID" class=" control-label">上传设计稿</label>
                    <input name="designPicture" type="file" id="designPictureId" onchange="updateCheck(this)" class="form-control"/>
                </div><%--被隐藏了,功能由上方button绑定事件触发--%>


                <div class="form-group">
                    <label for="inputID" class=" control-label">定制图片</label>
                    <img src="file/${orders.customerPicture }" width="160" height="120" />
                    <label for="inputID" class=" control-label">设计图案</label>
                    <img src="file/${orders.designPicture }" width="160" height="120" />
                </div>

                <input type="hidden" value="${orders.id }" id="ordersId" name="orders.id"/>
                <input type="submit" value="保存" class="btn btn-success"/>
                <input type="button" value="关闭" class="btn btn-success" onclick="javascript:window.opener=null;window.open('','_self');window.close();"/>
            </form>
            <!-- <div class="form-group">
                    <label for="inputID" class="control-label">商品分类</label>
                    <input type="text" value="${orders.kind }" name="orders.kind"  id="kindId1"  required="required" class="form-control" placeholder="商品分类"/>
                    <label for="inputID" class=" control-label">商品名称</label>
                    <input type="text" value="${orders.name }" name="orders.name"  id="nameId1" required="required" class="form-control" placeholder="商品名称"/>
                    <label for="inputID" class=" control-label">颜色分类</label>
                    <input type="text" value="${orders.color }" name="orders.color"  id="colorId1"  required="required" class="form-control" placeholder="颜色分类"/>
                </div> --><!-- 创建订单不显示-->

            <!-- <div class="form-group">
                    <label for="inputID" class=" control-label">创建时间</label>
                    <label class="form-control" >${orders.createTime }  </label>
                    <label for="inputID" class=" control-label">发货时间</label>
                    <label class="form-control" >${orders.publishTime } </label>
                    <label for="inputID" class=" control-label">撤单时间</label>
                    <label class="form-control" >${orders.undoTime }    </label>
                </div> --><!-- 创建和修改订单时不显示 -->

            <div class="col-md-2"></div><!-- 占位 -->
        </div><!-- row-2 end -->
    </div><!-- wrapper end -->
</body>
</html>

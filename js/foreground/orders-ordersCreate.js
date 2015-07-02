


//添加一行定制图文
function pictureMustacheCreate(json, div) {
	var str= Mustache.render($("#pictureMustache").html(), json);
	$(div).after(str);
	
	new uploadPreview({ UpBtn: json["customerPictureId"], DivShow: json["imgDiv"], ImgShow: json["customerPictureShow"] });
	new uploadPreview({ UpBtn: json["designPictureId"], DivShow: json["imgDiv"], ImgShow: json["designPictureShow"] });
}
//录入订单时去掉上传设计图片
function removeDesignPicture() {
	if($("#ordersId").val()!= "") {
		$("div[class='isModify'").css("display", "");
	} else {
		$("div[class='isModify']").css("display", "none");
	}
}
//创建定制图文初始化数据
function pictureWordCreate(i) {
	// 创建1行定制图
	//for(var i=2; i<= 5; i++) {
		var json= {
				"pictureNumber": "pn"+ i,
				"wordNumber": "定制文字"+ i,
				"customerWord": data[i-2]["cw"],
				"customerWordName": "orders.customerWord"+ i,
				"imgDiv": "imgDiv"+ i
				,
				"ocwText": "ocwText"+ i,
				"ocpHidden": "ocpHidden"+ i,
				"odpHidden": "odpHidden"+ i
				,
				"customerPictureShow": "customerPictureShow"+ i,
				"customerPicture": data[i-2]["cp"],
				"ordersCustomerPictureName": "orders.customerPicture"+ i,
				"customerPictureName": "customerPicture"+ i,
				"customerPictureId": "customerPictureId"+ i
				,
				"designPictureShow": "designPictureShow"+ i,
				"designPicture": data[i-2]["dp"],
				"ordersDesignPictureName": "orders.designPicture"+ i,
				"designPictureName": "designPicture"+ i,
				"designPictureId": "designPictureId"+ i
		};
		pictureMustacheCreate(json, "#pn"+ parseInt(i-1));
	//}
		removeDesignPicture();
}



//----------------------------------------

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
	var head= o.substring(0, o.length-1);
	var i= parseInt(o[o.length-1]);
	if(head== "customerPictureId" && $("#customerPictureId"+ (i+ 1)).size()== 0 && i< 5) {
		pictureWordCreate(i+ 1);
	}
}

function clearPicture(div) {
	var i= div[div.length-1];
	
	var ocwText= "#ocwText"+ i;
	var ocpHidden= "#ocpHidden"+ i;
	var odpHidden= "#odpHidden"+ i;
	$(ocwText).val("");
	$(ocpHidden).val("");
	$(odpHidden).val("");

	var cps= "#customerPictureShow"+ i;
	var dps= "#designPictureShow"+ i;
	$(cps).attr("src", "");
	$(dps).attr("src", "");
}

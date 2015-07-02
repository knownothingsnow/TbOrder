
function xmlCheck() {
	/*
	$.post("${pageContext.request.contextPath}/product/bCreateRepeat"
			, {productname: $("#productnameId").val()
				, id: $("#productId").val()}
			, function(data) {
				if(data!= "") {
					$("#productnameId").focus();
					alert(data);
				}
			});
	*/
}

function checkForm() {
	/*
	if(ue.getContentTxt()=="") {
		alert("请输入内容");
		return false;
	}
	if(productTypeId.selectedIndex== 0) {
		alert("please selete the productType!!");
		return false;
	}
	*/
	return true;
}
function colorUpdate(id, o) {
	if(o!= 0) {
		if(confirm("确认删除")) {
			$.post("product/bUpdateColor"
					, {colorId: o}
					, function(data) {
						$(id).parent().remove();
					});
		}
	} else {
		var params= {id:  $("#productId").val()
				, colorId: o
				, color: $("#colorText").val()
				, price: $("#priceText").val()};
		if(params.color== ""|| params.price==  0) {
			$("#colorText").focus();
			return;
		}
		$.post("product/bUpdateColor"
				, params
				, function(json) {
					$("#colorText").val("");
					$("#priceText").val("");
					$("#colorId").append("<li><a href='javascript:;' onclick='colorUpdate(this, "+ json.newColorId+ ")'>"+ params.color+ params.price+ "&nbsp;&nbsp;</a></li>");
				});
	}
	
}
/*, (colorAssortment.color): $("#colorId").val()
, price: $("#priceId").val()*/
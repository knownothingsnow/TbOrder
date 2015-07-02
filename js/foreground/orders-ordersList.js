

function xmlPage(n) {
	var nameI= "";
	if($("#nameId").val()!= "") {
		nameI= $("#nameId :selected").text();
	}
	var cp= calcCurrentPage(n);
	$.getJSON("orders/listXml",
  				{currentPage: cp
					, step: $("#stepId").val()
					, id: $("#deleteId").val()
					, state: $("#stateId").val()
					, priority: $("#priorityId").val()
					, kind: $("#kindId").val()
					, name: nameI
					, color: $("#colorId").val()
					, od: $("#orderId").val() },
				function(json) {
					$("#ordersListTable").find("li").remove();

					var str= "";
					/* 手动
					for(var i=0; i< json.jsonArray.length; i++) {
						str+= "<li class='list-group-item list-group-item-info'>";
						str+= "<h4><strong>淘宝订单编号:</strong>"+ json.jsonArray[i].tbNumber+ "<strong>&nbsp;状态:</strong>"+ json.jsonArray[i].state+ "</h4>";
						str+= "<p><strong>买家淘宝用户名:</strong>"+ json.jsonArray[i].tbUsername+ "</p>";
						str+= "<p><strong>优先级:</strong>"+ json.jsonArray[i].priority+ "</p>";
						str+= "<p><strong>类型:</strong>"+ json.jsonArray[i].kind+ "</p>";
						str+= "<p><strong>商品名:</strong>"+ json.jsonArray[i].name+ "</p>";
						str+= "<p><strong>颜色:</strong>"+ json.jsonArray[i].color+ "</p>";
						str+= "<p><strong>录入时间:</strong>"+ json.jsonArray[i].createTime+ "</p>";
						str+= "<p><strong>收货人:</strong>"+ json.jsonArray[i].username+ "</p>";
						str+= "<p><strong>电话:</strong>"+ json.jsonArray[i].phone+ "</p>";
						
						str+= "<div class='btn-group btn-icno'  role='group'>"
								+ "<button type='button' class='btn btn-default' title='设计订单' onclick=toDesign('"+ json.jsonArray[i].id + "')><i class='icon-plus-sign-alt icon-2x'></i></button>"
				                + "<button type='button' class='btn btn-default' title='详细信息' onclick=toDetail('"+ json.jsonArray[i].id + "')><i class='icon-list-ul icon-2x'></i></button>"
				                + "<button type='button' class='btn btn-default' title='撤销订单' onclick=     del('"+ json.jsonArray[i].id + "')><i class='icon-share-alt icon-2x'></i></button>"
				                + "<div></li>";
					}
					//*/
					
					
					/*
			         <!-- default/danger/primary/info/state1/success/warning/warning/warning 总共找到6中颜色值-->
			         <!-- 1待分发、2正在设计、3待确认、4待加工、5正在加工、6已发货、7交易完成、8撤单、-1已删除 -->
			        */

					//* mustache
					var ja= json.jsonArray;
					for(var i=0; i< ja.length; i++) {
						switch(ja[i]["state"]) {
							case "待分发": ja[i]["class"]= "list-group-item list-group-item-default"; break;
							case "正在设计": ja[i]["class"]= "list-group-item list-group-item-danger"; break;
							case "待确认": ja[i]["class"]= "list-group-item list-group-item-primary"; break;
							case "待加工": ja[i]["class"]= "list-group-item list-group-item-info"; break;
							case "正在加工": ja[i]["class"]= "list-group-item list-group-item-state1"; break;
							case "已发货": ja[i]["class"]= "list-group-item list-group-item-success"; break;
							case "交易完成": ja[i]["class"]= "list-group-item list-group-item-warning"; break;
							case "撤单": ja[i]["class"]= "list-group-item list-group-item-state2"; break;
							case "已删除": ja[i]["class"]= "list-group-item list-group-item-state3"; break;
							default : ja[i]["class"]= "list-group-item list-group-item-default"; break;
						}
						str+= Mustache.render($("#ordersListTableMustache").html(), ja[i]);
					}
					//*/
					
					$("#ordersListTable").append(str);
					$("#currentPageId").val(json.currentPage);
					$("#maxPageId").val(json.maxPage);
			  		pageCalcurate(); // 重新计算页码
					if(json.message!= null) {
						alert(json.message);
					}
				});
	
	document.documentElement.scrollTop=0;
	document.body.scrollTop=0;

}
function del(o) {
	if(confirm("确认要撤销？")) {
  		$("#deleteId").val(o);
  		xmlPage(0);
	}
}
function toProduct() {
	$("#nameId option:first").attr("selected", true);
	$("#colorId option:first").attr("selected", true);
	xmlPage(0);
	
	if($("#kindId").val()== "") {
		$("#nameId option:not(:first)").remove();
		$("#nameId").attr("disabled", true);
	}
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
	$("#colorId option:first").attr("selected", true);
	xmlPage(0);
	
	if($("#nameId").val()== "") {
  		$("#colorId option:not(:first)").remove();
		$("#colorId").attr("disabled", true);
	}
	
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

function toDetail(o) {
	window.open("orders/createView?id="+ o);
}
function toDesign(o) {
	$.getJSON("orders/toDesign",
			{id: o}, 
			function(json) {
				alert(json.message);
				if(json.message!= "操作失败,请检查订单状态") {
					window.location.href= "orders/assignOrders";
				}
			});
}



function xmlPage(n) {
	var state= $("#stateId").val();
	var cp= calcCurrentPage(n);
	$.getJSON("orders/assignListJson",
  				{currentPage: cp
					, state: state},
				function(json) {
					$("#ordersListTable").find("li").remove();

					var str= "";
					
					//* mustache
					var ja= json.jsonArray;
					for(var i=0; i< ja.length; i++) {
						str+= Mustache.render($("#ordersListTableMustache").html(), ja[i]);
					}
					
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

function toDetail(o) {
	var state= "state=";
	var me= "${message}";	
	if(me== "design") {
		state+= "待确认";
	} else if(me== "process") {
		state+= "已发货";
	}
	
	window.open("orders/createView?id="+ o+ "&"+ state);
}
function toDesign(o) {
	var me= "${message}";
	var str= "";
	if(me== "design") {
		str= "确定提交图案设计方案?";
	} else if(me== "process") {
		str= "确定发货?";
	}
	if(confirm(str)) {
		$.getJSON("orders/toDesign",
				{id: o}, 
				function(json) {
					alert(json.message);
					window.location.href= location.href;
				});
	}
}

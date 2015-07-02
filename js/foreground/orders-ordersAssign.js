

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

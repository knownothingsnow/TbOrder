
function xmlCheck() {
	$.post("processStaff/bCreateRepeat"
			, {username: $("#usernameId").val()
				, id: $("#processStaffId").val()}
			, function(data) {
				if(data.length> 0) {
					$("#usernameId").focus();
					alert(data.message);
				}
			});
}

function checkForm() {
	/*
	if(ue.getContentTxt()=="") {
		alert("请输入内容");
		return false;
	}
	if(processStaffTypeId.selectedIndex== 0) {
		alert("please selete the processStaffType!!");
		return false;
	}
	*/
	return true;
}
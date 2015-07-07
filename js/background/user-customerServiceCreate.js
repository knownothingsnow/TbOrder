
function xmlCheck() {
    $.post("customerService/bCreateRepeat"
        , {username: $("#usernameId").val()
            , id: $("#customerServiceId").val()}
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
     if(customerServiceTypeId.selectedIndex== 0) {
     alert("please selete the customerServiceType!!");
     return false;
     }
     */
    return true;
}
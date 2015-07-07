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

    $.getJSON("orders/bproductList",
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
    $.getJSON("orders/bcolorAssortmentList",
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
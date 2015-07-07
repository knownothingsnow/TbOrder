
function xmlPage(n) {
    var nameI= "";
    // 商品名称
    if($("#nameId").val()!= "") {
        nameI= $("#nameId :selected").text();
    }
    var cp= calcCurrentPage(n);
    $.getJSON("orders/blistXml",
        {currentPage: cp
            , step: $("#stepId").val()
            , id: $("#deleteId").val()
            , state: $("#stateId").val()
            , priority: $("#priorityId").val()
            , kind: $("#kindId").val()
            , name: nameI
            , color: $("#colorId").val()
            , order: $("#orderId").val() },
        function(json) {
            $("#ordersListTable tr:not(:first)").remove();

            var str= "";

            /* 手动
             for(var i=0; i< json.jsonArray.length; i++) {
             str+= "<tr><td>"+ json.jsonArray[i].name+ "</td>";
             str+= "<td>"+ json.jsonArray[i].tbNumber+ "</td>";
             str+= "<td>"+ json.jsonArray[i].tbUsername+ "</td>";
             str+= "<td>"+ json.jsonArray[i].priority+ "</td>";
             str+= "<td>"+ json.jsonArray[i].state+ "</td>";
             str+= "<td>"+ json.jsonArray[i].color+ "</td>";
             str+= "<td><img src='file/"+ json.jsonArray[i].customerPicture+ "' width='120' height='80' /></td>";
             str+= "<td><img src='file/"+ json.jsonArray[i].designPicture+ "' width='120' height='80' /></td>";
             str+= "<td>"+ json.jsonArray[i].kind+ "</td>";
             str+= "<td>"+ json.jsonArray[i].phone+ "</td>";
             str+= "<td>"+ json.jsonArray[i].username+ "</td>";
             str+= "<td>"+ json.jsonArray[i].createTime+ "</td>";
             str+= "<td><a href='orders/bcreateView?id="+ json.jsonArray[i].id + "' target='_blank' class='btn btn-default' >modify</a>&nbsp;"
             + "<a href='javascript:;' onclick=del('"+ json.jsonArray[i].id+ "') class='btn btn-default'>delete</a></td></tr>";
             }
             //*/

            //* mustache
            var ja= json.jsonArray;
            for(var i=0; i< ja.length; i++) {
                str+= Mustache.render($("#ordersListTableMustache").html(), ja[i]);
            }
            //*/

            $("#ordersListTable").append(str);
            $("#currentPageId").val(json.currentPage);
            $("#maxPageId").val(json.maxPage);
        });
}
function del(o) {
    if(confirm("确定要删除?")) {
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
    $("#colorId option:first").attr("selected", true);
    xmlPage(0);

    if($("#nameId").val()== "") {
        $("#colorId option:not(:first)").remove();
        $("#colorId").attr("disabled", true);
    }

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
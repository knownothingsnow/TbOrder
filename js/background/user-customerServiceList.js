
function xmlPage(n) {
    var cp= calcCurrentPage(n);
    $.getJSON("customerService/bListXml",
        {currentPage: cp
            , step: $("#stepId").val()
            , id: $("#deleteId").val()
            , orderBy: $("#orderById").val()
            , order: $("#orderId").val()
            , isVague: $("#isVagueId").val()
            , username: $("#usernameId").val()},
        function(json) {
            $("#customerServiceListTable tr:not(:first)").remove();

            var str= "";
            for(var i=0; i< json.jsonArray.length; i++) {
                str+= "<tr><td>"+ json.jsonArray[i].name+ "</td>";
                str+= "<td>"+ json.jsonArray[i].username+ "</td>";
                str+= "<td>"+ json.jsonArray[i].password+ "</td>";
                str+= "<td>"+ json.jsonArray[i].orderNumber+ "</td>";
                str+= "<td>"+ json.jsonArray[i].designNumber+ "</td>";
                str+= "<td>"+ json.jsonArray[i].createTime+ "</td>";
                str+= "<td><a href='customerService/bCreateView?id="+ json.jsonArray[i].id + "' target='_blank' class='btn btn-default'>modify</a>&nbsp;"
                    + "<a href='javascript:;' onclick=del('"+ json.jsonArray[i].id+ "') class='btn btn-default'>delete</a></td></tr>";
            }
            $("#customerServiceListTable").append(str);
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
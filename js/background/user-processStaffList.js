
function xmlPage(n) {
    var cp= calcCurrentPage(n);
    $.getJSON("processStaff/bListXml",
        {currentPage: cp
            , step: $("#stepId").val()
            , id: $("#deleteId").val()
            , orderBy: $("#orderById").val()
            , order: $("#orderId").val()
            , username: $("#usernameId").val()
            , isVague: $("#isVagueId").val()},
        function(json) {
            $("#processStaffListTable tr:not(:first)").remove();

            var str= "";
            for(var i=0; i< json.jsonArray.length; i++) {
                str+= "<tr><td>"+ json.jsonArray[i].name+ "</td>";
                str+= "<td>"+ json.jsonArray[i].username+ "</td>";
                str+= "<td>"+ json.jsonArray[i].password+ "</td>";
                str+= "<td>"+ json.jsonArray[i].publishNumber+ "</td>";
                str+= "<td>"+ json.jsonArray[i].createTime+ "</td>";
                str+= "<td><a href='processStaff/bCreateView?id="+ json.jsonArray[i].id + "' target='_blank' class='btn btn-default'>modify</a>&nbsp;"
                    + "<a href='javascript:;' onclick=del('"+ json.jsonArray[i].id+ "') class='btn btn-default'>delete</a></td></tr>";
            }
            $("#processStaffListTable").append(str);
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
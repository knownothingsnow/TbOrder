
function kindUpdate(id, o) {
    if(o!= 0) {
        if(confirm("确认删除")) {
            $.post("productAssortment/bUpdateKind",
                {id: o},
                function(data) {
                    $(id).parent().remove();
                });
        }
    } else {
        var params= {id: o
            , kind: $("#kindText").val()};
        if(params.kind== "") {
            return;
        }
        $.post("productAssortment/bUpdateKind",
            params,
            function(json) {
                if(typeof(json.message)!= "undefined") {
                    alert(json.message);
                } else {
                    $("#kindText").val("");
                    $("#kindId").append("<li><a href='javascript:;' onclick='kindUpdate(this, "+ json.newKindId+ ")'>"+ params.kind+ "&nbsp;&nbsp;</a></li>");
                }
            });
    }
}
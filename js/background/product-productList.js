
  	function xmlPage(n) {
  		var cp= calcCurrentPage(n);
  		$.getJSON("product/bListXml", 
	  				{currentPage: cp
						, kind: $("#kindId").val()
						, step: $("#stepId").val()
						, id: $("#deleteId").val()},
					function(json) {
						$("#productListTable tr:not(:first)").remove();
						var str= "";
						
						/* 手动拼接
						for(var i=0; i< json.jsonArray.length; i++) {
							str+= "<tr><td>"+ json.jsonArray[i].name+ "</td>";
							str+= "<td>"+ json.jsonArray[i].kind+ "</td>";
							str+= "<td><a href='product/bCreateView?id="+ json.jsonArray[i].id + "' target='_blank' class='btn btn-default'>modify</a>&nbsp;"
									+ "<a href='javascript:;' onclick=del('"+ json.jsonArray[i].id+ "') class='btn btn-default'>delete</a></td></tr>";
						}
						//*/
						
						//* 客户端模板 productListTableMustache
						var ja= json.jsonArray;
						for(var i=0; i< ja.length; i++) {
							str+= Mustache.render($("#productListTableMustache").html(), ja[i]);
						}
						//*/
						
						$("#productListTable").append(str);
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
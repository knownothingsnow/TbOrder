
function pageCalcurate() {
	// 数字页码处理
	var current= "${currentPage}";
	var max= "${maxPage}";
	current= parseInt($("#currentPageId").val());
	max= parseInt($("#maxPageId").val());
	
	var str= "<li><a href='javascript:;' onclick='jumpPage(where)'>where</a></li>";
	var replace= /where/g; // 正则表达式，全局匹配
	var result= ""; // 插入li
	
	// 长度取5个
	if(current-2 > 0) {
		result+= str.replace(replace, current-2);
	}
	if(current-1 > 0) {
		result+= str.replace(replace, current-1);
	}
	result+= str.replace(replace, current);
	if(current+1 <= max) {
		result+= str.replace(replace, current+1);
	}
	if(current+2 <= max) {
		result+= str.replace(replace, current+2);
	}

	$(".pagination li:not(:first):not(:last)").remove();
	$(result).insertAfter($(".pagination li:first"));
}

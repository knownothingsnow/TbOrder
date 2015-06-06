function calcCurrentPage(n) {
	var cp= parseInt($("#currentPageId").val());
	var mp= parseInt($("#maxPageId").val());
	switch(parseInt(n)) {
	case 0: cp= 1; break;
	case -1: cp--; break;
	case 1: cp++; break;
	case 2: cp= mp; break;
	case 3: cp= parseInt($("#jumpPageId").val()); break;
	case 4: if($("#stepId").val()=='' || parseInt($("#stepId").val())<= 0) {
				$("#stepId").val(12);
			}; break;
	}
	if(cp<= 0) {
		cp= 1;
	}
	if(cp> mp) {
		cp= mp;
	}
	return cp;
}
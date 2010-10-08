$(document).ready(function(){
	var path = window.location.pathname.substring(1);
	if(path == "" || $("#" + path).html() == null){
		$("#writing").addClass('selected');
	}
	else{
		e.addClass('selected');
	}
});
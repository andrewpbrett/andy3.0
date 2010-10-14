$(document).ready(function(){
	var path = window.location.pathname.substring(1);
	if(path == "" || $("#" + path).html() == null){
		$("#writing").addClass('selected');
	}
	else{
		$("#" + path).addClass('selected');
		document.title = "Andy Brett | " + path.charAt(0).toUpperCase() + path.slice(1)
	}
});
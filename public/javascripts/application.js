$(document).ready(function(){
	var path = window.location.pathname.substring(1);
	$("#" + path).addClass('selected');
});
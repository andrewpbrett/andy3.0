$(document).ready(function(){
	var path = window.location.pathname.substring(1);
	if(path.indexOf('/') != -1){
		path = path.substring(0, path.indexOf('/'));
	}
	if($("#" + path).html() == null){
		$("#writing").addClass('selected');
	}
	else{
		$("#" + path).addClass('selected');
		document.title = "Andy Brett | " + path.charAt(0).toUpperCase() + path.slice(1)
	}
});

$(document).ready(function(){
	var e = document.getElementById('update_body'),
	    f = document.getElementById('counter');

	if(e){
		e.onkeyup = function() {
	  		f.innerHTML = (140 - e.value.length);
		}	
	}
});
